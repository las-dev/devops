FROM openjdk:8 AS build

WORKDIR /

COPY pom.xml .

RUN mvn dependency:go-offline -B



COPY src ./src

RUN mvn package -DskipTests

FROM openjdk:11-jre-slim

WORKDIR /

COPY --from=build ./target/ExamThourayaS2-1.0.jar .

EXPOSE 8089

# Run the Spring Boot application
CMD ["java", "-jar", "ExamThourayaS2-1.0.jar" ]