#!/usr/bin/env bash

echo ""
echo "Starting radarr container ..."
sudo docker run -d \
	--name=radarr \
	-e PUID=1000 \
	-e PGID=1000 \
	-e TZ=Europe/London \
	-p 7878:7878 \
	-v `pwd`/Radarr/config:/config \
	-v `pwd`/Radarr/movies:/movies \
	-v `pwd`/Radarr/downloads:/downloads \
	--restart unless-stopped \
	linuxserver/radarr
echo "Done, Radarr is now listening to port 7878."
echo ""
