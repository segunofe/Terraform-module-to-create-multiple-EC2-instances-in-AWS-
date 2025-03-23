# Terraform-module-to-create-multiple-EC2-instances-in-AWS

![image](https://github.com/user-attachments/assets/8f882b36-daf2-4626-8a64-5e70c6fdfacb)


Step 1: create the directories and the files as shown in the image 
Step 2: create the variable.tf file inside the module (ec2-instance) 

variable "instance_name" {
    description = "Name of the EC2 instance"
    type = string
}

variable "ami_id"{
    description = "AMI ID for the EC2 instance"
    type = string
}

variable "instance_type"{
    description = "EC2 instance type"
    type = string
    default = "t3.micro"
}

variable "instance_count"{
    description = "Number of EC2 instance to create"
    type = number
}


Step 3: create the main.tf file inside the module 

resource "aws_instance" "webserver" {
    count = var.instance_count
    ami = var.ami_id
    instance_type = var.instance_type
    
    tags = {
        Name = "${var.instance_name}-${count.index + 1}"
    } 
    
}

Step 4: create the output.tf file inside the module 

output "instance_ids" {
    value = aws_instance.webserver[*].id
}

output "public_ips"{
    value = aws_instance.webserver[*].public_ip
}

Step 5: create the main.tf file outside the module
provider "aws" {
  region = "us-west-2"
}

module "multiple_ec2_instances" {
  source         = "./modules/ec2-instance"
  ami_id         = "ami-07d9cf938edb0739b"
  instance_count = 3
  instance_name  = "webserver"
}

output "instance_ids" {
  value = module.multiple_ec2_instances.instance_ids
}

output "public_ips" {
  value = module.multiple_ec2_instances.public_ips
}
