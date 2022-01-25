#! /bin/bash
IMAGE_VERSION=$(date '+%d%m%y')
docker build -t amitjavilaventura/srna_seq:${IMAGE_VERSION} -t amitjavilaventura/srna_seq:latest . && \
docker push amitjavilaventura/srna_seq:${IMAGE_VERSION}
docker push amitjavilaventura/srna_seq:latest
