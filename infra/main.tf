resource "aws_instance" "app_server" {
  ami           = "ami-ff0fea8310f3"
  instance_type = var.instancia
  key_name = var.chave
  vpc_security_group_ids = [aws_security_group.acesso_geral.id]

  user_data = <<-EOF
  
              #!/bin/bash -xeu

              apt update
              apt install python3 -y
              ython3 -m http.server 8000
              
              EOF

  tags = {
    Name = "ec2-nest-backend"
  }
}

resource "aws_key_pair" "chaveSSH" {
  key_name = var.chave
  public_key = file("${var.chave}.pub") 
}

output "IP_publico" {
  value = aws_instance.app_server.public_ip
}