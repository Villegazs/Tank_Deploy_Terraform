provider "aws" {
  region        = var.aws_region
}

resource "aws_instance" "terraform" {
  ami           = "ami-0c398cb65a93047f2" # ejemplo Ubuntu 22.04 en us-east-1
  instance_type = var.instance_type
  key_name      = var.key_name # tu key pair en AWS

  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = var.instance_name
  }

  # Seguridad: permitir puerto 80
  vpc_security_group_ids = [data.aws_security_group.security.id]

    # Configuración del almacenamiento
  root_block_device {
    volume_size = 20 # Cambia el tamaño del volumen raíz a 20 GiB
    volume_type = "gp3" # Tipo de volumen (gp3 es recomendado)
  }
}

data "aws_security_group" "security" {
  name = var.security_group_name
}

