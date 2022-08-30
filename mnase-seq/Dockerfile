FROM bioconductor/bioconductor_docker

RUN apt-get update \
    && apt-get install -y \
    curl \
    wget \
    gawk \
    python \
    perl

# Install miniconda
RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/miniconda3 \
    && /opt/miniconda3/bin/conda config --add channels defaults \
    && /opt/miniconda3/bin/conda config --add channels conda-forge \
    && /opt/miniconda3/bin/conda config --add channels anaconda \
    && /opt/miniconda3/bin/conda config --add channels bioconda


# Update PATH variable

# Install software required with bioconda
# Force version of bowtie because if not, it downloads v 1.0.0, which does not accept gzipped fastq
RUN /opt/miniconda3/bin/conda install fastqc rseqc multiqc cutadapt fastx_toolkit
RUN /opt/miniconda3/bin/conda install bowtie=1.3.1 samtools=1.15
RUN /opt/miniconda3/bin/conda install bedtools deeptools
RUN /opt/miniconda3/bin/conda install fastq_utils
RUN /opt/miniconda3/bin/conda install -c biobuilds shrimp


# Install R packages
RUN Rscript -e 'install.packages("BiocManager", repos = "http://cran.us.r-project.org")'
RUN mkdir /Rscripts
COPY rpackages_general.R /Rscripts/
COPY rpackages_bio.R /Rscripts/
RUN Rscript /Rscripts/rpackages_general.R
RUN Rscript /Rscripts/rpackages_bio.R
COPY rpackages_extra.R /Rscripts/
RUN Rscript /Rscripts/rpackages_extra.R

# Install nucleosome model for Kaplan et al., Nature, 2009.
# Taken from https://github.com/KaplanLab/NucleosomeModel
RUN mkdir -p /utils/kaplan_nuc_model
WORKDIR /utils/kaplan_nuc_model
RUN git clone https://github.com/KaplanLab/NucleosomeModel .
RUN make install
RUN perl nucleosome_prediction.pl --help
RUN perl nucleosome_prediction.pl -t title -s input.fa -c 0.03 -temp 1 -tab -p out
WORKDIR /

# I couldn't make danpos3 work from the sing image, so I installed a conda environment and the danpos scripts in my workstation/cluster

# UPDATE PATH VARIABLE ============================================================================ #
ENV PATH "/utils:/utils/kaplan_nuc_model:/utils/kaplan_nuc_model/bin:$PATH"
ENV PATH "/opt/miniconda3/bin:$PATH"

