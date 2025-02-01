output "ssh-command-to-server" {
  value = "ssh -i ssh-key.pem ec2-user@${aws_instance.Web_access[0].public_ip}"

}

output "server1" {
  value = aws_instance.Web_access[0].id

}


output "server2" {
  value = aws_instance.Web_access[1].id

}

output "server3" {
  value = aws_instance.Web_access[2].id

}