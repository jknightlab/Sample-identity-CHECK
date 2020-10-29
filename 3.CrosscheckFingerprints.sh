#!/bin/bash
#$ -cwd -N crosscMAPQ255
#$ -S /bin/bash -P jknight.prjc -q short.qc
#$ -pe shmem 12
#$ -o {PATH}
#$ -e {PATH}
#$ -j y
##$ -t 1-140

echo "Started at: "`date`

module load SAMtools/1.9-foss-2018b

# merge samples
samtools merge -@ 12 BIONIC_merged_RG.bam \
Deduplicated.bam/*.dedup_RG.bam 

# only consider the uniquely mapped reads (aligned bam via STAR)
samtools view -@ 12 -q 255 BIONIC_merged_RG.bam -b > BIONIC_merged_RG_MAPQ255.bam 

# run CrosscheckFingerprints using LD block file "hg38_chr.map"
/apps/well/java/jdk1.8.0_latest/bin/java -Xmx8g -jar /apps/well/picard-tools/2.21.1/picard.jar CrosscheckFingerprints \
INPUT=BIONIC_merged_RG_MAPQ255.bam \
HAPLOTYPE_MAP=hg38_chr.map \
NUM_THREADS=12 \
OUTPUT=sample.140.crosscheck_metrics_MAPQ255.txt \
MATRIX_OUTPUT=sample.140.crosscheck_LOD_Matrix_MAPQ255.txt

echo "Ended at: "`date`

