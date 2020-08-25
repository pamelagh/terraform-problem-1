variable nat_cidr_block {
    type        = string
    description = "IP addressing scheme for NAT gateway."
}

variable private_network_1_cidr_block {
    type        = string
    description = "IP addressing scheme for private network 1."
}

variable private_network_2_cidr_block {
    type        = string
    description = "IP addressing scheme for private network 2."
}

variable profile {
    type        = string
    default     = "default"
    description = "AWS profile name."
}

variable public_network_1_cidr_block {
    type        = string
    description = "IP addressing scheme for public network 1."
}

variable public_network_2_cidr_block {
    type        = string
    description = "IP addressing scheme for public network 2."
}

variable region {
    type        = string
    description = "AWS region."
}

variable table_routes_cidr_block {
    type        = string
    description = "IP addressing scheme for table routes."
}

variable vpc_cidr_block {
    type        = string
    description = "IP addressing scheme for VPC."
}
