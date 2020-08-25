provider "aws" {
    profile = var.profile
    region  = var.region
}

resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr_block
    instance_tenancy = var.vpc_instance_tenancy
    enable_dns_support = "true" #to have internal domain name
    enable_dns_hostnames = "true" #to have internal host name
    enable_classiclink = "false"
}

resource "aws_internet_gateway" "default" {
    vpc_id = aws_vpc.main.id
}

resource "aws_subnet" "public-nat" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.nat_cidr_block
    map_public_ip_on_launch = "true"
}

resource "aws_eip" "nat" {
    vpc = true
}

resource "aws_nat_gateway" "nat" {
    allocation_id = aws_eip.nat.id
    subnet_id     = aws_subnet.public-nat.id
    depends_on = [
        aws_internet_gateway.default
    ]
}

resource "aws_subnet" "public-network-1" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.public_network_1_cidr_block #256 possible IPs
    map_public_ip_on_launch = "true"
}

resource "aws_subnet" "public-network-2" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.public_network_2_cidr_block
    map_public_ip_on_launch = "true"
}

resource "aws_route_table" "public-routes" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = var.table_routes_cidr_block
        gateway_id = aws_internet_gateway.default.id
    }
}

resource "aws_route_table_association" "public-1" {
    subnet_id = aws_subnet.public-network-1.id
    route_table_id = aws_route_table.public-routes.id
}

resource "aws_route_table_association" "public-2" {
    subnet_id = aws_subnet.public-network-2.id
    route_table_id = aws_route_table.public-routes.id
}

resource "aws_route_table_association" "public-nat" {
    subnet_id = aws_subnet.public-nat.id
    route_table_id = aws_route_table.public-routes.id
}

resource "aws_route_table" "private-routes" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = var.table_routes_cidr_block
        nat_gateway_id = aws_nat_gateway.nat.id
    }
}

resource "aws_subnet" "private-network-1" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.private_network_1_cidr_block
    map_public_ip_on_launch = "false"
}

resource "aws_subnet" "private-network-2" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.private_network_2_cidr_block
    map_public_ip_on_launch = "false"
}

resource "aws_route_table_association" "private-1" {
    subnet_id = aws_subnet.private-network-1.id
    route_table_id = aws_route_table.private-routes.id
}

resource "aws_route_table_association" "private-2" {
    subnet_id = aws_subnet.private-network-2.id
    route_table_id = aws_route_table.private-routes.id
}
