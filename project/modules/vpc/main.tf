# create vpc
resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name = "${var.vpc_name}-${var.env}"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "karim-igw-${var.env}"
  }
  depends_on = [ aws_vpc.vpc ]
}

# Public Subnets web 
resource "aws_subnet" "public_subnets_web" {
  count =  length(var.env_subnets_caracteristics.web) 

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.env_subnets_caracteristics.web[count.index].cidr
  availability_zone       = var.env_subnets_caracteristics.web[count.index].az
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.env_subnets_caracteristics.web[count.index].name}-${var.env}"
  }
  depends_on = [ aws_internet_gateway.igw ]
}

# Private subnets app 
resource "aws_subnet" "private_subnets_app" {
  count = length(var.env_subnets_caracteristics.app) 

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.env_subnets_caracteristics.app[count.index].cidr
  availability_zone       = var.env_subnets_caracteristics.app[count.index].az

  tags = {
    Name = "${var.env_subnets_caracteristics.app[count.index].name}-${var.env}"
  }
  depends_on = [ aws_internet_gateway.igw ]
}

# Private subnets db 
resource "aws_subnet" "private_subnets_db" {
  count = length(var.env_subnets_caracteristics.db) 

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.env_subnets_caracteristics.db[count.index].cidr
  availability_zone       = var.env_subnets_caracteristics.db[count.index].az

  tags = {
    Name = "${var.env_subnets_caracteristics.db[count.index].name}-${var.env}"
  }
  depends_on = [ aws_internet_gateway.igw ]
}

# Elastic IP prod
resource "aws_eip" "eip" {
  count = length(aws_subnet.public_subnets_web)

  domain = "vpc"
  depends_on = [aws_subnet.private_subnets_app, aws_subnet.private_subnets_db]
}

# NAT Gateway prod
resource "aws_nat_gateway" "nat_gateways" {
  count = length(aws_subnet.public_subnets_web) 

  allocation_id = aws_eip.eip[count.index].id
  subnet_id     = aws_subnet.public_subnets_web[count.index].id
  depends_on = [ aws_eip.eip ]
}

# Public Route Table web 
resource "aws_route_table" "public_route_tables_web" {
  count = length(var.env_subnets_caracteristics.web) 

  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "public-route-table-web-${count.index + 1}-${var.env}"
  }
  depends_on = [ aws_subnet.public_subnets_web ]
}

# Route Table Associations web 
resource "aws_route_table_association" "public_route_table_web_association" {
  count = length(var.env_subnets_caracteristics.web) 

  subnet_id      = element(aws_subnet.public_subnets_web[*].id, count.index)
  route_table_id = element(aws_route_table.public_route_tables_web[*].id, count.index)
  depends_on = [ aws_route_table.public_route_tables_web, aws_route.public_internet_gateway_web ]
}

resource "aws_route" "public_internet_gateway_web" {
  count = length(aws_route_table.public_route_tables_web)

  route_table_id         = aws_route_table.public_route_tables_web[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id

  timeouts {
    create = "5m"
  }
  depends_on = [ aws_route_table.public_route_tables_web ]
}

# private route tables app 
resource "aws_route_table" "private_route_tables_app" {
  count = length(var.env_subnets_caracteristics.app) 
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "private-route-table-app-${count.index + 1}-${var.env}"
  }
  depends_on = [ aws_nat_gateway.nat_gateways ]
}

# Private Route Table app Associations
resource "aws_route_table_association" "private_route_table_app_association" {
  count = length(var.env_subnets_caracteristics.web)

  subnet_id      = element(aws_subnet.private_subnets_app[*].id, count.index)
  route_table_id = element(aws_route_table.private_route_tables_app[*].id, count.index)
  depends_on = [ aws_route_table.private_route_tables_app, aws_route.private_nat_gateway_app ]
}

resource "aws_route" "private_nat_gateway_app" {
  count =  length(aws_route_table.private_route_tables_app) 

  route_table_id         = aws_route_table.private_route_tables_app[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat_gateways[count.index].id

  timeouts {
    create = "5m"
  }
  depends_on = [ aws_route_table.private_route_tables_app ]
}

# Private Route Table app 
resource "aws_route_table" "private_route_tables_db" {
  count = length(var.env_subnets_caracteristics.db) 

  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "private-route-table-db-${count.index + 1}"
  }
  depends_on = [ aws_nat_gateway.nat_gateways ]
}

# Private Route Table Associations
resource "aws_route_table_association" "private_route_table_db_association" {
  count = length(var.env_subnets_caracteristics.web) 

  subnet_id      = element(aws_subnet.private_subnets_db[*].id, count.index)
  route_table_id = element(aws_route_table.private_route_tables_db[*].id, count.index)
  depends_on = [ aws_route_table.private_route_tables_db, aws_route.private_nat_gateway_db ]
}

resource "aws_route" "private_nat_gateway_db" {
  count = length(aws_route_table.private_route_tables_db) 

  route_table_id         = aws_route_table.private_route_tables_db[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat_gateways[count.index].id

  timeouts {
    create = "5m"
  }
  depends_on = [ aws_route_table.private_route_tables_db ]
}

resource "aws_security_group" "security_group" {
  for_each = var.env_subnets_caracteristics 
  name        = "security-group-${each.key}-${var.env}"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name = "security-group-${each.key}-${var.env}"
  }
  depends_on = [ aws_subnet.public_subnets_web, aws_subnet.private_subnets_app, aws_subnet.private_subnets_db ]
}

resource "aws_security_group_rule" "security_group_ingress" {
  for_each = var.sg_ingress_rules 

  security_group_id = aws_security_group.security_group[each.value.sg_name].id
  type              = "ingress"
  from_port         = tonumber(split("-", each.value.port_range)[0])
  to_port           = try(tonumber(split("-", each.value.port_range)[1])) == true ? tonumber(split("-", each.value.port_range)[1]) : tonumber(split("-", each.value.port_range)[0])
  protocol          = each.value.protocol
  cidr_blocks       = each.value.dst_cidr != "" ? [each.value.dst_cidr] : null
  source_security_group_id = each.value.dst_sg != "" ? aws_security_group.security_group[each.value.dst_sg].id : null
  depends_on = [ aws_security_group.security_group, aws_nat_gateway.nat_gateways, aws_internet_gateway.igw]
}
