resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.main.id
  count = var.public_subnet_count
  cidr_block = var.public_subnet_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "${var.vpc_name}-public-${count.index}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_name}-public-route-table"
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "public_association" {
  count           = var.public_subnet_count
  subnet_id       = aws_subnet.public[count.index].id
  route_table_id  = aws_route_table.public.id
}

resource "aws_security_group" "main" {
  name        = var.sg_name
  vpc_id      = aws_vpc.main.id

  # Allow inbound traffic for each port in the allowed_ports list
  dynamic "ingress" {
    for_each = var.allowed_ports
    content {
      description      = "Allow access on port ${ingress.value}"
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      cidr_blocks      = var.allowed_cidr_blocks
    }
  }

  # Allow all outbound traffic
  egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.sg_tags
  }
}