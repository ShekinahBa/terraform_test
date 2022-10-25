#initialising backend.. directing terraform to store in the S3 created on AWS
terraform {
  backend "s3" {
    bucket = "terraformtestbuckettest"
    key    = "testterra/terraform.tfstate"
    region = "eu-west-2"
  }
}

# creating a new VPC
resource "aws_vpc" "new_name" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "first_VPC"
  }
}

#creating subnet for VPC
resource "aws_subnet" "pub_sub_name" {
  vpc_id     = aws_vpc.new_name.id
  cidr_block = var.sub_cidr

  tags = {
    Name = "first_subnet"
  }

}
# creating the routing table for the subnet attached to the VPC 
# routing table determines which subnet is public and private 
resource "aws_route_table" "routetable_name" {
  vpc_id = aws_vpc.new_name.id

  tags = {
    Name = "first_routingtable"
  }

}

# connecting a route to the routing table 
# destination cider block is the internet..basically anywhere.. because 
# this is a public subnet 
resource "aws_route" "route_name1" {
  route_table_id         = aws_route_table.routetable_name.id
  gateway_id             = aws_internet_gateway.gateway_name.id
  destination_cidr_block = "0.0.0.0/0"
}

# create interenet gateway
resource "aws_internet_gateway" "gateway_name" {
  vpc_id = aws_vpc.new_name.id

  tags = {
    Name = "first_gateway"
  }

}

resource "aws_route_table_association" "association_name" {
  subnet_id      = aws_subnet.pub_sub_name.id
  route_table_id = aws_route_table.routetable_name.id

}

