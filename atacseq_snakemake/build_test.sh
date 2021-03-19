#! /bin/bash
IMAGE_VERSION=$(date '+%d%m%y')
docker build -t amitjavilaventura/atacseq_snakemake:${IMAGE_VERSION} -t amitjavilaventura/atacseq_snakemake:latest . && \
docker push amitjavilaventura/atacseq_snakemake:${IMAGE_VERSION}
docker push amitjavilaventura/atacseq_snakemake:latest