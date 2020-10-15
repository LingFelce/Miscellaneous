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
module load tracer
module load kallisto
tracer assemble -c tracer.conf -r -p 12 -s Hsap -q kallisto raw_files/merge/201249_1.fastq.gz raw_files/merge/201249_2.fastq.gz P1_A1_UK001CD8A2_2006 test_output

# submit job to queue as takes ages even with just 1 sample (paired reads)

#!/bin/sh
##########################################################################
## A script template for submitting batch jobs. To submit a batch job,
## please type
##
##    qsub tracer_assemble.sh
##
## Please note that anything after the first two characters "#$" on a line
## will be treated as a SUN Grid Engine command.
##########################################################################

## The following to run programs in the current working directory

#$ -cwd


## Specify a queue

#$ -q batchq


## The following two lines will send an email notification when the job is
## Ended/Aborted/Suspended - Please replace "UserName" with your own username.

#$ -M lfelce
#$ -m eas

module load tracer
module load kallisto
tracer assemble -c tracer.conf -r -p 12 -s Hsap -q kallisto raw_files/merge/201249_1.fastq.gz raw_files/merge/201249_2.fastq.gz P1_A1_UK001CD8A2_2006 test_output

# error message from most recent run (7th - 8th October 2020)
# [build] loading fasta file /t1-data/user/lfelce/P170335/test_output/P1_A1_UK001CD8A2_2006/expression_quantification/kallisto_index/P1_A1_UK001CD8A2_2006_transcriptome.fa
# [build] k-mer length: 31
# [build] warning: replaced 165046090 non-ACGUT characters in the input sequence
        # with pseudorandom nucleotides
# [build] counting k-mers ... done.
# [build] building target de Bruijn graph ...  done 
# [build] creating equivalence classes ...  done
# [build] target de Bruijn graph has 38967164 contigs and contains 2666295089 k-mers 


# [quant] fragment length distribution will be estimated from the data
# [index] k-mer length: 31
# [index] number of targets: 197
# [index] number of k-mers: 2,666,295,089
# [index] number of equivalence classes: 1,867,558
# [quant] running in paired-end mode
# [quant] will process pair 1: raw_files/merge/201249_1.fastq.gz
                             # raw_files/merge/201249_2.fastq.gz
# [quant] finding pseudoalignments for the reads ... done
# [quant] processed 2,793,690 reads, 2,385,777 reads pseudoaligned
# [quant] estimated average fragment length: 277.88
# [   em] quantifying the abundances ... done
# [   em] the Expectation-Maximization algorithm ran for 52 rounds

#/Filers/package/python/3.5.3/lib/python3.5/site-packages/IPython/html.py:14: ShimWarning: The `IPython.html` package has been deprecated since IPython 4.0. You should import from `notebook` instead. `IPython.html.widgets` has moved to `ipywidgets`.
#  "`IPython.html.widgets` has moved to `ipywidgets`.", ShimWarning)
#Traceback (most recent call last):
#  File "/package/tracer/implementing_build-20170413/bin/tracer", line 11, in <module>
#    load_entry_point('tracer==0.1', 'console_scripts', 'tracer')()
#TypeError: 'module' object is not callable

# does seem to give filtered_TCR and unfiltered_TCR files but they're the same??

# downloaded setup.py file and followed download instructions from https://github.com/Teichlab/tracer. Installed on own conda (not sure where exactly!)

# Adjusted tracer.conf file.

#Configuration file for TraCeR#

[tool_locations]
#paths to tools used by TraCeR for alignment, quantitation, etc
#bowtie2_path = /databank/igenomes/Homo_sapiens/UCSC/hg38/Sequence/Bowtie2Index
#bowtie2-build_path = /path/to/bowtie2-build
#igblastn_path = /path/to/igblastn
#makeblastdb_path = /path/to/makeblastdb
#kallisto_path = /path/to/kallisto
#salmon_path = /path/to/salmon
#trinity_path = /path/to/trinity
#dot_path = /path/to/dot
#neato_path = /path/to/neato


[trinity_options]
#line below specifies maximum memory for Trinity Jellyfish component. Set it appropriately for your environment.
max_jellyfish_memory = 1G

#uncomment the line below if you've got a configuration file for Trinity to use a computing grid 
#trinity_grid_conf = /path/to/trinity/grid.conf

#uncomment the line below to explicitly specify Trinity version. Options are '1' or '2'
trinity_version = 1


[IgBlast_options]
igblast_seqtype = TCR

[base_transcriptomes]
# reference transcriptomes for kallisto/salmon
Mmus = /path/to/kallisto/transcriptome_for_Mmus
Hsap = /databank/igenomes/Homo_sapiens/UCSC/hg38/Sequence/WholeGenomeFasta/genome.fa

[salmon_options]
# line below specifies type of sequencing library for Salmon; if not specified, automatic detection (--libType A) is used 
#libType = A

# line below specifies minimum acceptable length for valid match in salmon's quasi mapping; if not specified, default value of 31 is used
#kmerLen = 31
#


[bowtie2_options]
synthetic_genome_index_path = /package/tracer/implementing_build-20170413/resources/Hsap/combinatorial_recombinomes

##Tracer requirements##

# Start again with tracer conda environment
# Realised that it’s not asking for those specific versions, it’s just asking for that version or newer. So don’t necessarily need to install exact version number specified!

# Git clone tracer repository

# Packages to install in order
Python
Bowtie2
Trinity
Kallisto
Numpy
Biopython

pip install –r requirements.txt

python setup.py install

# Adjusted tracer.conf with base transcriptomes (mouse and human)

tracer test -p 10 -c tracer.conf

# error with biopython - downgrade one version to 1.77

tracer test -p 10 -c tracer.conf

(tracer_env) [lfelce@deva tracer]$ tracer test -p 10 -c tracer.conf
##Finding recombinant-derived reads##
Attempting new assembly for ['TCR_A', 'TCR_B']

##TCR_A##
1135 reads; of these:
  1135 (100.00%) were paired; of these:
    571 (50.31%) aligned concordantly 0 times
    564 (49.69%) aligned concordantly exactly 1 time
    0 (0.00%) aligned concordantly >1 times
    ----
    571 pairs aligned concordantly 0 times; of these:
      0 (0.00%) aligned discordantly 1 time
    ----
    571 pairs aligned 0 times concordantly or discordantly; of these:
      1142 mates make up the pairs; of these:
        1010 (88.44%) aligned 0 times
        0 (0.00%) aligned exactly 1 time
        132 (11.56%) aligned >1 times
55.51% overall alignment rate
##TCR_B##
1135 reads; of these:
  1135 (100.00%) were paired; of these:
    687 (60.53%) aligned concordantly 0 times
    448 (39.47%) aligned concordantly exactly 1 time
    0 (0.00%) aligned concordantly >1 times
    ----
    687 pairs aligned concordantly 0 times; of these:
      0 (0.00%) aligned discordantly 1 time
    ----
    687 pairs aligned 0 times concordantly or discordantly; of these:
      1374 mates make up the pairs; of these:
        1267 (92.21%) aligned 0 times
        7 (0.51%) aligned exactly 1 time
        100 (7.28%) aligned >1 times
44.19% overall alignment rate

##Assembling Trinity Contigs##
##TCR_A##


     ______  ____   ____  ____   ____  ______  __ __
    |      ||    \ |    ||    \ |    ||      ||  |  |
    |      ||  D  ) |  | |  _  | |  | |      ||  |  |
    |_|  |_||    /  |  | |  |  | |  | |_|  |_||  ~  |
      |  |  |    \  |  | |  |  | |  |   |  |  |___, |
      |  |  |  .  \ |  | |  |  | |  |   |  |  |     |
      |__|  |__|\_||____||__|__||____|  |__|  |____/

    Trinity-v2.8.5



Left read files: $VAR1 = [
          '/home/molimm/lfelce/tracer/test_data/results/cell1/aligned_reads/cell1_TCR_A_1.fastq'
        ];
Right read files: $VAR1 = [
          '/home/molimm/lfelce/tracer/test_data/results/cell1/aligned_reads/cell1_TCR_A_2.fastq'
        ];
Trinity version: Trinity-v2.8.5
** NOTE: Latest version of Trinity is v2.11.0, and can be obtained at:
	https://github.com/trinityrnaseq/trinityrnaseq/releases

Argument "error" isn't numeric in numeric ne (!=) at /t1-home/molimm/lfelce/conda/obds_conda_install/envs/tracer_env/bin/Trinity line 3812.
Error, need samtools installed that is at least as new as version 1.3 at /t1-home/molimm/lfelce/conda/obds_conda_install/envs/tracer_env/bin/Trinity line 3813.
*** WARNING *** Trinity command ['/t1-home/molimm/lfelce/conda/obds_conda_install/envs/tracer_env/bin/Trinity', '--seqType', 'fq', '--max_memory', '1G', '--CPU', '10', '--full_cleanup', '--no_normalize_reads', '--left', '/home/molimm/lfelce/tracer/test_data/results/cell1/aligned_reads/cell1_TCR_A_1.fastq', '--right', '/home/molimm/lfelce/tracer/test_data/results/cell1/aligned_reads/cell1_TCR_A_2.fastq', '--output', '/home/molimm/lfelce/tracer/test_data/results/cell1/Trinity_output/Trinity_cell1_TCR_A'] failed for locus TCR_A
##TCR_B##


     ______  ____   ____  ____   ____  ______  __ __
    |      ||    \ |    ||    \ |    ||      ||  |  |
    |      ||  D  ) |  | |  _  | |  | |      ||  |  |
    |_|  |_||    /  |  | |  |  | |  | |_|  |_||  ~  |
      |  |  |    \  |  | |  |  | |  |   |  |  |___, |
      |  |  |  .  \ |  | |  |  | |  |   |  |  |     |
      |__|  |__|\_||____||__|__||____|  |__|  |____/

    Trinity-v2.8.5



Left read files: $VAR1 = [
          '/home/molimm/lfelce/tracer/test_data/results/cell1/aligned_reads/cell1_TCR_B_1.fastq'
        ];
Right read files: $VAR1 = [
          '/home/molimm/lfelce/tracer/test_data/results/cell1/aligned_reads/cell1_TCR_B_2.fastq'
        ];
Trinity version: Trinity-v2.8.5
** NOTE: Latest version of Trinity is v2.11.0, and can be obtained at:
	https://github.com/trinityrnaseq/trinityrnaseq/releases

Argument "error" isn't numeric in numeric ne (!=) at /t1-home/molimm/lfelce/conda/obds_conda_install/envs/tracer_env/bin/Trinity line 3812.
Error, need samtools installed that is at least as new as version 1.3 at /t1-home/molimm/lfelce/conda/obds_conda_install/envs/tracer_env/bin/Trinity line 3813.
*** WARNING *** Trinity command ['/t1-home/molimm/lfelce/conda/obds_conda_install/envs/tracer_env/bin/Trinity', '--seqType', 'fq', '--max_memory', '1G', '--CPU', '10', '--full_cleanup', '--no_normalize_reads', '--left', '/home/molimm/lfelce/tracer/test_data/results/cell1/aligned_reads/cell1_TCR_B_1.fastq', '--right', '/home/molimm/lfelce/tracer/test_data/results/cell1/aligned_reads/cell1_TCR_B_2.fastq', '--output', '/home/molimm/lfelce/tracer/test_data/results/cell1/Trinity_output/Trinity_cell1_TCR_B'] failed for locus TCR_B
No successful Trinity assemblies
##No recombinants found##
(tracer_env) [lfelce@deva tracer]$ samtools --version
samtools: error while loading shared libraries: libcrypto.so.1.0.0: cannot open shared object file: No such file or directory


# failing at trinity step - try running trinity command separately
Trinity --seqType fq --left reads_1.fq --right reads_2.fq --CPU 6 --max_memory 20G

Trinity --seqType fq --max_memory 1G --CPU 10 --full_cleanup --no_normalize_reads --left /home/molimm/lfelce/tracer/test_data/results/cell1/aligned_reads/cell1_TCR_B_1.fastq --right /home/molimm/lfelce/tracer/test_data/results/cell1/aligned_reads/cell1_TCR_B_2.fastq --output /home/molimm/lfelce/tracer/test_data/results/cell1/Trinity_output/Trinity_cell1_TCR_B

conda update samtools 

# updated from 1.7 to 1.11

# tested separately after update, worked fine

# fixed trinity, new error

Traceback (most recent call last):
  File "/t1-home/molimm/lfelce/conda/obds_conda_install/envs/tracer_env/bin/tracer", line 33, in <module>
    sys.exit(load_entry_point('tracer==0.5', 'console_scripts', 'tracer')())
  File "/t1-home/molimm/lfelce/conda/obds_conda_install/envs/tracer_env/lib/python3.8/site-packages/tracer-0.5-py3.8.egg/tracerlib/launcher.py", line 43, in launch
    Task().run()
  File "/t1-home/molimm/lfelce/conda/obds_conda_install/envs/tracer_env/lib/python3.8/site-packages/tracer-0.5-py3.8.egg/tracerlib/tasks.py", line 1217, in run
    Assembler(resource_dir=self.resource_dir, ncores=str(self.ncores),
  File "/t1-home/molimm/lfelce/conda/obds_conda_install/envs/tracer_env/lib/python3.8/site-packages/tracer-0.5-py3.8.egg/tracerlib/tasks.py", line 372, in run
    cell = self.ig_blast()
  File "/t1-home/molimm/lfelce/conda/obds_conda_install/envs/tracer_env/lib/python3.8/site-packages/tracer-0.5-py3.8.egg/tracerlib/tasks.py", line 489, in ig_blast
    igblastn = self.get_binary('igblastn')
  File "/t1-home/molimm/lfelce/conda/obds_conda_install/envs/tracer_env/lib/python3.8/site-packages/tracer-0.5-py3.8.egg/tracerlib/tasks.py", line 69, in get_binary
    return check_binary(name, user_path)
  File "/t1-home/molimm/lfelce/conda/obds_conda_install/envs/tracer_env/lib/python3.8/site-packages/tracer-0.5-py3.8.egg/tracerlib/io.py", line 154, in check_binary
    raise OSError(
OSError: Required binary not found: igblastn. Please add to PATH or specify location in config file.

# igblast additional directories required - folders on ftp renamed to old optional file and old internal data.
# ftp://ftp.ncbi.nih.gov/blast/executables/igblast/release/
# use wget -r to download all the files in the directories

wget -r ftp://ftp.ncbi.nih.gov/blast/executables/igblast/release/old_internal_data/
wget -r ftp://ftp.ncbi.nih.gov/blast/executables/igblast/release/old_optional_file/

# renamed folders internal data and optional file

# still getting same error message - probably need to do wget -r for whole directory and point to latest version.
wget -r ftp://ftp.ncbi.nih.gov/blast/executables/igblast/release/

# path to ignblastn (had to unzip tar.gz folder)
# /home/molimm/lfelce/ftp.ncbi.nih.gov/blast/executables/igblast/release/1.16.0/ncbi-igblast-1.16.0/bin

# wasn't working so decided to try older version of igblastn that was mentioned in tracer readme.
# set envionmental variable - setting it as IGDATA wasn't working, as when typed which igblastn it was looking in the wrong place.
# had to set in environmental variable PATH
PATH='/t1-home/molimm/lfelce/conda/obds_conda_install/envs/tracer_env/bin:/grid/sge/bin/lx26-amd64:/package/cufflinks/2.2.1/bin:/package/bowtie2/2.1.0/bin:/package/bowtie2/2.1.0/scripts:/usr/local/pkgbin:/package/cbrg/bin:/grid/sge/bin/lx26-amd64:/package/cufflinks/2.2.1/bin:/package/bowtie2/2.1.0/bin:/package/bowtie2/2.1.0/scripts:/usr/local/pkgbin:/package/cbrg/bin:/t1-home/molimm/lfelce/conda/obds_conda_install/condabin:/grid/sge/bin/lx26-amd64:/usr/lib64/qt-3.3/bin:/package/cufflinks/2.2.1/bin:/package/bowtie2/2.1.0/bin:/package/bowtie2/2.1.0/scripts:/usr/local/pkgbin:/package/cbrg/bin:/usr/local/bin:/bin:/usr/bin:/opt/dell/srvadmin/bin:/usr/local/sbin:/usr/sbin:/sbin:/home/molimm/lfelce/ftp.ncbi.nih.gov/blast/executables/igblast/release/1.4.0/ncbi-igblast-1.4.0/bin'

# actually realised had put it in tracer.conf but left # would have probably worked without having to set environmental variable!!
# also had to move internal_data and optional_file folders into bin folder

#Configuration file for TraCeR#

[tool_locations]
#paths to tools used by TraCeR for alignment, quantitation, etc
##UNCOMMENT IF WANT TO USE PATH!

#bowtie2_path = /home/molimm/lfelce/conda/obds_conda_install/envs/tracer_env/bin
#bowtie2-build_path = /path/to/bowtie2-build
#igblastn_path = /home/molimm/lfelce/ftp.ncbi.nih.gov/blast/executables/igblast/release/1.4.0/ncbi-igblast-1.4.0/bin
#makeblastdb_path = /path/to/makeblastdb
#kallisto_path = /home/molimm/lfelce/conda/obds_conda_install/envs/tracer_env/bin
#salmon_path = /path/to/salmon
#trinity_path = /home/molimm/lfelce/conda/obds_conda_install/envs/tracer_env/bin
#dot_path = /path/to/dot
#neato_path = /path/to/neato


[trinity_options]
#line below specifies maximum memory for Trinity Jellyfish component. Set it appropriately for your environment.
max_jellyfish_memory = 1G

#uncomment the line below if you've got a configuration file for Trinity to use a computing grid 
#trinity_grid_conf = /path/to/trinity/grid.conf

#uncomment the line below to explicitly specify Trinity version. Options are '1' or '2'
trinity_version = 2

#### <---- beginning of trinity specialized options
# additional Trinity options in case you're dealing with very short reads (say 25 base reads)
# and want to achieve high sensitivity with questionable specificity, in other words
# trying to extract whatever you can from the data you have:

###  note, default Trinity kmer length is 25
#trinity_kmer_length = 17

### below stops trinity at the initial inchworm (greedy kmer extension) step.
#inchworm_only = True

#### end of trinity specialized options ---->


[IgBlast_options]
igblast_seqtype = TCR

[base_transcriptomes]
# reference transcriptomes for kallisto/salmon.  Just point to the raw transcriptome fasta files.
Mmus = /databank/igenomes/Mus_musculus/UCSC/mm10/Sequence/WholeGenomeFasta/genome.fa
Hsap = /databank/igenomes/Homo_sapiens/UCSC/hg38/Sequence/WholeGenomeFasta/genome.fa

[salmon_base_indices]
# salmon indices created from [base_transcriptomes] above; needed only when option --small_index is used
Mmus = /path/to/salmon/index_for_Mmus
Hsap = /path/to/salmon/index_for_Hsap

[kallisto_base_indices]
# kallisto indices created from [base_transcriptomes] above; needed only when option --small_index is used
Mmus = /path/to/kallisto/index_for_Mmus
Hsap = /path/to/kallisto/index_for_Hsap

[salmon_options]
# line below specifies type of sequencing library for Salmon; if not specified, automatic detection (--libType A) is used 
#libType = A

# line below specifies minimum acceptable length for valid match in salmon's quasi mapping; if not specified, default value of 31 is used
#kmerLen = 31

[tracer_location]
#Path to direcetory where TraCeR was originally downloaded
tracer_path = /home/molimm/lfelce/tracer

tracer test -p 10 -c tracer.conf -r # -r so don't repeat everything again if resuming from failed test
