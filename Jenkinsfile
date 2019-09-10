pipeline {
  agent any 
      
    environment {
        // 'This value is exported to all commands in this stage'
       BUILD_ID = "${env.BUILD_ID}"
       Port = "3333"         // define port for container
       IP = "34.93.211.93"   // Master machien ip
       Image_name = "mdep-login"
       Tag = "latest"
       Container_name = "${Image_name}-c"
       Repository = "demomav"
       Repo_userid = "demomav"
       Repo_passwd = "demomav123"
       k8_ideploy = "k8-${Image_name}"
       k8_Port = "8300"
       k8_Type = "LoadBalancer"
       
      }
    
  stages {
     stage('Code Validate'){
       steps {
               sh 'ls -ltr'   // check files are available
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
	     sh 'curl http://${IP}:${Port}/login.html'
         }
      }
    stage ('Push Image') {
      steps {
             sh 'docker commit ${Container_name}-c${BUILD_ID} ${Repository}/${Image_name}-${BUILD_ID}:${Tag}'
	      sh 'docker login -u ${Repo_userid} -p ${Repo_passwd}'
             sh 'docker push ${Repository}/${Image_name}-${BUILD_ID}:${Tag}'
        }
      }
    stage ('K8 Deploy') {
      steps {
	   sh 'kubectl  --kubeconfig /home/gokulsk_m/.kube/config run ${k8_ideploy} --image=${Repository}/${Image_name}-${BUILD_ID}:${Tag} --replicas=2 --port=80'
	   sh 'kubectl  --kubeconfig /home/gokulsk_m/.kube/config expose deployment ${k8_ideploy} --target-port=80 --type=${k8_Type}'
      		}
    }
     stage ('Validate-deploy') {
	steps {
	    sh 'kubectl --kubeconfig /home/gokulsk_m/.kube/config get service'
	    sh 'kubectl --kubeconfig /home/gokulsk_m/.kube/config get deployment'
	    sh 'kubectl --kubeconfig /home/gokulsk_m/.kube/config get deployment -o wide'
            sh 'kubectl --kubeconfig /home/gokulsk_m/.kube/config get pod -o wide'
	    
	  }
      }
	
    }
}
