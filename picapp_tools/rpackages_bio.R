# define packages to install from cran or bioconductor
pakages_compbio         <- c("fastqcr", 'GenomicRanges', 'plyranges', 'GenomicFeatures', "Rsamtools", "megadepth",
                             "ChIPpeakAnno", "enrichR", "clusterProfiler", "rtracklayer", "PhanstielLab/bedtoolsr",
                             "DOSE", "gprofiler2")
packages_nucleosome     <- c("NuPoP", "nuCpos")
packages_de_stuff       <- c('DESeq2', 'pcaExplorer','apeglm', 'IHW')
packages_annot          <- c('org.Mm.eg.db', 'org.Hs.eg.db',
                             'TxDb.Mmusculus.UCSC.mm9.knownGene', 'TxDb.Mmusculus.UCSC.mm10.knownGene', 
                             'TxDb.Hsapiens.UCSC.hg19.knownGene', 'TxDb.Hsapiens.UCSC.hg18.knownGene')

# Install packages from bioconductor
BiocManager::install(packages_de_stuff)
BiocManager::install(pakages_compbio)
BiocManager::install(packages_annot)
BiocManager::install(packages_nucleosome)

# Install megadepth
megadepth::install_megadepth()
