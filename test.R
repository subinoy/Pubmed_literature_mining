search_topic <- 'Metabolism of diazepam and selective serotonin re-uptake inhibitors'
search_query <- EUtilsSummary(search_topic, retmax=10000, mindate=2000,maxdate=2017)
summary(search_query)
# see the ids of our returned query
QueryId(search_query)
typeof(search_query)
str(search_query)
search_query@PMID[1]
