#!/usr/bin/env bash

echo ""
echo "Starting sonarr container ..."
sudo docker run -d \
  --name=sonarr \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -p 8989:8989 \
  -v `pwd`/Sonarr/config:/config \
  -v `pwd`/Sonarr/tvseries:/tv \
  -v `pwd`/Sonarr/downloads:/downloads \
  --restart unless-stopped \
  ghcr.io/linuxserver/sonarr
echo "Done."
echo ""
