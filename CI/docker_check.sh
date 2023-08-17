#!/bin/bash

Container_name=nginx-project
result=$(docker inspect -f {{.State.status}} $Container_name)
echo "result is" $result
if "$result" == "$result"
then docker restart $Container_name
else docker run -p 9889:80 -d --name nginx-project -v /var/jenkins/workspace/Pipe:/usr/share/nginx/html -v /var/jenkins/workspace/Pipe:/etc/nginx/conf.d nginx:latest
fi
exit 0