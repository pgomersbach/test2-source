podTemplate(label: 'mypod', containers: [
    containerTemplate(name: 'git', image: 'alpine/git', ttyEnabled: true, command: 'cat'),
    containerTemplate(name: 'maven', image: 'maven:3.5-jdk-8', command: 'cat', ttyEnabled: true),
    containerTemplate(name: 'docker', image: 'docker', command: 'cat', ttyEnabled: true)
  ],
  volumes: [
    hostPathVolume(mountPath: '/var/run/docker.sock', hostPath: '/var/run/docker.sock'),
  ]
  ) {
  node('mypod') {
    container('maven') {
      stage('git checkout') {
          sh "git clone -b ${GITBRANCH} ${GITURL} ."
//        sh 'git clone -b master https://${GIT_USERNAME}:${GIT_PASSWORD}@bitbucket.org/mnwgp/mn-wgp.git'
//        sh 'echo $SLACK_URL $DOCKER_REGISTRY'
      }
      stage('maven package') {
        sh 'mvn package "-Dtest=*Test, !*ApplicationTest*" "-Dmaven.exec.skip=true"'
      }
      stage('maven reports') {
        sh 'mvn surefire-report:report-only'
      }
      stage('run unit tests') {
        sh 'echo "run unit tests"'
      }
    }
    container('docker') {
      stage('create docker image') {
        sh 'echo "create docker image"'
        def customImage = docker.build("my-image:${env.BUILD_ID}")
      } 
    }
  }
}
