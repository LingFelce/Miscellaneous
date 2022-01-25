library(ggplot2)
library(ggridges)

#* NP1sIMP3hChroms ----
# 3h NP1 immunoproteasome - NP, P6L, Q7K
wt <- read.csv("/stopgap/donglab/ling/R/dannielle/NP1sIMP3hChroms/WT.csv")
p6l <- read.csv("/stopgap/donglab/ling/R/dannielle/NP1sIMP3hChroms/P6L.csv")
q7k <- read.csv("/stopgap/donglab/ling/R/dannielle/NP1sIMP3hChroms/Q7K.csv")
# p20l <- read.csv("/stopgap/donglab/ling/R/dannielle/NP1sIMP3hChroms/P20L.csv")
# d22g <- read.csv("/stopgap/donglab/ling/R/dannielle/NP1sIMP3hChroms/D22G.csv")

wt$protein <- "NP"
p6l$protein <- "P6L"
q7k$protein <- "Q7K"
# p20l$protein <- "P20L"
# d22g$protein <- "D22G"


df <- rbind(wt, p6l, q7k)
df <- df[df$Time_mins >=14 & df$Time_mins <=16,]


# df$factor <- ifelse(df$Height_mins == 0, 1, df$Height_mins)
# df.expanded <- df[rep(row.names(df), df$factor), 1:5]

# ggplot(df.expanded, aes(x = Time_mins, y = protein, fill = protein)) +
#   geom_density_ridges() +
#   theme_classic() 

my_colours <- c("P6L" = "#00B050",
                "Q7K" = "#EC782A",
                "NP" = "black")

order <- c("Q7K", "P6L", "NP")

# df.expanded <- df.expanded %>%
#   mutate(protein =  factor(protein, levels = order)) %>%
#   arrange(protein)

df <- df %>%
  mutate(protein =  factor(protein, levels = order)) %>%
  arrange(protein)

pdf("/stopgap/donglab/ling/R/dannielle/NP1sIMP3hChroms/NP1_imp_3h_chrom.pdf")
ggplot(df, aes(x = Time_mins, y = Height_mins, fill = protein)) + 
  geom_line(aes(color = protein), lwd=1.5) +
  scale_color_manual(values = my_colours) +
  scale_y_continuous(expand = expansion(mult = c(0, .2))) +
  facet_grid(protein~., switch = "y") +
  xlim(14, 16) +
  theme_ridges() 
dev.off()

#* NP1sCP3hChroms ----
# 3h NP1 constitutive proteasome - NP, P6L, Q7K

np <- read.csv("/stopgap/donglab/ling/R/dannielle/NP1sCP3hChroms/NP.csv")
p6l <- read.csv("/stopgap/donglab/ling/R/dannielle/NP1sCP3hChroms/P6L.csv")
q7k <- read.csv("/stopgap/donglab/ling/R/dannielle/NP1sCP3hChroms/Q7K.csv")

np$protein <- "NP"
p6l$protein <- "P6L"
q7k$protein <- "Q7K"

df <- rbind(np, p6l, q7k)
df <- df[df$Time_mins >=14 & df$Time_mins <=16,]

my_colours <- c("P6L" = "#00B050",
                "Q7K" = "#EC782A",
                "NP" = "black")

order <- c("Q7K", "P6L", "NP")

df <- df %>%
  mutate(protein =  factor(protein, levels = order)) %>%
  arrange(protein)

pdf("/stopgap/donglab/ling/R/dannielle/NP1sCP3hChroms/NP1_cp_3h_chrom.pdf")
ggplot(df, aes(x = Time_mins, y = Height_mins, fill = protein)) + 
  geom_line(aes(color = protein), lwd=1.5) +
  scale_color_manual(values = my_colours) +
  scale_y_continuous(expand = expansion(mult = c(0, .2))) +
  facet_grid(protein~., switch = "y") +
  xlim(14, 16) +
  theme_ridges() 
dev.off()

#* NP16IMPChroms ----
# 3h NP16 immuno-proteasome - NP, D103N, D103Y

np <- read.csv("/stopgap/donglab/ling/R/dannielle/NP1sCP3hChroms/NP.csv")
p6l <- read.csv("/stopgap/donglab/ling/R/dannielle/NP1sCP3hChroms/P6L.csv")
q7k <- read.csv("/stopgap/donglab/ling/R/dannielle/NP1sCP3hChroms/Q7K.csv")

np$protein <- "NP"
p6l$protein <- "P6L"
q7k$protein <- "Q7K"

df <- rbind(np, p6l, q7k)
df <- df[df$Time_mins >=14 & df$Time_mins <=16,]

my_colours <- c("P6L" = "#00B050",
                "Q7K" = "#EC782A",
                "NP" = "black")

order <- c("Q7K", "P6L", "NP")

df <- df %>%
  mutate(protein =  factor(protein, levels = order)) %>%
  arrange(protein)

pdf("/stopgap/donglab/ling/R/dannielle/NP1sCP3hChroms/NP1_cp_3h_chrom.pdf")
ggplot(df, aes(x = Time_mins, y = Height_mins, fill = protein)) + 
  geom_line(aes(color = protein), lwd=1.5) +
  scale_color_manual(values = my_colours) +
  scale_y_continuous(expand = expansion(mult = c(0, .2))) +
  facet_grid(protein~., switch = "y") +
  xlim(14, 16) +
  theme_ridges() 
dev.off()

#* NP16CPChroms ----
# 3h NP16 immuno-proteasome - NP, D103N, D103Y

np <- read.csv("/stopgap/donglab/ling/R/dannielle/NP16CPChroms/NP.csv")
d103n <- read.csv("/stopgap/donglab/ling/R/dannielle/NP16CPChroms/D103N.csv")
d103y <- read.csv("/stopgap/donglab/ling/R/dannielle/NP16CPChroms/D103Y.csv")

np$protein <- "NP"
d103n$protein <- "D103N"
d103y$protein <- "D103Y"

df <- rbind(np, d103n, d103y)
df <- df[df$Time_mins >=16 & df$Time_mins <=24,]

my_colours <- c("D103N" = "#931100",
                "D103Y" = "#011892",
                "NP" = "black")

order <- c("D103Y", "D103N", "NP")

df <- df %>%
  mutate(protein =  factor(protein, levels = order)) %>%
  arrange(protein)

pdf("/stopgap/donglab/ling/R/dannielle/NP16CPChroms/NP16_cp_3h_chrom.pdf")
ggplot(df, aes(x = Time_mins, y = Height_mins, fill = protein)) + 
  geom_line(aes(color = protein), lwd=1.5) +
  scale_color_manual(values = my_colours) +
  scale_y_continuous(expand = expansion(mult = c(0, .2))) +
  facet_grid(protein~., switch = "y") +
  xlim(16, 24) +
  theme_ridges() 
dev.off()
