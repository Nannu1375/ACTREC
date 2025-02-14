#!/bin/bash

## Acc list file
Acc_List="/media/nannu1375/Briefcase/Actrec/Bioinfo/RNA_Seq_Trial/SRR_Acc_List.txt"

## trimmed files location
trimReads="/media/nannu1375/Briefcase/Actrec/Bioinfo/RNA_Seq_Trial/trimmed_reads"

## Reference sequence
refSeq="/media/nannu1375/Briefcase/Actrec/Bioinfo/RNA_Seq_Trial/refseq/mus_musculus/index_files/mm10_index"

## Sam file
alignDir="/media/nannu1375/Briefcase/Actrec/Bioinfo/RNA_Seq_Trial/aligned_reads"
mkdir -p "$alignDir"

while IFS= read -r ACC; do
	start_time=$(date +"%d-%m-%Y %H:%M:%S")
    	echo "[$start_time] Aligning $ACC to reference genome..."
	
	## Check if trimmed file exists
    	if [ ! -f "$trimReads/${ACC}_trimmed.fastq.gz" ]; then
		echo "Error: File $trimReads/${ACC}_trimmed.fastq.gz not found. Skipping..."
		continue
    	fi
    	
	## Check if output already exists to prevent reruns
	if [ -f "$alignDir/${ACC}_aligned.sam" ]; then
		echo "[$start_time] Alignment for $ACC already exists. Skipping..."
		continue
	fi
	
	## Check if BAM already exists
    	if [ -f "$alignDir/${ACC}_sorted.bam" ]; then
        	echo "[$start_time] BAM for $ACC already exists. Skipping..."
        	continue
    	fi
	
	## Align the reads using hisat2
	echo "Aligning $ACC"
	hisat2 -p 12 \
	-x "$refSeq" \
	-U "$trimReads/${ACC}_trimmed.fastq.gz" \
	-S "$alignDir/${ACC}_aligned.sam"
	
	## Check alignment success
	if [ $? -ne 0 ]; then
	  echo "Error aligning $ACC. Try again..."
	else
	  echo "Successfully aligned $ACC."
	fi
	
	## SAM to BAM conversion and sorting
	echo "Converting $ACC SAM to BAM and sorting."
	samtools view -@ 12 -bS "$alignDir/${ACC}_aligned.sam" | \
	samtools sort -@ 12 -o "$alignDir/${ACC}_sorted.bam"
	if [ -f "$alignDir/${ACC}_sorted.bam" ]; then
	    rm "$alignDir/${ACC}_aligned.sam"
	fi
	
	 ## Check BAM conversion success
    	if [ $? -ne 0 ]; then
            echo "[$start_time] Error converting $ACC SAM to BAM."
       	    continue
    	fi
    	
    	## Index the BAM file
    	echo "[$start_time] Indexing BAM for $ACC..."
    	samtools index -@ 12 "$alignDir/${ACC}_sorted.bam"
    	
    	## Check BAM indexing success
    	if [ $? -ne 0 ]; then
        	echo "[$start_time] Error indexing BAM for $ACC."
        	continue
    	fi
    	
    	
    	
    	echo "[$start_time] DONE PROCESSING $ACC"
	
done < "$Acc_List"
	
	
