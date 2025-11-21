FROM nginx:alpine

# Copiar archivos de la aplicación
COPY app/ /usr/share/nginx/html/

# Exponer puerto 80
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]