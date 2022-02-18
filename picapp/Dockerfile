FROM bioconductor/bioconductor_docker

RUN apt-get update \
&& apt-get install -y \
curl \
wget \
libboost-all-dev \
libudunits2-dev \
gawk \
pigz \
subversion \
python

# Install miniconda
RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh \
&& bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/miniconda3 \
&& /opt/miniconda3/bin/conda config --add channels defaults \
&& /opt/miniconda3/bin/conda config --add channels conda-forge \
&& /opt/miniconda3/bin/conda config --add channels anaconda \
&& /opt/miniconda3/bin/conda config --add channels bioconda

# Install software required for small RNA-seq pipeline with bioconda
# Force version of bowtie because if not, it downloads v 1.0.0, which does not accept gzipped fastq
RUN /opt/miniconda3/bin/conda install fastqc rseqc multiqc
RUN /opt/miniconda3/bin/conda install cutadapt fastx_toolkit
RUN /opt/miniconda3/bin/conda install bowtie=1.3.1 samtools star
RUN /opt/miniconda3/bin/conda install subread
RUN /opt/miniconda3/bin/conda install bedtools bedops
RUN /opt/miniconda3/bin/conda install deeptools
RUN /opt/miniconda3/bin/conda install pysam
RUN /opt/miniconda3/bin/conda install r-spp
RUN /opt/miniconda3/bin/conda install fastq_utils


# Create directory for other tools 
RUN mkdir -p /utils 
WORKDIR /utils/

# # Install pyicoteo toolsuite (it has problems, but I could install it locally)
# RUN wget -O pyicoteo.zip https://bitbucket.org/regulatorygenomicsupf/pyicoteo/get/b49b679a3f8f.zip && \
#  unzip pyicoteo.zip && \
#  mv *pyicoteo*/ pyicoteo/
# RUN ls -lah /utils/
# RUN ls -lah /utils/pyicoteo
# RUN python pyicoteo/setup.py install

# Install ENSEMBL Compara Perl API and requirements
RUN wget https://github.com/bioperl/bioperl-live/archive/refs/tags/release-1-7-2.zip
RUN unzip release-1-7-2.zip && \
 mv bioperl-live-release-1-7-2  bioperl-1.7.2
RUN wget -O ensembl-api.tar.gz http://ftp.ensembl.org/pub/ensembl-api.tar.gz
RUN tar zxvf ensembl-api.tar.gz

WORKDIR /

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

# Install repeatMasker and dependencies
# force unzip of Dfam.h5.gz because there is already one file with the same name
WORKDIR /utils/
RUN pip install h5py

RUN wget -O rmblast-2.11.0.tar.gz http://www.repeatmasker.org/rmblast-2.11.0+-x64-linux.tar.gz && \
  tar zxvf rmblast-2.11.0.tar.gz

RUN wget -O trf_4.09 https://github.com/Benson-Genomics-Lab/TRF/releases/download/v4.09.1/trf409.linux64
RUN chmod -x trf_4.09

RUN wget https://www.repeatmasker.org/RepeatMasker/RepeatMasker-4.1.2-p1.tar.gz && \
 tar -xvzf RepeatMasker-4.1.2-p1.tar.gz

RUN ls /utils/RepeatMasker/Libraries

WORKDIR /utils/RepeatMasker/Libraries
RUN wget https://www.dfam.org/releases/Dfam_3.2/families/Dfam.h5.gz && \
 gunzip -f Dfam.h5.gz
WORKDIR /utils/

# Install h5py for repeatmasker. 
# With pip intstall gives some problem for the subsequent configuration of the repeatMasker. 
# I have done it manually inside the docker container by running the following command
# /opt/miniconda3/bin/conda install h5py
RUN /opt/miniconda3/bin/conda install h5py

# I will configure repeatmasker within the image itself since I cannot configure within the build.
# First give execution permissions to all the utils
# Also install the h5py with conda if not installed
#  $ cd /utils 
#  $ chmod 755 *
#  $ cd /utils/RepeatMasker/ 
#  $ perl ./configure
#  $ ... TRF path = /utils/trf_4.09
#  $ ... RMBLAST dir path = /utils/rmblast-2.11.0/bin/
# To do so, build this docker file, open the docker image and run the required configurations and save them
#  $ docker images ## get the image id
#  $ docker run -it image_id bin/bash
#  $ ... see commands avobe
#  $ exit
#  $ docker ps -a # to get the container id
#  $ docker commit container_id new_image_name


# Install Manna ()
WORKDIR /utils/
RUN svn checkout https://svn.code.sf.net/p/manna/code/ /utils/manna-code
WORKDIR /

# Install R packages
RUN Rscript -e 'install.packages("BiocManager", repos = "http://cran.us.r-project.org")'

RUN mkdir /Rscripts
COPY rpackages_general.R /Rscripts/
COPY rpackages_bio.R /Rscripts/
RUN Rscript /Rscripts/rpackages_general.R
RUN Rscript /Rscripts/rpackages_bio.R

# Update path
ENV PATH "/utils/ensembl/:/utils/ensembl/modules:$PATH"
ENV PATH "/utils/ensembl-compara/:/utils/ensembl-compara/modules:$PATH"
ENV PATH "/utils/ensembl-variation/:/utils/ensembl-variation/modules:$PATH"
ENV PATH "/utils/ensembl-funcgen/:/utils/ensembl-funcgen/modules:$PATH"
ENV PATH "/utils/RepeatMasker:$PATH"
ENV PATH "/utils/manna-code:$PATH"
ENV PATH "/utils:$PATH"
ENV PATH "/opt/miniconda3/bin:$PATH"
ENV PATH "/usr/local/bin:$PATH"
