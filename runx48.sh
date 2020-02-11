#!/bin/bash

#TODO:
# Check for the docker exec and that the user has access to start containers.

start_x48 () {
  docker run --rm --network none \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix" \
    --volume="/home/$USER:/home/$USER" \
    --volume="/etc/group:/etc/group:ro" \
    --volume="/etc/passwd:/etc/passwd:ro" \
    --volume="/etc/shadow:/etc/shadow:ro" \
    --volume="/etc/sudoers.d:/etc/sudoers.d:ro" \
    --env="DISPLAY" \
    --user $(id -u):$(id -g) \
    danwitt/x48 $@
}

# IF we can't pull the image, then we need to build it
if [[ $1 == "--build" ]]; then
  #Run the build process
  docker build -t danwitt/x48 . 
  #If the build was good, start x48
  if [[ $? == 0 ]]; then
    start_x48 $@
  fi
else
  start_x48 $@
fi
