#!/bin/bash

## Input file for Acc list
Acc_List="/media/nannu1375/Briefcase/Actrec/Bioinfo/RNA_Seq_Trial/Multiple_AccNo.txt"

## Output dir for fastq files
OutDir="/media/nannu1375/Briefcase/Actrec/Bioinfo/RNA_Seq_Trial/SRR_fastq"
mkdir -p "$OutDir"

## Read Acc list line by line
while IFS= read -r ACC; do
	echo "Downloading FASTQ for SRR$ACC..."
	fasterq-dump "SRR$ACC" -O "$OutDir" --split-files
	if [ $? -ne 0 ]; then
	  echo "Error downloading SRR$ACC. Skipping..."
	else
	  echo "Successfully downloaded SRR$ACC."
	fi
done < "$Acc_List"

