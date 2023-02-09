# create a variable file

variable "vpc_cidr" {
    type = string
    description = "cidr for dev vpc"
    default = "10.0.0.0/16"
}