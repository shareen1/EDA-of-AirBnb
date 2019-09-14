# Configure JAVA and Libraries
Sys.setenv ( JAVA_HOME ='C:\\ Program Files \\ Java \\ jre1.8.0_151')
library (rJava)
library (jsonlite)
library (rvest)
library (syuzhet)
library(gtools)
library(Jmisc)

#content <- fromJSON ("https://content.guardianapis.com/search?q=,Airbnb&from-date=2012-01-01&to-date=2012-12-31&api-key=8709ced8-c7df-404d-921e-07eb5a477684&page-size=50&order-by=relevance&,show-fields=body&production-office=uk&page=1", flatten = TRUE )
#ts = as.data.frame(content)
#s<-addCol(ts,value=c("response.results.fields.body"="" ))
s<-NULL


for ( i in 1:50) {
  url = paste("https://content.guardianapis.com/search?q=,Airbnb&from-date=2008-01-01&to-date=2008-12-31&api-key=8709ced8-c7df-404d-921e-07eb5a477684&page-size=50&order-by=relevance&show-fields=body&production-office=uk&page=",i,sep ="")
  tryCatch({
    content <- fromJSON (url , flatten = TRUE )
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
mysentiment_review <- get_nrc_sentiment((s$bodyCleaned ))
x <- get_sentiment (s$bodyCleaned )
bing <- get_sentiment (s$bodyCleaned , method ="bing")
nrc <- get_sentiment (s$ bodyCleaned , method ="nrc")
afinn <- get_sentiment ( s$bodyCleaned , method ="afinn")
t = as.data.frame ( mysentiment_review $ anger )
t$ anticipation = mysentiment_review$anticipation
t$ disgust = mysentiment_review$disgust
t$ fear = mysentiment_review$fear
t$ joy = mysentiment_review$joy
t$ sadness = mysentiment_review$sadness
t$ surprise = mysentiment_review $ surprise
t$ trust = mysentiment_review $ trust
t$ negative = mysentiment_review $ negative
t$ positive = mysentiment_review $ positive
t$ nrc = nrc
t$ bing = bing
t$ afinn = afinn
t$ sentiments = x
sentiments = as.data.frame ( lapply (t, rep , 166) )
s<-addCol(sentiments,value=c("Year"="2008" ))
end_limit<-(178118+nrow(sentiments))
SENTIMENT_ID<-c(178119:end_limit)
sentiments_final<-data.frame(SENTIMENT_ID,s)
write.csv( sentiments_final,"C:/Users/MOLAP/Desktop/AirBnb/output/sentiment-analysis/sentiment-analysis_2008.csv",row.names = FALSE )
