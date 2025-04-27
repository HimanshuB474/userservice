pipeline {
    agent any
    
    environment {
        // Define environment variables, if needed
        JAVA_HOME = tool 'JDK17'  // Make sure to configure this in Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the latest code from the Git repository
                checkout scm
            }
        }
        
        stage('Build') {
            steps {
                // Run Gradle build using the wrapper
                script {
                    try {
                        if (isUnix()) {
                            sh './gradlew clean build --no-daemon'
                        } else {
                            bat 'gradlew.bat clean build --no-daemon'
                        }
                    } catch (Exception e) {
                        currentBuild.result = 'FAILURE'
                        error('Build failed: ' + e.message)
                    }
                }
            }
        }

        stage('Test') {
            steps {
                // Run unit tests using the wrapper
                script {
                    try {
                        if (isUnix()) {
                            sh './gradlew test --no-daemon'
                        } else {
                            bat 'gradlew.bat test --no-daemon'
                        }
                    } catch (Exception e) {
                        currentBuild.result = 'FAILURE'
                        error('Tests failed: ' + e.message)
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                // Deploy the project (e.g., copy JAR, deploy to server)
                echo 'Deploying the build...'
                // Add your deployment steps here
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
        always {
            // Clean up workspace
            cleanWs()
        }
    }
} 