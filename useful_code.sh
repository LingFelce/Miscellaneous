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


# move multiple files out of multiple subfolders and into main folder
find . -type f -print0 | xargs -0 mv -t .

# re-ordering columns of dataframe based on character
test <- data.frame(a = c(1, 2, 3), b = c(4, 5, 6), c = c(7, 8, 9))
cols <- c("b", "a", "c")
test <- test[,cols]

# renaming multiple files with common string in file name
for i in s2_GEX-AK3472*; do mv ${i} ${i/#s2_GEX-AK3472/s2_GEX-1}; done
for i in s2_GEX-AK3473*; do mv ${i} ${i/#s2_GEX-AK3473/s2_GEX-2}; done
for i in s2_GEX-AK3474*; do mv ${i} ${i/#s2_GEX-AK3474/s2_GEX-3}; done
for i in s2_GEX-AK3475*; do mv ${i} ${i/#s2_GEX-AK3475/s2_GEX-4}; done

for i in s2_totalseq-AK2436*; do mv ${i} ${i/#s2_totalseq-AK2436/s2_totalseq-1}; done
for i in s2_totalseq-AK8028*; do mv ${i} ${i/#s2_totalseq-AK8028/s2_totalseq-2}; done
for i in s2_totalseq-AK8029*; do mv ${i} ${i/#s2_totalseq-AK8029/s2_totalseq-3}; done
for i in s2_totalseq-AK8030*; do mv ${i} ${i/#s2_totalseq-AK8030/s2_totalseq-4}; done

for i in s2_GEX-1_HN2L5DSX2*; do mv ${i} ${i/#s2_GEX-1_HN2L5DSX2/s2_GEX-1_A}; done
for i in s2_GEX-1_HNT5KDSX2*; do mv ${i} ${i/#s2_GEX-1_HNT5KDSX2/s2_GEX-1_B}; done
for i in s2_GEX-2_HN2L5DSX2*; do mv ${i} ${i/#s2_GEX-2_HN2L5DSX2/s2_GEX-2_A}; done
for i in s2_GEX-2_HNT5KDSX2*; do mv ${i} ${i/#s2_GEX-2_HNT5KDSX2/s2_GEX-2_B}; done
for i in s2_GEX-3_HN2L5DSX2*; do mv ${i} ${i/#s2_GEX-3_HN2L5DSX2/s2_GEX-3_A}; done
for i in s2_GEX-3_HNT5KDSX2*; do mv ${i} ${i/#s2_GEX-3_HNT5KDSX2/s2_GEX-3_B}; done
for i in s2_GEX-4_HN2L5DSX2*; do mv ${i} ${i/#s2_GEX-4_HN2L5DSX2/s2_GEX-4_A}; done
for i in s2_GEX-4_HNT5KDSX2*; do mv ${i} ${i/#s2_GEX-4_HNT5KDSX2/s2_GEX-4_B}; done

for i in s2_totalseq-1_HN2L5DSX2*; do mv ${i} ${i/#s2_totalseq-1_HN2L5DSX2/s2_totalseq-1_A}; done
for i in s2_totalseq-1_HNT5KDSX2*; do mv ${i} ${i/#s2_totalseq-1_HNT5KDSX2/s2_totalseq-1_B}; done
for i in s2_totalseq-2_HN2L5DSX2*; do mv ${i} ${i/#s2_totalseq-2_HN2L5DSX2/s2_totalseq-2_A}; done
for i in s2_totalseq-2_HNT5KDSX2*; do mv ${i} ${i/#s2_totalseq-2_HNT5KDSX2/s2_totalseq-2_B}; done
for i in s2_totalseq-3_HN2L5DSX2*; do mv ${i} ${i/#s2_totalseq-3_HN2L5DSX2/s2_totalseq-3_A}; done
for i in s2_totalseq-3_HNT5KDSX2*; do mv ${i} ${i/#s2_totalseq-3_HNT5KDSX2/s2_totalseq-3_B}; done
for i in s2_totalseq-4_HN2L5DSX2*; do mv ${i} ${i/#s2_totalseq-4_HN2L5DSX2/s2_totalseq-4_A}; done
for i in s2_totalseq-4_HNT5KDSX2*; do mv ${i} ${i/#s2_totalseq-4_HNT5KDSX2/s2_totalseq-4_B}; done

# check which files are missing after running STAR
ls -l ./*.bam > /stopgap/donglab/ling/bam.txt
ls -l ./*.sh > /stopgap/donglab/ling/files.txt
# print list of file names for .bam and .sh (script) files
# check in R which ones are missing

# soft link file
find /t1-data/user/lfelce/MiXCR/CD4_input -name "*.fastq.gz" | xargs -I v_f ln -s v_f
