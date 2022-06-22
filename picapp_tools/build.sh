#! /bin/bash

# Define image version -----
IMAGE_VERSION=$(date '+%d%m%y')
echo "ImageVersion: "$IMAGE_VERSION

# Build and push docker image -----
# docker build --no-cache -t amitjavilaventura/picapp_tools:${IMAGE_VERSION} -t amitjavilaventura/picapp_tools:latest -t amitjavilaventura/picapp_tools:config . && \
docker build -t amitjavilaventura/picapp_tools:${IMAGE_VERSION} -t amitjavilaventura/picapp_tools:latest .


# docker push amitjavilaventura/picapp_tools:${IMAGE_VERSION}  # after configuring repeatmasker etc
# docker push amitjavilaventura/picapp_tools:latest            # after configuring repeatmasker etc