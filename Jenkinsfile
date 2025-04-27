pipeline {
    agent any
    
    environment {
        // Set GRADLE_USER_HOME to a directory where Jenkins has write permissions
        GRADLE_USER_HOME = "${env.WORKSPACE}/.gradle"
        JAVA_HOME = tool 'JDK17'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the latest code from the Git repository
                checkout scm
            }
        }
        
        stage('Setup') {
            steps {
                // Create Gradle user home directory
                script {
                    if (isUnix()) {
                        sh 'mkdir -p ${GRADLE_USER_HOME}'
                    } else {
                        bat 'if not exist "%GRADLE_USER_HOME%" mkdir "%GRADLE_USER_HOME%"'
                    }
                }
            }
        }

        stage('Build') {
            steps {
                // Run Gradle build with specific user home
                script {
                    try {
                        if (isUnix()) {
                            sh './gradlew clean build --no-daemon --gradle-user-home "${GRADLE_USER_HOME}"'
                        } else {
                            bat 'gradlew.bat clean build --no-daemon --gradle-user-home "%GRADLE_USER_HOME%"'
                        }
                    } catch (Exception e) {
                        currentBuild.result = 'FAILURE'
                        error("Build failed: ${e.message}")
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
                            sh './gradlew test --no-daemon --gradle-user-home "${GRADLE_USER_HOME}"'
                        } else {
                            bat 'gradlew.bat test --no-daemon --gradle-user-home "%GRADLE_USER_HOME%"'
                        }
                    } catch (Exception e) {
                        currentBuild.result = 'FAILURE'
                        error("Tests failed: ${e.message}")
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
            echo 'Build or Tests failed. Please check the logs.'
        }
        always {
            // Clean up workspace
            cleanWs()
        }
    }
} 