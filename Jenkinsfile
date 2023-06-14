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
                    def imageName = 'greyabiwon/springboot:v3'
                    
                    docker.build(imageName, "-f Dockerfile .")
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-login') {
                        docker.image(imageName).push()
                    }
                }
            }
        }
        
    stage('Deploy') {
            steps {
                // Deploy the Docker stack to the Swarm cluster
                sh 'docker stack deploy -c compose.yml myapps'
            }
    }
