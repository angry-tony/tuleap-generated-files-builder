def buildAndPublishImage() {
    def image = docker.build('tuleap-generated-files-builder')
    docker.withRegistry('https://nexus.enalean.com:22000', 'ci-write') {
        image.push()
    }
}

pipeline {
    agent {
        label 'docker'
    }

    stages {
        stage('Build and publish images') {
            steps {
                buildAndPublishImage()
            }
        }
    }
}