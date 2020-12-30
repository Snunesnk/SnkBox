#!/usr/bin/env bash

echo ""
echo "Starting lidarr container ..."

#Check if container exists or not
test_container=$(docker ps -a | grep lidarr)
if [[ ! -z $test_container ]]
then
    echo "Lidarr already started, restarting it.."
    docker restart lidarr
    
#Launch it
else
    sudo docker run -d \
    --name=lidarr \
    -e PUID=1000 \
    -e PGID=1000 \
    -e TZ=Europe/London \
    -p 8686:8686 \
    -v /home/snunes/SnkBox/Lidarr/config:/config \
    -v /home/snunes/SnkBox/Lidarr/music:/music \
    -v /home/snunes/SnkBox/Lidarr/downloads:/downloads \
    --restart unless-stopped \
    linuxserver/lidarr
fi

echo "Done, Lidarr is now listening to port 8686."
echo ""
