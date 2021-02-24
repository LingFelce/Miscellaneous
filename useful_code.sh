# formatting table for ggplot2 eg for density plot 
# http://www.sthda.com/english/wiki/ggplot2-density-plot-quick-start-guide-r-software-and-data-visualization
# get your data frame into a format where your x axis values are in rows and your separate groups (different lines on plot) are columns

library(ggplot2)
library(reshape2)

cols <- colnames(df)
rows <- rownames(df)

df2 <- melt(data = df,
       id.vars = rows
       measure.vars = cols
       variable.name = "groups"
       value.name = "counts")
       
ggplot(df2, aes(x=counts)) + geom_density() + facet_wrap(groups)
ggplot(df2, aes(x=counts)) + geom_density(aes=groups)
