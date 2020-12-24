#!/usr/bin/env bash

echo ""
echo "Starting jackett container ..."
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
echo "Done, Jackett is now listening to port 9117."
echo ""
