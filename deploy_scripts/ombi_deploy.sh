#!/usr/bin/env bash

echo ""
echo "Starting ombi container ..."
 --name=ombi \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -p 3579:3579 \
  -v /path/to/appdata/config:/config \
  --restart unless-stopped \
  linuxserver/ombi
echo ""
