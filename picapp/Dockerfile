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
python \
perl 


# Install miniconda
RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh \
&& bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/miniconda3 \
&& /opt/miniconda3/bin/conda config --add channels defaults \
&& /opt/miniconda3/bin/conda config --add channels conda-forge \
&& /opt/miniconda3/bin/conda config --add channels anaconda \
&& /opt/miniconda3/bin/conda config --add channels bioconda


# Install software required for small RNA-seq pipeline with bioconda
# Force version of bowtie because if not, it downloads v 1.0.0, which does not accept gzipped fastq
# Force version of samtools because otherwise downloads an older version that has conflicts with openssl
RUN /opt/miniconda3/bin/conda install fastqc
RUN /opt/miniconda3/bin/conda install rseqc
RUN /opt/miniconda3/bin/conda install multiqc
RUN /opt/miniconda3/bin/conda install cutadapt
RUN /opt/miniconda3/bin/conda install fastx_toolkit
RUN /opt/miniconda3/bin/conda install bowtie=1.3.1
RUN /opt/miniconda3/bin/conda install samtools=1.11
RUN /opt/miniconda3/bin/conda install subread
RUN /opt/miniconda3/bin/conda install bedtools
RUN /opt/miniconda3/bin/conda install deeptools
RUN /opt/miniconda3/bin/conda install pysam 
RUN /opt/miniconda3/bin/conda install r-spp
RUN /opt/miniconda3/bin/conda install fastq_utils


# Install R packages
RUN Rscript -e 'install.packages("BiocManager", repos = "http://cran.us.r-project.org")'
RUN mkdir /Rscripts
COPY rpackages_general.R /Rscripts/
COPY rpackages_bio.R /Rscripts/
RUN Rscript /Rscripts/rpackages_general.R
RUN Rscript /Rscripts/rpackages_bio.R


# UPDATE PATH VARIABLE ============================================================================ #
ENV PATH "/opt/miniconda3/bin:$PATH"
ENV PATH "/usr/local/bin:$PATH"

