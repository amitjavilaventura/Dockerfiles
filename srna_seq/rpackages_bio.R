
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
pakages_compbio         <- c("fastqcr", 'GenomicRanges', 'plyranges', 'GenomicFeatures', "Rsamtools", "megadepth",
                             "ChIPpeakAnno", "enrichR", "clusterProfiler",
                             "DOSE", "gprofiler2")
packages_de_stuff       <- c('DESeq2', 'pcaExplorer','apeglm', 'IHW')
packages_annot          <- c('org.Mm.eg.db', 'org.Hs.eg.db', 
                             'TxDb.Mmusculus.UCSC.mm9.knownGene', 'TxDb.Mmusculus.UCSC.mm10.knownGene', 
                             'TxDb.Hsapiens.UCSC.hg19.knownGene', 'TxDb.Hsapiens.UCSC.hg18.knownGene')

packages_gh <- c("amitjavilaventura/plotmics", "PhanstielLab/bedtoolsr")

# Install packages from bioconductor
install_packages(packages_de_stuff)
install_packages(pakages_compbio)
install_packages(packages_annot)
install_packages(packages_gh)

# Install megadepth
megadepth::install_megadepth()
