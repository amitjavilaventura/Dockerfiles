FROM bioconductor/bioconductor_docker

RUN apt-get update \
&& apt-get install -y \
curl \
wget \
libboost-all-dev \
libudunits2-dev \
gawk 

# Install miniconda
RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh \
&& bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/miniconda3 \
&& /opt/miniconda3/bin/conda config --add channels defaults \
&& /opt/miniconda3/bin/conda config --add channels conda-forge \
&& /opt/miniconda3/bin/conda config --add channels bioconda

# Install software required for chipseq pipeline with bioconda
# Force version of samtools to avoid error https://github.com/bioconda/bioconda-recipes/issues/13958
RUN /opt/miniconda3/bin/conda install -c bioconda \
fastqc \
multiqc \ 
bowtie2 \
samtools=1.11 \
samblaster \
picard \
genrich \ 
deeptools \
bedtools \
wiggletools \
pysam \ 
r-spp \
ucsc-bedgraphtobigwig \
NGmerge
# nucleoatac \
# tobias \   
# atacv 

# Install fastp manually because bioconda verison is not the latest
RUN wget http://opengene.org/fastp/fastp \
&& chmod a+x ./fastp \
&& mv ./fastp /usr/local/bin

# # Install TOBIAS via pip -->no
# RUN pip install tobias

# bioconductor
RUN R --slave -e "BiocManager::install(c( \
        'org.Mm.eg.db', \
        'org.Hs.eg.db', \
        'TxDb.Mmusculus.UCSC.mm9.knownGene', \
        'TxDb.Mmusculus.UCSC.mm10.knownGene', \
        'TxDb.Hsapiens.UCSC.hg19.knownGene', \
        'TxDb.Hsapiens.UCSC.hg18.knownGene', \
        'ChIPseeker', \
        'ChIPpeakAnno', \
        'DiffBind', \
        'clusterProfiler', \
        'enrichplot', \
        'plyranges', \
        'ComplexHeatmap', \
        'circlize', \
        'ATACseqQC', \
        'MotifDb'))" 

# cran
RUN R --slave -e 'install.packages(c( \
         "data.table", \
         "tidyverse", \
         "RColorBrewer", \
         "devtools", \
         "spp", \
         "magrittr"), \
         repos="https://cloud.r-project.org/")'

# Update path
ENV PATH "/opt/miniconda3/bin:$PATH"
ENV PATH "/usr/local/bin:$PATH"
