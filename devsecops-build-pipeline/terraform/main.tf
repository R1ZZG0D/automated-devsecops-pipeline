provider "aws" {
  region = "us-east-2"
}

############################################
# Data Sources (Reference, Don't Recreate)
############################################

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = data.aws_vpc.default.id
}

############################################
# Jenkins Security Group (Managed by Us)
############################################

module "jenkins_sg" {
  source = "./modules/security_group"

  name        = "jenkins-sg"
  description = "Security Group for jenkins server"
  vpc_id      = data.aws_vpc.default.id

  ingress_rules = [
    {
      description = "HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "HTTPS"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "Sonar webhook"
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "SSH from my IP"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["69.251.125.110/32"]
    }
  ]
}

############################################
# EC2 Instances
############################################

module "ec2_instances" {
  source = "./modules/ec2"

  instances = {
    build-server = {
      instance_type = "t2.medium"
      key_name      = "build-server"
      private_ip    = "172.31.29.116"
      volume_size   = 20
      sg_ids        = [data.aws_security_group.default.id]  # Uses default VPC SG automatically
    }

    sonarqube-server = {
      instance_type = "t2.medium"
      key_name      = "build-server"
      private_ip    = "172.31.23.143"
      volume_size   = 20
      sg_ids        = [data.aws_security_group.default.id]
    }

    jenkins-server = {
      instance_type = "t2.medium"
      key_name      = "jenkins-key"
      private_ip    = "172.31.17.136"
      volume_size   = 20
      sg_ids        = [module.jenkins_sg.id]
    }

    minikube-server = {
      instance_type = "t3.large"
      key_name      = "build-server"
      private_ip    = "172.31.30.9"
      volume_size   = 25
      sg_ids        = [data.aws_security_group.default.id]
    }
  }

  subnet_id = data.aws_subnets.default.ids[0]
  ami_id    = "ami-0503ed50b531cc445"
}