# create a variable file

variable "vpc_cidr" {
    type = string
    description = "cidr for dev vpc"
    default = "10.0.0.0/16"
}

variable "pub_subnet_1a_cidr" {
    type = string
    description = "cidr for public subnet 1a"
    default = "10.0.0.0/24"
}

variable "pub_subnet_1b_cidr" {
    type = string
    description = "cidr for public subnet 1b"
    default = "10.0.1.0/24"
}
