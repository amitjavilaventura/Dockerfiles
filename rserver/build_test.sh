#! /bin/bash
IMAGE_VERSION=$(date '+%d%m%y')
docker build -t amitjavilaventura/rserver:${IMAGE_VERSION} -t amitjavilaventura/rserver:latest . && \
docker push amitjavilaventura/rserver:${IMAGE_VERSION}
docker push amitjavilaventura/rserver:latest
