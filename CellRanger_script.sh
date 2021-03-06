#STEP 1: MAKE GTF FILE

#mkdir refdata-cellranger-mm10-3.0.0_premrna
#cd refdata-cellranger-mm10-3.0.0_premrna


awk 'BEGIN{FS="\t"; OFS="\t"} $3 == "transcript"{ $3="exon"; print}' \
/rds/general/user/ah3918/ephemeral/CELLRANGER_GENOMES/mouse/refdata-cellranger-mm10-3.0.0/genes/genes.gtf > mm10-3.0.0.premrna.gtf

#----------------------------------------------------------------------------------------------------------------------
#PBS -lwalltime=24:00:00
#PBS -lselect=1:ncpus=8:ompthreads=8:mem=96gb

genomeloc=/rds/general/user/ah3918/ephemeral/CELLRANGER_GENOMES/mouse/refdata-cellranger-mm10-3.0.0
export PATH=/rds/general/user/ah3918/ephemeral/CELLRANGER/cellranger-3.1.0:$PATH

cellranger mkref --genome=CELLRANGERREFGENOME \
                --fasta=$genomeloc/fasta/genome.fa \
--genes=$genomeloc/mm10-3.0.0.premrna.gtf \
--ref-version=3.0.0





#----------------------------------------------------------------------------------------------------------------------

#STEP2: CREATE PBSPRO TEMPLATE FILE

cd /rds/general/user/ah3918/ephemeral/CELLRANGER/cellranger-3.1.0/martian-cs/v3.2.3/jobmanagers

cp pbspro.template.example pbspro.template


#!/usr/bin/env bash
#
# Copyright (c) 2016 10x Genomics, Inc. All rights reserved.
#
# =============================================================================
# Setup Instructions
# =============================================================================
#
# 1. Add any other necessary PBSpro arguments such as queue (-q) or account
#    (-A). If your system requires a walltime (-l walltime), 24 hours (24:00:00)
#    is sufficient.  We recommend you do not remove any arguments below or
#    Martian may not run properly.
#
# 2. Change filename of pbspro.template.example to pbspro.template.
#
# =============================================================================
# Template
# =============================================================================
#PBS -lwalltime:24:00:00
#PBS -N __MRO_JOB_NAME__
#PBS -V
#PBS -l select=1:ncpus=__MRO_THREADS__
#PBS -l mem=__MRO_MEM_GB__gb
#PBS -o __MRO_STDOUT__
#PBS -e __MRO_STDERR__

cd __MRO_JOB_WORKDIR__



#__MRO_CMD__


#ID looks for the prefix
#Name is the name of the folder it will outputto (new)

#STEP3: RUN Cellranger

xs
