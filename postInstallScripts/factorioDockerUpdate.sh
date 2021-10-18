#!/bin/bash
# unmodded factorio server
echo -e'\n=> Stopping and removing the container'
docker rm -f factorio
echo -e'\n=> Pulling the latest Docker image'
docker pull factoriotools/factorio
echo -e'\n=> Running a new instance of the server'
docker run -d \
  -p 34197:34197/udp \
  -p 27015:27015/tcp \
  -v /opt/factorio:/factorio \
  --name factorio \
  --restart=always \
  factoriotools/factorio
echo -e 'Done.\n'
echo -e'\n=> Removing tagless docker images'
docker image prune


