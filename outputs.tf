output "dev_ip" {
  value = aws_instance.dev_node.public_ip

}

output "dev_dns" {
  value = aws_instance.dev_node.public_dns
}
