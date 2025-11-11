provider "aws" {
  region = "us-east-1" # cambia según tu región
}

resource "aws_instance" "terraform" {
  ami           = "ami-0c398cb65a93047f2" # ejemplo Ubuntu 22.04 en us-east-1
  instance_type = var.instance_type
  key_name      = "llaveIoTpracticas" # tu key pair en AWS

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install python3-pip -y
              pip3 install Flask==2.3.2
              cat <<EOT >> /home/ubuntu/app.py
              from flask import Flask
              app = Flask(__name__)
              @app.route("/")
              def hello():
                  return "Hola Mundo desde Flask en EC2!"
              if __name__ == "__main__":
                  app.run(host="0.0.0.0", port=80)
              EOT
              nohup python3 /home/ubuntu/app.py &
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
