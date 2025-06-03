pipeline {
    agent any

    environment {
        IMAGE_NAME = 'pro-ecommerce'
        CONTAINER_NAME = 'pro-ecommerce-container'
        PORT = '8080'
    }

    stages {
        stage('Clone') {
            steps {
                timeout(time: 5, unit: 'MINUTES') {
                    git branch: 'main', url: 'https://github.com/JuanJoseHack/Gardenia-Remasterizado-.git'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                timeout(time: 5, unit: 'MINUTES') {
                    script {
                        sh 'docker build -t $IMAGE_NAME .'
                    }
                }
            }
        }

        stage('Deploy Container') {
            steps {
                timeout(time: 5, unit: 'MINUTES') {
                    script {
                        // Elimina cualquier contenedor previo
                        sh '''
                            docker rm -f $CONTAINER_NAME || true
                            docker run -d --name $CONTAINER_NAME -p $PORT:80 $IMAGE_NAME
                        '''
                    }
                }
            }
        }

        stage('Health Check') {
            steps {
                timeout(time: 2, unit: 'MINUTES') {
                    script {
                        // Verifica que el sitio responda
                        sh '''
                            sleep 5
                            curl -I http://localhost:$PORT || echo "La aplicación no respondió correctamente"
                        '''
                    }
                }
            }
        }
    }

    post {
        success {
            echo "🚀 Sitio desplegado exitosamente en http://localhost:$PORT"
        }
        failure {
            echo "❌ Falló el despliegue del sitio"
        }
        always {
            cleanWs()
        }
    }
}