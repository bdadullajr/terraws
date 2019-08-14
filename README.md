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
```

### Steps 1
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
### Steps 2
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
### Steps 2
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




