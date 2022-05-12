pipeline{
    agent none
    tools{
        jdk 'myjava'
        maven 'mymaven'
    }
    stages{
        stage("COMPILE"){
            agent any
            steps{
                script{
                  echo "COMPILIG THE CODE"
                  sh 'mvn compile'
                }
            }
        }
        stage("UNITTEST"){
            //agent {label 'linux_slave'}
            agent any
         steps{
           script{
               echo "Testing THE CODE"
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
            agent any
            steps{
            script{
                echo "Packaging THE CODE"
                sshagent(['BUILD_SERVER_KEY']) {
                sh "scp -o StrictHostKeyChecking=no server-script.sh ec2-user@172.31.8.7:/home/ec2-user"
                sh "ssh -o StrictHostKeyChecking=no ec2-user@172.31.8.7 'bash ~/server-script.sh'"
              }
        }
    }
}     
    }
}