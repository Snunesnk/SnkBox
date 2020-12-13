#!/usr/bin/env bash

echo ""
echo "Starting jellyfin container ..."
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
	ghcr.io/linuxserver/jellyfin
echo ""
