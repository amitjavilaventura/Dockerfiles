#! /bin/bash
IMAGE_VERSION=$(date '+%d%m%y')
podman build -t amitjavilaventura/rserver:${IMAGE_VERSION} -t amitjavilaventura/rserver:latest . #&& \
podman push amitjavilaventura/rserver:${IMAGE_VERSION}
podman push amitjavilaventura/rserver:latest
