#!/usr/bin/env bash

echo ""
echo "Starting Jellyfin container ..."

#Check if container exists or not
test_container=$(docker ps -a | grep jellyfin)
if [[ ! -z $test_container ]]
then
    echo "Jellyfin already started, restarting it.."
    docker restart jellyfin

#Launch it
else
    docker run -d \
    --name=jellyfin \
    -e PUID=1000 \
    -e PGID=1000 \
    -e TZ=Europe/London \
    -p 8096:8096 \
    -v `pwd`/Jellyfin/config:/config \
    -v `pwd`/Sonarr/tvshows:/data/tvshows \
    -v `pwd`/Radarr/movies:/data/movies \
    --restart unless-stopped \
    jellyfin/jellyfin
fi

echo "Done, Jellyfin is now listening to port 8096."
echo ""
