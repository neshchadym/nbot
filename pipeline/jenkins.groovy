pipeline {
    agent any
    parameters {
        choice(name: 'OS', choices: ['linux', 'darwin', 'windows', 'all'], description: 'Pick OS')
        choice(name: 'ARCH', choices: ['amd64', 'arm64'], description: 'Pick ARCH')
    }

    environment {
        REPO = 'https://github.com/neshchadym/nbot'
        BRANCH = 'main'
        REGISTRY = 'ghcr.io/neshchadym'
        APP = 'nbot'
        GHCR = 'https://ghcr.io'
    }

    stages {

        stage("clone") {
            steps {
                echo "Clone Repository"
                git branch: "${BRANCH}", url: "${REPO}"
            }
        }

        stage("test") {
            steps {
                echo "Testing started"
                sh "make test"
            }
        }

        stage("build") {
            steps {
                echo "Build started"
                sh "make build TARGETOS=${OS} TARGETARCH=${ARCH}"
            }
        }

        stage("image") {
            steps {
                echo "Building image ..."
                sh "make image REGISTRY=${REGISTRY} APP=${APP}"
            }
        }
        stage("login to GHCR") {
            steps {
                echo "LOGIN TO GHCR"
                withCredentials([usernamePassword(credentialsId: 'github-token', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh "docker login -u $USERNAME -p $PASSWORD ${GHCR}"
                }

            }
        }      
        stage("push image") {
            steps {
                echo 'PUSH TO GHCR'
                sh 'make push REGISTRY=${REGISTRY} TARGETOS=${OS} TARGETARCH=${ARCH}'
            }
        }
    }
}
