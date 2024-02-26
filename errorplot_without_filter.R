#Import dada2
library(dada2); packageVersion("dada2")

# Set path
path <- "/Users/ngan/Desktop/PhD_yr12/Guy/Interviewtasks/BioinformaticPipeline_Env/FASTQs/Example"

# List and sort the sequences
list.files(path, full.names = TRUE)
fnFs <- sort(list.files(path, pattern="_R1_001.fastq", full.names = TRUE))
fnRs <- sort(list.files(path, pattern="_R2_001.fastq", full.names = TRUE))
sample.names <- sapply(strsplit(basename(fnFs), "_"), `[`, 1)

# Plot the graph for each samples
plotQualityProfile(fnFs[1:4])
plotQualityProfile(fnRs[1:4])

# We group F and R sequences together.
# Even we do not want to filter or trim. If there are reads that are not ATCG, quality error plot cannot be mearsures. 
# So we stil do this step with no filtering setting.
filtFs <- file.path(path, "filtered", paste0(sample.names, "_F_filt", seq_along(sample.names), ".fastq.gz"))
filtRs <- file.path(path, "filtered", paste0(sample.names, "_R_filt", seq_along(sample.names), ".fastq.gz"))

out <- filterAndTrim(fnFs, filtFs, fnRs, filtRs, truncLen = 0,
                     maxN = 0, maxEE = Inf, truncQ = 2, minLen = 0,
                     compress = TRUE, multithread = TRUE)
head(out)


# Let's calculate the errors
errF <- learnErrors(filtFs, multithread=TRUE)
errR <- learnErrors(filtRs, multithread=TRUE)

#Import ggplot2
library(ggplot2)

# Plot errors for forward reads
p1 <- plotErrors(errF, nominalQ = TRUE) +
  ggtitle("Errors for Forward Reads")

# Plot errors for reverse reads
p2 <- plotErrors(errR, nominalQ = TRUE) +
  ggtitle("Errors for Reverse Reads")

# Display the plots
print(p1)
print(p2)

