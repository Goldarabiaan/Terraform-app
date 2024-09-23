

# Frontend instance 1
resource "aws_instance" "frontend_instance_1" {
  ami           = "ami-02f55bfb3e1ff7264"  
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id
  security_groups = [aws_security_group.allow_web.id]

  tags = {
    Name = "frontend_instance_1"
  }
}

# Frontend instance 2
resource "aws_instance" "frontend_instance_2" {
  ami           = "ami-02f55bfb3e1ff7264"  
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id
  security_groups = [aws_security_group.allow_web.id]

  tags = {
    Name = "frontend_instance_2"
  }
}

# Backend instance 1
resource "aws_instance" "backend_instance_1" {
  ami           = "ami-01b4c055f2cde34f2"  
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_subnet.id

  tags = {
    Name = "backend_instance_1"
  }
}

# Backend instance 2
resource "aws_instance" "backend_instance_2" {
  ami           = "ami-01b4c055f2cde34f2"  
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_subnet.id

  tags = {
    Name = "backend_instance_2"
  }
}