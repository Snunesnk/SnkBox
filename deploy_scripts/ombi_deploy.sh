#!/usr/bin/env bash

echo ""
echo "Starting ombi container ..."
docker run -d \
	--name=ombi \
	-e PUID=1000 \
	-e PGID=1000 \
	-e TZ=Europe/London \
	-p 3579:3579 \
	-v `pwd`/Ombi/config:/config \
	--restart unless-stopped \
	linuxserver/ombi
echo "Done, Ombi is now listening to port 3579."
