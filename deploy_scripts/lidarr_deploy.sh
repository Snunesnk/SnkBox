#!/usr/bin/env bash

echo ""
echo "Starting lidarr container ..."
sudo docker run -d \
	--name=lidarr \
	-e PUID=1000 \
	-e PGID=1000 \
	-e TZ=Europe/London \
	-p 8686:8686 \
	-v `pwd`/Lidarr/config:/config \
	-v `pwd`/Lidarr/music:/music \
	-v `pwd`/Lidarr/downloads:/downloads \
	--restart unless-stopped \
	linuxserver/lidarr
echo ""
