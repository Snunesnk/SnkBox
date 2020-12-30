#!/usr/bin/env bash

echo ""
echo "Starting jackett container ..."

#Check if container exists or not
test_container=$(docker ps -a | grep jackett)
if [[ ! -z $test_container ]]
then
    echo "Jackett already started, restarting it.."
    docker restart jackett
    
#Launch it
else
    sudo docker run -d \
    --name=jackett \
    -e PUID=1000 \
    -e PGID=1000 \
    -e TZ=Europe/London \
    -p 9117:9117 \
    -v `pwd`/Jackett/config:/config \
    -v `pwd`/Jackett/downloads:/downloads \
    --restart unless-stopped \
    linuxserver/jackett
fi

echo "Done, Jackett is now listening to port 9117."
echo ""
