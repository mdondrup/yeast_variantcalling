# Snakemake rule file for downloading fastq files from SRA
# Uses fasterq-dump from sra-tools
# Requires a config file with a list of SRA accessions, one per line

accessions = []

srafile = config['sra_accessions']
    
with open(srafile) as f:
    for row in f:
        accessions.append(row.split()[0])

print("Found "+  str(len(accessions)) + " accessions to download from SRA")

rule download_all_fastq:
    input:
        expand("Fastqs/{accession}_1.fastq.gz", accession=accessions),
        expand("Fastqs/{accession}_2.fastq.gz", accession=accessions),
    
    message:
        "Downloading all FASTQ files from SRA"
    run:
        print("Downloaded all FASTQ files from SRA")



rule get_fastq_pe_gz:
    output:
        # the wildcard name must be accession, pointing to an SRA number
        "Fastqs/{accession}_1.fastq.gz",
        "Fastqs/{accession}_2.fastq.gz",
    log:
        "logs/{accession}.gz.log"
    params:
        extra="--skip-technical"
    threads: 6  # defaults to 6
    retries: 3
    message:
        "Downloading {output} from SRA"
    wrapper:
        "v7.6.0/bio/sra-tools/fasterq-dump"