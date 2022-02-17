###Github Link: https://github.com/zazauwu/Rentrez

###1. Using what you have learned, make a new script called COVIDgenome.

library(rentrez)
library(dplyr)

ncbi_id <- "NC_045512.2" #Download the SARS-CoV-2 reference genome from Genbank
Cov2 <- entrez_fetch(db = "nuccore", #Download data from NCBI databases, db directly specifies a set of unique identifiers as a numeric or character vector
                      id = ncbi_id, #Unique ID(s) for records in database db
                      rettype = "fasta") #Use fasta format to get data

CovSeq <- strsplit(Cov2, split = "\n\n", fixed = T) #Create a new object called CovSeq

print(CovSeq)

CovSeq <- unlist(CovSeq) #Convert "CovSeq" from list to dataframe using unlist

header <- gsub("(^>.*genome)\\n[ATCG].*","\\1", CovSeq) #Use regular expressions to separate the genome sequence from the headers
seq <- gsub("^>.*genome\\n([ATCG].*)","\\1", CovSeq)
CovSeq <- data.frame(Name = header, Sequence = seq)
CovSeq$Sequence <- gsub("\n", "", CovSeq$Sequence #remove the newline characters from the Sequence data frame using "gsub"

###2. Use regular expressions in R to isolate the S protein from the genome you downloaded
                        
CovSeq <- CovSeq %>%
  mutate(Sprotein = gsub(".*(ATGTTTGTTTTTCTTGTTTTA)(.*)(GTCAAATTACATTACACATAA).*", "\\1 \\2 \\3", Sequence))

write.csv(CovSeq, "A5_LI_ZHIJUN_COVID.csv", row.names = FALSE)

###3. BLAST search in your web browser. 
According to these tab 'Descriptions', 'Graphic Summary', and 'Alignments', I think this gene is highly conserved with an E value of 0, alignment scores greater than 200, and a 100% query cover across all 100 found sequences.
For E is the number of similar size scores expected to be in database by chance alone and the alignment program is used to find clusters of similarity within the protein, these sequences are highly related and have a unique conserved domain. 
