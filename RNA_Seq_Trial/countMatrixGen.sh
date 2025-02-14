#!/bin/bash

## Acc list file
Acc_List="/media/nannu1375/Briefcase/Actrec/Bioinfo/RNA_Seq_Trial/SRR_Acc_List.txt"

## BAM files folder
bamFldr="/media/nannu1375/Briefcase/Actrec/Bioinfo/RNA_Seq_Trial/aligned_reads"

## GTF file
gtfFile="/media/nannu1375/Briefcase/Actrec/Bioinfo/RNA_Seq_Trial/refseq/mus_musculus/GCF_000001635.27_GRCm39_genomic.gtf"

## Output file
outFile="/media/nannu1375/Briefcase/Actrec/Bioinfo/RNA_Seq_Trial/Analysis"
mkdir -p "$outFile"

while IFS= read -r ACC; do
	
	## Check if the counts file exists
	if [ -f "${outFile}/${ACC}_counts.txt" ]; then
	    echo "Counts matrix for ${ACC} already exists. Skipping to next..."
	    continue
	fi
	
	## Generation of count matrix
	featureCounts -T 12 \
	-a "$gtfFile" \
	-o "${outFile}/${ACC}_counts.txt" \
	-g gene_id -Q 30 --primary \
	"$bamFldr/${ACC}_sorted.bam"
	
	## Check for errors and exit if fatal error
	if [ $? -ne 0 ]; then
	    echo "Error generating counts for ${ACC}. Critical issue—exiting."
	    exit 1
	fi
done < "$Acc_List"
	
	


