#!/usr/bin/env bash

echo ""
echo "Starting lidarr container ..."
sudo docker run -d \
	--name=lidarr \
	-e PUID=1000 \
	-e PGID=1000 \
	-e TZ=Europe/London \
	-p 8686:8686 \
	-v /path/to/appdata/config:/config \
	-v /path/to/music:/music \
	-v /path/to/downloads:/downloads \
	--restart unless-stopped \
	linuxserver/lidarr
echo ""
