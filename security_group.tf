#Security Group for VPC
resource "aws_security_group" "allow-dev-ssh" {
  vpc_id = aws_vpc.development-vpc.id

  name    = "allow-dev-ssh"
  description  = "security group that allows ssh connection"

  egress {
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port  = 22
    to_port    = 22
    protocol   = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow-dev-ssh"
  }
}