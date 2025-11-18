#!/bin/bash

docker stop cas > /dev/null 2>&1
docker rm cas > /dev/null 2>&1
image_tag=(`cat gradle.properties | grep "cas.version" | cut -d= -f2`)
docker run -d -p 8080:8080 -p 8443:8443 --name="cas" mmoayyed/cas-oidc-docker:"v${image_tag}-amd64"
docker logs -f cas