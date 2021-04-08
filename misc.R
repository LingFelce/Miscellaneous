setwd("/t1-data/user/lfelce/R/")

abatch <- read.table("/t1-data/user/lfelce/tmp/GSE61397_non-normalized_data.txt", 
                     header = TRUE, sep = "", fileEncoding="utf-16le", fill=TRUE)


mpe <- read.table("/t1-data/user/lfelce/MiXCR/CD8_ORF3a-28_TCR_Clones_output/test2.txt", header=TRUE, sep="", fill=TRUE)
mpe_tra <- mpe[mpe$targetSequences=="TRAV8-4",]
mpe_trb <- mpe[mpe$targetSequences=="TRBV10-3",]
mpe_seq <- rbind(mpe_tra, mpe_trb)
write.csv(mpe_seq, "/t1-data/user/lfelce/mpe_sequences.csv")

mpe <- read.table("/t1-data/user/lfelce/MiXCR/CD8_ORF3a-28_TCR_Clones_output/test3.txt", header=TRUE, sep="", fill=TRUE)
mpe_tra <- mpe[mpe$targetSequences=="TRAV8-4",]
mpe_trb <- mpe[mpe$targetSequences=="TRBV10-3",]

mpe <- read.table("/t1-data/user/lfelce/MiXCR/CD8_ORF3a-28_TCR_Clones_output/MRN345_Cl07_full_clones.txt", header=TRUE, sep="", fill=TRUE)
mpe_edit <- mpe[1:2,]
write.csv(mpe_edit, "/t1-data/user/lfelce/mpe_sequences_2.csv")


np16_clones <- read.csv("/t1-data/user/lfelce/TCR_analysis/tcr_clones_results/cd8_np16_tcr_clones.csv", header=TRUE)
np16_clones_b <- np16_clones[,c("CloneName", "CDR3_aa.y", "beta")]
colnames(np16_clones_b) <- c("name", "CDR3b", "TRB")
np16_clones_b <- unique(np16_clones_b)

library(ggraph)
library(igraph)

edge <- as.data.frame(flare$edges)
vertices <-  as.data.frame(flare$vertices)

graph <- graph_from_data_frame(flare$edges, vertices = flare$vertices)

set.seed(1)
ggraph(graph, 'circlepack') + 
  geom_edge_link(aes(start_cap = label_rect(node1.name),
                     end_cap = label_rect(node2.name)), 
                 arrow = arrow(length = unit(4, 'mm'))) + 
  geom_node_text(aes(label = name), repel=TRUE) +
  geom_node_label(aes(label = name), repel=TRUE, label.size=0.1)
 
