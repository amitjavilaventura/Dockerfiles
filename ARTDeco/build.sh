#! /bin/bash

# Define image version -----
IMAGE_VERSION=$(date '+%d%m%y')
echo "ImageVersion: "$IMAGE_VERSION

# Build and push docker image -----
# docker build --no-cache -t amitjavilaventura/artdeco:${IMAGE_VERSION} -t amitjavilaventura/artdeco:latest -t amitjavilaventura/artdeco:config . && \
docker build -t amitjavilaventura/artdeco:${IMAGE_VERSION} -t amitjavilaventura/artdeco:latest .

docker push amitjavilaventura/artdeco:latest       
docker push amitjavilaventura/artdeco:${IMAGE_VERSION} 
    