pipeline {
  agent any 
      
    environment {
        // 'This value is exported to all commands in this stage'
       BUILD_ID = "${env.BUILD_ID}"
       Port = "8004"         // def port for container
       IP = "34.93.211.93"   // master machien ip
       Image_name = "nginx-local"
       Tag = "latest"
       Container_name = "nginx-test"
       Repository = "demomave"
       Repo_userid = "demomav"
       Repo_passwd = "demomav123"
       
      }
    
  stages {
     stage('Code Validate'){
       steps {
               sh 'ls -ltr'
	       sh ' echo "${BUILD_ID}_${Port}_${IP}_${Image_name}_${Tag}_${Image_name}_${Container_name}_${Repository}_${Repo_userid}_${Repo_passwd}"'
        }
     }
     stage ('Image Creation') {
       steps {
	       sh 'docker build -t ${Image_name}-${BUILD_ID}:${Tag} .'
	       sh 'docker run -d -p ${Port}:80 --name ${Container_name}-c${BUILD_ID} ${Image_name}-${BUILD_ID}:${Tag}' 
       }
    }
   stage ('Validate Image') {
     steps {
	     sh 'curl http://${IP}:${Port}'
         }
      }
    stage ('Push Image') {
      steps {
             sh 'docker commit ${Container_name}-c${BUILD_ID} ${Repository}/${Image_name}-${BUILD_ID}:${Tag}'
	      sh 'docker login -u ${Repo_userid} -p ${Repo_passwd}'
             sh 'docker push ${Repository}/${Image_name}-${BUILD_ID}:${Tag}'
        }
      }
    }
}
