FROM bioconductor/bioconductor_docker

RUN apt-get update \
&& apt-get install -y \
curl \
wget \
libboost-all-dev \
libudunits2-dev \
gawk \
pigz \
subversion

# Install miniconda
RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh \
&& bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/miniconda3 \
&& /opt/miniconda3/bin/conda config --add channels defaults \
&& /opt/miniconda3/bin/conda config --add channels conda-forge \
&& /opt/miniconda3/bin/conda config --add channels anaconda \
&& /opt/miniconda3/bin/conda config --add channels bioconda

# Install software required for small RNA-seq pipeline with bioconda
# Force version of bowtie because if not, it downloads v 1.0.0, which does not accept gzipped fastq
RUN /opt/miniconda3/bin/conda install fastqc
RUN /opt/miniconda3/bin/conda install rseqc
RUN /opt/miniconda3/bin/conda install multiqc
RUN /opt/miniconda3/bin/conda install cutadapt
RUN /opt/miniconda3/bin/conda install fastx_toolkit
RUN /opt/miniconda3/bin/conda install bowtie=1.3.1
RUN /opt/miniconda3/bin/conda install samtools
RUN /opt/miniconda3/bin/conda install subread
RUN /opt/miniconda3/bin/conda install bedtools
RUN /opt/miniconda3/bin/conda install deeptools
RUN /opt/miniconda3/bin/conda install pysam 
RUN /opt/miniconda3/bin/conda install r-spp
RUN /opt/miniconda3/bin/conda install fastq_utils

# Create directory for other tools 
RUN mkdir -p /src 

# Install ENSEMBL Compara Perl API and requirements
RUN cd /src && \
 wget https://github.com/bioperl/bioperl-live/archive/refs/tags/release-1-7-2.zip && \
 unzip release-1-7-2.zip && \
 mv bioperl-live-release-1-7-2  bioperl-1.7.2
RUN  cd /src && \
 wget -O ensembl-api.tar.gz http://ftp.ensembl.org/pub/ensembl-api.tar.gz && \
 tar zxvf ensembl-api.tar.gz

RUN PERL5LIB=${PERL5LIB}:/src/bioperl-1.7.2 && \
 PERL5LIB=${PERL5LIB}:/src/ensembl/modules && \
 PERL5LIB=${PERL5LIB}:/src/ensembl-compara/modules && \
 PERL5LIB=${PERL5LIB}:/src/ensembl-variation/modules && \
 PERL5LIB=${PERL5LIB}:/src/ensembl-funcgen/modules && \
 export PERL5LIB

# Install repeatMasker and dependencies
RUN pip install h5py
RUN cd /src && \
 wget -O rmblast-2.11.0.tar.gz http://www.repeatmasker.org/rmblast-2.11.0+-x64-linux.tar.gz && \
 tar zxvf rmblast-2.11.0.tar.gz
RUN cs /src && \
 wget -O trf4.09 https://github.com/Benson-Genomics-Lab/TRF/releases/download/v4.09.1/trf409.linux64 && \
 chmod -x trf4.09
RUN  cd /src && \
 wget -O RepeatMasker-4.1.2-p1.tar.gz https://www.repeatmasker.org/RepeatMasker/RepeatMasker-4.1.2-p1.tar.gz && \
 tar -xvzf RepeatMasker-4.1.2-p1.tar.gz && \
 cd RepeatMasker && \
 perl configure 

# Install Manna ()
RUN svn checkout https://svn.code.sf.net/p/manna/code/ /src/manna-code

RUN ls /src/*

# Install R packages
RUN Rscript -e 'install.packages("BiocManager", repos = "http://cran.us.r-project.org")'

RUN mkdir /Rscripts
COPY rpackages_general.R /Rscripts/
COPY rpackages_bio.R /Rscripts/
RUN Rscript /Rscripts/rpackages_general.R
RUN Rscript /Rscripts/rpackages_bio.R

# Update path
ENV PATH "/src/ensembl/:/src/ensembl/modules:$PATH"
ENV PATH "/src/ensembl-compara/:/src/ensembl-compara/modules:$PATH"
ENV PATH "/src/ensembl-variation/:/src/ensembl-variation/modules:$PATH"
ENV PATH "/src/ensembl-funcgen/:/src/ensembl-funcgen/modules:$PATH"
ENV PATH "/src/RepeatMasker:$PATH"
ENV PATH "/src/manna-code:$PATH"
ENV PATH "/src:$PATH"
ENV PATH "/opt/miniconda3/bin:$PATH"
ENV PATH "/usr/local/bin:$PATH"
