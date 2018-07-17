pipeline {
    agent any
    stages {
        stage('Build Docker Image') {
            when {
                branch 'master'
            }
            steps {
                script {
                    app = docker.build("lkamz/deb9-nginx")
                    //app.inside {
                    //    sh 'echo $(curl localhost:8080)'
                    //}
                }
            }
        }
        stage('Push Docker Image') {
            when {
                branch 'master'
            }
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker_hub_login') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }
        stage('Deploy to docker') {
            when {
                branch 'master'
            }
            steps {
                script {
                    try {
                        sh "docker stop deb9-nginx"
                        sh "docker rm deb9-nginx"
                    } catch (err) {
                        echo '$err'
                    }
                    sh "docker run --network=bridge --name=deb9-nginx -ti -d --privileged=true -p 8000:80 lkamz/deb9-nginx"
                }
            }
        }
        stage('Deploy to production') {
            when {
                branch 'master'
            }
            steps {
                input 'Deploy to production ?'
                milestone(1)
                withCredentials([usernamePassword(credentialsId: 'webserver_login', usernameVariable: 'USERNAME', passwordVariable: 'USERPASS')]) {
                    sshPublisher(
                        failOnError: true,
                        continueOnError: false,
                        publishers: [
                            sshPublisherDesc(
                                configName: 'production',
                                sshCredentials: [
                                    username: "$USERNAME",
                                    encryptedPassphrase: "$USERPASS"
                                ],
                                transfers: [
                                    sshTransfer(
                                        sourceFiles: 'webapp/',
                                        removePrefix: 'webapp/',
                                        remoteDirectory: '/var/www/html'

                                    )
                                ]
                            )
                        ]
                    )
                }

            }
        }

    }
}
