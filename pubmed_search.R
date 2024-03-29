#install the RISmed package
install.packages("RISmed")
library(RISmed)

#now let's look up this dude called Dave Tang
res <- EUtilsSummary('dave tang', type='esearch', db='pubmed')

summary(res)
# Query:
#     Tang, Dave[Full Author Name] 
# 
# Result count:  10

#what are the PubMed ids for the Author Dave Tang?
QueryId(res)
# [1] "23180801" "22976001" "22722852" "21888672" "21386911" "20510229" "19648138" "19501082" "19393063"
# [10] "19270757"

#limit by date
res2 <- EUtilsSummary('dave tang', type='esearch', db='pubmed',
                      mindate='2012', maxdate='2012')

# summary(res2)
# Query:
#     Tang, Dave[Full Author Name] AND 2012[EDAT] : 2012[EDAT] 
# 
# Result count:  3

#three publications in 2012
QueryId(res2)
[1] "23180801" "22976001" "22722852"
# 
#  ------------------------------------------
#first how many total articles containing retrotransposon
res3 <- EUtilsSummary('retrotransposon', type='esearch', db='pubmed')


summary(res3)
# Query:
#     "retroelements"[MeSH Terms] OR "retroelements"[All Fields] 
# OR "retrotransposon"[All Fields] 
# 
# Result count:  8123

# AUTISM
res_autism <- EUtilsSummary('autism', type='esearch', db='pubmed')
summary(res_autism)

res_autism2 <- EUtilsSummary('autism and diazepam', type='esearch', db='pubmed')
summary(res_autism2)
#if you only want the number of articles



QueryCount(res3)
# [1] 8123

#tally each year beginning at 1970
#In order not to overload the E-utility servers, NCBI recommends that users post no more than three
#URL requests per second and limit large jobs to either weekends or between 9:00 PM and 5:00 AM
#Eastern time during weekdays. Failure to comply with this policy may result in an IP address being
#blocked from accessing NCBI.

tally <- array()
x <- 1
for (i in 1970:2013){
    Sys.sleep(1)
    r <- EUtilsSummary('retrotransposon', type='esearch',
                       db='pubmed', mindate=i, maxdate=i)
    tally[x] <- QueryCount(r)
    x <- x + 1
}

names(tally) <- 1970:2013
max(tally)
# [1] 573

barplot(tally, las=2, ylim=c(0,600), 
        main="Number of PubMed articles containing retrotransposon")

# How about the word "transposon"?
transposon <- array()
x <- 1
for (i in 1970:2013){
    Sys.sleep(1)
    r <- EUtilsSummary('transposon', type='esearch', db='pubmed', mindate=i, maxdate=i)
    transposon[x] <- QueryCount(r)
    x <- x + 1
}

names(transposon) <- 1970:2013
max(transposon)
# [1] 1634

barplot(transposon, las=2, ylim=c(0,2000),
        main="Number of PubMed articles containing transposon")

# Is there an upward trend for any keyword, due to the increase in the number 
# of journals and database entries?
trna <- array()
x <- 1
for (i in 1970:2013){
    Sys.sleep(1)
    r <- EUtilsSummary('trna', type='esearch', db='pubmed',
                       mindate=i, maxdate=i)
    trna[x] <- QueryCount(r)
    x <- x + 1
}

names(trna) <- 1970:2013
max(trna)
# [1] 2015

barplot(trna, las=2, ylim=c(0,2000),
        main="Number of PubMed articles containing trna")


# Normalising by total article counts
# 
# To get the total number of articles for a given year, 
# just use an empty query.

test <- EUtilsSummary('', type='esearch', db='pubmed', mindate=1970, maxdate=1970)
summary(test)
# Query:
#     1970[EDAT] : 1970[EDAT] 
# 
# Result count:  218690

#number of articles each year
total <- array()
x <- 1
for (i in 1970:2013){
    Sys.sleep(1)
    r <- EUtilsSummary('', type='esearch', db='pubmed',
                       mindate=i, maxdate=i)
    total[x] <- QueryCount(r)
    x <- x + 1
}

names(total) <- 1970:2013
max(total)
# [1] 917657

barplot(total, las=2, ylim=c(0,1000000), 
        main="Number of PubMed articles each year")

# Now to normalise the previous searches:
tally_norm <- tally / total
transposon_norm <- transposon / total
trna_norm <- trna / total

par(mfrow=c(1,3))
barplot(tally_norm, las=2)
barplot(transposon_norm, las=2)
barplot(trna_norm, las=2)
#reset
par(mfrow=c(1,1))