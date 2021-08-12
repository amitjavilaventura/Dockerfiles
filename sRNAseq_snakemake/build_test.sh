#! /bin/bash
IMAGE_VERSION=$(date '+%d%m%y')
docker build -t amitjavilaventura/sRNAseq_snakemake:${IMAGE_VERSION} -t amitjavilaventura/sRNAseq_snakemake:latest . && \
docker push amitjavilaventura/sRNAseq_snakemake:${IMAGE_VERSION}
docker push amitjavilaventura/sRNAseq_snakemake:latest