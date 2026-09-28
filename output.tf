output "ec2_instance_ids" {
  value = {
    for key, instance in aws_instance.EC2_instance :
    key => instance.id
  }
}


output "ec2_public_ips" {
  value = {
    for key, instance in aws_instance.EC2_instance :
    key => instance.public_ip
  }
}


output "load_balancer_dns" {
  value = aws_elb.my_classic_lb.dns_name
}