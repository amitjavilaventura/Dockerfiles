# Base image
FROM python:3.10

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1

# System dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    cmake \
    libhdf5-dev \
    libssl-dev \
    libffi-dev \
    libxml2-dev \
    libcurl4-openssl-dev \
    libblas-dev \
    liblapack-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN pip install --upgrade pip  wheel


# install older version of setuptools because it fails when importing spatialdata
RUN pip install "setuptools<82"


############################################
# Install CellSP + dependencies
############################################
# instant is already installed with cellsp
# RUN pip install cellsp subcellular-sprawl sc-instant
RUN pip install cellsp subcellular-sprawl


## cellsp already installs 
## - sc-instant, anndata, pandas, numpy, scipy, scikit-learn, matplotlib...

# # Install bento --> not working with others
# RUN pip install bento-tools

############################################
# scverse + spatialdata ecosystem
############################################
# anndata is already installed with cellsp
RUN pip install squidpy spatialdata spatialdata-io spatialdata-plot


############################################
# Core scientific stack and others
############################################
RUN pip install h5py dask dask-image seaborn xarray zarr jupyterlab ipython setuptools


############################################
# Validate installation (fail early if broken)
############################################
# RUN python -c "import cellSP; print('cellSP OK')"
# RUN python -c "import InSTAnT; print('InSTAnT OK')"
# RUN python -c "import sprawl; print('SPRAWL OK')"
# RUN python -c "import anndata; print('anndata OK')"

# RUN python -c "import pkg_resources; print('pkg_resources OK')"
# RUN python -c "import spatialdata; print('spatialdata OK')"


WORKDIR /workspace

CMD ["/bin/bash"]