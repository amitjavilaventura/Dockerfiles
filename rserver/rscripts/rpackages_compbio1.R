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
packages_compbio_general <- c("Biostrings","biomaRt", "biomartr",'GenomicRanges','GenomicFeatures','plyranges', "SummarizedExperiment")

packages_compbio_deep    <- c("megadepth", "Rsamtools", "Rsubread","ChIPseeker", "ChIPpeakAnno","bamsignals")

packages_compbio_de     <- c("tximport", 'DESeq2', 'pcaExplorer','apeglm', 'IHW', "edgeR", "limma", "DiffBind")

packages_compbio_seqs   <- c("memmes", "marge", "nucleR", "nuCpos", "msa", "seqinr", "seqTools")

packages_compbio_singlecell <- c("Seurat", "GreenleafLab/ArchR")

# Install packages
install_packages(c(packages_compbio_general, packages_compbio_deep, packages_compbio_de, packages_combio_seqs, packages_compbio_singlecell))

# Install megadepth
megadepth::install_megadepth()

