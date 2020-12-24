#!/usr/bin/env bash

echo ""
echo "Starting transmission container ..."
 docker run --cap-add=NET_ADMIN -d \
	 --name=transmission \
	 -e PUID=1000 \
	 -e PGID=1000 \
	 -e TZ=Europe/London \
	 -e TRANSMISSION_WEB_HOME=/combustion-release/ \
	 -p 9091:9091 \
	 -p 51413:51413 \
	 -p 51413:51413/udp \
	 -v `pwd`/Transmission/config:/config \
	 -v `pwd`/Transmission/downloads:/downloads \
	 -v `pwd`/Transmission/watch:/watch \
	 --restart unless-stopped \
	 ghcr.io/linuxserver/transmission
echo "Done, Transmission is now listening to port 9091."
echo ""
