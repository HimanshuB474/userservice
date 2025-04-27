pipeline {
    agent any
    
    environment {
        // Define environment variables, if needed
        GRADLE_HOME = '/usr/local/gradle'  // Adjust to your Gradle installation
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the latest code from the Git repository
                git 'https://github.com/HimanshuB474/userservice.git'
            }
        }
        
        stage('Build') {
            steps {
                // Run Gradle build
                script {
                    sh './gradlew clean build'
                }
            }
        }

        stage('Test') {
            steps {
                // Run unit tests
                script {
                    sh './gradlew test'
                }
            }
        }

        stage('Deploy') {
            steps {
                // Deploy the project (e.g., copy JAR, deploy to server)
                echo 'Deploying the build...'
            }
        }
    }

    post {
        success {
            echo 'Build and Tests passed successfully!'
        }
        failure {
            echo 'Build failed. Please check the logs.'
        }
    }
} 