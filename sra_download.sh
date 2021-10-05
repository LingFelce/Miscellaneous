# find SRP/Bioproject ID of overall experiment
# search by individual BioSample/SRA ID for each sample
# each sample then has individual run ID
# download SRA archive data from public links
# download toolkit and configure in order to extract (and zip) fastq files
# https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?view=toolkit_doc

/stopgap/donglab/ling/TCR/SRP109035/sratoolkit.2.11.1-centos_linux64/bin/fastq-dump-orig.2.11.1 -I --split-files /stopgap/donglab/ling/TCR/SRP109035/SRR5676643 --outdir /stopgap/donglab/ling/TCR/SRP109035/ --gzip

/stopgap/donglab/ling/TCR/SRP109035/sratoolkit.2.11.1-centos_linux64/bin/fastq-dump-orig.2.11.1 -I --split-files /stopgap/donglab/ling/TCR/SRP109035/SRR5676626 --outdir /stopgap/donglab/ling/TCR/SRP109035/ --gzip

/stopgap/donglab/ling/TCR/SRP109035/sratoolkit.2.11.1-centos_linux64/bin/fastq-dump-orig.2.11.1 -I --split-files /stopgap/donglab/ling/TCR/SRP109035/SRR5676625 --outdir /stopgap/donglab/ling/TCR/SRP109035/ --gzip

# use mixcr analyze amplicon to extract TCR sequences
