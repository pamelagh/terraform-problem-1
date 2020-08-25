variable nat_cidr_block {}

variable private_network_1_cidr_block {}

variable private_network_2_cidr_block {}

variable public_network_1_cidr_block {}

variable public_network_2_cidr_block {}

variable table_routes_cidr_block {}

variable vpc_cidr_block {}

variable vpc_instance_tenancy {
    type = string
    default = "default"
    description = "Instance launched into the VPC."
}
