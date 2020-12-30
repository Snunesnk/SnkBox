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
    -v `pwd`/LazyLibrarian/config:/config \
    -v `pwd`/LazyLibrarian/downloads:/downloads \
    -v `pwd`/LazyLibrarian/books:/books \
    --restart unless-stopped \
    linuxserver/lazylibrarian
fi

echo "Done, LazyLibrarian is now listening to port 5299."
echo ""
