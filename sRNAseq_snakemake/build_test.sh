#! /bin/bash
IMAGE_VERSION=$(date '+%d%m%y')
docker build -t amitjavilaventura/srnaseq_snakemake:${IMAGE_VERSION} -t amitjavilaventura/srnaseq_snakemake:latest . && \
docker push amitjavilaventura/srnaseq_snakemake:${IMAGE_VERSION}
docker push amitjavilaventura/srnaseq_snakemake:latest
