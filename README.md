# rnaseqGene-nf
A nextflow pipeline converted using seqera.ai from snakemake pipeline in [rnaseqGene](https://bioconductor.org/packages/release/workflows/vignettes/rnaseqGene/inst/doc/rnaseqGene.html) manual.

# RNA-seq Analysis Pipeline

## Overview

This repository contains a Nextflow DSL2 pipeline for RNA-seq analysis, focusing on gene expression comparison between case and control samples. The pipeline uses Salmon for quantification and DESeq2 for differential expression analysis.

## Features

- Nextflow DSL2 implementation
- Modular design for easy customization and extension
- Utilizes Salmon for transcript quantification
- Performs differential expression analysis using DESeq2
- Supports paired-end RNA-seq data
- Uses Wave for efficient software management and containerization

## Requirements

- Nextflow (version 21.04.0 or later)
- Docker or Singularity
- Java 8 or later

## Usage

1. Clone this repository:


Replace `path/to/reads/*_{1,2}.fastq.gz` with the path to your paired-end FASTQ files, and `path/to/reference.fasta` with the path to your reference genome FASTA file.

## Parameters

- `--fastq_reads`: Path to input FASTQ files (must be enclosed in quotes)
- `--fasta_reference`: Path to reference genome FASTA file
- `--outdir`: Output directory (default: 'results')

## Pipeline Steps

1. FASTQC: Quality control of input reads
2. Salmon Index: Indexing the reference transcriptome
3. Salmon Quant: Quantification of transcript expression
4. DESeq2: Differential expression analysis

## Output

The pipeline generates the following outputs in the specified `outdir`:

- FastQC reports
- Salmon quantification results
- DESeq2 differential expression results
- MA plot and PCA plot

## Configuration

The `nextflow.config` file contains the following configurations:

- Wave configuration for software management
- Resource allocation for each process
- Default parameters
- Execution environment settings

You can modify this file to adjust resource allocations or change default parameters.

## Customization

To customize the pipeline:

1. Modify process definitions in `main.nf`
2. Add or remove modules as needed
3. Adjust parameters in `nextflow.config`

## Contributing

Contributions to improve the pipeline are welcome. Please follow these steps:

1. Fork the repository
2. Create a new branch
3. Make your changes
4. Submit a pull request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Citation

If you use this pipeline in your research, please cite:
