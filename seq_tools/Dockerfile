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

# Install python that may be needed
RUN /opt/miniconda3/bin/conda install -c anaconda pip
RUN /opt/miniconda3/bin/pip install pandas
RUN /opt/miniconda3/bin/pip install numpy
RUN /opt/miniconda3/bin/pip install scipy

# OTHER TOOLS ====================================================================== #
# Create directory for other tools 
RUN mkdir -p /utils 

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

# Install Manna ------------------------------------------------------------------------ #
WORKDIR /utils/
RUN svn checkout https://svn.code.sf.net/p/manna/code/ /utils/manna-code
WORKDIR /

# Install HOMER -------------------------------------------------------------------- #
RUN mkdir -p /utils/homer
WORKDIR /utils/homer
RUN wget http://homer.ucsd.edu/homer/configureHomer.pl
RUN perl configureHomer.pl -install
WORKDIR /

# Install RNAz, vienna RNA package, locaRNA, evofold2 and RNAstructure with conda ------------------------------------------------------------- #
RUN /opt/miniconda3/bin/conda install -c bioconda rnaz
RUN /opt/miniconda3/bin/conda install -c bioconda viennarna
RUN /opt/miniconda3/bin/conda install -c bioconda locarna
RUN /opt/miniconda3/bin/conda install -c bioconda evofold2
RUN /opt/miniconda3/bin/conda install -c bioconda rnastructure

RUN chmod 755 -R /utils/*

# Install Rpackages ================================================================ #

RUN Rscript -e 'install.packages("BiocManager", repos = "http://cran.us.r-project.org")'

RUN mkdir /Rscripts
COPY rpackages_general.R /Rscripts/
COPY rpackages_bio.R /Rscripts/
RUN Rscript /Rscripts/rpackages_general.R
RUN Rscript /Rscripts/rpackages_bio.R

# PATH VARIABLE ==================================================================== #
# Update DATAPATH VARIABLE (required for correct rnastructure)
ENV DATAPATH "/opt/miniconda3/share/rnastructure/data_tables"

# Update path
ENV PATH "/utils/homer/bin:$PATH"
ENV PATH "/utils/manna-code:$PATH"
ENV PATH "/utils:$PATH"
ENV PATH "/opt/miniconda3/share/rnastructure/data_tables:$PATH"
ENV PATH "/opt/miniconda3/share/ViennaRNA/bin:$PATH"
ENV PATH "/opt/miniconda3/share/RNAz/:$PATH"
ENV PATH "/opt/miniconda3/bin:$PATH"
ENV PATH "/usr/local/bin:$PATH"