library(immuneSIM)
v_usage_fpath <- "projet_long/donnees/v_usage.txt"
j_usage_fpath <- "projet_long/donnees/j_usage.txt"
# basic usage of immuneSIM for TCR
# sim_tcr = immuneSIM(number_of_seqs = 200, species = "hs", receptor = "tr", chain= "b")
# plot_report_repertoire(sim_tcr,output_dir = "projet_long/res")

# how to change the frequencies of genes to match that of our data

# list_germline_genes_allele_01_Teff_mus <- list_germline_genes_allele_01
# 
# v_usage = read.csv(v_usage_fpath,sep=" ",header = TRUE)
# list_germline_genes_allele_01_Teff_mus$mm$tr$b$V <- subset(
#   list_germline_genes_allele_01_Teff_mus$mm$tr$b$V,
#   list_germline_genes_allele_01_Teff_mus$mm$tr$b$V$gene %in% row.names(v_usage))
# list_germline_genes_allele_01_Teff_mus$mm$tr$b$V$frequency <- v_usage$Teff
# 
# j_usage = read.csv(j_usage_fpath,sep=" ",header = TRUE)
# list_germline_genes_allele_01_Teff_mus$mm$tr$b$J <- subset(
#   list_germline_genes_allele_01_Teff_mus$mm$tr$b$J,
#   list_germline_genes_allele_01_Teff_mus$mm$tr$b$J$gene %in% row.names(j_usage))
# list_germline_genes_allele_01_Teff_mus$mm$tr$b$J$frequency <- j_usage$Teff

# you just have to replace Teff with amTreg to simulate the Treg instead

list_germline_genes_allele_01_Treg_mus <- list_germline_genes_allele_01

v_usage = read.csv(v_usage_fpath,sep=" ",header = TRUE)
list_germline_genes_allele_01_Treg_mus$mm$tr$b$V <- subset(
  list_germline_genes_allele_01_Treg_mus$mm$tr$b$V,
  list_germline_genes_allele_01_Treg_mus$mm$tr$b$V$gene %in% row.names(v_usage))
list_germline_genes_allele_01_Treg_mus$mm$tr$b$V$frequency <- v_usage$amTreg

j_usage = read.csv(j_usage_fpath,sep=" ",header = TRUE)
list_germline_genes_allele_01_Treg_mus$mm$tr$b$J <- subset(
  list_germline_genes_allele_01_Treg_mus$mm$tr$b$J,
  list_germline_genes_allele_01_Treg_mus$mm$tr$b$J$gene %in% row.names(j_usage))
list_germline_genes_allele_01_Treg_mus$mm$tr$b$J$frequency <- j_usage$amTreg

# then the call to immuneSIM looks like this (we switched to mouse as the model)
# sim_tcr_teff = immuneSIM(number_of_seqs = 230000, 
#                          vdj_list = list_germline_genes_allele_01_Teff_mus,
#                          species = "mm",
#                          receptor = "tr",
#                          chain= "b",
#                          name_repertoire = "mm_teff_sim",
#                          min_cdr3_length = 14-8,
#                          max_cdr3_length = 14+8)
# it takes a long time to generate the bigger repertoire size
# same command for Treg (we will use this population for our tests as it is 
# smaller which means we can obtain the simulated data faster)
sim_tcr_treg = immuneSIM(number_of_seqs = 78000, 
                         vdj_list = list_germline_genes_allele_01_Treg_mus,
                         species = "mm",
                         receptor = "tr",
                         chain= "b",
                         name_repertoire = "mm_treg_sim",
                         min_cdr3_length = 14-8,
                         max_cdr3_length = 14+8)
# the next interesting test would be to play with the noise parameter as it can 
# be useful to benchmark normalization methods

sim_tcr_treg_noisy = immuneSIM(number_of_seqs = 78000, 
                         vdj_list = list_germline_genes_allele_01_Treg_mus,
                         species = "mm",
                         receptor = "tr",
                         chain= "b",
                         name_repertoire = "mm_treg_sim_noisy",
                         vdj_noise = 0.2,
                         min_cdr3_length = 14-8,
                         max_cdr3_length = 14+8)
