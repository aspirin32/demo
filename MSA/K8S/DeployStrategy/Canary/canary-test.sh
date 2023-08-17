#!/bin/bash
COUNTS=10
PROD=()
CANARY=()
for i in $(seq 1 $COUNTS)
do
 result=`curl -s -H "Host: echo.com" http://localhost | grep 'pod namespace' | awk '{print $3}'`
 echo "Get response from $result"
 if [ "$result" = "first" ];
 then
   PROD+=($i)
 else
   CANARY+=($i)
 fi
done
echo 'production = ' ${#PROD[@]}
echo 'canary = ' ${#CANARY[@]}