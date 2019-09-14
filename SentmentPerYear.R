# Configure JAVA and Libraries
Sys.setenv ( JAVA_HOME ='C:\\ Program Files \\ Java \\ jre1.8.0_151')
library (rJava)
library (jsonlite)
library (rvest)
library (syuzhet)
library(gtools)
library(Jmisc)


Reviews<-NULL
years<-NULL
totals<-NULL
positives<-NULL
negatives<-NULL
neutrals<-NULL
for(year in 2008:2018)
{
s<-NULL
for ( i in 1:50) {
  house<-"uk"
  url = paste("https://content.guardianapis.com/search?q=,Airbnb&api-key=8709ced8-c7df-404d-921e-07eb5a477684&page-size=50&order-by=relevance&show-fields=body&production-office=",house,sep ="") 
  url1 = paste(url,"&from-date=" , sep ="")
  FromDate<-paste(year,"-01-01",sep = "")
  url2 = paste(url1,FromDate , sep ="")
  url3 = paste(url2,"&to-date=" , sep  ="")
  ToDate<-paste(year,"-12-31",sep = "")
  url4 = paste(url3,ToDate , sep  ="")
  url5=paste(url4,"&page=",sep="")
  url6=paste(url5,i,sep="")
  tryCatch({
    content <- fromJSON (url6 , flatten = TRUE )
    tmp = as.data.frame(content)
    ifelse(i!=1,s <- smartbind (s,tmp),s<-tmp)
    
  }, error = function(err) {
    
    return()
    
  }, finally = {
  })
}

cleanFun <- function ( htmlString ) {
  return ( gsub(" <.*? >", "", htmlString ) )
}
cleanone <- sapply(s$response.results.fields.body,function(row) iconv(row, "latin1", "ASCII", sub=""))
# Clear whitespaces

s$bodyCleaned = trimws(cleanFun(cleanone))
# Perform NRC Sentiment Analysis
#mysentiment_review <- get_nrc_sentiment((s$bodyCleaned ))
sent.value<- get_sentiment (s$bodyCleaned )

most.positive <- s$bodyCleaned[sent.value == max(sent.value)]
most.negative <- s$bodyCleaned[sent.value <= min(sent.value)] 
positive.tweets <- s$bodyCleaned[sent.value > 0]
negative.tweets <- s$bodyCleaned[sent.value < 0]
neutral.tweets <- s$bodyCleaned[sent.value == 0] 

total = length(positive.tweets) + length(negative.tweets) + length(neutral.tweets)

positives<-c(positives,(length(positive.tweets)))
negatives<-c(negatives,(length(negative.tweets)))
neutrals<-c(neutrals,(length(neutral.tweets)))
years<-c(years,year)

Reviews<-c(Reviews,Review)
s$bodyCleaned<-NULL
}

sentiments<-data.frame(years,positives,negatives,neutrals)
sentiments_final<-addCol(sentiments,value=c("market"="london"))
write.csv( sentiments_final,"C:/Users/MOLAP/Desktop/AirBnb/output/sentiment-analysis_uk.csv",row.names = FALSE )
ggplot(sentiments, aes(x=years,y = neutrals)) +geom_bar(stat = "identity")
ggplot(sentiments, aes(x=years,y = negatives)) +geom_bar(stat = "identity")
ggplot(sentiments, aes(x=years,y = positives)) +geom_bar(stat = "identity")
ggplot(sentiments, aes(x=years,y = positives)) +geom_line()
ggplot(sentiments, aes(x=as.integer(years),y = positives,fill = factor(negatives))) +geom_bar(stat = "identity")
