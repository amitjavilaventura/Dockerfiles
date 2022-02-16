#! /bin/bash

# Define image version ----- 
IMAGE_VERSION=$(date '+%d%m%y')

# Build and push docker image -----
docker build --no-cache -t amitjavilaventura/srna_seq:${IMAGE_VERSION} -t amitjavilaventura/srna_seq:latest . && \
#docker build -t amitjavilaventura/srna_seq:${IMAGE_VERSION} -t amitjavilaventura/srna_seq:latest . && \
docker push amitjavilaventura/srna_seq:${IMAGE_VERSION}
docker push amitjavilaventura/srna_seq:latest
