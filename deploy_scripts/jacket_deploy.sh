#!/usr/bin/env bash

echo ""
echo "Starting jackett container ..."
sudo docker run -d \
	--name=jackett \
	-e PUID=1000 \
	-e PGID=1000 \
	-e TZ=Europe/London \
	-p 9117:9117 \
	-v path to data:/config \
	-v path to blackhole:/downloads \
	--restart unless-stopped \
	linuxserver/jackett
echo "Done."
echo ""
