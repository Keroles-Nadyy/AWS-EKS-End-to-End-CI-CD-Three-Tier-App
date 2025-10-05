resource "aws_route_table" "route_tables" {
  count  = 2
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = count.index == 0 ? aws_internet_gateway.main_igw.id : aws_nat_gateway.main_ngw.id
  }
  tags = {
    Name = count.index == 0 ? "${var.common_resource_name}_Public_Route_Table" : "${var.common_resource_name}_private_Route_Table"
  }
}

# ==================================== Public Route Table ======================================
resource "aws_route_table_association" "public_rt_associate" {
  for_each = { for subnet in var.subnets_details : subnet.name => subnet if subnet.type == "public"}
  subnet_id      = aws_subnet.subnets[each.key].id
  route_table_id = aws_route_table.route_tables[0].id
}


# ==================================== Private Route Table ======================================
resource "aws_route_table_association" "private_rt_associate" {
  for_each = { for subnet in var.subnets_details : subnet.name => subnet if subnet.type == "private"}
  subnet_id      = aws_subnet.subnets[each.key].id
  route_table_id = aws_route_table.route_tables[1].id
}

