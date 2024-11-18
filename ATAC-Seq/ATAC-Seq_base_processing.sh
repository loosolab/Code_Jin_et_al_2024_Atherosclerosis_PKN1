##
## Notes
##
## Prepare reference indices and flatfiles according to ../CONFIG.md
##
## variables:
## ${sample_prefix}:            label prefix for any fastq (treatment or input)
## ${sample_prefix_treatment}:  label prefix for treatment fastq; e.g. WT_1
## ${sample_prefix_input}:      label prefix for input/igg/background fastq; e.g. WT_1_input
## ${ref_gtf}:                  reference genome gtf by Ensembl; e.g. mus_musculus.101.mainChr.gtf
## ${star_index}:               star reference index


##
## Repeat the following steps per fastq
##

## Trimming chip/input: Trimmomatic
java -jar trimmomatic.jar PE -threads 8 ./raw/${sample_prefix}_R1.fastq ./raw/${sample_prefix}_R2.fastq ./trim/${sample_prefix}_R1_trim.fastq ./trim/${sample_prefix}_R1_unpaired.fastq ./trim/${sample_prefix}_R2_trim.fastq ./trim/${sample_prefix}_R2_unpaired.fastq HEADCROP:0 LEADING:0 TRAILING:0 SLIDINGWINDOW:5:15 CROP:500 AVGQUAL:0 MINLEN:15

## Mapping chip/input: STAR
STAR --genomeDir ${star_index} --runThreadN 16 --readFilesIn ./trim/${sample_prefix}_R1_trim.fastq ./trim/${sample_prefix}_R2_trim.fastq --outReadsUnmapped Fastx --outFileNamePrefix ./star/${sample_prefix} --outSAMstrandField intronMotif --outSAMtype BAM Unsorted --genomeLoad LoadAndKeep --outFilterMismatchNoverLmax 0.1 --outFilterScoreMinOverLread 0.66 --outFilterMatchNminOverLread 0.66 --outFilterMatchNmin 20 --alignEndsProtrude 10 ConcordantPair --alignMatesGapMax 2000 --limitOutSAMoneReadBytes 10000000 --outMultimapperOrder Random --sjdbOverhang 100 --alignEndsType EndToEnd --alignIntronMax 1 --alignSJDBoverhangMin 999 --outFilterMultimapNmax 1

## Deduplication chip/input: PICARD
java -Xmx4g -jar picard.jar MarkDuplicates I=./star/${sample_prefix}.bam O=./star/${sample_prefix}_nodup.bam REMOVE_DUPLICATES=true VALIDATION_STRINGENCY=LENIENT

## Generate BigWig normalized to mapped reads per sample chip/input: python package deeptools / bamCoverage
bamCoverage -b ./star/${sample_prefix}_nodup.bam -o ./star/${sample_prefix}.bw -p 16 --binSize 25 --smoothLength 75 --normalizeUsing RPKM --outFileFormat bigwig


##
## Repeat the following steps per sample
##

## Call peaks: MACS3
macs3 callpeak --seed 123 --keep-dup all -t ./star/${sample_prefix_treatment}_nodup.bam -g hs --outdir ./macs -n ${sample_prefix_treatment}_fdr0.0001 -q 0.0001 --extsize 200 -f BAMPE 


##
## Combine sample results
##

## Create union peaks
mkdir ./matrix
cat ./macs/*_peaks.bed | bedtools merge -header -d 50 >matrix/union.bed

## Recount union peaks for all samples: Run per sample
mkdir ./matrix/bed_recount/merge
bigWigAverageOverBed ./star/${sample_prefix}.bw ./matrix/union.bed ./matrix/bed_recount/${sample_prefix}.union.counts.txt
cut -f7 ./matrix/bed_recount/${sample_prefix}.union.counts.txt >./matrix/bed_recount/merge/${sample_prefix}

## Merge union peak counts per sample to count matrix
paste ./matrix/bed_recount/merge/* >counts.matrix

## Differential analysis: R with DESeq2 package
## de_analysis.R script has to be adapted to include samples/conditions of the respective dataset
R --vanilla -q < de_analysis.R

## Normalize matrix for downstream plots: R with DESeq2 package -> counts.matrix.norm
deseq_norm.R -m counts.matrix

