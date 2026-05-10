# this is build stage
FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /spring-docker
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# this is run stage
FROM eclipse-temurin:21-jre
WORKDIR /spring-docker
COPY --from=build /spring-docker/target/*.jar spring-docker.jar

EXPOSE 8080
ENTRYPOINT ["java","-jar","spring-docker.jar"]