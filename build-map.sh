#!/bin/sh

# Usage
# ./build-map.sh

# Main script
start_time=`date +%s`

echo ${pwd}/data
echo ${pwd}/html

docker pull mide/minecraft-overviewer:latest
docker run \
  --rm \
  -e MINECRAFT_VERSION="1.14" \
  -v $(pwd)/data:/home/minecraft/server/:ro \
  -v $(pwd)/html:/home/minecraft/render/:rw \
  mide/minecraft-overviewer:latest

end_time=`date +%s`
time=$((end_time - start_time))
echo $time
