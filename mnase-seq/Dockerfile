FROM bioconductor/bioconductor_docker

RUN apt-get update
RUN apt-get install -y \
    curl \
    wget \
    python3 \
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
RUN /opt/miniconda3/bin/conda install -y fastqc rseqc multiqc cutadapt fastx_toolkit seqtk seqkit
RUN /opt/miniconda3/bin/conda install -y bowtie=1.3.1 samtools=1.15
RUN /opt/miniconda3/bin/conda install -y bedtools deeptools
RUN /opt/miniconda3/bin/conda install -y fastq_utils

# Install R packages
RUN Rscript -e 'install.packages("BiocManager", repos = "http://cran.us.r-project.org")'
RUN mkdir /Rscripts
COPY rpackages_general.R /Rscripts/
COPY rpackages_bio.R /Rscripts/
RUN Rscript /Rscripts/rpackages_general.R
COPY rpackages_extra.R /Rscripts/
RUN Rscript /Rscripts/rpackages_extra.R
RUN Rscript /Rscripts/rpackages_bio.R

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
# Install DANPOS3
RUN mkdir -p /utils/danpos3/
WORKDIR /utils/danpos3/
RUN git clone https://github.com/sklasfeld/DANPOS3.git .
# RUN pip install -r requirements.txt
WORKDIR /

# Install DANPOS3 requirements, since pip install does not work
RUN pip install rpy2
RUN pip install argparse
RUN pip install numpy # =1.18.5
RUN pip install pysam # =0.16.0.1
RUN pip install scipy # =1.5.4

# Install nucleosomeDynamics
RUN mkdir -p /utils/nucleosome_dynamics/
WORKDIR /utils/nucleosome_dynamics/
RUN git clone https://github.com/nucleosome-dynamics/nucleosome_dynamics.git 


RUN mkdir -p /utils/wig_utils;
WORKDIR /utils/wig_utils;
RUN wget http://hgdownload.soe.ucsc.edu/admin/exe/linux.x86_64/wigToBigWig &&  \ 
 wget http://hgdownload.soe.ucsc.edu/admin/exe/linux.x86_64/bigWigToWig  && \ 
 wget http://hgdownload.soe.ucsc.edu/admin/exe/linux.x86_64/fetchChromSizes;
RUN chmod a+x *



# UPDATE PATH VARIABLE ============================================================================ #
ENV PATH "/utils:/utils/kaplan_nuc_model:/utils/kaplan_nuc_model/bin:/utils/danpos3/:/utils/nucleosome_dynamics/:/utils/wig_utils/:$PATH"
ENV PATH "/opt/miniconda3/bin:$PATH"


