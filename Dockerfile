# Шаг 1: сборка Gradle проекта
FROM gradle:8.14-jdk17 AS build
WORKDIR /app
COPY . .
RUN gradle build -x test

# Шаг 2: запуск приложения
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=build /app/build/libs/*.jar app.jar

# ПРОБРАСЫВАЕМ ПЕРЕМЕННЫЕ ОКРУЖЕНИЯ ИЗ RAILWAY
ENV DB_HOST=${DB_HOST}
ENV DB_PORT=${DB_PORT}
ENV DB_NAME=${DB_NAME}
ENV DB_USER=${DB_USER}
ENV DB_PASSWORD=${DB_PASSWORD}

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]