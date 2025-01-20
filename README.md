This repository contains all my trial small projects in R while working in ACTREC. It is not related to any projects (as of 12th Jan, 2024) that i am working on and is purely a repo of all my learnings during this tenure extracurricularly.

## Questions and Answers
1. What is a count matrix?
    Count matrix refers to a table of data, where the rows represent different genes that have been looked into, and the columns represent the different conditions that they have been looked into. The column can be from different samples or     even can be replicates of the same sample.

2. How is a count matrix generated?

    Count matrix is generated through few steps
    
    1. Retrieve the .fastq file.
    2. Pre-process it through trimming of the reads generated.
    3. Sequence alignment with reference sequence.
    4. Counting number of reads aligned to specific genes of interest onto the reference sequence (also known as feature counting).
    
    Thus, a count matrix is generated.
