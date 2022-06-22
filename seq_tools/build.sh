#! /bin/bash

# Define image version -----
IMAGE_VERSION=$(date '+%d%m%y')
echo "ImageVersion: "$IMAGE_VERSION

# Build and push docker image -----
# docker build --no-cache -t amitjavilaventura/seq_tools:${IMAGE_VERSION} -t amitjavilaventura/seq_tools:latest -t amitjavilaventura/seq_tools:config . && \
docker build -t amitjavilaventura/seq_tools:${IMAGE_VERSION} -t amitjavilaventura/seq_tools:latest .


docker push amitjavilaventura/seq_tools:${IMAGE_VERSION}  # after configuring repeatmasker etc
docker push amitjavilaventura/seq_tools:latest            # after configuring repeatmasker etc