pipeline{
    agent none
    parameters{
        choice(name:'VERSION',choices:['1.1.0','1.2.0','1.3.0'],description:'version of the code')
        booleanParam(name:'ExecuteTests',defaultValue: true,description: 'tc validity')
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
                    params.ExecuteTests == true
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
            agent any
            when{
                expression{
                    BRANCH_NAME == 'main'
                }
            }
            steps{
                script{
                    echo "packaging the code"
                    sh 'mvn package'
                }
            }
        }
        stage("BUILD THE DOCKER IMAGE"){
            agent any
            when{
                expression{
                    BRANCH_NAME == 'main'
                }
            }
            steps{
                script{
                    echo "BUILDING THE DOCKER IMAGE"
                    echo "Deploying version ${params.VERSION}"
                    withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                    sh 'sudo docker build -t poojaj2406/myownimage:$BUILD_NUMBER .'
                    sh 'sudo docker login -u $USERNAME -p $PASSWORD'
                    sh 'sudo docker push poojaj2406/myownimage:$BUILD_NUMBER'
                    }
                }
            }
        }
        stage("DEPLOY"){
            agent any
            when{
                expression{
                    BRANCH_NAME == 'main'
                }
            }
            steps{
                script{
                    echo "Deploying the code"
                    echo "Deploying version ${params.VERSION}"
                }
            }
        }
    }
}
