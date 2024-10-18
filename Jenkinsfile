pipeline {
    agent any
    environment {
        
        registry = "shahnilesh/my-first-app" 

        DOCKER_CREDENTIALS_ID = 'dockerhubfirst-credentials' 

        dockerImage = '' 
        
        DOCKER_CLI_EXPERIMENTAL = "enabled"
 
    }
    

    stages {
        stage('Clone Git Repository') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/nileshkumarshah/sewaloan.git']])
                echo 'Git repository cloned.'
            }
        }
        
        stage('Set up Buildx') {
            steps {
                script {
                    sh 'docker buildx create --use'
                }
            }
        }
        
        stage ('Docker Registry'){
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                        def pythonImage = docker.image('library/python:3.8')
                        pythonImage.pull() // This ensures the image is pulled using the correct credentials
                    }
                }
            }
        }
        
        
        stage('Build Docker Image') {
            steps {
                
                script {
                    
                    sh 'python3.8 --version'
                    
                    sh '''
                        if ! pip --version; then
                            sudo apt install -y python3-pip
                        fi
                        '''
                    
                    sh "docker build -f ./Dockerfile -t $registry:$BUILD_NUMBER ."
                    
                    echo 'Build Images.'
                    
                }
                
            }
        }
        
        
        
        stage('Push Image') {
            steps {
                
                script {
                 
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                        
                        
                        sh "docker tag $registry:$BUILD_NUMBER $registry:$BUILD_NUMBER"
                        
                        sh "docker push docker.io/$registry:$BUILD_NUMBER"
                        
                        
                    }
                   
                }
                
                echo 'Docker Images push.'
            }
        }
        
        
        stage('Cleaning up') { 

            steps { 

                sh "docker rmi $registry:$BUILD_NUMBER" 

            }

        }
        
        // stage('Check Files') {
        //     steps {
        //         sh 'ls -al'
        //     }
        // }
        
    }
    
    
}
