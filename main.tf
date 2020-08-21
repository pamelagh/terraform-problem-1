provider "aws" {
    profile = "default"
    region  = "us-east-1"
}

resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16" #use IPs with 10.0.X.X
    instance_tenancy = "default"
    enable_dns_support = "true" #internal domain name
    enable_dns_hostnames = "true" #internal host name
    enable_classiclink = "false"
}

resource "aws_internet_gateway" "default" {
    vpc_id = aws_vpc.main.id
}

resource "aws_eip" "nat" {
    vpc = true
}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.3.0/24"
    map_public_ip_on_launch = "true"
}

resource "aws_nat_gateway" "nat" {
    allocation_id = aws_eip.nat.id
    subnet_id     = aws_subnet.public.id
    depends_on = [
        aws_internet_gateway.default
    ]
}

resource "aws_subnet" "public-network-1" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.1.0/24" #256 possible IPs
    map_public_ip_on_launch = "true"
}

resource "aws_subnet" "public-network-2" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = "true"
}

# resource "aws_subnet" "private-network-1" {
#     vpc_id = aws_vpc.main.id
#     cidr_block = "10.0.3.0/24"
#     map_public_ip_on_launch = "false"
# }

# resource "aws_subnet" "private-network-2" {
#     vpc_id = aws_vpc.main.id
#     cidr_block = "10.0.4.0/24"
#     map_public_ip_on_launch = "false"
# }
