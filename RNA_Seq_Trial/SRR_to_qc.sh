#!/bin/bash

## Input file for Acc list
Acc_List="/media/nannu1375/Briefcase/Actrec/Bioinfo/RNA_Seq_Trial/SRR_Acc_List.txt"

## Output dir for fastq files
OutDir="/media/nannu1375/Briefcase/Actrec/Bioinfo/RNA_Seq_Trial/raw_reads"
mkdir -p "$OutDir"

## Fetch the sra files
echo "Downloading SRA files..."
parallel -j 8 prefetch {} < "$Acc_List"

## Read Acc list line by line
while IFS= read -r ACC; do
	echo "Downloading FASTQ for $ACC..."
	
	## Convert sra files to fastq
	fasterq-dump "$ACC" --threads 10 -O "$OutDir"
	
	## Compress fastq files to gz
	pigz -p 10 "$OutDir/${ACC}".fastq
	
	## Remove SRA to make space
	rm -f "/media/nannu1375/Briefcase/Actrec/Bioinfo/RNA_Seq_Trial/SRA_cache/sra/${ACC}.sra"

	if [ $? -ne 0 ]; then
	  echo "Error downloading $ACC. Skipping..."
	else
	  echo "Successfully downloaded $ACC."
	fi
done < "$Acc_List"

## Run fastqc on all the raw files using 10 threads
fastqc -t 10 -o "$OutDir"/raw_fastqc	"$OutDir/"*.fastq.gz

## Run multiqc of these raw files
multiqc "$OutDir"/raw_fastqc	-o "$OutDir"/raw_fastqc/raw_multiqc


