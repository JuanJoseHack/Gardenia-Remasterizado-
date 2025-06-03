pipeline {
    agent any

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
                    sh 'docker-compose down || true'  // Apaga servicios anteriores
                    sh 'mvn clean package -DskipTests'
                    sh 'docker-compose build'
                    sh 'docker-compose up -d'
                }
            }
        }

        stage('Health Check') {
            steps {
                script {
                    // Esperar que arranque Spring Boot
                    sh '''
                        echo "⏳ Esperando que la aplicación esté disponible..."
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
                // Opcional: bajar contenedores y limpiar
                sh 'docker-compose down'
                cleanWs()
            }
        }
    }
}
