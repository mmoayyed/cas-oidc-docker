#!/bin/bash

read -p "Docker username: " docker_user

echo $DOCKER_REGISTRY_TOKEN | docker login --username "$docker_user" --password-stdin

image_tag=(`cat gradle.properties | grep "cas.version" | cut -d= -f2`)

echo "Pushing CAS docker image tagged as v$image_tag to mmoayyed/cas-oidc-docker..."

docker push mmoayyed/cas-oidc-docker:"v$image_tag-amd64" 
docker push mmoayyed/cas-oidc-docker:"v$image_tag-arm64" 

docker manifest create mmoayyed/cas-oidc-docker:v${image_tag} \
  --amend mmoayyed/cas-oidc-docker:v${image_tag}-amd64 \
  --amend mmoayyed/cas-oidc-docker:v${image_tag}-arm64

docker manifest push mmoayyed/cas-oidc-docker:v${image_tag}