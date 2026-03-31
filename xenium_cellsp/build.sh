#! /bin/bash

# Define image version -----
IMAGE_VERSION=$(date '+%d%m%y')
echo "ImageVersion: "$IMAGE_VERSION

# Build and push docker image -----
# docker build --no-cache -t amitjavilaventura/xenium_cellsp:${IMAGE_VERSION} -t amitjavilaventura/xenium_cellsp:latest -t amitjavilaventura/xenium_cellsp:config . && \
# docker build --no-cache --progress=plain -t amitjavilaventura/xenium_cellsp:${IMAGE_VERSION} -t amitjavilaventura/xenium_cellsp:latest .
docker build --no-cache --progress=plain -t amitjavilaventura/xenium_cellsp:${IMAGE_VERSION} -t amitjavilaventura/xenium_cellsp:latest .

docker push amitjavilaventura/xenium_cellsp:latest       
docker push amitjavilaventura/xenium_cellsp:${IMAGE_VERSION} 


# docker run -it --rm amitjavilaventura/xenium_cellsp:latest bash
