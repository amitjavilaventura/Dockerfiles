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
packages_plots           <- c("UpSetR", "ggforce", "ggpubr", "RColorBrewer", "scales", "cowplot", "patchwork", "ggbeeswarm", "pheatmap", "ComplexHeatmap",
                              "corrplot", "enrichplot", "ggdendro", "ggExtra",  "ggvenn", "ggrepel", "ggrastr","ggExtra", "ggsignif" "viridis", "wesanderson",
                              "ggthemes","GGally", "ggforestplot", "ggnewscale", "plotROC","RColorBrewer", "WVPlots", "egg", "ggtree", "ggstance", "ggraph")

install_packages(packages_plots)
