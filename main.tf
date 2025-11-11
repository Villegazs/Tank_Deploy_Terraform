provider "aws" {
  region = "us-east-1" # cambia según tu región
}

resource "aws_instance" "terraform" {
  ami           = "ami-0c398cb65a93047f2" # ejemplo Ubuntu 22.04 en us-east-1
  instance_type = var.instance_type
  key_name      = "llaveIoTpracticas" # tu key pair en AWS

  user_data = <<-EOF
              #!/bin/bash
              set -e

              # Actualizar e instalar dependencias (Ubuntu)
              sudo apt-get update -y
              sudo apt-get install -y git docker.io 

              # Habilitar y arrancar docker
              sudo apt-get install -y docker-compose

              # Preparar directorio del backend
              rm -rf /home/ubuntu/backend
              mkdir -p /home/ubuntu/backend
              cd /home/ubuntu/backend

              # Clonar el repositorio (asegúrate que la URL es la correcta)
              git clone https://github.com/Walkhie/Backend-Robot-Oruga.git /home/ubuntu/backend
              
              # Entrar al directorio del proyecto
              cd /home/ubuntu/backend || exit 1

              # Limpieza segura: detener y borrar contenedores/volúmenes del compose anterior si existen
              # usar || true para evitar que falle si no hay nada que limpiar
              sudo docker compose down -v --rmi local --remove-orphans || true
              sudo docker ps -aq | xargs -r sudo docker rm -f || true
              sudo docker volume ls -q | xargs -r sudo docker volume rm || true
              sudo docker system prune -a --volumes -f || true

              # Levantar los servicios con docker compose
              sudo docker-compose up -d --build
              EOF

  tags = {
    Name = var.instance_name
  }

  # Seguridad: permitir puerto 80
  vpc_security_group_ids = [data.aws_security_group.security.id]
}

data "aws_security_group" "security" {
  name        = var.security_group_name
} 
