##############################
# MODULES
import os, re
import glob
import pandas as pd

# ##############################
# # Parameters
# CORES=int(os.environ.get("CORES", 4))


##############################
# Paths
# SRC_DIR = srcdir("../scripts")
# ENV_DIR = srcdir("../envs")
# NOTES_DIR = srcdir("../notes")
# SUBMODULES= srcdir("../../submodules")

##############################
# Dependencies 



##############################
# default executable for snakemake
shell.executable("bash")


##############################
# working directory
workdir:
    config["work_dir"]


##############################
# Relevant directories
ENV_DIR=config["env_dir"]
READS_DIR=config["reads_dir"]
RESULTS_DIR=config["results_dir"]
WORK_DIR = config["work_dir"]


##############################
# Steps
STEPS = config["steps"]


##############################
# Input


READS = glob_wildcards(os.path.join(READS_DIR, "{reads}.fastq.gz")).reads
