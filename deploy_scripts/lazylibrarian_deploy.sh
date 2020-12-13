#!/usr/bin/env bash

echo ""
echo "Starting lazylibrarian container ..."
sudo docker run -d \
	--name=lazylibrarian \
	-e PUID=1000 \
	-e PGID=1000 \
	-e TZ=Europe/London \
	-p 5299:5299 \
	-v path to data:/config \
	-v path to downloads:/downloads \
	-v path to data:/books \
	--restart unless-stopped \
	linuxserver/lazylibrarian
echo ""
