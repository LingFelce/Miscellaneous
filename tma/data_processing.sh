# Merging lanes for each sample - 4 lanes per read, 2 reads per sample

# 1st run 17th October

pwd
/ifs/research-groups/botnar/proj033/backup/tma_raw_files/LF_proj04-204282078/FASTQ_Generation_2020-10-17

# files downloaded into subfolders, 2 reads per subfolder for each lane. 
# need to move files out of subfolders into main FASTQ_Generation_2020-10-17 folder

# type command into FASTQ folder (. indicates current folder)
find . -type f -print0 | xargs -0 mv -t .

# file name from NextSeq is different from file names generated from WTCHG sequencing
TMA-181-R9_S47_L003_R1_001.fastq.gz
# $1 is first variable in file name, $2 is second variable, $3 is third variable
# $1 unique ID # $2 S_random number # $3 lane number # read number # all end in 001
# $1 and $2 are the unique IDs combined!

# find unique identifier/name for each sample and save in file called ID (should have 51 IDs per lane)
ls -1 *_R1*.gz | awk -F '_' '{print $1"_"$2}' | sort | uniq > ID

# merge files from lane 1 (L001), lane 2 (L002), lane 3 (L003) and lane 4 (L004) into a new folder called merge and save file name after unique ID. 
# do separately for read 1 (_R1) and read 2 (_R2)
for i in `cat ./ID`; do cat $i\_L001_R1_001.fastq.gz  $i\_L002_R1_001.fastq.gz  $i\_L003_R1_001.fastq.gz  $i\_L004_R1_001.fastq.gz > merge_201017/$i\_R1_001.fastq.gz; done
for i in `cat ./ID`; do cat $i\_L001_R2_001.fastq.gz  $i\_L002_R2_001.fastq.gz  $i\_L003_R2_001.fastq.gz  $i\_L004_R2_001.fastq.gz > merge_201017/$i\_R2_001.fastq.gz; done

# repeat for 3rd run 22th October (ran 1st pool again)
for i in `cat ./ID`; do cat $i\_L001_R1_001.fastq.gz  $i\_L002_R1_001.fastq.gz  $i\_L003_R1_001.fastq.gz  $i\_L004_R1_001.fastq.gz > merge_201022/$i\_R1_001.fastq.gz; done
for i in `cat ./ID`; do cat $i\_L001_R2_001.fastq.gz  $i\_L002_R2_001.fastq.gz  $i\_L003_R2_001.fastq.gz  $i\_L004_R2_001.fastq.gz > merge_201022/$i\_R2_001.fastq.gz; done

# repeat for 2nd run 20th October (2nd pool only has 47 samples)
# for some reason find command not working any more, keeps saying missing file operand?

