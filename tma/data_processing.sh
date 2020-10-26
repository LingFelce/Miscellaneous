# Merging lanes for each sample - 4 lanes per read, 2 reads per sample

# 1st run 17th October

pwd
/ifs/research-groups/botnar/proj033/backup/tma_raw_files/LF_proj04-204282078/FASTQ_Generation_2020-10-17

# files downloaded into subfolders, 2 reads per subfolder for each lane. 
# need to move files out of subfolders into main FASTQ_Generation_2020-10-17 folder

# type command into FASTQ folder (. indicates current folder)
find . -type f -print0 | xargs -0 mv -t .
