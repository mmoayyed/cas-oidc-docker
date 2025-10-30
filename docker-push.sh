#!/bin/bash

read -p "Docker username: " docker_user
read -s -p "Docker password: " docker_psw

echo "$docker_psw" | docker login --username "$docker_user" --password-stdin

image_tag=(`cat gradle.properties | grep "cas.version" | cut -d= -f2`)

echo "Pushing CAS docker image tagged as v$image_tag to mmoayyed/cas-oidc-docker..."
docker push mmoayyed/cas-oidc-docker:"v$image_tag" \
	&& echo "Pushed mmoayyed/cas-oidc-docker:v$image_tag successfully.";