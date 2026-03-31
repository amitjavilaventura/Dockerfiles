#! /bin/bash

# Define image version -----
IMAGE_VERSION=$(date '+%d%m%y')
echo "ImageVersion: "$IMAGE_VERSION

# Build and push docker image -----
# docker build --no-cache -t amitjavilaventura/xenium_ella:${IMAGE_VERSION} -t amitjavilaventura/xenium_ella:latest -t amitjavilaventura/xenium_ella:config . && \
# docker build --no-cache --progress=plain -t amitjavilaventura/xenium_ella:${IMAGE_VERSION} -t amitjavilaventura/xenium_ella:latest .
docker build --progress=plain -t amitjavilaventura/xenium_ella:${IMAGE_VERSION} -t amitjavilaventura/xenium_ella:latest .

docker push amitjavilaventura/xenium_ella:latest       
docker push amitjavilaventura/xenium_ella:${IMAGE_VERSION} 


# docker run -it --rm amitjavilaventura/xenium_ella:latest bash
