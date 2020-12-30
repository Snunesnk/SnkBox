#!/usr/bin/env bash

echo ""
echo "Starting lazylibrarian container ..."

#Check if container exists or not
test_container=$(docker ps -a | grep lazylibrarian)
if [[ ! -z $test_container ]]
then
    echo "LazyLibrarian already started, restarting it.."
    docker restart lazylibrarian
    
#Launch it
else
    sudo docker run -d \
    --name=lazylibrarian \
    -e PUID=1000 \
    -e PGID=1000 \
    -e TZ=Europe/London \
    -p 5299:5299 \
    -v /home/snunes/SnkBox/LazyLibrarian/config:/config \
    -v /home/snunes/SnkBox/LazyLibrarian/downloads:/downloads \
    -v /home/snunes/SnkBox/LazyLibrarian/books:/books \
    --restart unless-stopped \
    linuxserver/lazylibrarian
fi

echo "Done, LazyLibrarian is now listening to port 5299."
echo ""
