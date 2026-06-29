rule basecalling:
    input:
        pod5="raw/{sample}.pod5"

    output:
        fastq="results/basecalling/{sample}.fastq.gz"

    log:
        "logs/basecalling/{sample}.log"

    threads:
        config["threads"]

    params:
        executable=config["dorado"]["executable"],
        model=config["dorado"]["model"],
        device=config["dorado"]["device"]

    shell:
        r"""
        mkdir -p results/basecalling logs/basecalling

        {params.executable} basecaller \
            --device {params.device} \
            {params.model} \
            {input.pod5} \
        2> {log} | gzip > {output.fastq}
        """
