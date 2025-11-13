#!/bin/bash
# set -e
sudo sysctl -w vm.max_map_count=262144

# Actualizar e instalar dependencias (Ubuntu)
sudo apt-get update -y
sudo apt-get install -y git docker.io docker-compose

# Preparar directorio del proyecto
sudo rm -rf /home/ubuntu/proyecto
mkdir -p /home/ubuntu/proyecto
cd /home/ubuntu/proyecto

git clone --recurse-submodules -b Test_All_Services --single-branch https://github.com/Villegazs/Temperature_Humidity_GPS_Monitoring_Platform_TankRC.git /home/ubuntu/proyecto

# Entrar al directorio del proyecto
cd /home/ubuntu/proyecto || exit 1

# Limpieza segura
sudo docker compose down -v --rmi local --remove-orphans || true
sudo docker ps -aq | xargs -r sudo docker rm -f || true
sudo docker volume ls -q | xargs -r sudo docker volume rm || true
sudo docker system prune -a --volumes -f || true

# Obtener la IP pública dinámicamente
PUBLIC_IP=$(curl -s http://checkip.amazonaws.com/) 

# Crear archivo .env con la IP pública en el directorio orion-nexus
echo "PUBLIC_IP=$PUBLIC_IP" > ./orion-nexus/.env

echo "🚀 Desplegando con IP pública: $PUBLIC_IP"

sudo rm -rf orion-nexus/docker-compose.yml

# Levantar los servicios con la IP pública
sudo PUBLIC_IP=$PUBLIC_IP docker-compose up -d --build

echo "✅ Despliegue completado!"
echo "🌐 Frontend disponible en: http://$PUBLIC_IP"
echo "🔧 Backend API en: http://$PUBLIC_IP:8000"
echo "🏛️ Orion Context Broker en: http://$PUBLIC_IP:1026"