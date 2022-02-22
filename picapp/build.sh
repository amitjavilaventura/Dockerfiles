#! /bin/bash

# Define image version ----- 
IMAGE_VERSION=$(date '+%d%m%y')
echo "ImageVersion: "$IMAGE_VERSION

# Build and push docker image -----
# docker build --no-cache -t amitjavilaventura/picapp:${IMAGE_VERSION} -t amitjavilaventura/picapp:latest -t amitjavilaventura/picapp:config . && \
docker build -t amitjavilaventura/picapp:${IMAGE_VERSION} -t amitjavilaventura/picapp:latest -t amitjavilaventura/picapp:config . && \
docker push amitjavilaventura/picapp:${IMAGE_VERSION}
docker push amitjavilaventura/picapp:latest
# docker push amitjavilaventura/picapp:config
