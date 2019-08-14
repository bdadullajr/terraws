# Terraform +  AWS provisioning

Tools version needed to install. 
```
- Terraform v0.11.13
- git version 2.14.5 
```
## Hashicorp 

* [Terraform](https://releases.hashicorp.com/terraform/) - Releases


## High level instructions
```
	1.) Install terraform in environment 
	2.) Perform clone from github 
	3.) AWS IAM credential should be created 
	4.) Terraform + AWS Provisioning "How to"
	5.) Terraform destroy to avoid unwanted charges :)
```

## Technical Steps guidelines 
### Step 1
```
--- Download and Install

 cd /usr/local/src
 wget https://releases.hashicorp.com/terraform/0.11.13/terraform_0.11.13_linux_386.zip
 unzip terraform_0.11.13_linux_386.zip
 mv terraform /usr/local/bin/

--- Setup Path

 export PATH=$PATH:/terraform-path/

--- Verify installation running "terraform version"

Terraform v0.11.13

Your version of Terraform is out of date! The latest version
is 0.12.6. You can update by downloading from www.terraform.io/downloads.html
  
```
### Step 2
```
--- Clone repository from Github

[root@jenkins root_modules]# git clone https://github.com/bdadullajr/terraws.git
Cloning into 'terraws'...
remote: Enumerating objects: 67, done.
remote: Counting objects: 100% (67/67), done.
remote: Compressing objects: 100% (47/47), done.
remote: Total 67 (delta 16), reused 63 (delta 15), pack-reused 0
Unpacking objects: 100% (67/67), done.
[root@jenkins root_modules]# cd terraws/
[root@jenkins terraws]# ls -lart
total 32
drwxr-xr-x 11 root root 4096 Aug 14 11:37 ..
-rw-r--r--  1 root root  239 Aug 14 11:37 variables.tf
-rw-r--r--  1 root root  358 Aug 14 11:37 output.tf
-rw-r--r--  1 root root 5747 Aug 14 11:37 main.tf
-rw-r--r--  1 root root  887 Aug 14 11:37 README.md
drwxr-xr-x  8 root root 4096 Aug 14 11:37 .git
drwxr-xr-x  3 root root 4096 Aug 14 11:37 .
[root@jenkins terraws]# 
 
```
### Step 3
```
--- AWS Users information

[root@jenkins terraws]# aws iam get-user
{
    "User": {
        "UserName": "terraform", 
        "Tags": [
            {
                "Value": "flaconi_provisioning", 
                "Key": "terraform"
            }
        ], 
        "CreateDate": "2019-08-10T16:26:59Z", 
        "UserId": "user-id-goes-here", 
        "Path": "/", 
        "Arn": "arn:aws:iam::1234567890:user/terraform"
    }
}
[root@jenkins terraws]# 

```

### Step 4
```
--- Go to "terraws" cloned folder 

[root@jenkins terraws]# ls -lart
total 44
drwxr-xr-x 3 root root  4096 Aug 14 01:47 ..
-rw-r--r-- 1 root root   239 Aug 14 11:26 variables.tf
-rw-r--r-- 1 root root   358 Aug 14 11:26 output.tf
-rw-r--r-- 1 root root  5747 Aug 14 11:26 main.tf
drwxr-xr-x 8 root root  4096 Aug 14 12:35 .git
-rw-r--r-- 1 root root  2301 Aug 14 12:39 README.md
drwxr-xr-x 3 root root  4096 Aug 14 12:40 .
-rw-r--r-- 1 root root 12288 Aug 14 12:41 .README.md.swp
[root@jenkins terraws]# 

--- Initialized and Export "AWS_ACCESS_KEY_ID" and "export AWS_SECRET_ACCESS_KEY" credentials

[root@jenkins terraws]# terraform init

Initializing provider plugins...
- Checking for available provider plugins on https://releases.hashicorp.com...
- Downloading plugin for provider "aws" (2.23.0)...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.aws: version = "~> 2.23"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
[root@jenkins terraws]# export AWS_ACCESS_KEY_ID="Access-goes-here"
[root@jenkins terraws]# export AWS_SECRET_ACCESS_KEY="Secret-goes-here"

--- Test by running "Terraform plan" (E.g below is just a sample out of 14 resources)

 + aws_vpc.iac_vpc
      id:                                          <computed>
      arn:                                         <computed>
      assign_generated_ipv6_cidr_block:            "false"
      cidr_block:                                  "10.0.0.0/16"
      default_network_acl_id:                      <computed>
      default_route_table_id:                      <computed>
      default_security_group_id:                   <computed>
      dhcp_options_id:                             <computed>
      enable_classiclink:                          "false"
      enable_classiclink_dns_support:              <computed>
      enable_dns_hostnames:                        "true"
      enable_dns_support:                          "true"
      instance_tenancy:                            "default"
      ipv6_association_id:                         <computed>
      ipv6_cidr_block:                             <computed>
      main_route_table_id:                         <computed>
      owner_id:                                    <computed>
      tags.%:                                      "1"
      tags.Name:                                   "iac_vpc"


Plan: 14 to add, 0 to change, 0 to destroy.

--- Apply by running "terraform apply -auto-approve" to perform the provisioning

aws_nat_gateway.iac_nat_gateway: Still creating... (10s elapsed)
aws_autoscaling_group.iac_asg_autoscaling: Still creating... (10s elapsed)
aws_nat_gateway.iac_nat_gateway: Still creating... (20s elapsed)
aws_autoscaling_group.iac_asg_autoscaling: Still creating... (20s elapsed)
aws_nat_gateway.iac_nat_gateway: Still creating... (30s elapsed)
aws_autoscaling_group.iac_asg_autoscaling: Still creating... (30s elapsed)
aws_nat_gateway.iac_nat_gateway: Still creating... (40s elapsed)
aws_autoscaling_group.iac_asg_autoscaling: Still creating... (40s elapsed)
aws_autoscaling_group.iac_asg_autoscaling: Creation complete after 44s (ID: iac_asgautoscaling)
aws_nat_gateway.iac_nat_gateway: Still creating... (50s elapsed)
aws_nat_gateway.iac_nat_gateway: Still creating... (1m0s elapsed)
aws_nat_gateway.iac_nat_gateway: Still creating... (1m10s elapsed)
aws_nat_gateway.iac_nat_gateway: Still creating... (1m20s elapsed)
aws_nat_gateway.iac_nat_gateway: Still creating... (1m30s elapsed)
aws_nat_gateway.iac_nat_gateway: Still creating... (1m40s elapsed)
aws_nat_gateway.iac_nat_gateway: Creation complete after 1m48s (ID: nat-0e0ca9887795d5f05)

Apply complete! Resources: 14 added, 0 changed, 0 destroyed.

Outputs:

NAT Elastic IP = 54.77.134.243
Private Subnet ID = subnet-08de89b311bc84770
Public Subnet ID = subnet-0d046248383d2bc87
VPC ID = vpc-0e7a1080fc806cd90
elb_dns_name = iac-asg-sample-1190618414.eu-west-1.elb.amazonaws.com
[root@jenkins terraws]# 

```
### Step 5

```
--- Make sure to destroy resourceccby running "terraform destroy -auto-approve" to avoid unwanted charges

[root@jenkins terraws]# terraform destroy -auto-approve
aws_vpc.iac_vpc: Refreshing state... (ID: vpc-0e7a1080fc806cd90)
aws_security_group.iac_elb: Refreshing state... (ID: sg-04a1154457ce8d44c)
aws_key_pair.web-ec2-key: Refreshing state... (ID: web-key)
aws_eip.ngw_elastic_ip: Refreshing state... (ID: eipalloc-0d61e1fe841f8a5e4)
data.aws_availability_zones.all: Refreshing state...
aws_elb.iac-elb: Refreshing state... (ID: iac-asg-sample)
aws_subnet.iac_private_subnet: Refreshing state... (ID: subnet-08de89b311bc84770)
aws_internet_gateway.iac_gw: Refreshing state... (ID: igw-0e1e103d6ccc4c19f)
aws_subnet.iac_public_subnet: Refreshing state... (ID: subnet-0d046248383d2bc87)
aws_security_group.iac_allow_ssh: Refreshing state... (ID: sg-0e2be91d8a4e9a951)
aws_nat_gateway.iac_nat_gateway: Refreshing state... (ID: nat-0e0ca9887795d5f05)
aws_route_table.iac_public_rt: Refreshing state... (ID: rtb-0af1a3d23b73c5b16)
aws_launch_configuration.iac_asg_launchconfig: Refreshing state... (ID: iac_asg_launchconfig20190814125131236200000001)
aws_route_table_association.iac_public_assoc: Refreshing state... (ID: rtbassoc-08b6b36c14642e120)
aws_autoscaling_group.iac_asg_autoscaling: Refreshing state... (ID: iac_asgautoscaling)
aws_route_table_association.iac_public_assoc: Destroying... (ID: rtbassoc-08b6b36c14642e120)
aws_elb.iac-elb: Destroying... (ID: iac-asg-sample)
aws_nat_gateway.iac_nat_gateway: Destroying... (ID: nat-0e0ca9887795d5f05)
aws_autoscaling_group.iac_asg_autoscaling: Destroying... (ID: iac_asgautoscaling)
aws_subnet.iac_private_subnet: Destroying... (ID: subnet-08de89b311bc84770)
aws_route_table_association.iac_public_assoc: Destruction complete after 1s
aws_route_table.iac_public_rt: Destroying... (ID: rtb-0af1a3d23b73c5b16)
aws_subnet.iac_private_subnet: Destruction complete after 1s
aws_elb.iac-elb: Destruction complete after 2s
aws_security_group.iac_elb: Destroying... (ID: sg-04a1154457ce8d44c)
aws_route_table.iac_public_rt: Destruction complete after 2s
aws_autoscaling_group.iac_asg_autoscaling: Still destroying... (ID: iac_asgautoscaling, 10s elapsed)
aws_nat_gateway.iac_nat_gateway: Still destroying... (ID: nat-0e0ca9887795d5f05, 10s elapsed)
aws_security_group.iac_elb: Still destroying... (ID: sg-04a1154457ce8d44c, 10s elapsed)
aws_nat_gateway.iac_nat_gateway: Still destroying... (ID: nat-0e0ca9887795d5f05, 20s elapsed)
aws_autoscaling_group.iac_asg_autoscaling: Still destroying... (ID: iac_asgautoscaling, 20s elapsed)
aws_security_group.iac_elb: Still destroying... (ID: sg-04a1154457ce8d44c, 20s elapsed)
aws_autoscaling_group.iac_asg_autoscaling: Still destroying... (ID: iac_asgautoscaling, 30s elapsed)
aws_nat_gateway.iac_nat_gateway: Still destroying... (ID: nat-0e0ca9887795d5f05, 30s elapsed)
aws_security_group.iac_elb: Still destroying... (ID: sg-04a1154457ce8d44c, 30s elapsed)
aws_security_group.iac_elb: Destruction complete after 32s
aws_nat_gateway.iac_nat_gateway: Still destroying... (ID: nat-0e0ca9887795d5f05, 40s elapsed)
aws_autoscaling_group.iac_asg_autoscaling: Still destroying... (ID: iac_asgautoscaling, 40s elapsed)
aws_nat_gateway.iac_nat_gateway: Destruction complete after 44s
aws_eip.ngw_elastic_ip: Destroying... (ID: eipalloc-0d61e1fe841f8a5e4)
aws_internet_gateway.iac_gw: Destroying... (ID: igw-0e1e103d6ccc4c19f)
aws_eip.ngw_elastic_ip: Destruction complete after 2s
aws_autoscaling_group.iac_asg_autoscaling: Still destroying... (ID: iac_asgautoscaling, 50s elapsed)
aws_internet_gateway.iac_gw: Still destroying... (ID: igw-0e1e103d6ccc4c19f, 10s elapsed)
aws_internet_gateway.iac_gw: Destruction complete after 12s
aws_autoscaling_group.iac_asg_autoscaling: Still destroying... (ID: iac_asgautoscaling, 1m0s elapsed)
aws_autoscaling_group.iac_asg_autoscaling: Still destroying... (ID: iac_asgautoscaling, 1m10s elapsed)
aws_autoscaling_group.iac_asg_autoscaling: Still destroying... (ID: iac_asgautoscaling, 1m20s elapsed)
aws_autoscaling_group.iac_asg_autoscaling: Destruction complete after 1m27s
aws_subnet.iac_public_subnet: Destroying... (ID: subnet-0d046248383d2bc87)
aws_launch_configuration.iac_asg_launchconfig: Destroying... (ID: iac_asg_launchconfig20190814125131236200000001)
aws_launch_configuration.iac_asg_launchconfig: Destruction complete after 1s
aws_security_group.iac_allow_ssh: Destroying... (ID: sg-0e2be91d8a4e9a951)
aws_key_pair.web-ec2-key: Destroying... (ID: web-key)
aws_key_pair.web-ec2-key: Destruction complete after 0s
aws_subnet.iac_public_subnet: Destruction complete after 2s
aws_security_group.iac_allow_ssh: Destruction complete after 1s
aws_vpc.iac_vpc: Destroying... (ID: vpc-0e7a1080fc806cd90)
aws_vpc.iac_vpc: Destruction complete after 1s

Destroy complete! Resources: 14 destroyed.

```



# Captured evidence 


* [Terminal](https://daduber-storage.s3-ap-southeast-1.amazonaws.com/GIFs/terraform_provisioning.gif)
* [AWS Console](https://daduber-storage.s3-ap-southeast-1.amazonaws.com/GIFs/aws_console.gif)



``` 
