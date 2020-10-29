#!/bin/bash
#$ -cwd -N RGs
#$ -S /bin/bash -P jknight.prjc -q short.qc
#$ -pe shmem 4
#$ -o {PATH}
#$ -e {PATH}
#$ -j y
#$ -t 1-140

echo "Started at: "`date`

##### results folder
if [[ ! -e Deduplicated.bam ]]; then
mkdir Deduplicated.bam
fi

# Get sample ID for this task
SAMPLE_NAME=$(cat mapping.key.txt | tail -n+${SGE_TASK_ID} | head -1 | cut -f1 )
echo "SAMPLE_NAME: $SAMPLE_NAME"

# add RGs to distinguish samples
/apps/well/java/jdk1.8.0_latest/bin/java -Xmx8g -jar \
/apps/well/picard-tools/2.21.1/picard.jar AddOrReplaceReadGroups \
INPUT=Deduplicated.bam/${SAMPLE_NAME}.dedup.bam \
OUTPUT=Deduplicated.bam/${SAMPLE_NAME}.dedup_RG.bam \
RGID=$SAMPLE_NAME \
RGLB=RNAseq \
RGPL=illumina \
RGPU=$SAMPLE_NAME \
RGSM=$SAMPLE_NAME

# index
module load SAMtools/1.9-foss-2018b
samtools index -@ 4 Deduplicated.bam/${SAMPLE_NAME}.dedup_RG.bam

echo "Ended at: "`date`

