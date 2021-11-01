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

# downloading .fastq files only from Wellcome Trust sequencing ftp servers
wget -Nc -r -A .fastq.gz URL
# -Nc pick up from where you left off with original time stamp, -r recursive, -A file extension

# search for "string" in particular file type .extension in current folder .
# use to search for particular line of code in all .R files
find . -type f -name '*.extension' | xargs grep "string"

# if a normal Linux process is taking too long or has frozen (eg opening Libre Calc) then use@

top

# to see all processes and get process ID, then

kill <PID>

# re-ordering columns of dataframe based on character
test <- data.frame(a = c(1, 2, 3), b = c(4, 5, 6), c = c(7, 8, 9))
cols <- c("b", "a", "c")
test <- test[,cols]
