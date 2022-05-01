pipeline{
    agent none
    parameters{
        choice(name:'VERSION', choices:['1.1.0','1.2.0','1.3.0'], description:'version of the code')
        booleanParam(name:'ExecuteTests', defaultValue: true, description: 'tc validity')
    }
    tools{
        jdk 'myjava'
        maven 'mymaven'
    }
    stages{
        stage("COMPILE"){
            agent{
                label 'linux_slave'
            }
            steps{
                script{
                    echo "Compliling the code"
                    sh 'mvn compile'
                }
            }
        }
        stage("TEST"){
            agent any
            when{
                expression{
                    param.ExecuteTests == true
                }
            }
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
            agent{label 'linux_slave'}
            steps{
                script{
                    echo "packaging the code"
                    sh 'mvn package'
                }
            }
        }
        stage("DEPLOY"){
            agent any
            steps{
                script{
                    echo "Deploying the code"
                    echo "Deploying version ${param.VERSION}"
                }
            }
        }
    }
}
