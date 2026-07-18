# --- Stage 1: Build the Java Application ---
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app

# Copy the pom.xml and source code
COPY pom.xml .
COPY src ./src

# Compile and package the application into a JAR file
RUN mvn clean package -DskipTests

# --- Stage 2: Create the Lightweight Runtime Image ---
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# Create a non-privileged system user for banking security compliance
RUN addgroup -S bankgroup && adduser -S bankuser -G bankgroup
USER bankuser

# Copy the compiled JAR file from the build stage
COPY --from=build /app/target/banking-core-app-1.0.0.jar ./banking-app.jar

# Expose potential internal port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "banking-app.jar"]