#!/usr/bin/env bash

docker stop `docker ps -aq` && docker container rm `docker ps -aq` && docker-compose up -d
