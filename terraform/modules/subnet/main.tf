#Create a Subnet
resource "aws_subnet" "my_subnet" {
  vpc_id = var.vpc_id
  #vpc_id     = aws_vpc.my_vpc.id
  #cidr_block = "10.0.1.0/24"
   cidr_block = var.subnet_cidr_block
   availability_zone = var.az
  tags = {
    #Name = "my_own_subnet"
    Name = "${var.env}-subnet"
  }
}

#Create IGW
resource "aws_internet_gateway" "my_IGW" {
 # vpc_id = aws_vpc.my_vpc.id
    vpc_id = var.vpc_id
  tags = {
    #Name = "my_own_IGW"
    Name = "${var.env}-IGW"
  }
}

#Create a route table
resource "aws_route_table" "my_routetable" {
  #vpc_id = aws_vpc.my_vpc.id
    vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_IGW.id
  }
  tags = {
    #Name = "my_own_routetable"
    Name = "${var.env}-Routetable"
  }
}

#associate route table to the subnet
resource "aws_route_table_association" "my_route_table_ass" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.my_routetable.id
}