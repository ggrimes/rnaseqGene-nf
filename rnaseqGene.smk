DATASETS = ["SRR1039508",
            "SRR1039509",
            "SRR1039512",
            "SRR1039513",
            "SRR1039516",
            "SRR1039517",
            "SRR1039520",
            "SRR1039521"]

SALMON = "/path/to/salmon_0.14.1/bin/salmon"

rule all:
  input: expand("quants/{dataset}/quant.sf", dataset=DATASETS)

rule salmon_quant:
    input:
        r1 = "fastq/{sample}_1.fastq.gz",
        r2 = "fastq/{sample}_2.fastq.gz",
        index = "/path/to/gencode.v29_salmon_0.14.1"
    output:
        "quants/{sample}/quant.sf"
    params:
        dir = "quants/{sample}"
    shell:
        "{SALMON} quant -i {input.index} -l A -p 6 --validateMappings \
         --gcBias --numGibbsSamples 20 -o {params.dir} \
         -1 {input.r1} -2 {input.r2}"
