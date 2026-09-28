resource "aws_key_pair" "my_key" {
  key_name   = "my_app_key"
  public_key = file("yourpublickey")
}


resource "aws_security_group" "my_app_group" {

  name        = "my_app-sg"
  description = "this is terraform generated"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH open"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP open"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPS open"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "All outbound port open"
  }
}


resource "aws_instance" "EC2_instance" {

  for_each = {
  server1 = {
    name   = "EC2TERRAFORM-1"
    subnet = aws_subnet.subnet_1.id
  }

  server2 = {
    name   = "EC2TERRAFORM-2"
    subnet = aws_subnet.subnet_2.id
  }
}

  key_name = aws_key_pair.my_key.key_name

  subnet_id = each.value.subnet

  vpc_security_group_ids = [
    aws_security_group.my_app_group.id
  ]

  instance_type = var.ec2_instance_type
  ami           = var.ec2_ami_id

  root_block_device {
    volume_size = var.ec2_root_volume
    volume_type = "gp3"
  }

  user_data = templatefile("hello.sh", {
    server_name = each.value.name
  })

  tags = {
    Name = each.value.name
  }
}