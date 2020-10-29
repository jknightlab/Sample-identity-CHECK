# Sample-identity-CHECK
## Crosscheck sample swaps
### --> based on https://www.nature.com/articles/s41467-020-17453-5

#### An example shows the relative likelihood of shared (in green) or distinct (in purple) genetic fingerprints across the time-course RNA-seq samples from each individul. Eight individuals (yellow squares) contain unmatched samples. [A positive LOD score suggests the two compared samples are more likely from the same individul, e.g., LOD score=10 means it's 10^10 more likely that the two are matched.]
![Screenshot](LOD_matrxi.png)

#### 1. Download pre-compiled haplotype maps for hg19 or hg38. see details in https://github.com/naumanjaved/fingerprint_maps

#### 2. Add Readgroups (RGs) for each RNA-seq sample (aligned * deduplicated bam file) for pairwise comparisons
```
java -Xmx8g -jar \
picard.jar AddOrReplaceReadGroups \
INPUT=Deduplicated.bam/${SAMPLE_NAME}.dedup.bam \
OUTPUT=Deduplicated.bam/${SAMPLE_NAME}.dedup_RG.bam \
RGID=$SAMPLE_NAME \
RGLB=RNAseq \
RGPL=illumina \
RGPU=$SAMPLE_NAME \
RGSM=$SAMPLE_NAME
```
#### 3. Collects fingerprints (LD blocks information derived from the RNA-seq reads) and run CrosscheckFingerprints.sh
#### see details in https://gatk.broadinstitute.org/hc/en-us/articles/360037057832-CrosscheckFingerprints-Picard-
#### the "MATRIX_OUTPUT" file could then be used for results visualization re CrossCheck.R
```
# merge the bam files
samtools merge -@ 12 BIONIC_merged_RG.bam \
Deduplicated.bam/*.dedup_RG.bam 
# run CrosscheckFingerprints. change the maximum Java heap size if needed.
java -Xmx8g -jar /apps/well/picard-tools/2.21.1/picard.jar CrosscheckFingerprints \
INPUT=BIONIC_148_RG.bam \
HAPLOTYPE_MAP=hg38_chr.map \
NUM_THREADS=4 \
OUTPUT=sample.140.crosscheck_metrics.txt \
MATRIX_OUTPUT=sample.140.crosscheck_LOD_Matrix.txt
```
#### see example runs in rescomp "2.add.ReadGroups.sh" and "3.CrosscheckFingerprints.sh"
#### see example output "sample.140.crosscheck_LOD_Matrix_MAPQ255.txt" and "CrossCheck.R" for plotting
