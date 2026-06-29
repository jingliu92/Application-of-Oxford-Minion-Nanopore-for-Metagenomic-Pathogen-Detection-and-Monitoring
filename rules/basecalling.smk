#################################################
# Basecalling Rule
#################################################

rule basecalling:
    input:
        "raw/{sample}.pod5"

    output:
        "results/basecalling/{sample}.fastq.gz"

    shell:
        """
        mkdir -p results/basecalling
        touch {output}
        """
