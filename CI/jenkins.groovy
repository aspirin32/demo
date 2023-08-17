pipeline {
    agent any
    stages {
        stage('git clone') {
            steps {
                git branch: 'main', credentialsId: '32f540e3-76eb-4f3a-bd96-7bfbe66976f7', url: 'https://github.com/aspirin32/GitHub_CI.git'
            }
        }
            stage('check_container') {
           
            steps {
                 
                    catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh '''Container=nginx-project
                  result=$( docker inspect -f {{.State.Running}} $Container; exit 0)
                  echo "result is" $result
                  if [ $result = "true" ]
                  then
                  echo It WORKS
                  else
                  docker restart $Container
                  fi'''
                }
            }
        }
            stage('run') {
                
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                sh '''docker run -p 9889:80 -d --name nginx-project -v /var/jenkins/workspace/Pipe:/usr/share/nginx/html -v /var/jenkins/workspace/Pipe:/etc/nginx/conf.d nginx:latest
sleep 10s'''
            }
        }
            }
            stage('info') {
            steps {
                sh 'docker ps'
            }
        }
                    stage('check 200') {
                        
            steps {
                sh '''url=\'http://158.160.59.196:9889\'
                      status=$(curl --head --location --connect-timeout 5 --write-out %{http_code} --silent --output /dev/null ${url})
                      TOKEN=6035895695:AAHNidSIJbar5jPHotYELA2xnmpuWlMulU0
                      CHAT_ID=-1001863047576
                      if [ $status = "200" ]
                      then exit 0
                      else curl -X POST -H "Content-Type:multipart/form-data" -F chat_id=$CHAT_ID -F text="job *pipe* stage *check 200* failed"  "https://api.telegram.org/bot$TOKEN/sendMessage"
                      fi'''

            }
        
            }
    
            stage('check md5') {
                
            steps {
                sh '''gitfile=$(md5sum /var/jenkins/workspace/Pipe/index.html | awk \'{print $1}\')
                nginxfile=$(docker exec nginx-project md5sum /usr/share/nginx/html/index.html | awk \'{print $1}\')
                if [ $gitfile = $nginxfile ]
                then exit 0
                else exit 1
                fi'''
            }
        }

            stage('Delete docker') {
            steps {
                sh '''docker stop nginx-project
docker rm nginx-project'''
            }
        }
    }



post {
     success {
        withCredentials([string(credentialsId: 'bot', variable: 'TOKEN'), string(credentialsId: 'chatd', variable: 'CHAT_ID')]) {
        sh  ("""
            curl -X POST -H "Content-Type:multipart/form-data" -F chat_id=$CHAT_ID -F text="*${env.JOB_NAME}* : *Branch* ${env.GIT_BRANCH} : Success " "https://api.telegram.org/bot$TOKEN/sendMessage"
        """)
        }
     }

     aborted {
        withCredentials([string(credentialsId: 'bot', variable: 'TOKEN'), string(credentialsId: 'chatd', variable: 'CHAT_ID')]) {
        sh  ("""
            curl -X POST -H "Content-Type:multipart/form-data" -F chat_id=$CHAT_ID -F text="*${env.JOB_NAME}* : *Branch* ${env.GIT_BRANCH} : Aborted "  "https://api.telegram.org/bot$TOKEN/sendMessage"
        """)
        }

     }
     failure {
        withCredentials([string(credentialsId: 'bot', variable: 'TOKEN'), string(credentialsId: 'chatd', variable: 'CHAT_ID')]) {
        sh  ("""
            curl -X POST -H "Content-Type:multipart/form-data" -F chat_id=$CHAT_ID -F text="*${env.JOB_NAME}* : *Branch* ${env.GIT_BRANCH} : Failed" "https://api.telegram.org/bot$TOKEN/sendMessage"
        """)
        }
     }

 }
}