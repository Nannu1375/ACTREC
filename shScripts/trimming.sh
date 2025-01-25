#!/bin/bash

## Script to iterate through files and trim the reads

## List to mention the names of the files
genes=("WT" "Toll" "Pirk" "ND42" "FoxO" "Atg8")

## Input folder
inputFolder="/scratch/khadilkarlab/Nawaneetan/raw_reads/"

## Output folder
outFolder="/scratch/khadilkarlab/Nawaneetan/trimmed_reads/"

## Iterate through each gene in the list
for gene in "${genes[@]}"; do
    echo "Trimming $gene..."
    
    ## Checking existence of files before trimming
    if [ ! -f "$inputFolder$gene"_R1.fastq.gz ] || [ ! -f "$inputFolder$gene"_R2.fastq.gz ]; then
      echo "Input files for $gene not found. Skipping..."
      continue ## Skips to next gene
    fi
    
    ## Run trimmomatic to trim forward and reverse reads, gene by gene
    trimmomatic PE "$inputFolder$gene"_R1.fastq.gz "$inputFolder$gene"_R2.fastq.gz "$outFolder$gene"_fw_paired.fastq.gz "$outFolder$gene"_fw_unpaired.fastq.gz "$outFolder$gene"_rev_paired.fastq.gz "$outFolder$gene"_rev_unpaired.fastq.gz ILLUMINACLIP:TruSeq3-PE.fa:2:30:10:2:True LEADING:3 TRAILING:3 MINLEN:36
    
    ## Check if trimming was successful
    if [ $? -ne 0 ]; then
       echo "$gene could not be trimmed"
     else
       echo "Finished trimming $gene"
     fi
done
      
