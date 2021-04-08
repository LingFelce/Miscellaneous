#### Phylogenetic tree ####

setwd("/t1-data/user/lfelce/R/")

library(tidyverse)
library(ggraph)
library(tidygraph)
library(igraph)


# ORF3a replacement V202L

metadata <- read.csv("/t1-data/user/lfelce/R/ORF3a_replacement_V202L.csv")

df <- metadata[,c("virusName", "gisaidID", "covGlueLineage", "countryCode", "m49SubRegion")]

df2 <- df[,c("gisaidID", "covGlueLineage")]
colnames(df2) <- c("to", "from")
df2 <- df2[,c("from", "to")]

df3 <- df[,c("gisaidID", "countryCode", "m49SubRegion")]
colnames(df3) <- c("name", "country", "region")

df4 <- as.data.frame(df[,c("covGlueLineage")])
df4 <- df4[!duplicated(df4$`df[, c("covGlueLineage")]`),]
df4 <- as.data.frame(df4)
colnames(df4) <- "name"
df4$country <- "NA"
df4$region <- "NA"

df3 <- rbind(df3, df4)


graph <- graph_from_data_frame(df2, vertices = df3)

set.seed(1)
ggraph(graph, 'circlepack') + 
  geom_edge_link(aes(start_cap = label_rect(node1.name),
                     end_cap = label_rect(node2.name))) +
  geom_node_label(aes(label = name), repel=TRUE, label.size=0.1) +
  geom_node_point(aes(fill=country))


set.seed(1)
ggraph(graph, 'circlepack') + 
  geom_edge_link() + 
  geom_node_point(aes(colour=region)) + 
  geom_node_label(aes(label = ifelse(grepl("B", name), as.character(name), NA_character_)), repel=TRUE, label.size=0.25) +
  coord_fixed() +
  theme(legend.position = "bottom") +
  ggtitle("ORF3a replacement V202L")
  



 




