provider "aws" {
    profile = var.profile
    region  = var.region
}

module "networks" {
    source = "./modules/networks"
    
    nat_cidr_block = var.nat_cidr_block
    private_network_1_cidr_block = var.private_network_1_cidr_block
    private_network_2_cidr_block = var.private_network_2_cidr_block
    
    public_network_1_cidr_block = var.public_network_1_cidr_block
    public_network_2_cidr_block = var.public_network_2_cidr_block
    
    table_routes_cidr_block = var.table_routes_cidr_block
    vpc_cidr_block = var.vpc_cidr_block
}
