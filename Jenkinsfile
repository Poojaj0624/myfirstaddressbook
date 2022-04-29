pipeline{
    agent any
    tools{
        jdk 'myjava'
        maven 'mymaven'
    }
    stages{
        stage("COMPILE"){
            steps{
                script{
                    echo "Compliling the code"
                    sh 'mvn compile'
                }
            }
        }
        stage("TEST"){
            steps{
                script{
                    echo "Testing the code"
                    sh 'mvn test'
                }
            }
            post{
                always{
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        stage("PACKAGE"){
            steps{
                script{
                    echo "packaging the code"
                    sh 'mvn package'
                }
            }
        }
        stage("DEPLOY"){
            steps{
                script{
                    echo "Deploying the code"
                }
            }
        }
    }
}
