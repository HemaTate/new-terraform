provider "aws" {
    region = "us-east-1"
    profile = "tf"
}
resource "aws_instance" "inst" {
    ami = "var.ami_id"
    instance type = "var.instance_type "
    key_name = "var.key_name"
     
     tags ={
        name = "var.tags"
     }
}
variable = "ami_id" {
     type = sring
     description = "define var for ami id"
     default = " "
}
variable = "instance_type" {
     type = sring
     description = "define var for instance_type"
     default = "t2/micro"
}
variable = "key_name" {
     type = sring
     description = "define var for key name"
     default = "master"
}
variable = "tags" {
     type = sring
     description = "definr var for tag"
     default = "my instance"
}
