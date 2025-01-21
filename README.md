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

## Normalisation, standardization and scaling.

Let's start with this raw count data from an RNA-seq experiment:

```python
# Raw counts
#         Sample1  Sample2  Sample3  Sample4   Gene Length (kb)
# GeneA    1000     1500     800      1200         2.0
# GeneB    50       80       40       60          1.0
# GeneC    5000     7500     4000     6000        3.0

# Total reads per sample (millions):
# Sample1: 20M, Sample2: 30M, Sample3: 15M, Sample4: 25M
```

Let's apply each transformation method:

1. Normalization (using FPKM):
First, we'll normalize using FPKM to account for both sequencing depth and gene length. The formula is:
(reads × 10⁹) / (total reads × gene length)

For GeneA in Sample1:
```python
# FPKM calculation for GeneA, Sample1:
# (1000 × 10⁹) / (20,000,000 × 2000) = 25 FPKM

# Complete FPKM values:
#         Sample1  Sample2  Sample3  Sample4
# GeneA    25.0     25.0     26.7     24.0
# GeneB    2.5      2.7      2.7      2.4
# GeneC    83.3     83.3     88.9     80.0
```

Notice how after FPKM normalization, the values are more comparable between samples because we've accounted for sequencing depth differences and gene length.

2. Standardization:
Now let's standardize the FPKM values (subtract mean, divide by standard deviation):

```python
# For GeneA:
# Mean = 25.2, Std Dev = 1.1
# Standardized values:
#         Sample1  Sample2  Sample3  Sample4
# GeneA   -0.18    -0.18    1.36    -1.09
# GeneB   -0.58     0.87    0.87    -1.16
# GeneC   -0.18    -0.18    1.36    -1.09
```

After standardization, notice how:
- Values center around 0
- Each value represents how many standard deviations it is from the mean
- Negative values are below average expression
- Positive values are above average expression

3. Scaling (Min-Max to 0-1):
Finally, let's scale the FPKM values to range from 0 to 1:

```python
# For each gene:
# New_value = (value - min) / (max - min)
#         Sample1  Sample2  Sample3  Sample4
# GeneA    0.37     0.37     1.00     0.00
# GeneB    0.17     1.00     1.00     0.00
# GeneC    0.37     0.37     1.00     0.00
```

Key observations about each transformation:

FPKM Normalization:
- Made expression levels comparable between genes of different lengths
- Accounted for different sequencing depths between samples
- Maintained the relative expression relationships
- Values are still in an interpretable range (reads per kilobase per million)

Standardization:
- Centered the data around 0
- Made it easy to identify unusually high/low expression
- Values represent relative expression in terms of standard deviations
- Lost the original scale of expression

Scaling:
- Compressed all values between 0 and 1
- Preserved relative relationships within each gene
- Made it easier to visualize patterns
- Lost information about absolute expression levels

This example shows why you might choose different transformations:
- Use normalization (FPKM) when you need to compare expression levels between genes and samples
- Use standardization when you need to identify outliers or unusual expression patterns
- Use scaling when you need values in a specific range, often for visualization or machine learning
