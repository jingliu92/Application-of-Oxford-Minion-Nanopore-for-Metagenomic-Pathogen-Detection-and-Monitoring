#################################################
# FoodNanoDetect Snakefile
#################################################

configfile: "config/config.yaml"

include: "rules/basecalling.smk"

SAMPLES = ["sample01"]

rule all:
    input:
        expand(
            "results/basecalling/{sample}.fastq.gz",
            sample=SAMPLES
        )
