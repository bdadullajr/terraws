#######################################################
#####     AWS PROVIDE & AVAILABILITY ZONES        #####
#######################################################
provider "aws" {
  region = "eu-west-1"
}

data "aws_availability_zones" "all" {}

#######################################################
#####     VIRTUAL PRIVATE CLOUD	                  #####
#######################################################

resource "aws_vpc" "iac_vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags {
    Name = "iac_vpc"
  }
}

#######################################################
#####     PUBLIC SUBNET			          #####
#######################################################

resource "aws_subnet" "iac_public_subnet" {
  vpc_id                  = "${aws_vpc.iac_vpc.id}"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-west-1a"

  tags {
    Name = "iac_public_subnet"
  }
}

#######################################################
#####     PRIVATE SUBNET 	                  #####
#######################################################

resource "aws_subnet" "iac_private_subnet" {
  vpc_id                  = "${aws_vpc.iac_vpc.id}"
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "eu-west-1a"

  tags {
    Name = "iac_private_subnet"
  }
}

#######################################################
######     INTERNET GATEWAY                       #####
#######################################################
resource "aws_internet_gateway" "iac_gw" {
  vpc_id = "${aws_vpc.iac_vpc.id}"

  tags {
    Name = "iac_gw"
  }
}

#######################################################
#####     NETWORK ADDRESS TRANSLATION ELASTIC IP ######
#######################################################

resource "aws_eip" "ngw_elastic_ip" {
  vpc = true

  tags = {
    Name = "iac_ngw"
  }
}

resource "aws_nat_gateway" "iac_nat_gateway" {
  allocation_id = "${aws_eip.ngw_elastic_ip.id}"
  subnet_id     = "${aws_subnet.iac_public_subnet.id}"
  depends_on    = ["aws_internet_gateway.iac_gw"]

  tags {
    Name = "iac_nat_eip"
  }
}

#######################################################
######     ROUTE TABLE 			          #####
#######################################################

resource "aws_route_table" "iac_public_rt" {
  vpc_id = "${aws_vpc.iac_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.iac_gw.id}"
  }

  tags {
    Name = "iac_public_rt"
  }
}

#######################################################
#####     ASSIGN ROUTE TABLE TO PUBLIC SUBNET     #####
#######################################################

resource "aws_route_table_association" "iac_public_assoc" {
  subnet_id      = "${aws_subnet.iac_public_subnet.id}"
  route_table_id = "${aws_route_table.iac_public_rt.id}"
}

#######################################################
#####     SSH and SECURITY GROUP        	  #####
#######################################################

resource "aws_key_pair" "web-ec2-key" {
  key_name   = "web-key"
  public_key = "${file("~/.ssh/app-ec2-key.pub")}"
}

resource "aws_security_group" "iac_allow_ssh" {
  vpc_id      = "${aws_vpc.iac_vpc.id}"
  name        = "iac_allow_sh"
  description = "security group that allows ssh and all egress traffic"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "iac_allow_ssh"
  }
}

#######################################################
#####     AUTO SCALING GROUP    		  #####
#######################################################

resource "aws_launch_configuration" "iac_asg_launchconfig" {
  name_prefix     = "iac_asg_launchconfig"
  image_id        = "${lookup(var.amis,var.region)}"
  instance_type   = "t2.micro"
  key_name        = "${aws_key_pair.web-ec2-key.key_name}"
  security_groups = ["${aws_security_group.iac_allow_ssh.id}"]
 user_data = <<EOF
#!/bin/bash
sudo yum install httpd -y
sudo cd /var/www/html
sudo echo "Hello World" > index.html
sudo chkconfig httpd on
sudo service httpd start
EOF
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "iac_asg_autoscaling" {
  name                      = "iac_asgautoscaling"
  vpc_zone_identifier       = ["${aws_subnet.iac_public_subnet.id}"]
  launch_configuration      = "${aws_launch_configuration.iac_asg_launchconfig.name}"
  min_size                  = 2
  max_size                  = 3
  health_check_grace_period = 300
  health_check_type         = "EC2"
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "ec2 instances"
    propagate_at_launch = true
  }
}

#######################################################
#####     ELASTIC LOAD BALANCER                   #####
#######################################################
resource "aws_security_group" "iac_elb" {
  name = "iac_elb"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_elb" "iac-elb" {
  name               = "iac-asg-sample"
  security_groups    = ["${aws_security_group.iac_elb.id}"]
  availability_zones = ["${data.aws_availability_zones.all.names}"]

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:8080/"
  }

  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = "8080"
    instance_protocol = "http"
  }
}
