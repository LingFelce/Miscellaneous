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

ggplot(df.expanded, aes(x = Time_mins, y = protein, fill = protein)) +
  geom_density_ridges() +
  theme_ridges() 





