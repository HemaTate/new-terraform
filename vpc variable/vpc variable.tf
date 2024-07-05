#main.tf(declare resource)
resource "aws_vpc" "vpc1" {
    cidr_block = "vpc_cidr_block"
    tags ={
        name ="myvpc"
    }
}
resource "aws_subnet" "pubsub"{
    cidr_block = "subnet_cidr_block" [0]
    vpc_id = aws_vpc.vpc1.id
    availability_zone = "avability_zone" [0]
    map_public_ip_on_launch = "public_ip_to_enable_sub"
    tags ={
        name = "pubsub"
    }
}
resource "aws_subnet" "prisub"{
    vpc_id =aws_vpc.vpc1.id
    cidr_block = "subnet_cidr_block" [1]
    availability_zone = "avability_zone" [1]
    map_public_ip_on_launch = false
    tags ={
        name = "pubsub"
    }
}
output = "vpc_id" {
    value = aws_vpc.vpc1.id
}

#input.tf (using to pass variables)
variable "vpc_cidr_block" {
    type = string
}

variable "subnet_cidr_block" {
    type = list(string)
}
variable "public_ip_to_enable_sub"{
    type = bool
}
variable "avability_zone"{
    type = list(string)
}

#variable_value_.tf -->declare value here of our variable
vpc_cidr_block = "10.0.0.0/16"
subnet_cidr_block =["10.0.1.0/16","10.0.2.0/16"]
public_ip_to_enable_sub = true /*true means we assign the public ip to our subnet*/
avability_zone = ["us-east-1a","us-east-1b"]

