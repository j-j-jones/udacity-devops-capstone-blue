#!/usr/bin/env bash

# STEP-01:
# BUILD DOCKER IMAGE WITH DESCRIPTIVE TAG
sudo docker build --tag=blueImage .

# STEP-02:
# LIST DOCKER IMAGES
sudo docker image ls

# STEP-03:
# RUN DOCKER IMAGE
sudo docker run -p 8000:80 blueImage
