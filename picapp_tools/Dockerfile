FROM bioconductor/bioconductor_docker

RUN apt-get update \
&& apt-get install -y \
curl \
wget \
python \
perl \
libdbi-perl \
libdbd-mysql-perl \
subversion

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

# Install RNAz, vienna RNA package, locaRNA, evofold2 and RNAstructure with conda ------------------------------------------------------------- #
RUN /opt/miniconda3/bin/conda install -c bioconda rnaz
RUN /opt/miniconda3/bin/conda install -c bioconda viennarna
RUN /opt/miniconda3/bin/conda install -c bioconda locarna
RUN /opt/miniconda3/bin/conda install -c bioconda evofold2
RUN /opt/miniconda3/bin/conda install -c bioconda rnastructure


# ENSEMBL COMPARA PERL API AND REQUIREMENTS ---------------------------------------- #
# Install ENSEMBL Compara Perl API and requirements
WORKDIR /utils/
RUN wget https://github.com/bioperl/bioperl-live/archive/refs/tags/release-1-7-2.zip
RUN unzip release-1-7-2.zip && \
 mv bioperl-live-release-1-7-2  bioperl-1.7.2
RUN wget -O ensembl-api.tar.gz http://ftp.ensembl.org/pub/ensembl-api.tar.gz
RUN tar zxvf ensembl-api.tar.gz
WORKDIR /

# Update PATH
ENV PATH "/utils/ensembl/:/utils/ensembl/modules:$PATH"
ENV PATH "/utils/ensembl-compara/:/utils/ensembl-compara/modules:$PATH"
ENV PATH "/utils/ensembl-variation/:/utils/ensembl-variation/modules:$PATH"
ENV PATH "/utils/ensembl-funcgen/:/utils/ensembl-funcgen/modules:$PATH"

# Update PERL5LIB
ENV PERL5LIB "${PERL5LIB}:/utils/bioperl-1.7.2"
ENV PERL5LIB "${PERL5LIB}:/utils/ensembl/modules"
ENV PERL5LIB "${PERL5LIB}:/utils/ensembl-compara/modules"
ENV PERL5LIB "${PERL5LIB}:/utils/ensembl-variation/modules"
ENV PERL5LIB "${PERL5LIB}:/utils/ensembl-funcgen/modules"

# Check that ENSEMBL APIs work
WORKDIR /utils/ensembl/misc-scripts
RUN ./ping_ensembl.pl
WORKDIR /

# REPEATMASKER ------------------------------------------------------------------- #
# Install repeatMasker and dependencies
WORKDIR /utils/

RUN /opt/miniconda3/bin/conda install -c anaconda pip
RUN /opt/miniconda3/bin/pip install h5py
RUN /opt/miniconda3/bin/conda install h5py

RUN wget -O rmblast-2.11.0.tar.gz http://www.repeatmasker.org/rmblast-2.11.0+-x64-linux.tar.gz && \
  tar zxvf rmblast-2.11.0.tar.gz

RUN wget -O trf_4.09 https://github.com/Benson-Genomics-Lab/TRF/releases/download/v4.09.1/trf409.linux64
RUN chmod -x trf_4.09 && chmod 755 *

RUN wget https://www.repeatmasker.org/RepeatMasker/RepeatMasker-4.1.2-p1.tar.gz && \
 tar -xvzf RepeatMasker-4.1.2-p1.tar.gz

RUN chmod 755 *
WORKDIR /utils/RepeatMasker/
RUN perl ./configure -trf_prgm /utils/trf_4.09 -rmblast_dir /utils/rmblast-2.11.0/bin/ -default_search_engine "rmblast"

# WORKDIR /utils/RepeatMasker/Libraries
# RUN wget https://www.dfam.org/releases/Dfam_3.6/families/Dfam.h5.gz
# RUN gunzip --force Dfam.h5.gz
WORKDIR /

# Install Manna ------------------------------------------------------------------------ #
WORKDIR /utils/
RUN svn checkout https://svn.code.sf.net/p/manna/code/ /utils/manna-code
WORKDIR /

# # Install HOMER -------------------------------------------------------------------- #
# RUN mkdir -p /utils/homer
# WORKDIR /utils/homer
# RUN wget http://homer.ucsd.edu/homer/configureHomer.pl
# RUN perl configureHomer.pl -install

WORKDIR /

# # R LIBRARIES ========================================================================== #
# # Install R packages
# RUN Rscript -e 'install.packages("BiocManager", repos = "http://cran.us.r-project.org")'
# RUN mkdir /Rscripts
# COPY rpackages_general.R /Rscripts/
# COPY rpackages_bio.R /Rscripts/
# RUN Rscript /Rscripts/rpackages_general.R
# RUN Rscript /Rscripts/rpackages_bio.R

# Install python that may be needed
RUN /opt/miniconda3/bin/pip install pandas
RUN /opt/miniconda3/bin/pip install numpy
RUN /opt/miniconda3/bin/pip install scipy

# PATH VARIABLE ==================================================================== #
# Update path
ENV PATH "/utils/RepeatMasker:$PATH"
ENV PATH "/utils/RepeatMasker/util:$PATH"
ENV PATH "/utils/manna-code:$PATH"
ENV PATH "/utils:$PATH"
ENV PATH "/utils/ensembl/:/utils/ensembl/modules:$PATH"
ENV PATH "/utils/ensembl-compara/:/utils/ensembl-compara/modules:$PATH"
ENV PATH "/utils/ensembl-variation/:/utils/ensembl-variation/modules:$PATH"
ENV PATH "/utils/ensembl-funcgen/:/utils/ensembl-funcgen/modules:$PATH"
ENV PATH "/usr/local/bin:$PATH"

# Test ENSEMBL Compara ============================================================== #
WORKDIR /utils/ensembl/misc-scripts
RUN perl ping_ensembl.pl
WORKDIR /

# I will configure somethings inside the docker container
# To do so, build this docker file, open the docker image and run the required configurations and save them
#  $ docker images ## get the image id
#  $ docker run -it image_id bin/bash
#  $ ... see commands to configure and install extra things
#  $ exit
#  $ docker ps -a # to get the container id
#  $ docker commit container_id amitjavilaventura/picapp_tools:latest
# Configure repeatmasker within the image itself since I cannot configure within the build.
# First give execution permissions to all the utils
# Also install the h5py with conda if not installed
#  $ cd /utils
#  $ chmod 755 *
#  $ cd /utils/RepeatMasker/
#  $ perl ./configure -trf_prgm /utils/trf_4.09 -rmblast_dir /utils/rmblast-2.11.0/bin/ -default_search_engine "rmblast"
#  $ ... TRF path = /utils/trf_4.09
#  $ ... RMBLAST dir path = /utils/rmblast-2.11.0/bin/
# Ensembl compara things.
# Go to /utils/ensembl/misc_scripts and run "perl ping_ensembl.pl" (it may take some minutes). If there is an error, try to fix it.
