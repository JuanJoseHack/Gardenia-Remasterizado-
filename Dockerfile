# Usa una imagen oficial de Java 17
FROM eclipse-temurin:17-jdk-jammy

# Directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiamos el JAR generado al contenedor
COPY target/Gardenia-0.0.1-SNAPSHOT.jar app.jar

# Exponemos el puerto del Spring Boot (ajústalo si usas otro)
EXPOSE 8080

# Comando para correr el app
ENTRYPOINT ["java", "-jar", "app.jar"]
