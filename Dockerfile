# Шаг 1: сборка Gradle проекта
FROM gradle:8.14-jdk17 AS build
WORKDIR /app
COPY . .
RUN gradle build -x test

# Шаг 2: запуск приложения
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=build /app/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]