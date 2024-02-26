rule concatenate_reads:
	input:
		expand(os.path.join(READS_DIR, "{reads}.fastq.gz"), reads = READS)
	output:
		os.path.join(RESULTS_DIR, "rawReads/concatenated_reads.fastq.gz")
	shell:
		"cat {input} > {output}"
