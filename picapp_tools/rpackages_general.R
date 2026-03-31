# define packages to install from cran or bioconductor
packages_utilities      <- c("devtools", "here", "reticulate", "openxlsx", "stringi", "workflowr")
packages_tidy_stuff     <- c("plyr", "DT", "data.table", "tidyverse", "openxlsx", "magrittr", "reshape2", "janitor")
packages_plots          <- c("ggforce", "ggpubr", "RColorBrewer", "scales", "circlize", "cowplot", "ggdendro", "ggExtra",
                             "patchwork", "ggthemes", "pheatmap", "ComplexHeatmap", "ggvenn", "ggrepel", "ggrastr",
                             "ggbeeswarm", "ggbio", "thomasp85/ggfx", "ggsignif", "UpSetR", "viridis", "wesanderson", "amitjavilaventura/plotmics", 
                             "amitjavilaventura/ggmitji")

# Install packages from bioconductor
BiocManager::install(packages_utilities)
BiocManager::install(packages_tidy_stuff)
BiocManager::install(packages_plots)