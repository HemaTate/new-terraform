resource "aws_vpc" "vpc1" {
    cidr_block = var.vpc_cidr_block
    tags ={
        name = "myvpc"
    }
}
resource "aws_subnet" "pubsub" {
    vpc_id = aws_vpc.vpc1.id
    cidr_block = var.subnet_block[0]
    availability_zone = var.az[0]
    map_public_ip_on_launch = var.public_ip
    tags ={
        name = "pubsub"
    }
}
resource "aws_subnet" "prisub"{
    vpc_id = aws_vpc.vpc1.id
    cidr_block = var.subnet_block[1]
    availability_zone = var.az[1]

    tags ={
        name = "pubsub"
    }
}
output "vpc_id" {
    value = aws_vpc.vpc1.id
}
