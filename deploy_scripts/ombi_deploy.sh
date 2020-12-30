#!/usr/bin/env bash

echo ""
echo "Starting ombi container ..."

#Check if container exists or not
test_container=$(docker ps -a | grep ombi)
if [[ ! -z $test_container ]]
then
    echo "Ombi already started, restarting it.."
    docker restart ombi
    
#Launch it
else
    docker run -d \
    --name=ombi \
    -e PUID=1000 \
    -e PGID=1000 \
    -e TZ=Europe/London \
    -p 3579:3579 \
    -v /home/snunes/SnkBox/Ombi/config:/config \
    --restart unless-stopped \
    linuxserver/ombi
fi

echo "Done, Ombi is now listening to port 3579."
echo ""
