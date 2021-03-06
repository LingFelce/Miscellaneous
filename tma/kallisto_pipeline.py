"""
Kallisto Pseudoalignment Pipeline
29th October 2020
"""

from ruffus import *
from cgatcore import pipeline as P
import sys

P.get_parameters('kallisto_pipeline.yml') 

@follows(mkdir('fastqc')) # fastq quality control
@transform('*.fastq.gz', regex(r'(.*).fastq.gz'),r'fastqc/\1_fastqc.html')
def fastqc (infile, outfile):
    statement = '''fastqc -q -t %(threads)s --nogroup %(infile)s --outdir fastqc'''
    P.run(statement, job_queue=P.PARAMS['queue'], job_threads=P.PARAMS['threads'])

@merge([P.PARAMS['index_fasta'],P.PARAMS['index_gtf']], 'transcripts.fasta') # input files from .yml put as a list, output name. Only need to do once
def create_fasta (infiles,outfile):
    fasta,gtf = infiles #unpack list
    statement = '''zcat %(gtf)s | gffread -w %(outfile)s -g %(fasta)s - ''' #unzip gtf.gz first, then use - as standard input after -g
    P.run(statement, job_queue=P.PARAMS['queue'], job_memory ='8G')
   
@transform(create_fasta, suffix('.fasta'),'.index') # follow from create_fasta, use output as input. Only need to do once
def create_index (infile, outfile):
    statement = '''kallisto index -i %(outfile)s %(infile)s'''
    P.run(statement, job_queue=P.PARAMS['queue'], job_memory ='8G')
    
@follows(mkdir('quant'), create_index) # create quant folder, follow from create_index to use output as input
@collate('*.fastq.gz', regex(r'(.*)_R[1-2]_001.fastq.gz'), r'quant/\1/abundance.h5') # find all fastq.gz files, output into quant folder/name of sample/abundances.h5 (one of 3 output files generated by default)
def run_quant(infiles, outfile):
    read1, read2 = infiles #set variables
    outdir = outfile.replace('abundance.h5','') #set directory for output, remove file name
    statement = ''' kallisto quant -t %(threads)s %(quant_option)s -i transcripts.index -o %(outdir)s %(read1)s %(read2)s''' #-o is only for output directory
    P.run(statement, job_queue=P.PARAMS['queue'], job_memory ='8G', job_threads=P.PARAMS['threads'])
	
# output will be abundance.h5, abundance.tsv and run_info.json (run info). Can import .h5 into R and use R txiimport package to convert to counts

@merge(run_quant, 'multiqc_report.html')
def multiqc (infile, outfile):
    statement = '''multiqc .'''
    P.run(statement)

if __name__ == "__main__":
    sys.exit( P.main(sys.argv) )
