# Load base image
FROM continuumio/miniconda3:24.3.0-0

# Install system packages required for building dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    make \
    git \
    libssl-dev \
    libffi-dev \
    libc6-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Disable Conda's compiler compatibility to use system's GCC and LD
ENV CONDA_BUILD_SYSROOT=/ \
    CC=/usr/bin/gcc \
    CXX=/usr/bin/g++

# Install conda packages
RUN conda install --yes -c bioconda -c conda-forge \
  bedops=2.4.41 \
  bx-python=0.11.0 \
  homer=4.11 \
  networkx=3.3 \
  numpy=1.26.4 \
  pandas=1.5.3 \
  python=3.10.14 \
  rseqc=5.0.3 \
  samtools=1.20

# Clean up conda tarballs
RUN conda clean --all --yes

# Install R and DESeq2
RUN apt-get update && apt-get install -y --no-install-recommends r-base && \
    R --slave -e 'install.packages("DESeq2", repos="https://cloud.r-project.org/")'

# Clone and install ARTDeco
RUN git clone https://github.com/sjroth/ARTDeco.git /ARTDeco
WORKDIR /ARTDeco
RUN python setup.py install

# Set working directory back to root
WORKDIR /
