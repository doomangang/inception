#!/bin/sh

rm -rf ./jihyjeon
docker image rm $(docker images -qa)
docker volume rm $(docker volume ls -q)
docker system prune -a --force