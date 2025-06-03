pipeline {
    agent any

    tools {
        // Asegúrate de tener una instalación de Maven en Jenkins con este nombre
        maven "MAVEN_HOME"
    }

    environment {
        COMPOSE_FILE = 'docker-compose.yaml'
        APP_PORT = '8082'
    }

    stages {
        stage('Clonar Repositorio') {
            steps {
                git branch: 'master', url: 'https://github.com/JuanJoseHack/Gardenia-Remasterizado-.git'
            }
        }

        stage('Levantar Servicios') {
            steps {
                script {
                    // Apaga servicios anteriores, compila, construye y levanta
                    sh 'docker-compose down || true'
                    sh 'mvn clean package -DskipTests'
                    sh 'docker-compose build'
                    sh 'docker-compose up -d'
                }
            }
        }

        stage('Health Check') {
            steps {
                script {
                    echo "⏳ Esperando que la aplicación esté disponible..."
                    sh '''
                        sleep 15
                        curl -I http://localhost:${APP_PORT} || echo "⚠️ La aplicación no respondió"
                    '''
                }
            }
        }
    }

    post {
        success {
            echo "✅ Despliegue exitoso: http://localhost:${APP_PORT}"
        }
        failure {
            echo "❌ Falló el despliegue"
        }
        always {
            script {
                sh 'docker-compose down'
                cleanWs()
            }
        }
    }
}
