pipeline {
    agent none
    
    tools {
        maven 'mymaven'
    }
    
    stages {
        stage('Build') {
            agent {
                node {
                    label 'node1'
                }
            }
            steps {
                sh 'mvn clean package'
            }
        }
        
        stage('Build Docker Image') {
            agent {
                node {
                    label 'node2'
                }
            }
            steps {
                script {
                    def imageName = 'greyabiwon/springboot:v3'
                    
                    docker.build(imageName, "-f Dockerfile .")
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-login') {
                        docker.image(imageName).push()
                    }
                }
            }
        }
        
        stage('Deploy') {
            agent {
                node {
                    label 'master_node'
                }
            }
            steps {
                sh 'docker stack deploy -c compose.yml myapps'
            }
        }
    }
}
