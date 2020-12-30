#!/usr/bin/env bash

echo ""
echo "Starting transmission container ..."

#Check if container exists or not
test_container=$(docker ps -a | grep transmission)
if [[ ! -z $test_container ]]
then
    echo "Transmission already started, restarting it.."
    docker restart transmission
    
#Launch it
else
    docker run --cap-add=NET_ADMIN -d \
    --name=transmission \
    -e PUID=1000 \
    -e PGID=1000 \
    -e TZ=Europe/London \
    -e TRANSMISSION_WEB_HOME=/combustion-release/ \
    -p 9091:9091 \
    -p 51413:51413 \
    -p 51413:51413/udp \
    -e USER=SNK \
    -e PASS=SNK \
    -v /home/snunes/SnkBox/Transmission/config:/config \
    -v /home/snunes/SnkBox/Transmission/downloads:/downloads \
    -v /home/snunes/SnkBox/Transmission/watch:/watch \
    --restart unless-stopped \
    ghcr.io/linuxserver/transmission
fi

echo "Done, Transmission is now listening to port 9091."
echo ""
