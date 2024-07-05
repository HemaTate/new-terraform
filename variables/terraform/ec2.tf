provider "aws" {
  # Configuration options
  region = "us-east-1"
  profile = "tf"
}
resource "aws_instance" "sample" {
  ami = ami-01b799c439fd5516a
  instance_type = "t2.micro"
  key_name = "master"
tags = {
    Name = "HelloWorld"
  }
}