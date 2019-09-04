pipeline {
  agent any 
    stages {
      stage('code Validate'){
	steps {
        sh 'ls -ltr'
        }
      }
    
    stage ('define env') {
       environment {
        // 'This value is exported to all commands in this stage'
       BUILD_ID = "${env.BUILD_ID}"
       Port = "8004"         // def port for container
       IP = "34.93.211.93"   // master machien ip
       Image_name = "nginx-local"
       tag = "latest"
       Container_name = "nginx-test"
       Repository = "demomave"
       Repo_userid = "demomave"
       Repo_passwd = "demomave123"
      }
    }
   stage ('Image Creation') {
       steps {
	       sh 'docker build -t ${Image_name}-${BUILD_ID}:${tag} .'
	       sh 'docker run -d -p ${Port}:80 --name ${Container_name}-c${BUILD_ID} ${Image_name}-${BUILD_ID}:${tag}' 
       }
    }
   stage ('Validate Image') {
     steps {
	     sh 'curl http://${IP}:${port}'
         }
      }
    stage ('Push Image') {
      steps {
             sh 'docker commit ${Container_name}-c${BUILD_ID} ${Repository}/${Image_name}-${BUILD_ID}:${tag}'
	      sh 'docker login -u ${Repo_userid} -p ${Repo_passwd}'
             sh 'docker push ${Repository}/${Image_name}-${BUILD_ID}:${tag}'
        }
      }
    }
}
