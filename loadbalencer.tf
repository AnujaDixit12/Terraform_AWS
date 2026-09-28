resource "aws_elb" "my_classic_lb" {

  name = "terraform-classic-lb"

  subnets = [
    aws_subnet.subnet_1.id,
    aws_subnet.subnet_2.id
  ]

  security_groups = [
    aws_security_group.my_app_group.id
  ]

  listener {
    instance_port     = 80
    instance_protocol = "http"

    lb_port     = 80
    lb_protocol = "http"
  }

  health_check {
    target              = "HTTP:80/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  instances = [
    for instance in aws_instance.EC2_instance : instance.id
  ]

  tags = {
    Name = "Terraform-Classic-LB"
  }
}