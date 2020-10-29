# Sample-identity-CHECK
### --> based on https://www.nature.com/articles/s41467-020-17453-5

## pre-compiled haplotype maps for hg19 and hg38. see details in https://github.com/naumanjaved/fingerprint_maps

```
python python_scripts/dexseq_prepare_annotation2.py -r no -f Homo_sapiens.GRCh37.87_DEXSeq.gtf  Homo_sapiens.GRCh37.87.gtf.gz Homo_sapiens.GRCh37.87_DEXSeq.gff.
```

### 2. Generate exonic_part count file
```
GTF=/well/jknight/ping/gtfs/Homo_sapiens.GRCh38.84_DEXSeq.counts.gtf.
/apps/htseq/subread/bin/featureCounts -p -f -O -s 2 -F GTF -a $GTF \
-t exonic_part -o fcount.DEXSeq.no.r.txt \
*.bam.
```

### 3. Differential exon usage analysis via DEXseq
```
qusb run.sh
```


