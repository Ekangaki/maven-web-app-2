pipeline {
    agent any
    
    tools {
        maven 'maven-3.9.5'
        jdk 'jdk17'
    }
    
    environment {
        SCANNER_HOME = tool 'sonar-scanner'
    }
        
        stage('AIT Compile Source Code') {
            steps {
                sh "mvn compile -f maven-web-app-master/pom.xml"
            }
        }   

        stage('Maven Test') {
            steps {
                sh "mvn test -f maven-web-app-master/pom.xml"
            }
        }    

        stage('AIT Sonarqube Analysis') {
            steps {
                withSonarQubeEnv('sonar-server') {
                    sh """$SCANNER_HOME/bin/sonar-scanner \
                          -Dsonar.projectName=santa \
                          -Dsonar.projectKey=santa \
                          -Dsonar.java.binaries=. \
                    """
                }
            }
        }

        stage('AIT Manager Approval') {
            steps {
                echo "Taking approval from DEV Manager for QA Deployment"
                timeout(time: 7, unit: 'DAYS') {
                    input message: 'Do you want to deploy?', submitter: 'admin'
                }
            }
        }
		

        stage('AIT Build Application') {
            steps {
                sh "mvn package -f maven-web-app-master/pom.xml"
            }
        }
    }

    post {
        success {
            emailext(
                subject: "Build Successful: ${currentBuild.fullDisplayName}",
                body: "The build ${currentBuild.fullDisplayName} was successful.",
                to: 'georgegedeon2012@gmail.com',
                from: 'ekangakigeorge@gmail.com',
                attachLog: true
            )
        }
        failure {
            emailext(
                subject: "Build Failed: ${currentBuild.fullDisplayName}",
                body: "The build ${currentBuild.fullDisplayName} failed. Please check the console output for more details.",
                to: 'georgegedeon2012@gmail.com',
                from: 'ekangakigeorge@gmail.com',
                attachLog: true
            )
        } 
  }
}
