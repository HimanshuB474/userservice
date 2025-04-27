pipeline {
    agent any
    
    environment {
        JAVA_HOME = tool 'JDK-17'
    }

    stages {
        stage('Set Gradle User Home') {
            steps {
                script {
                    if (isUnix()) {
                        env.GRADLE_USER_HOME = "${env.WORKSPACE}/gradle_home"
                    } else {
                        env.GRADLE_USER_HOME = "${env.WORKSPACE}\gradle_home"
                    }
                }
            }
        }

        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Setup') {
            steps {
                script {
                    if (isUnix()) {
                        sh '''
                            chmod +x gradlew
                            mkdir -p gradle_home
                            chmod -R 777 gradle_home
                        '''
                    } else {
                        bat '''
                            mkdir gradle_home 2>nul
                            icacls gradle_home /grant Everyone:(OI)(CI)F /T
                            icacls gradlew.bat /grant Everyone:F
                        '''
                    }
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    try {
                        if (isUnix()) {
                            sh './gradlew clean build --no-daemon --gradle-user-home=${GRADLE_USER_HOME} --info'
                        } else {
                            bat 'gradlew.bat clean build --no-daemon --gradle-user-home=%GRADLE_USER_HOME% --info'
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
                script {
                    try {
                        if (isUnix()) {
                            sh './gradlew test --no-daemon --gradle-user-home=${GRADLE_USER_HOME} --info'
                        } else {
                            bat 'gradlew.bat test --no-daemon --gradle-user-home=%GRADLE_USER_HOME% --info'
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