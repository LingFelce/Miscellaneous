library(ggplot2)
library(ggridges)

wt <- read.csv("/stopgap/donglab/ling/R/dannielle/WT.csv")
p6l <- read.csv("/stopgap/donglab/ling/R/dannielle/P6L.csv")
q7k <- read.csv("/stopgap/donglab/ling/R/dannielle/Q7K.csv")
p20l <- read.csv("/stopgap/donglab/ling/R/dannielle/P20L.csv")
d22g <- read.csv("/stopgap/donglab/ling/R/dannielle/D22G.csv")

wt$protein <- "WT NP"
p6l$protein <- "P6L"
q7k$protein <- "Q7K"
p20l$protein <- "P20L"
d22g$protein <- "D22G"


df <- rbind(wt, p6l, q7k, p20l, d22g)
df <- df[df$Time_mins >=14 & df$Time_mins <=16,]


df$factor <- ifelse(df$Height_mins == 0, 1, df$Height_mins)
df.expanded <- df[rep(row.names(df), df$factor), 1:5]

# ggplot(df.expanded, aes(x = Time_mins, y = protein, fill = protein)) +
#   geom_density_ridges() +
#   theme_classic() 

my_colours <- c("P6L" = "#00B050",
                "P20L" = "#69269B",
                "D22G" = "#4371C4",
                "Q7K" = "#EC782A",
                "WT NP" = "black")

order <- c("D22G", "P20L", "Q7K", "P6L", "WT NP")

df.expanded <- df.expanded %>%
  mutate(protein =  factor(protein, levels = order)) %>%
  arrange(protein)

pdf("/stopgap/donglab/ling/R/dannielle/plot.pdf")
ggplot(df.expanded, aes(x = Time_mins, fill = protein)) +
  geom_density() +
  scale_fill_manual(values= my_colours) +
  scale_y_continuous(expand = expansion(mult = c(0, .2))) +
  facet_grid(protein~., switch = "y") +
  xlim(14, 16) +
  theme_ridges() +
  scale_color_identity()
dev.off()


