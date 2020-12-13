#!/usr/bin/env bash

echo ""
echo "Starting radarr container ..."
sudo docker run -d \
	--name=radarr \
	-e PUID=1000 \
	-e PGID=1000 \
	-e TZ=Europe/London \
	-p 7878:7878 \
	-v path to data:/config \
	-v path/to/movies:/movies \
	-v path/to/downloadclient-downloads:/downloads \
	--restart unless-stopped \
	linuxserver/radarr
	echo "Done."
echo ""
