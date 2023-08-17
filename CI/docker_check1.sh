#!/bin/bash
Container=nginx-project HERE
result=$( docker inspect -f {{.State.Running}} $Container)
echo "result is" $result
if [ $result = "true" ]
then
echo It Works
else
docker restart $Container
fi
exit 0