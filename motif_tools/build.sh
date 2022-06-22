#! /bin/bash

# Define image version -----
IMAGE_VERSION=$(date '+%d%m%y')
echo "ImageVersion: "$IMAGE_VERSION

# Build and push docker image -----
# docker build --no-cache -t amitjavilaventura/motif_tools:${IMAGE_VERSION} -t amitjavilaventura/motif_tools:latest -t amitjavilaventura/motif_tools:config . && \
docker build -t amitjavilaventura/motif_tools:${IMAGE_VERSION} -t amitjavilaventura/motif_tools:latest .


# docker push amitjavilaventura/motif_tools:${IMAGE_VERSION}  # after configuring repeatmasker etc
# docker push amitjavilaventura/motif_tools:latest            # after configuring repeatmasker etc