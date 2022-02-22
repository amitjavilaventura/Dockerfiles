
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
packages_utilities      <- c("devtools", "here", "reticulate", "openxlsx", "stringi", "workflowr")
packages_tidy_stuff     <- c("plyr", "DT", "data.table", "tidyverse", "openxlsx", "magrittr", "reshape2", "janitor")
packages_plots          <- c("ggforce", "ggpubr", "RColorBrewer", "scales", "circlize", "cowplot", "ggdendro", "ggExtra",
                             "patchwork", "ggthemes", "pheatmap", "ComplexHeatmap", "ggvenn", "ggrepel", "ggrastr",
                             "ggbeeswarm", "ggbio", "thomasp85/ggfx", "ggsignif", "UpSetR", "viridis", "wesanderson")

# Install packages from bioconductor
install_packages(packages_utilities)
install_packages(packages_tidy_stuff)
install_packages(packages_plots)