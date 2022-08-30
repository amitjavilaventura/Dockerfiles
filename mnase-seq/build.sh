#! /bin/bash

# Define image version ----- 
IMAGE_VERSION=$(date '+%d%m%y')
echo "ImageVersion: "$IMAGE_VERSION

# # Docker build test
# docker build -t amitjavilaventura/mnase_seq:test .

# Build and push docker image -----
# docker build --no-cache -t amitjavilaventura/mnase_seq:${IMAGE_VERSION} -t amitjavilaventura/mnase_seq:latest -t amitjavilaventura/mnase_seq:config . && \
docker build -t amitjavilaventura/mnase_seq:${IMAGE_VERSION} -t amitjavilaventura/mnase_seq:latest . && \
  docker push amitjavilaventura/mnase_seq:${IMAGE_VERSION}
  docker push amitjavilaventura/mnase_seq:latest 