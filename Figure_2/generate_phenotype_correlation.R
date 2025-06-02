#! /usr/bin/R

# load required libraries

library(microeco)
library(file2meco)

# set the paths to abundance, sample information and phenotypes
inputfile_path = "/path/to/merged_kraken2.mpa"
metafile_path = "path/to/sample.info.txt"
phenotype_path = "/path/to/phenotype.csv"

# build the object
test <- mpa2meco(feature_table = inputfile_path,sample_table = metafile_path)

# normalize abundances for each samples
test$cal_abund()

# fetch species/genus/phylum with differential abundances across the preset group factor at different taxonomy levels using lefse algorithms
groupFactor <- "group"
taxaLevel <- "Species" # other taxonomy levels: Genus, Phylum
test.lefse <- trans_diff$new(test, method = "lefse", group  = groupFactor, taxa_level = taxaLevel)

# add phenotype data and investigate relationships between selected species/genus and phenotypic features.
pheno_data <- read.csv(phenotype_path, header = TRUE, row.names = 1)

test_env <- trans_env$new(dataset = test, add_data = pheno_data)

test_env$cal_cor(by_group = groupFactor, use_data = "other", p_adjust_method = "fdr", other_taxa = test$res_diff$Taxa, method = "speaman")


# generate correlation heatmap
test_env$plot_cor()

