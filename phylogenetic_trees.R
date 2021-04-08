#### Phylogenetic tree ####

setwd("/t1-data/user/lfelce/R/")

library(tidyverse)
library(ggraph)
library(tidygraph)
library(igraph)


# ORF3a replacement V202L

metadata <- read.csv("/t1-data/user/lfelce/R/ORF3a_replacement_V202L.csv")

df <- metadata[,c("virusName", "gisaidID", "covGlueLineage", "m49SubRegion")]

table <- as.data.frame(table(df$virusName, df$covGlueLineage))

#  Get distinct sources names
sources <- df %>%
  distinct(covGlueLineage) %>%
  rename(label = covGlueLineage)

# Get distinct destination names
destinations <- df %>%
  distinct(virusName) %>%
  rename(label = virusName)

# Join the two data to create node

# Add unique ID for each country
nodes <- full_join(sources, destinations, by = "label") 
nodes <- nodes %>%
  mutate(id = 1:nrow(nodes)) %>%
  select(id, everything())
head(nodes, 3)


# # Rename the n.call column to weight
# phone.call <- phone.call %>%
#   rename(weight = n.call)

# (a) Join nodes id for source column
edges <- df %>% 
  left_join(nodes, by = c("covGlueLineage" = "label")) %>% 
  rename(from = id)

# (b) Join nodes id for destination column
edges <- edges %>% 
  left_join(nodes, by = c("virusName" = "label")) %>% 
  rename(to = id)

# (c) Select/keep only the columns from and to
edges <- select(edges, from, to)
head(edges, 3)

net.igraph <- graph_from_data_frame(
  d = edges, vertices = nodes, 
  directed = TRUE
)

set.seed(123)
plot(net.igraph, edge.arrow.size = 0.2,
     layout = layout_with_graphopt)


net.tidy <- tbl_graph(
  nodes = nodes, edges = edges, directed = TRUE
)

ggraph(net.tidy, layout = "graphopt") + 
  geom_node_point() +
  geom_edge_link() + 
  scale_edge_width(range = c(0.2, 2)) +
  geom_node_text(aes(label = label), repel = TRUE) +
  labs(edge_width = "df") +
  theme_graph()









groups <- as.data.frame(df[,3])

# to perform different types of hierarchical clustering
# package functions used: daisy(), diana(), clusplot()
dist <- daisy(groups, metric = c("gower"))

cl <- hclust(dist(df3, method="euclidean"), method="complete")

dend <- cl %>% as.dendrogram 

# labels as virus name, colour as country
correct_labels <- cl$labels[cl$order]
correct_labels <- as.data.frame(correct_labels)
country <- str_split_fixed(correct_labels$correct_labels, "/", 4)
correct_labels$country <- country[,2]
labels(dend) <- correct_labels$correct_labels

library(colorspace)

region <- as.factor(df$m49SubRegion)
n_region <- length(unique(region))
cols <- colorspace::rainbow_hcl(n_region)
col_region <- cols[region]
labels_colors(dend) <- col_region[order.dendrogram(dend)]

# correct_labels <- rownames_to_column(correct_labels, "order")
# order <- str_pad(correct_labels$order, 3, side="left",pad = "0")
# correct_labels$order <- order


par(mar = c(1,5,1,5))
dend %>% set("labels_cex",1) %>% color_branches(k=6) %>%
  plot(main = "ORF3a replacement V202L", cex.main=2, horiz=TRUE)
legend("topright", legend = levels(cell_type), fill = cols_2, cex=2)


