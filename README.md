# Terraform +  AWS provisioning

Tools version needed to install. 
```
- Terraform v0.11.13
- git version 2.14.5 
```
## Hashicorp 

* [Terraform](https://releases.hashicorp.com/terraform/) - Releases


## Below are the high level instruction
```
	1.) Install terraform in terminal 
	2.) Perform clone from github 
	3.) Create/Use AWS Account with enough privileges to perform provisioning
```

### Steps 1
```
 cd /usr/local/src
 wget https://releases.hashicorp.com/terraform/0.11.13/terraform_0.11.13_linux_386.zip
 unzip terraform_0.11.13_linux_386.zip
 mv terraform /usr/local/bin/

### Now add the following line to add terraform in PATH location

 export PATH=$PATH:/terraform-path/

### Verify installation running "terraform version"

```
Terraform v0.11.13

Your version of Terraform is out of date! The latest version
is 0.12.6. You can update by downloading from www.terraform.io/downloads.html
```
  
```


