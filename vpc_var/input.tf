variable "vpc_cidr_block" {
    type = string
}

variable "subnet_block" {
    type = list(string)
}
variable "public_ip" {
    type = bool
}
variable "az" {
    type = list(string)
}
