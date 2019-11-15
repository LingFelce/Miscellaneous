# sorting genes into separate libraries (Weissman pooled libraries)

library(AnnotationDbi)
library(org.Hs.eg.db)
library(stringr)

master <- read.csv("weissman_genes.csv", header=FALSE)

names(master)[1] <- "gene"
names(master)[2] <- "library"

library_list <- c("h1","h2","h3","h4","h5","h6","h7")

table(as.vector(master$library))

h1_genes <- master[is.element(master$library, library_list[1]),]
h2_genes <- master[is.element(master$library, library_list[2]),]
h3_genes <- master[is.element(master$library, library_list[3]),]
h4_genes <- master[is.element(master$library, library_list[4]),]
h5_genes <- master[is.element(master$library, library_list[5]),]
h6_genes <- master[is.element(master$library, library_list[6]),]
h7_genes <- master[is.element(master$library, library_list[7]),]

write.csv(h1_genes, "h1_genes.csv")
write.csv(h2_genes, "h2_genes.csv")
write.csv(h3_genes, "h3_genes.csv")
write.csv(h4_genes, "h4_genes.csv")
write.csv(h5_genes, "h5_genes.csv")
write.csv(h6_genes, "h6_genes.csv")
write.csv(h7_genes, "h7_genes.csv")

# optional - annotate gene list with full gene names
data <- as.vector(master$gene)
annots <-  AnnotationDbi::select(org.Hs.eg.db, keys=data,
                                 columns=c("GENENAME"), keytype = "SYMBOL")

annotated_list <- merge(master, annots, by.x="gene", by.y="SYMBOL")

# check to see if E3 ubiquitin ligases are on Weissman gene lists
e3_ligases <- read.csv("e3_ub_ligases.csv", header=FALSE)
names(e3_ligases)[1] <- "gene"

e3_weissman <- master[is.element(master$gene, e3_ligases$gene),]

table(as.vector(e3_weissman$library))


# check to see if SLC family are on Weissman gene lists
slc <- read.csv("slc_list.csv", header=TRUE)

slc_weissman <- master[is.element(master$gene, slc$gene),]

table(as.vector(slc_weissman$library))
