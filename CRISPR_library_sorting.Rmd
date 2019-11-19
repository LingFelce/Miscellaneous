---
title: "CRISPR libraries"
author: "Ling"
date: "15/11/2019"
output: html_document
---
## CRISPR libraries

```{r}
# load required packages

# library(AnnotationDbi)
# library(org.Hs.eg.db)
library(stringr)
library(dplyr)

```

# Weissman pooled libraries - sorting genes into separate files based on library designation 

```{r weissman}

master <- read.csv("weissman_genes.csv", header=FALSE)

names(master)[1] <- "gene"
names(master)[2] <- "library"

library_list <- c("h1","h2","h3","h4","h5","h6","h7")

table(as.vector(master$library))

# Ctrl + Shift + C to comment block of code

# h1_genes <- master[is.element(master$library, library_list[1]),]
# h2_genes <- master[is.element(master$library, library_list[2]),]
# h3_genes <- master[is.element(master$library, library_list[3]),]
# h4_genes <- master[is.element(master$library, library_list[4]),]
# h5_genes <- master[is.element(master$library, library_list[5]),]
# h6_genes <- master[is.element(master$library, library_list[6]),]
# h7_genes <- master[is.element(master$library, library_list[7]),]
#
# write.csv(h1_genes, "h1_genes.csv")
# write.csv(h2_genes, "h2_genes.csv")
# write.csv(h3_genes, "h3_genes.csv")
# write.csv(h4_genes, "h4_genes.csv")
# write.csv(h5_genes, "h5_genes.csv")
# write.csv(h6_genes, "h6_genes.csv")
# write.csv(h7_genes, "h7_genes.csv")

## I WROTE A LOOP IN R!!!

## Avoid repetitive code above using a for loop - looked at these links:
# https://r4ds.had.co.nz/iteration.html#introduction-14
# https://www.earthdatascience.org/courses/earth-analytics/automate-science-workflows/create-for-loops-r/

# create test file with first 100 rows from Weissman master file
test <- head(master, n=100)

# create output - empty vector with:
# - type of vector: logical, integer, double or character
# - length of vector (number of columns)
output <- vector("character", ncol(master))

# i in vector/list/data frame determines what to loop over;
# each run of for loop will assign i to different value from vector
# output[[i]] - need double brackets to select single element
# for lists [] returns list of selected elements
# main body of code run repeatedly with different value for i each time
# create a .csv file - use paste0() to paste together a file name

for (i in library_list) {
  output[[i]] <- test[is.element(test$library, i),]
  write.csv(output[i], file=paste0("test/", i, ".csv"))
}

# for actual master file:
# for (i in library_list){
#   output[[i]] <- master[is.element(master$library, i),]
#   write.csv(output[i], file=paste0(i, "_genes.csv"))
# }


# optional - annotate gene list with full gene names
# data <- as.vector(master$gene)
# annots <-  AnnotationDbi::select(org.Hs.eg.db, keys=data,
                                 #columns=c("GENENAME"), keytype = "SYMBOL")

# annotated_list <- merge(master, annots, by.x="gene", by.y="SYMBOL")

## Nick's version
# The basic for loop you want, to replace your repeated code, is:

# define the length of the loop by the length of the library list
# curly bracket opens the loop
#for (i in 1:length(library_list)) {

# use i to define which member of the library list you want (this changes each loop)  
# gene_set <- master[is.element(master$library, library_list[i]),]
  
# define variables needed for the output filename
# this isn’t really necessary (you could put this directly in the write.csv command, but I think this way is easier to read)
# library_filename <- paste0(library_list[i], "_genes.csv")

# write.csv(gene_set, file = library_filename)

# curly bracket closes the loop
# }

```

# Bassik library - pulling out gene and library name from gRNA name

```{r bassik}

bassik_full_names_list <- read.csv("bassik_full_names.csv", header=FALSE)

bassik_full_list <- as.character(bassik_full_names_list$V1)

# trying to work out how to get gene name and library name from string ...
# gives table with 2 columns; column 1 is gene name, column 2 is library type (have to transpose)
# test <- c("ENSG00000158402_CDC25C_DTKP_19779.5", "ENSG00000273439_ZNF8_GEEX_169811.1")
# test_results <- t(sapply(strsplit(test, "_"), "[", 2:3))

bassik_list <- as.data.frame(t(sapply(strsplit(bassik_full_list, "_"), "[", 2:3)))
names(bassik_list)[1] <- "gene"
names(bassik_list)[2] <- "library"

# original bassik table - each row corresponded to unique guide sequence, not gene. 
# now that have pulled out gene and library info, will have multiple rows with same gene name.
# need to collapse/filter so that 1 row = 1 gene

bassik_list <- unique(bassik_list)

# remove non-genes (none and safe)

bassik <- bassik_list[!(bassik_list$gene == "none"| bassik_list$gene == "safe"),]

# generate table object so can copy and paste into Word

table <- t(as.data.frame(table(as.vector(bassik$library))))
table

# export gene list

write.csv (bassik, "bassik_sublibraries.csv")

```
# Brunello kinome library

```{r brunello}

brunello_gene_list <- read.csv("brunello_gene_list.csv", header=FALSE)

# several guides per gene - collapse list to see how many genes in kinome library
brunello <- unique(brunello_gene_list)

brunello <- as.vector(brunello$V1)

```

# Sabatini metabolic genes library

```{r sabatini}

sabatini_gene_list <- read.csv("sabatini_gene_list.csv", header=TRUE)

sabatini <- as.vector(sabatini_gene_list$Gene.Symbol)


```


# Sanger druggable genes panel
From Sigma-Aldrich/Merck:

We have both an "expanded discovery" panel, and the more focused "core essential" panel for the human druggable genome. The expanded discovery panel targets 8,564 genes, and there's 17,132 clones in the set; the core essential panel targets 967 genes, and there's 1,934 clones in the set.

```{r sanger}

sanger_master <- read.csv("sanger_panel.csv", header=FALSE)

names(sanger_master)[1] <- "gene"

sanger <- as.vector(sanger_master$gene)

```

# E3 ubiquitin ligases

```{r e3}

e3_ligases <- read.csv("e3_ub_ligases.csv", header=FALSE)
names(e3_ligases)[1] <- "gene"

# check to see if E3 ubiquitin ligases are on Weissman gene lists

e3_weissman <- master[is.element(master$gene, e3_ligases$gene),]

table(as.vector(e3_weissman$library))

# check to see if E3 ubiquitin ligases are on Bassik gene lists

e3_bassik <- bassik[is.element(bassik$gene, e3_ligases$gene),]

table(as.vector(e3_bassik$library))

# check to see if E3 ubiquitin ligases are on Brunello gene list

e3_brunello <- brunello[is.element(brunello, e3_ligases$gene)]

print("Number of E3 ligase genes in Brunello library") 
length(e3_brunello)

# check to see if E3 ubiquitin ligases are on Sabatini gene list

e3_sabatini <- sabatini[is.element(sabatini, e3_ligases$gene)]

print("Number of E3 ligase genes in Sabatini library") 
length(e3_sabatini)

# check to see if E3 ligase genes on Sanger list

e3_sanger <- sanger[is.element(sanger, e3_ligases$gene)]

print("Number of E3 ligase genes in Sanger library") 
length(e3_sanger)



```

# SLC family

``` {r slc}

slc <- read.csv("slc_list.csv", header=TRUE)

# check to see if SLC family are on Weissman gene lists

slc_weissman <- master[is.element(master$gene, slc$gene),]

table(as.vector(slc_weissman$library))

# check to see if SLC family are on Bassik gene lists

slc_bassik <- bassik[is.element(bassik$gene, slc$gene),]

table(as.vector(slc_bassik$library))

# check to see if E3 ubiquitin ligases are on Brunello gene list

slc_brunello <- brunello[is.element(brunello, slc$gene)]

print("Number of SLc family in Brunello library") 
length(slc_brunello)

# check to see if SLC family are on Sabatini gene list

slc_sabatini <- sabatini[is.element(sabatini, slc$gene)]

print("Number of SLC genes in Sabatini library") 
length(slc_sabatini)

# check to see if SLC genes on Sanger list

slc_sanger <- sanger[is.element(sanger, slc$gene)]

print("Number of SLC genes in Sanger library") 
length(slc_sanger)

```

# Removing E3 ligase genes from Weissman and Bassik libraries

```{r editing}

# df <- filter(df, C != "Foo")

```
