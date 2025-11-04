#!/bin/bash

image_tag=(`cat gradle.properties | grep "cas.version" | cut -d= -f2`)

echo "Building CAS docker image tagged as [v$image_tag]"
# read -p "Press [Enter] to continue..." any_key;

docker buildx build --platform linux/amd64 --tag="mmoayyed/cas-oidc-docker:v$image_tag-amd64" --load . 
docker buildx build --platform linux/arm64 --tag="mmoayyed/cas-oidc-docker:v$image_tag-arm64" --load . 
