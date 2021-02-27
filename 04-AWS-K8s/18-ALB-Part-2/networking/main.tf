# ---- mtc networking/main.tf -----

data "aws_availability_zones" "available" {}

resource "random_integer" "random" {
  min = 1
  max = 100
}

resource "random_shuffle" "public_az" {
  input        = data.aws_availability_zones.available.names
  result_count = var.max_subnets
}

resource "aws_vpc" "mtc_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "mtc_vpc-${random_integer.random.id}"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_subnet" "mtc_public_subnet" {
  count                   = var.public_sn_count
  vpc_id                  = aws_vpc.mtc_vpc.id
  cidr_block              = var.public_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone       = random_shuffle.public_az.result[count.index]

  tags = {
    Name = "mtc_public_${count.index + 1}"
  }
}

resource "aws_subnet" "mtc_private_subnet" {
  count                   = var.private_sn_count
  vpc_id                  = aws_vpc.mtc_vpc.id
  cidr_block              = var.private_cidrs[count.index]
  map_public_ip_on_launch = false
  availability_zone       = random_shuffle.public_az.result[count.index]

  tags = {
    Name = "mtc_private_${count.index + 1}"
  }
}

resource "aws_db_subnet_group" "mtc_rds_subnetgroup" {
  count      = var.db_subnet_group == "true" ? 1 : 0
  name       = "mtc_rds_subnetgroup"
  subnet_ids = aws_subnet.mtc_private_subnet.*.id
  tags = {
    Name = "mtc_rds_sng"
  }
}

resource "aws_internet_gateway" "mtc_internet_gateway" {
  vpc_id = aws_vpc.mtc_vpc.id

  tags = {
    Name = "mtc_igw"
  }
}

resource "aws_route_table" "mtc_public_rt" {
  vpc_id = aws_vpc.mtc_vpc.id

  tags = {
    Name = "mtc_public"
  }
}


resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.mtc_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.mtc_internet_gateway.id
}


resource "aws_default_route_table" "mtc_private_rt" {
  default_route_table_id = aws_vpc.mtc_vpc.default_route_table_id

  tags = {
    Name = "mtc_private"
  }
}

resource "aws_route_table_association" "mtc_public_assoc" {
  count          = var.public_sn_count
  subnet_id      = aws_subnet.mtc_public_subnet.*.id[count.index]
  route_table_id = aws_route_table.mtc_public_rt.id
}

resource "aws_security_group" "mtc_sg" {
  for_each    = var.security_groups
  name        = each.value.name
  description = each.value.description
  vpc_id      = aws_vpc.mtc_vpc.id



  #public Security Group
  dynamic "ingress" {
    for_each = each.value.ingress
    content {
      from_port   = ingress.value.from
      to_port     = ingress.value.to
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}