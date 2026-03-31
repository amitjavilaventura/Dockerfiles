# define packages to install from cran or bioconductor
packages_nucleosome <- c("nucleR","nucleosome-dynamics/NucDyn")

# Install packages from bioconductor
BiocManager::install(packages_nucleosome)
