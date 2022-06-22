FROM bioconductor/bioconductor_docker

RUN apt-get update \
&& apt-get install -y \
curl \
wget \
python \
perl \
libdbi-perl \
libdbd-mysql-perl \
subversion \
libgsl0ldbl \
libgsl2 

# Install miniconda
RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh \
&& bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/miniconda3 \
&& /opt/miniconda3/bin/conda config --add channels defaults \
&& /opt/miniconda3/bin/conda config --add channels conda-forge \
&& /opt/miniconda3/bin/conda config --add channels anaconda \
&& /opt/miniconda3/bin/conda config --add channels bioconda

# Install some tools
RUN /opt/miniconda3/bin/conda install bedtools 


# OTHER TOOLS ====================================================================== #
# Create directory for other tools 
RUN mkdir -p /utils

# Install HOMER -------------------------------------------------------------------- #
RUN mkdir -p /utils/homer
WORKDIR /utils/homer
RUN wget http://homer.ucsd.edu/homer/configureHomer.pl
RUN perl configureHomer.pl -install 

# Install REAPR and dependencies --------------------------------------------------- #
WORKDIR /utils

# Download and install dependencies
RUN wget https://www.tbi.univie.ac.at/RNA/download/sourcecode/2_5_x/ViennaRNA-2.5.0.tar.gz && \
  tar -vxzf ViennaRNA-2.5.0.tar.gz
WORKDIR VienaRNA-2.5.0
RUN ./configure --prefix=/utils/VienaRNA-2.5.0
RUN make
RUN make check
RUN make install
WORKDIR /utils

RUN wget https://www.tbi.univie.ac.at/software/RNAz/RNAz-2.1.tar.gz && \
  tar -vxzf RNAz-2.1.tar.gz
WORKDIR RNAz-2.1
RUN ./configure
RUN make
RUN make install
WORKDIR /utils

RUN wget http://cb.csail.mit.edu/cb/reapr/Software/locarna-1.7.1.tar.gz && \
  tar -vxcf locarna-1.7.1.tar.gz
WORKDIR locarna-1.7.1
RUN ./configure --enable-librna
RUN make
RUN make install
WORKDIR /utils

# Download and install reapr
RUN wget http://cb.csail.mit.edu/cb/reapr/Software/reapr.zip && \
  unzip reapr.zip && \
  mv reapr* reapr
RUN python configure.py

# # R LIBRARIES ========================================================================== #
# # Install R packages
# RUN Rscript -e 'install.packages("BiocManager", repos = "http://cran.us.r-project.org")'
# RUN mkdir /Rscripts
# COPY rpackages_general.R /Rscripts/
# COPY rpackages_bio.R /Rscripts/
# RUN Rscript /Rscripts/rpackages_general.R
# RUN Rscript /Rscripts/rpackages_bio.R

# Install python modules that may be needed
RUN /opt/miniconda3/bin/pip install pandas
RUN /opt/miniconda3/bin/pip install numpy
RUN /opt/miniconda3/bin/pip install scipy

# PATH VARIABLE ==================================================================== #
# Update path
ENV PATH "/utils/homer/bin:$PATH"
ENV PATH "/utils:$PATH"
ENV PATH "/opt/miniconda3/bin:$PATH"
ENV PATH "/usr/local/bin:$PATH"



# I will configure somethings inside the docker container
# To do so, build this docker file, open the docker image and run the required configurations and save them
#  $ docker images ## get the image id
#  $ docker run -it image_id bin/bash
#  $ ... see commands to configure and install extra things
#  $ exit
#  $ docker ps -a # to get the container id
#  $ docker commit container_id amitjavilaventura/picapp_tools:latest
# Configure required stuff
# First give execution permissions to all the utils
