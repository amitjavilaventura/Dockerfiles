FROM bioconductor/bioconductor_docker

RUN apt-get update \
&& apt-get install -y \
curl \
wget \
libboost-all-dev \
libudunits2-dev \
gawk \
pigz 

# Install miniconda
RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh \
&& bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/miniconda3 \
&& /opt/miniconda3/bin/conda config --add channels defaults \
&& /opt/miniconda3/bin/conda config --add channels conda-forge \
&& /opt/miniconda3/bin/conda config --add channels anaconda \
&& /opt/miniconda3/bin/conda config --add channels bioconda

# Install software required for small RNA-seq pipeline with bioconda
RUN /opt/miniconda3/bin/conda install fastqc
RUN /opt/miniconda3/bin/conda install rseqc
RUN /opt/miniconda3/bin/conda install multiqc
RUN /opt/miniconda3/bin/conda install cutadapt
RUN /opt/miniconda3/bin/conda install fastx_toolkit
RUN /opt/miniconda3/bin/conda install bowtie
RUN /opt/miniconda3/bin/conda install samtools
RUN /opt/miniconda3/bin/conda install subread
RUN /opt/miniconda3/bin/conda install bedtools
RUN /opt/miniconda3/bin/conda install deeptools
RUN /opt/miniconda3/bin/conda install pysam 
RUN /opt/miniconda3/bin/conda install r-spp



# Install R packages
RUN Rscript -e 'install.packages("BiocManager", repos = "http://cran.us.r-project.org")'

RUN mkdir /Rscripts
COPY rpackages.R /Rscripts/
RUN Rscript /Rscripts/rpackages.R

# Download proTRAC and related tools
RUN mkdir -p /src/
RUN cd /src/
RUN wget https://sourceforge.net/projects/protrac/files/proTRAC_2.4.3.pl
RUN mv proTRAC_2.4.3.pl proTRAC.pl
RUN wget https://www.smallrnagroup.uni-mainz.de/software/TBr2.zip
RUN unzip TBr2.zip
RUN wget https://sourceforge.net/projects/protrac/files/sRNAmapper.pl
RUN wget https://sourceforge.net/projects/protrac/files/reallocate.pl
RUN wget https://www.smallrnagroup.uni-mainz.de/software/phaser.pl

# Update path
ENV PATH "/src:$PATH"
ENV PATH "/opt/miniconda3/bin:$PATH"
ENV PATH "/usr/local/bin:$PATH"
