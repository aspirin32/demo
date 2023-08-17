#!/bin/sh
url=\'http://158.160.59.196:9889\'
status=$(curl --head --location --connect-timeout 5 --write-out %{http_code} --silent --output /dev/null ${url})
TOKEN=6035895695:AAHNidSIJbar5jPHotYELA2xnmpuWlMulU0
CHAT_ID=-1001863047576
if [ $status = "200" ];
then
   exit 0;
else 
    curl -X POST -H "Content-Type:multipart/form-data" -F chat_id=$CHAT_ID -F text="job *pipe* stage *check 200* failed"  "https://api.telegram.org/bot$TOKEN/sendMessage";
fi

