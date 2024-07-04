
provider "aws" {
  region  = "ap-south-1"
  profile = "tf-user"

}

# create iam users
resource "aws_iam_user" "demo" {
  name = "oggy"
}

resource "aws_iam_user" "demo1" {
  name = "olivia"
}

resource "aws_iam_user" "demo2" {
  name = "jack"
}

resource "aws_iam_user" "demo3" {
  name = "bob"
}
#create iam group
resource "aws_iam_group" "grp" {
  name = "oggyandcrocs"
}

resource "aws_iam_group" "team" {
  name = "tomandjerry"
}

# add users into group
resource "aws_iam_group_membership" "test" {

  name = "test_iam_group_membership"

  users = [ 
    aws_iam_user.demo.name,
    aws_iam_user.demo1.name,
    aws_iam_user.demo2.name,
    aws_iam_user.demo3.name
  ]
  group = aws_iam_group.grp.name
}

# create s3 bucket 
resource "aws_s3_bucket" "bucket" {
  bucket = "thelordoftherings"
  

  tags = {
    Name = "rings of power"
    Environment = "Dev"
  }
  
}

# create ec2 instance
resource "aws_instance" "vm" {
  ami = "ami-04f8d7ed2f1a54b14"
  instance_type = "t2.micro"
  key_name = "tf-key"
  vpc_security_group_ids = [aws_security_group.sg-1.id]  # reference of sg created below

  tags = {
    Name = "server"
  }
  
}
#create security group
resource "aws_security_group" "sg-1" {
  name = "tf-demo-sg"
  vpc_id = "vpc-04ada8ce11d206fd5"  # take vpc id from aws vpc

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# display public ip of instance
output "public_ip" {
  value = aws_instance.vm.public_ip
}
