pipeline {
    agent {
        label 'node1'
    }
    
    tools {
        maven 'mymaven'
        dockerTool 'mydocker' // Name of the Docker installation configured in Jenkins
    }
    
    stages {
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        
        stage('Build Docker Image') {
            agent {
                label 'node2'
            }
            
            steps {
                script {
                    def imageName = 'greyabiwon/springboot:v2'
                    
                    docker.build(imageName, "-f Dockerfile .")
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-login') {
                        docker.image(imageName).push()
                    }
                }
            }
        }
        
        stage('Deploy to Container') {
            agent {
                label 'node2'
            }
            
            steps {
                script {
                    def containerName = 'springboot-app'
                    def imageName = 'greyabiwon/springboot:v2'
                    
                    sh "docker pull $imageName"
                    sh "docker stop $containerName || true"
                    sh "docker rm $containerName || true"
                    sh "docker run --name test -d -p 9393:80 --name $containerName $imageName"
                }
            }
        }
    }
}
