# Reference Flatfiles and Samples

## RNA-Seq

### Prepare Reference GTF/FASTA
 
 - organism/assembly:	Ensembl homo sapiens release 104, hg38 (https://ftp.ensembl.org/pub/)
 - ref_gtf:				homo_sapiens.104.mainChr.gtf
 - star_index: 			Prepare STAR genome index as described in STAR manual

### Prepare Sample FASTQ
 - Copy sample FASTQ files to subfolder ./raw/

### Samples: RNA-Seq 1 - GSE261753

```
prefix	fastq1
CTRL-Static_1	CTRL-Static_1_R1.fastq
CTRL-Static_2	CTRL-Static_2_R1.fastq
CTRL-DF_1	CTRL-DF_1_R1.fastq
CTRL-DF_2	CTRL-DF_2_R1.fastq
siPKN1-Static_1	siPKN1-Static_1_R1.fastq
siPKN1-Static_2	siPKN1-Static_2_R1.fastq
siPKN1-DF_1	siPKN1-DF_1_R1.fastq
siPKN1-DF_2	siPKN1-DF_2_R1.fastq
```

## ATAC-Seq

### Prepare Reference GTF/FASTA
 
 - organism/assembly:	Ensembl homo sapiens release 104, hg38 (https://ftp.ensembl.org/pub/)
 - ref_gtf:				homo_sapiens.104.mainChr.gtf
 - star_index: 			Prepare STAR genome index as described in STAR manual

### Prepare Sample FASTQ
Copy sample FASTQ files to subfolder ./raw/

### Samples: ATAC-Seq 1 - GSE261754

```
prefix	fastq1	fastq2
CTRL-Static_1	CTRL-Static_1_R1.fastq	CTRL-Static_1_R2.fastq
CTRL-Static_2	CTRL-Static_2_R1.fastq	CTRL-Static_2_R2.fastq
CTRL-DF_1	CTRL-DF_1_R1.fastq	CTRL-DF_1_R2.fastq
siPKN1-Static_1	siPKN1-Static_1_R1.fastq	siPKN1-Static_1_R2.fastq
siPKN1-Static_2	siPKN1-Static_2_R1.fastq	siPKN1-Static_2_R2.fastq
siPKN1-DF_1	siPKN1-DF_1_R1.fastq	siPKN1-DF_1_R2.fastq
siPKN1-DF_2	siPKN1-DF_2_R1.fastq	siPKN1-DF_2_R2.fastq
```

### Samples: ATAC-Seq 2 - GSE261755

```
prefix	fastq1	fastq2
Static_1	Static_1_R1.fastq	Static_1_R2.fastq
Static_2	Static_2_R1.fastq	Static_2_R2.fastq
Static_3	Static_3_R1.fastq	Static_3_R2.fastq
DF_1	DF_1_R1.fastq	DF_1_R2.fastq
DF_2	DF_2_R1.fastq	DF_2_R2.fastq
DF_3	DF_3_R1.fastq	DF_3_R2.fastq
```