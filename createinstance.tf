# Creat EC2 Instance
resource "aws_key_pair" "dev-key" {
  key_name = "dev-key"
  public_key  = file(var.PATH_TO_PUBLIC_KEY)
}


resource "aws_instance" "my-instances" {
    ami           = lookup(var.AMIS, var.AWS_REGION)
 #  ami           = "ami-01685d240b8fbbfeb"
    instance_type = "t2.micro"
    key_name   = aws_key_pair.dev-key.key_name
    
    provisioner "local-exec" {
    	command = "echo aws_instance.my-instances.private_ip >> my_private_ips.txt"
    }
    vpc_security_group_ids = [aws_security_group.allow-dev-ssh.id]
    subnet_id  = aws_subnet.dev-public-subnet-1.id
    tags = {
      Name = "custom_instance"
    }
}


output "dev-instance-ip" {
   value = aws_instance.my-instances.public_ip
}
