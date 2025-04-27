# Create the gradle/wrapper directory if it doesn't exist
New-Item -ItemType Directory -Force -Path "gradle\wrapper"

# Download the Gradle wrapper JAR file
$url = "https://raw.githubusercontent.com/gradle/gradle/v8.5.0/gradle/wrapper/gradle-wrapper.jar"
$output = "gradle\wrapper\gradle-wrapper.jar"
Invoke-WebRequest -Uri $url -OutFile $output

Write-Host "Gradle wrapper JAR downloaded successfully to $output" 