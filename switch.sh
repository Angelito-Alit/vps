#!/bin/bash

# Colores para output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo "🔄 Blue-Green Deployment Switch"
echo "================================"

# Verificar cuál está activo actualmente
CURRENT=$(grep "server blue:80" nginx.conf)

if [ -n "$CURRENT" ]; then
    echo -e "${BLUE}Actualmente en: BLUE${NC}"
    echo "Cambiando a GREEN..."
    
    # Cambiar a GREEN
    sed -i 's/server blue:80;/# server blue:80;/' nginx.conf
    sed -i 's/# server green:80;/server green:80;/' nginx.conf
    
    echo -e "${GREEN}✅ Ahora apuntando a: GREEN${NC}"
else
    echo -e "${GREEN}Actualmente en: GREEN${NC}"
    echo "Cambiando a BLUE..."
    
    # Cambiar a BLUE
    sed -i 's/server green:80;/# server green:80;/' nginx.conf
    sed -i 's/# server blue:80;/server blue:80;/' nginx.conf
    
    echo -e "${BLUE}✅ Ahora apuntando a: BLUE${NC}"
fi

# Recargar NGINX sin downtime
echo "Recargando NGINX..."
docker exec nginx-proxy nginx -s reload

echo "✨ Switch completado!"