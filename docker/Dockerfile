FROM maven:3.9.11-eclipse-temurin-21 AS build
WORKDIR /build
COPY pom.xml .
COPY src ./src
RUN mvn -B -ntp -DskipTests package

FROM eclipse-temurin:21-jre-jammy
RUN groupadd --gid 10001 nexo && useradd --uid 10001 --gid nexo --no-create-home nexo
WORKDIR /opt/nexo
COPY --from=build --chown=nexo:nexo /build/target/nexo-api-0.0.1-SNAPSHOT.jar app.jar
COPY --chown=nexo:nexo nexo-config/ ./config/
ENV SPRING_CONFIG_ADDITIONAL_LOCATION=file:/opt/nexo/config/
USER 10001:10001
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
