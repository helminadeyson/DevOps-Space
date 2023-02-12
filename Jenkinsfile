def label = "build"
podTemplate(label: label, yaml: """
apiVersion: v1
kind: Pod
metadata:
  labels:
    app: build
spec:
  containers:
  - name: build
    image: colanta/build-agent
    command:
    - cat
    tty: true
    volumeMounts:
    - name: dockersock
      mountPath: /var/run/docker.sock
  volumes:
  - name: dockersock
    hostPath:
      path: /var/run/docker.sock
"""
) {
    node (label) {

-        stage ('Checkout SCM'){
          git url: 'https://github.com/Orion83-h/colanta-login-intergration.git', branch: 'main'
          container('build') {
                stage('Build a Maven project') {
                    sh 'mvn clean deploy -s settings.xml'             
                }
            }
        }

        stage ('Docker Build'){
          container('build') {
                stage('Build Image') {
                    docker.withRegistry( 'https://registry.hub.docker.com', 'docker' ) { 
                    def customImage = docker.build("colanta/tomcat-base:v1")
                    customImage.push()            
                    }
                }
            }
        }

        stage ('Helm Chart') {
          container('build') {
            dir('charts') {
              withCredentials([usernamePassword(credentialsId: 'jfrog', usernameVariable: 'username', passwordVariable: 'password')]) {
              sh '/usr/local/bin/helm package webapp'
              sh '/usr/local/bin/helm push-artifactory webapp-1.0.tgz https://lufthansa.jfrog.io/artifactory/oliver-demo-helm-local --username $username --password $password'
              }
            }
        }
        }
    }
}
