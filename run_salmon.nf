#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Define parameters
params.fastq_reads = "/home/user/data/genomics/homo_sapiens/illumina/fastq/test_rnaseq_{1,2}.fastq.gz"
params.fasta_reference = "/home/user/data/genomics/homo_sapiens/genome/transcriptome.fasta"
params.outdir = 'results'

// Define the main workflow
workflow {
    // Create channels for input data
    ch_fastq = channel
        .fromFilePairs(params.fastq_reads, checkIfExists: true)
        .ifEmpty { error "Cannot find any reads matching: ${params.fastq_reads}" }
    
    ch_reference = channel
        .fromPath(params.fasta_reference, checkIfExists: true)
        .ifEmpty { error "Cannot find reference file: ${params.fasta_reference}" }

    // Run the salmon_index process
    SALMON_INDEX(ch_reference)

    // Run the salmon_quant process
    SALMON_QUANT(ch_fastq, SALMON_INDEX.out.index)
}

// Define the salmon_index process
process SALMON_INDEX {
    publishDir "${params.outdir}/salmon_index", mode: 'copy'

    input:
    path reference

    output:
    path 'index', emit: index

    conda "bioconda::salmon=0.14.1"

    script:
    """
    salmon index -t $reference -i index
    """
}

// Define the salmon_quant process
process SALMON_QUANT {
    publishDir "${params.outdir}/salmon_quant", mode: 'copy'

    input:
    tuple val(sample_id), path(reads)
    path index

    output:
    path "${sample_id}", emit: quant

    conda "bioconda::salmon=0.14.1"

    script:
    """
    salmon quant -i $index -l A -p 6 --validateMappings \
    --gcBias --numGibbsSamples 20 -o ${sample_id} \
    -1 ${reads[0]} -2 ${reads[1]}
    """
}
