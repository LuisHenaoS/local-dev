#!/bin/bash
set -e

echo " Desplegando en Producción..."
docker pull luiishs/deployjenkins:${GIT_COMMIT}
docker stop production-container || true
docker rm production-container || true
docker run -d --name production-container -p 8080:80 luiishs/deployjenkins:${GIT_COMMIT}
echo "Despliegue en Producción completado."