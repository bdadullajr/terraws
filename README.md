# Terraform +  AWS provisioning

#Version: 
*Terraform v0.11.13
*git version 2.14.5 

#Prerequisite:
	*1.) Installed terraform version - https://releases.hashicorp.com/terraform/
	*2.) Git to clone from github
	*3.) AWS Account with enough privileges
		*- Access key ID
		*- Secret access key

  

## Terraform module

Create a stand-alone Terraform module (e.g.: in its own directory, github or similar),
which is able to do the following:

* Provision a VPC with private and public subnets
* Provision IGW and NAT gateways
* Provision Security Groups and routing tables
* Provision a Load Balancer with an ASG behind (any number of EC2 instances)
* Run a webserver in the ASG EC2 instances (custom AMI, docker or via userdata)

The final setup should look like this:
```
                  +---VPC-------------------------------------+
                  |                  |                        |
                  |        +-----+   |   +--------------+     |
                  |        | NAT |   |   | +-----+      |     |
                  |        +-----+   |   | | EC2 |      |     |
               +-----+     +-----+   |   | +-----+      |     |
HTTP(S) <----> | IGW |<--->|  LB |<--|-->|         ASG  |     |
               +-----+     +-----+   |   | +-----+      |     |
                  |                  |   | | EC2 |      |     |
                  |                  |   | +-----+      |     |
                  |                  |   +--------------+     |
                  | pub subnet       | priv subnet            |
                  +-------------------------------------------+
```

## Terraform root module

Provide a root module using the above module which provisions two EC2 instances only allowed to
be accessed by the load balancer on 80 and/or 443.

Additionally after successful run you should have the following Terraform outputs:

* LB endpoint address
* VPC id
* Subnet id's
* EIP of NAT GW


