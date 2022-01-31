#-----Test-----------------
library(stringr)
library(tidyverse)
library(data.table)
library(factoextra)
library(FactoMineR)
library(umap)

#-----UMAP-----------------
# # UMAP with test data using Seurat (probably not ideal?)
# data <- read.csv("/stopgap/donglab/ling/R/total_R.csv", header=FALSE)
# data <- column_to_rownames(data, var = "V1")
# 
# colnames1 <- data.frame(paste("S1", 1:391, sep="_"))
# colnames(colnames1) <- "name"
# colnames2 <- data.frame(paste("S2", 1:391, sep="_"))
# colnames(colnames2) <- "name"
# colnames3 <- data.frame(paste("S3", 1:391, sep="_"))
# colnames(colnames3) <- "name"
# colnames4 <- data.frame(paste("S4", 1:391, sep="_"))
# colnames(colnames4) <- "name"
# colnames5 <- data.frame(paste("S5", 1:391, sep="_"))
# colnames(colnames5) <- "name"
# 
# colnames <- rbind(colnames1, colnames2, colnames3, colnames4, colnames5)
# colnames(data) <- colnames$name
# data <- data[-1,]
# 
# seurat <- CreateSeuratObject(counts=data, min.cells = 0, min.features=0, assay="RNA")
# counts <- seurat@assays$RNA@counts
# metadata <- seurat@meta.data
# 
# seurat <- NormalizeData(seurat)
# seurat <- FindVariableFeatures(seurat)
# seurat <- ScaleData(seurat)
# seurat <- RunPCA(seurat)
# DimPlot(seurat, reduction="pca")
# seurat <- FindNeighbors(seurat, dims=1:5)
# seurat <- FindClusters(seurat, resolution=0.5)
# seurat <- RunUMAP(seurat, dims=1:5)
# DimPlot(seurat, reduction="umap", group.by="orig.ident")
# DimPlot(seurat, reduction="umap", group.by="seurat_clusters")

# https://cran.r-project.org/web/packages/umap/vignettes/umap.html
data <- read.csv("/stopgap/donglab/ling/R/test/total_python.csv", header=TRUE)
data$Sample <- as.factor(data$Sample)
data.labels <- data[, "Sample"]
data1 <- data[,-1]
data.umap <- umap(data1)

plot.umap <-function(x, labels,main = "UMAP visualization",
         colors=c("grey0", "grey11", "grey23", "grey35", "grey47"),
         pad=0.1, cex=0.6, 
         pch=c(15, 16, 17, 18, 19), 
         add=FALSE, legend.suffix="",
         cex.main=1, cex.legend=0.85) {

  layout = x
  if (is(x, "umap")) {
    layout = x$layout
  }

  xylim = range(layout)
  xylim = xylim + ((xylim[2]-xylim[1])*pad)*c(-0.5, 0.5)
  if (!add) {
    par(mar=c(0.2,0.7,1.2,0.7), ps=10)
    plot(xylim, xylim, type="n", axes=F, frame=F)
    rect(xylim[1], xylim[1], xylim[2], xylim[2], border="#aaaaaa", lwd=0.25)
  }
  points(layout[,1], layout[,2], col=colors[as.integer(labels)],
         cex=cex, pch=pch)
  mtext(side=3, main, cex=cex.main)

  labels.u = unique(labels)
  legend.pos = "topleft"
  legend.text = as.character(labels.u)
  if (add) {
    legend.pos = "bottomleft"
    legend.text = paste(as.character(labels.u), legend.suffix)
  }

  legend(legend.pos, legend=legend.text, inset=0.03,
         col=colors[as.integer(labels.u)],
         bty="n", pch=pch, cex=cex.legend)
}

plot.umap(data.umap, data.labels)

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
             col.ind = data$Sample,
             palette = c("grey0", "grey11", "grey23", "grey35", "grey47"),
             addEllipses = TRUE,
             legend.title = "Samples") +
  scale_shape_manual(values=c(15, 16, 17, 18, 19))
