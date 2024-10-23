# Bacterial Genome Assembly

This project uses Snakemake to assemble and annotate a bacterial genome from nanopore reads.

## Description

This workflow uses the following tools to assemble and annotate a bacterial genome:

- [Porechop](https://github.com/rrwick/Porechop)(v0.2.4) for adapter trimming.
- [Chopper](https://github.com/wdecoster/chopper/)(v0.9.0) for read filtering.
- [Flye](https://github.com/fenderglass/Flye) (v2.9.3) for genome assembly.
- [raven](https://github.com/lbcb-sci/raven) (v1.8.3) for genome assembly.
- [medaka](https://github.com/nanoporetech/medaka/) (v1.11.3) for polishing the assemblies.
- [seqkit](https://bioinf.shenwei.me/seqkit/) (v2.7) to gets statistics of the assemblies.
- [bakta](https://github.com/oschwengers/bakta) (v1.9.2) for genome annotation.
- [checkm2](https://github.com/chklovski/CheckM2) (v1.0.1) to estimate the quality (completeness and contamination) of the genome.

<!-- - [ragtag](https://github.com/malonge/RagTag)(v2.1.0) to scaffold the assemblies based on the output of flye and raven. -->

At the end, there will be two different assemblies for your genome, one from flye and the other from raven in the `assemblies` folder. We chose the best assembly based on the checkm2 results, where we compare the genome qualities with this formula: `perc_diff = (max(completeness)-min(completeness))*100/max(completeness)`. If the difference in completeness is less than 5%, we choose the assembly with the lowest number of contigs. If the difference is greater than 5%, we choose the assembly with the highest completeness.

## Setup

1. Clone this repository to your local machine.
2. Navigate to the project directory.
3. Install miniconda from [here](https://docs.conda.io/en/latest/miniconda.html).
4. Create a new conda environment to install the snakemake dependencies:

```bash	
conda env create -n snakemake_env -c conda-forge snakemake mamba polars
```

5. Download the required databases: 

- `bakta`
- `checkm2`

## Configuration

Open the `config/config.yaml` file and modify the parameters according to your needs.

- `work_dir`: The location of this folder.
- `results_dir` : The directory where the results will be saved.
- `env_dir` : The directory where the conda files are found to create new environments.
- `reads_dir` : The location where the raw reads are stored in `.fastq.gz`.
- `threads` : The number of threads to use for the assembly and annotation steps.
- `reads_size` : The minimum size of the reads to be filtered.
- `bakta_db` : The location of the bakta database.
- `checkm2_db` : The location of the checkm2 database.

If using slurm, open the `profile/config.yaml` file and modify/add the following parameters if needed.

- `qos`
- `partition`
- `account`

## Running the Workflow

To run the Snakemake workflow using `slurm`, execute the following command in your terminal:

```bash
conda activate snakemake_env
snakemake -s workflow/Snakefile --configfile config/config.yaml --conda-prefix snakemake_envs --use-conda --rerun-incomplete --profile profile/ 
```

Without `slurm`, you can run the workflow using the following command:

```bash
conda activate snakemake_env
snakemake -s workflow/Snakefile --configfile config/config.yaml --conda-prefix snakemake_envs --use-conda --rerun-incomplete
```