#install.packages("RISmed")
library(RISmed)
library(rmarkdown)
search_topic <- 'selective serotonin reuptake inhibitors and autism'
search_query <- EUtilsSummary(search_topic, retmax=10000)
summary(search_query)

# see the ids of our returned query
QueryId(search_query)

# get actual data from PubMed
records<- EUtilsGet(search_query)
class(records)

# store it
pubmed_data <- data.frame('PMID'=search_query@PMID, 'Title'=ArticleTitle(records),
                          'Abstract'=AbstractText(records))
head(pubmed_data,1)

pubmed_data$Abstract <- as.character(pubmed_data$Abstract)
pubmed_data$Abstract <- gsub(",", " ", pubmed_data$Abstract, fixed = TRUE)

# see what we have
str(pubmed_data)


write.csv(pubmed_data, file='file_8_SSRI_and_autism.csv')
write.csv(pubmed_data, file='file_10_SSRI_and_autism.csv')

# Function added for extracting the search query from Pubmed database
pub_extract <- function(search_text){
    
    require(RISmed)
    search_topic <- search_text
    search_query <- EUtilsSummary(search_topic, retmax=10000, mindate=2000,maxdate=2017)
    # summary(search_query)
    
    # see the ids of our returned query
    QueryId(search_query)
    
    # get actual data from PubMed
    records<- EUtilsGet(search_query)
    # class(records)
    
    # store it
    pubmed_data <- data.frame('PMID'=search_query@PMID, 'Title'=ArticleTitle(records),
                              'Abstract'=AbstractText(records))
    # head(pubmed_data,1)
    
    pubmed_data$Abstract <- as.character(pubmed_data$Abstract)
    pubmed_data$Abstract <- gsub(",", " ", pubmed_data$Abstract, fixed = TRUE)
    
    return (pubmed_data)
    
}

mq <- pub_extract("serotonin specific re-uptake inhibitors and autism")
str(pub_extract)
mq
write.csv(mq, file='file_9_SSRUI_and_autism.csv')

mq_10 <- pub_extract("serotonin specific reuptake inhibitors and autism")
