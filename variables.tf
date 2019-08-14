variable "region" {
  description = "AWS region for hosting our your network"
  default     = "eu-west-1"
}

variable "amis" {
  description = "Base AMI to launch the instances"

  default = {
    eu-west-1 = "ami-0bbc25e23a7640b9b"
  }
}
