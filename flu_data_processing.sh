# soft link all .fastq.gz files from Peng's folder (lane 1 and lane 2) to my folder
find /t1-data/user/ypeng/P170335/downloaded_files/lane1 -name "*.fastq.gz" | xargs -I v_f ln -s v_f
find /t1-data/user/ypeng/P170335/downloaded_files/lane2 -name "*.fastq.gz" | xargs -I v_f ln -s v_f

# find unique identifier/name for each sample and save in file called ID (should have 192 IDs per lane)
ls -1 *_1*.gz | awk -F '_' '{print $3}' | sort | uniq > ID

# merge files from lane 1 (WTCHG_390445) and lane 2 (WTCHG_392409) into a new folder called merge and save file name after unique ID. 
# do separately for read 1 (_1) and read 2 (_2)
for i in `cat ./ID`; do cat WTCHG_390445_$i\_1.fastq.gz WTCHG_392409_$i\_1.fastq.gz > merge/$i\_1.fastq.gz; done
for i in `cat ./ID`; do cat WTCHG_390445_$i\_2.fastq.gz WTCHG_392409_$i\_2.fastq.gz > merge/$i\_2.fastq.gz; done

# tracer test
module load tracer
Hsap = /databank/igenomes/Homo_sapiens/UCSC/hg38/Sequence/WholeGenomeFasta
tracer assemble -p 8 -s Hsap -q kallisto raw_files/merge/201249_1.fastq.gz raw_files/merge/201249_2.fastq.gz P1_A1_UK001CD8A2_2006 test_output

# found location of tracer.conf
/package/tracer/implementing_build-20170413

# copied tracer.conf into directory being used - maybe have to do for each experiment if paths are different?
# output from running tracer assemble code: Config file not found at ~/.tracerrc. Using default tracer.conf in repo...

# as a back up saved setup.py from git page as separate file in home folder and run - not sure if it'll work!

# TraCeR looks for the configuration file, in descending order of priority, from the following sources:
# The -c option used at run time for any of the TraCeR modes
# The environmental variable TRACER_CONF, which can be set to point to a default location
# The default global location of ~/.tracerrc
# If all else fails, the provided example tracer.conf in the directory is used

# already tried environmental variable and tracer.conf in directory used, can't find ~/.tracerrc

# final option - added -c option (tracer.conf file in same folder as command being run)
tracer assemble -c tracer.conf -p 8 -s Hsap -q kallisto raw_files/merge/201249_1.fastq.gz raw_files/merge/201249_2.fastq.gz P1_A1_UK001CD8A2_2006 test_output

# final bit with kallisto running really slowly, put more cores!
tracer assemble -c tracer.conf -p 12 -s Hsap -q kallisto raw_files/merge/201249_1.fastq.gz raw_files/merge/201249_2.fastq.gz P1_A1_UK001CD8A2_2006 test_output
