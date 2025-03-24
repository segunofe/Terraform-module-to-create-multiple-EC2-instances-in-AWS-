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