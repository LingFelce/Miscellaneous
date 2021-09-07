#-----Test-----------------
library(stringr)
library(tidyverse)
library(data.table)
library(Seurat)
library(factoextra)
library(FactoMineR)

#-----UMAP-----------------
# UMAP with test data using Seurat (probably not ideal?)
data <- read.csv("/stopgap/donglab/ling/R/total_R.csv", header=FALSE)
data <- column_to_rownames(data, var = "V1")

colnames1 <- data.frame(paste("S1", 1:391, sep="_"))
colnames(colnames1) <- "name"
colnames2 <- data.frame(paste("S2", 1:391, sep="_"))
colnames(colnames2) <- "name"
colnames3 <- data.frame(paste("S3", 1:391, sep="_"))
colnames(colnames3) <- "name"
colnames4 <- data.frame(paste("S4", 1:391, sep="_"))
colnames(colnames4) <- "name"
colnames5 <- data.frame(paste("S5", 1:391, sep="_"))
colnames(colnames5) <- "name"

colnames <- rbind(colnames1, colnames2, colnames3, colnames4, colnames5)
colnames(data) <- colnames$name
data <- data[-1,]

seurat <- CreateSeuratObject(counts=data, min.cells = 0, min.features=0, assay="RNA")
counts <- seurat@assays$RNA@counts
metadata <- seurat@meta.data

seurat <- NormalizeData(seurat)
seurat <- FindVariableFeatures(seurat)
seurat <- ScaleData(seurat)
seurat <- RunPCA(seurat)
DimPlot(seurat, reduction="pca")
seurat <- FindNeighbors(seurat, dims=1:5)
seurat <- FindClusters(seurat, resolution=0.5)
seurat <- RunUMAP(seurat, dims=1:5)
DimPlot(seurat, reduction="umap", group.by="orig.ident")
DimPlot(seurat, reduction="umap", group.by="seurat_clusters")

#-----PCA-----------------
# http://www.sthda.com/english/articles/31-principal-component-methods-in-r-practical-guide/112-pca-principal-component-analysis-essentials/

# tab:blue : #1f77b4
# tab:orange : #ff7f0e
# tab:green : #2ca02c
# tab:red : #d62728
# tab:purple : #9467bd

data <- read.csv("/stopgap/donglab/ling/R/test/total_python.csv")
data.pca <- PCA(data[,-1], graph=FALSE)
print(data.pca)
fviz_pca_ind(data.pca,
             geom.ind = "point",
             pointshape = 20,
             col.ind = data$Sample,
             palette = c("#1f77b4", "#ff7f0e", "#2ca02c", "#d62728", "#9467bd"),
             addEllipses = TRUE,
             legend.title = "Samples")
