#!/usr/bin/env bash

echo ""
echo "Starting lazylibrarian container ..."
sudo docker run -d \
	--name=lazylibrarian \
	-e PUID=1000 \
	-e PGID=1000 \
	-e TZ=Europe/London \
	-p 5299:5299 \
	-v `pwd`/LazyLibrarian/config:/config \
	-v `pwd`/LazyLibrarian/downloads:/downloads \
	-v `pwd`/LazyLibrarian/books:/books \
	--restart unless-stopped \
	linuxserver/lazylibrarian
echo ""
