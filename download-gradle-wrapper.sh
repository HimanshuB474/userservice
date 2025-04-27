#!/bin/bash

# Create the gradle/wrapper directory if it doesn't exist
mkdir -p gradle/wrapper

# Download the Gradle wrapper JAR file
curl -o gradle/wrapper/gradle-wrapper.jar https://raw.githubusercontent.com/gradle/gradle/v8.5.0/gradle/wrapper/gradle-wrapper.jar

# Make the gradlew script executable
chmod +x gradlew 