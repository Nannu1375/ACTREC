## Load the library
library(dplyr)
library(readr)

## Set the directory to the count matrix dir
matDir <- "/media/nannu1375/Briefcase/Actrec/Bioinfo/RNA_Seq_Trial/Analysis"

## List all the files
files <- list.files(path = matDir, pattern = "_counts.txt$", full.names = TRUE)

## A function to keep Geneid and counts
read_counts <- function(file) {
  df <- read_tsv(file, comment = "#")
  df <- df[, c(1, ncol(df))]
  colnames(df)[2] <- gsub("_sorted.bam$", "", basename(file))
  return(df)
}

## List out geneid and counts of all files
list_of_counts <- lapply(files, read_counts)

## Combine all the files
all_counts <- Reduce(function(x, y) full_join(x, y, by = "Geneid"), list_of_counts)

## Save final counts file
write_tsv(all_counts, "all_counts.txt")

