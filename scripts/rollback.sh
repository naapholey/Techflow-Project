#!/bin/bash
echo "================================================================================================"
echo "Rollback to previous stable version if  the health of the current deployed application fail"
echo "================================================================================================"

docker stop tech-flow-app
docker rm tech-flow-app
docker rmi naapholey/tech-flow:latest
docker pull naapholey/tech-flow:previous_stable
docker tag naapholey/tech-flow:previous_stable naapholey/tech-flow:latest
docker push naapholey/tech-flow:latest
docker run -d -p 5000:5000 --name tech-flow-app naapholey/tech-flow:latest
        