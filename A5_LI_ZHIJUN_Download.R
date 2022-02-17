###Github Link: https://github.com/zazauwu/Rentrez

install.packages("rentrez") #This package provides tools for interacting with Genbank
library(rentrez) #Load the package

ncbi_ids <- c("HQ433692.1","HQ433694.1","HQ433691.1")

Bburg <- entrez_fetch(db = "nuccore", #Download data from NCBI databases, db directly specifies a set of unique identifiers as a numeric or character vector
                      id = ncbi_ids, #Unique ID(s) for records in database db
                      rettype = "fasta") #Use fasta format to get data

Sequences <- strsplit(Bburg, split = "\n\n", fixed = T) #Create a new object called Sequences that contains 3 elements: one for each sequence

print(Sequences)

Sequences <- unlist(Sequences) #Convert "Sequences" from list to dataframe using unlist

header <- gsub("(^>.*sequence)\\n[ATCG].*","\\1",Sequences) #Use regular expressions to separate the sequences from the headers

seq <- gsub("^>.*sequence\\n([ATCG].*)","\\1",Sequences)

Sequences <- data.frame(Name=header,Sequence=seq)

Sequences$Sequence <- gsub("\n", "", Sequences$Sequence) #remove the newline characters from the Sequences data frame using "gsub"

write.csv(Sequences, "A5_LI_ZHIJUN_Sequences.csv", row.names = FALSE)
