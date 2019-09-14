library(pdftools)
file<-pdf_text('C:/Users/MOLAP/Desktop/AirBnb/Table View.pdf') 
data<-unlist(strsplit(file,"\n"))
data1<-data[1:22]
MyCsvDta<-NULL
mycol1<-NULL
mycol2<-NULL
mycol3<-NULL
mycol4<-NULL
mycol5<-NULL
mycol6<-NULL
mycol7<-NULL
mycol8<-NULL
mycol9<-NULL
mycol10<-NULL
mycol11<-NULL
mycol12<-NULL
mycol13<-NULL
mycol14<-NULL
mycol15<-NULL
mycol16<-NULL
mycol17<-NULL
mycol18<-NULL
mycol19<-NULL
mycol20<-NULL
mycol21<-NULL
mycol22<-NULL
City<-NULL
Hotel_Price_Index<-NULL
arraylen<-NULL
s1<-gsub("\t", "", data1)
s2<-gsub("\r", "", s1)
s3<-gsub("[[:punct:]]", "", s2)
s4<-gsub("EUREuro", "", s3)
s5<-gsub("Month", "", s4)
s6<-gsub("Multiplevalues", "", s5)
s7<-gsub("City", "", s6)
s8<-gsub("All", "", s7)
s9<-gsub("Region", "", s8)
s10<-gsub("Africa", "", s9)
s11<-gsub("Asia", "", s10)
s12<-gsub("Europe", "", s11)
s13<-gsub("NorthAmerica", "", s12)
s14<-gsub("Oceania", "", s13)
s15<-gsub("Currency", "", s14)
for(i in 1:length(s15))
{
  csvData<-unlist(strsplit(s15[i]," "))
  for(j in 1:length(csvData))
  {
  if(""==csvData[j])
  {
    print("Null found")
  }else
  {
    switch(i,mycol1<-c(mycol1,csvData[j])
           ,mycol2<-c(mycol2,csvData[j]),
           mycol3<-c(mycol3,csvData[j]),
           mycol4<-c(mycol4,csvData[j]),
           mycol5<-c(mycol5,csvData[j]),
           mycol6<-c(mycol6,csvData[j])
           ,mycol7<-c(mycol7,csvData[j]),
           mycol8<-c(mycol8,csvData[j]),
           mycol9<-c(mycol9,csvData[j]),
           mycol10<-c(mycol10,csvData[j])
           ,mycol11<-c(mycol11,csvData[j])
           ,mycol12<-c(mycol12,csvData[j]),
           mycol13<-c(mycol13,csvData[j]),
           mycol14<-c(mycol14,csvData[j]),
           mycol15<-c(mycol15,csvData[j]),
           mycol16<-c(mycol16,csvData[j])
           ,mycol17<-c(mycol17,csvData[j]),
           mycol18<-c(mycol18,csvData[j]),
           mycol19<-c(mycol19,csvData[j]),
           mycol20<-c(mycol20,csvData[j]),
           mycol21<-c(mycol21,csvData[j]),
           mycol22<-c(mycol22,csvData[j]))
  }
  }
  
}

templist <- list(mycol1)
templist[2] <- list(mycol2)
templist[3] <- list(mycol3)
templist[4]<- list(mycol4)
templist[5] <- list(mycol5)
templist[6] <- list(mycol6)
templist[7] <- list(mycol7)
templist[8] <- list(mycol8)
templist[9] <- list(mycol9)
templist[10] <- list(mycol10)
templist[11] <- list(mycol11)
templist[12] <- list(mycol12)
templist[13] <- list(mycol13)
templist[14] <- list(mycol14)
templist[15] <- list(mycol15)
templist[16] <- list(mycol16)
templist[17] <- list(mycol17)
templist[18] <- list(mycol18)
templist[19] <- list(mycol19)
templist[20] <- list(mycol20)
templist[21] <- list(mycol21)
templist[22] <- list(mycol22)
for(k in 2:length(templist))
{
  hotelmeanval=0
 temparray<-templist[[k]]
for(n in 1:length(temparray))
  {
    if(n==1)
    {
      City<-c(City,temparray[n])
      
    }
    else{
     intval<- as.integer(substr(temparray[n],2,4))
      hotelmeanval<-hotelmeanval+intval
     arraylen<- (length(temparray)-1)
    }

}
 Hotel_Price_Index<-c(Hotel_Price_Index,hotelmeanval/arraylen)
}
Location_ID<-c(1:17)
outputData<-data.frame(Location_ID,City,Hotel_Price_Index)

write.csv(outputData,"C:/Users/MOLAP/Desktop/AirBnb/output/HOTEL_PRICE_INDEX.csv" ,row.names = FALSE)