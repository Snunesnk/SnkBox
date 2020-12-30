#!/usr/bin/env bash

echo ""
echo "Starting portainer container..."

#Check if container exists or not
test_container=$(docker ps -a | grep portainer)
if [[ ! -z $test_container ]]
then
    echo "Portainer already started, restarting it.."
    docker restart portainer
    
#Launch it
else
    docker run -d -p 8000:8000 -p 9000:9000 \
    --name=portainer --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data portainer/portainer-ce
fi

echo "Done, Portainer is now listening to port 9000."
echo ""
