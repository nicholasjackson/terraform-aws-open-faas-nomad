variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "azs" {
  default = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "private_subnets" {
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

# Create a VPC to launch our instances into
resource "aws_vpc" "default" {
  cidr_block           = "10.0.0.0/16"
  cidr_block           = "${var.vpc_cidr_block}"
  enable_dns_hostnames = true

  tags {
    "Name" = "${var.namespace}"
  }
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"

  tags {
    "Name" = "${var.namespace}"
  }
}

# Grant the VPC internet access on its main route table
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.default.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.default.id}"
}

# Create a subnet to launch our instances into
resource "aws_subnet" "default" {
  count                   = "${length(var.private_subnets)}"
  vpc_id                  = "${aws_vpc.default.id}"
  availability_zone       = "${var.azs[count.index]}"
  cidr_block              = "${var.private_subnets[count.index]}"
  map_public_ip_on_launch = true

  tags {
    "Name" = "${var.namespace}"
  }
}
