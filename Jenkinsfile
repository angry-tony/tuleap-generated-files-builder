node('docker') {
    stage('Checkout sources') {
        checkout scm
    }

    def image
    stage('Build image') {
        image = docker.build('tuleap-generated-files-builder', '.')
    }

    stage('Publish image') {
        docker.withRegistry('https://nexus.enalean.com:22000', 'ci-write') {
            image.push()
        }
    }
}
