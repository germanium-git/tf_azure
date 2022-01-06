#!/bin/bash

# Load the cRPD software image
docker load -i junos-routing-crpd-docker-21.4R1.12.tgz

# Create data volume for configuration and var logs
docker volume create crpd01-config
docker volume create crpd01-varlog


docker run --rm --detach --name crpd01 -h crpd01 --privileged --net=host -v crpd01-config:/config -v crpd01-varlog:/var/log -it crpd:21.4R1.12