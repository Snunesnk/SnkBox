#!/usr/bin/env bash

echo ""
echo "Starting sonarr container ..."

#Check if container exists or not
test_container=$(docker ps -a | grep sonarr)
if [[ ! -z $test_container ]]
then
    echo "Sonarr already started, restarting it.."
    docker restart sonarr
    
#Launch it
else
    sudo docker run -d \
    --name=sonarr \
    -e PUID=1000 \
    -e PGID=1000 \
    -e TZ=Europe/London \
    -p 8989:8989 \
	-p 9898:9898 \
    -v /home/snunes/SnkBox/Sonarr/config:/config \
    -v /home/snunes/SnkBox/Sonarr/tvseries:/tv \
    -v /home/snunes/SnkBox/Sonarr/downloads:/downloads \
    --restart unless-stopped \
    ghcr.io/linuxserver/sonarr
fi

echo "Done, Sonarr is now listening to port 8989."
echo ""
