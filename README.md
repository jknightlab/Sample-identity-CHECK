# Sample-identity-CHECK
### --> based on https://www.nature.com/articles/s41467-020-17453-5

## 1. download pre-compiled haplotype maps for hg19 and hg38. see details in https://github.com/naumanjaved/fingerprint_maps

### 2. collects fingerprints (essentially, genotype information from the RNA reads)
```
samtools merge -@ 12 BIONIC_merged_RG.bam \
Deduplicated.bam/*.dedup_RG.bam 

/apps/well/java/jdk1.8.0_latest/bin/java -Xmx8g -jar /apps/well/picard-tools/2.21.1/picard.jar CrosscheckFingerprints \
INPUT=BIONIC_148_RG.bam \
HAPLOTYPE_MAP=hg38_chr.map \
NUM_THREADS=4 \
OUTPUT=sample.140.crosscheck_metrics.txt \
MATRIX_OUTPUT=sample.140.crosscheck_LOD_Matrix.txt
```

### 3. Differential exon usage analysis via DEXseq
```
qusb run.sh
```


