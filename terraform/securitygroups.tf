resource "aws_security_group" "Test1" {
  name = "Test1"
  tags = {
    Name = "Test1"
  }
  vpc_id = aws_vpc.testvpcaries.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "Test2" {
  name = "Test2"
  tags = {
    Name = "Test2"
  }
  vpc_id = aws_vpc.testvpcaries.id
  ingress {
    from_port   = 9200
    to_port     = 9200
    protocol    = "TCP"
    cidr_blocks = ["172.28.0.5/32"]
  }
  ingress {
    from_port   = 9300
    to_port     = 9300
    protocol    = "TCP"
    cidr_blocks = ["172.28.0.5/32"]
  }
  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}