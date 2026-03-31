# Install packages function -- function taken from dfernandezperez
install_packages <- function(packages) {
  for ( i in packages ) {
    if ( grepl(i, pattern = '/') ) {
      if ( grepl(i, pattern = '@') ) {
        name <- strsplit(i, split = '/')[[1]][2]
        name <- strsplit(name, split = '@')[[1]][1]
      } else {
        name <- strsplit(i, split = '/')[[1]][2]
      }
    } else {
      name <- i
    }
    if ( (name %in% library()$results[,1] ) == FALSE ) {
      message(paste0('[', format(Sys.time(), '%Y-%m-%d %H:%M:%S'), "] '", i, "' will be installed."))
      BiocManager::install(i, update = TRUE, ask = FALSE, quiet = TRUE, Ncpus = 2)
      if ( (name %in% library()$results[,1] ) == FALSE ) {
        message(paste0('[', format(Sys.time(), '%Y-%m-%d %H:%M:%S'), "] '", i, "' installation failed."))
        stop()
      } else {
        message(paste0('[', format(Sys.time(), '%Y-%m-%d %H:%M:%S'), "] '", i, "' successfully installed."))
      }
    } else {
      message(paste0('[', format(Sys.time(), '%Y-%m-%d %H:%M:%S'), "] '", i, "' already installed."))
    }
  }
}



# define packages to install from cran or bioconductor
packages_utilities       <- c("devtools", "plyr", "tidyverse", "tibble", "here", "workflowr", "reticulate", "openxlsx", "stringi", "janitor", "jpeg", "tidygraph",
                              "DT", "data.table", "openxlsx", "magrittr", "reshape", "reshape2","readxl")

packages_compbio_general <- c("Biostrings","biomaRt", "biomartr",'GenomicRanges','GenomicFeatures','plyranges', "SummarizedExperiment",
                              "megadepth", "Rsamtools", "Rsubread","ChIPseeker", "ChIPpeakAnno","bamsignals","BSgenome",
                              "tximport", 'DESeq2', 'pcaExplorer','apeglm', 'IHW', "edgeR", "limma", "DiffBind",
                              "memmes", "marge", "nucleR", "nuCpos", "msa", "seqinr", "seqTools", 
                              "Seurat")

packages_annot <- c('org.Mm.eg.db', 'org.Hs.eg.db', "msigdbr", "GSEABase", 
                    'TxDb.Mmusculus.UCSC.mm9.knownGene','TxDb.Mmusculus.UCSC.mm10.knownGene', 'TxDb.Hsapiens.UCSC.hg19.knownGene', 'TxDb.Hsapiens.UCSC.hg18.knownGene', 'TxDb.Mmusculus.UCSC.mm39.refGene', 
                    "BSgenome.Dmelanogaster.UCSC.dm6", "BSgenome.Hsapiens.UCSC.hg38", "BSgenome.Mmusculus.UCSC.mm10", "BSgenome.Mmusculus.UCSC.mm39", "BSgenome.Celegans.UCSC.ce11")

packages_compbio         <- c("fastqcr", "ATACseqQC","circlize", "biovizBase","rtracklayer","clusterProfiler","DOSE", 
                              "ggnomics", "gggenes", "ggbio", "GViz", "igvR", "ggseqlogo", "enrichR",
                              "genefilter", "geneplotter", "RegioneR", "RegioneReloaded", "gprofiler2", "InteractionSet") 

packages_github <- c("amitjavilaventura/plotmics", "PhanstielLab/bedtoolsr", "poisonalien/trackplot", "ruthkr/rnafolding", "dzhang32/ggtranscript",
                     "amitjavilaventura/ggmitji", "teunbrand/ggh4x", "thomasp85/ggfx", "kylec/SeqTools", "lianos/seqtools","thackl/gggenomes", "GreenleafLab/ArchR")

packages_plots           <- c("UpSetR", "ggforce", "ggpubr", "RColorBrewer", "scales", "cowplot", "patchwork", "ggbeeswarm", "pheatmap", "ComplexHeatmap",
                              "corrplot", "enrichplot", "ggdendro", "ggExtra",  "ggvenn", "ggrepel", "ggrastr","ggExtra", "ggsignif" "viridis", "wesanderson",
                              "ggthemes","GGally", "ggforestplot", "ggnewscale", "plotROC","RColorBrewer", "WVPlots", "egg", "ggtree", "ggstance", "ggraph")

install_packages(packages_utilities)
install_packages(packages_compbio_general)
install_packages(packages_annot)
install_packages(packages_compbio)
install_packages(packages_github)
install_packages(packages_plots)