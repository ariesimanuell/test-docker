resource "aws_subnet" "publictestA" {
  vpc_id            = aws_vpc.testvpcaries.id
  cidr_block        = var.Subnet-Publics
  availability_zone = data.aws_availability_zones.available.names[0]
}
resource "aws_route_table_association" "publictestA" {
  subnet_id      = aws_subnet.publictestA.id
  route_table_id = aws_route_table.public.id
}