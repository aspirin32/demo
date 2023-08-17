#!/bin/bash
gitfile=$(md5sum /var/jenkins/workspace/Pipe/index.html | awk '{print $1}')
nginxfile=$(docker exec nginx-project md5sum /usr/share/nginx/html/index.html | awk '{print $1}')
if [ $gitfile == $nginxfile ]
then exit 0
else exit 1
fi