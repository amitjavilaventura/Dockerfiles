FROM python:3.9-slim

LABEL maintainer="your_email"

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1

# System dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    cmake \
    libssl-dev \
    libffi-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN pip install --upgrade pip setuptools wheel

# Scientific dependencies
RUN pip install \
    numpy \
    scipy \
    pandas \
    scikit-learn

# Install PyTorch (CPU version)
RUN pip install torch torchvision torchaudio \
    --index-url https://download.pytorch.org/whl/cpu

# Install ELLA
RUN pip install git+https://github.com/jadexq/ELLA.git


# ####################################
# # Clone & Install ELLA via Poetry
# ####################################
# RUN git clone https://github.com/jadexq/ELLA.git /opt/ELLA
# WORKDIR /opt/ELLA/
# RUN poetry install 
# WORKDIR /


WORKDIR /workspace

CMD ["/bin/bash"]