# Utilizamos una imagen de Java como base
FROM openjdk:17-jdk-slim

# Definimos el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiamos los archivos de nuestra aplicación al contenedor
COPY target/demo-0.0.1.jar /app

# Exponemos el puerto en el que se ejecuta la aplicación
EXPOSE 8000

# Definimos el comando para ejecutar la aplicación cuando el contenedor se inicie
CMD ["java", "-jar", "demo-0.0.1.jar"]