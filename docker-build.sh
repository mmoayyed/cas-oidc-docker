#!/bin/bash

image_tag=(`cat gradle.properties | grep "cas.version" | cut -d= -f2`)

echo "Building CAS docker image tagged as [v$image_tag]"
# read -p "Press [Enter] to continue..." any_key;

docker build --tag="mmoayyed/cas-oidc-docker:v$image_tag" . \
  && echo "Built CAS image successfully tagged as mmoayyed/cas-oidc-docker:v$image_tag" \
  && docker images "mmoayyed/cas-oidc-docker:v$image_tag"