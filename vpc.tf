provider  "aws" {
region = "us-east-1"
profile = "tf" 
}
resource "aws_vpc" "myvpc"{
    cidr_block = "198.168.0.0/16"
    tags = {
        name = "myvpc"
    }
}
resource "aws_subnet" "pubsub" {
    vpc_id = aws_vpc.myvpc.id
    cidr-block = "198.168.0.0/24"
    avability_zone = "us-east-1"
     aws_public_ip_on_launch = true
     
     tags = {
        name = "pubsubnet"
     }
}
resource "aws_subnet" "private" {
    vpc_id     = aws_vpc.myvpc.id
    cidr_block = "10.0.1.0/24" 
    aws_public_ip_on_launch = false
  
    tags = {
      Name = "prisub"
    }
  }
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.myvpc.id
  
    tags = {
      Name = "intgw"
    }
  }

  resource "aws_rout_table" "pubrt" {
    vpc_id = aws_vpc.myvpc.id
    rout {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
  
    tags = {
      Name = "routtable"
    }
  }
  resource "aws_route_table_association" "attach" {
    subnet_id      = aws_subnet.pubsub.id
    route_table_id = aws_route_table.pubrt.id
  }
  resource "aws_eip" "elastic" {
    domain = "vpc"

  }
  
  resource "aws_nat_gateway" "example" {
    allocation_id = aws_eip.elastic.id
    subnet_id     = aws_subnet.pubsub.id
  
    tags = {
      Name = "NAT-gw"
    }
  }
  resource "aws_route_table" "private-rt" {
    vpc_id = aws_vpc.myvpc.id
  
    route {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.example.id
    }
    tags = {
      Name = "Private-RT"
    }
  }
  
  resource "aws_route_table_association" "attach2" {
    subnet_id      = aws_subnet.private.id
    route_table_id = aws_route_table.private-rt.id
  
  }
  
  output "vpc_id" {
    value = aws_vpc.myvpc.id
  