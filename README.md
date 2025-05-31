# Snakemake workflow: `yeast_variant calling`

[![Snakemake](https://img.shields.io/badge/snakemake-≥6.3.0-brightgreen.svg)](https://snakemake.github.io)



A Snakemake workflow for variant detection and filtering with GATK 4, also generates assemblies with NASP.
Trimming and QC is done with fastp.


## Usage

Place all paired-end (must contain `R1`, `R2` or `_1`, `_2` in their file names) `.fastq` or `fastq.gz` files in the Fastq directory.
Configure the reference genome files. For NASP, a genome file with mitochondrial genome removed can be used.

Configure the reference genomes and ploidy settings in the Snakemake file. Dependencies are installed by conda.

Run the workflow:

```
snakemake --use-conda -c <threads>
```

There may be an issue with waiting for NASP to finish. In this case, install and run NASP manually as indicated during the rule execution.
