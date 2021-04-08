#### Network graphs ####

library(tidyverse)
library(ggraph)
library(tidygraph)
library(igraph)


# ORF3a replacement V202L

metadata <- read.csv("/t1-data/user/lfelce/R/SARS-CoV-2_mutations/ORF3a_replacement_V202L.csv")

df <- metadata[,c("virusName", "gisaidID", "covGlueLineage", "location", "countryCode", "m49SubRegion")]
df$location <- gsub(x = df$location, pattern = " / ", replacement = "/")
split <- str_split_fixed(df$location, "/", 3)
df <- cbind(df, split)

df2 <- df[,c("gisaidID", "covGlueLineage")]
colnames(df2) <- c("to", "from")
df2 <- df2[,c("from", "to")]

df3 <- df[,c("gisaidID", "countryCode", "1")]
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
  geom_edge_link() + 
  geom_node_point(aes(colour=region)) + 
  geom_node_label(aes(label = ifelse(grepl("B", name), as.character(name), NA_character_)), repel=TRUE, label.size=0.1, size=6) +
  coord_fixed() +
  theme(legend.position = "bottom") +
  ggtitle("ORF3a replacement V202L")



