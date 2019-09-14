library(gtools)
library(Jmisc)
options(max.print = 999999999)

#Read List
df1<-read.csv("C:/Users/MOLAP/Desktop/AirBnb/data/new york/listings.csv")
df2<-read.csv("C:/Users/MOLAP/Desktop/AirBnb/data/london/listings.csv")
df3<-read.csv("C:/Users/MOLAP/Desktop/AirBnb/data/paris/listings.csv")
df4<-read.csv("C:/Users/MOLAP/Desktop/AirBnb/data/Rio de janerio/listings.csv")
df5<-read.csv("C:/Users/MOLAP/Desktop/AirBnb/data/rome/listings.csv")
df6<-read.csv("C:/Users/MOLAP/Desktop/AirBnb/data/sydney/listings.csv")

#read Calender
cl1<-read.csv("C:/Users/MOLAP/Desktop/AirBnb/data/calender/london/calendar.csv")
cl2<-read.csv("C:/Users/MOLAP/Desktop/AirBnb/data/calender/rome/calendar.csv")
cl3<-read.csv("C:/Users/MOLAP/Desktop/AirBnb/data/calender/new york/calendar.csv")
cl4<-read.csv("C:/Users/MOLAP/Desktop/AirBnb/data/calender/paris/calendar.csv")
cl5<-read.csv("C:/Users/MOLAP/Desktop/AirBnb/data/calender/Rio de janerio/calendar.csv")
cl6<-read.csv("C:/Users/MOLAP/Desktop/AirBnb/data/calender/sydney/calendar.csv")

#2:19,21,25:28,30:36,38:41,43:48,51,59:60,62:76,78,79,87:90,91:95
#2:19,21:22,24:26,28,30:36,38,40:48,51,54:60,62:79,81:84,86:91,93:96
Data1 <- subset( df1, select = -c(2:19,21:22,24:26,28,30:36,38,40:48,51,54:60,62:79,81:84,86:91,93:96 ) )
Data2 <- subset( df2, select = -c(2:19,21:22,24:26,28,30:36,38,40:48,51,54:60,62:79,81:84,86:91,93:96 ) )
Data3 <- subset( df3, select = -c(2:19,21:22,24:26,28,30:36,38,40:48,51,54:60,62:79,81:84,86:91,93:96) )
Data4 <- subset( df4, select = -c(2:19,21:22,24:26,28,30:36,38,40:48,51,54:60,62:79,81:84,86:91,93:96 ) )
Data5 <- subset( df5, select = -c(2:19,21:22,24:26,28,30:36,38,40:48,51,54:60,62:79,81:84,86:91,93:96 ) )
Data6 <- subset( df6, select = -c(2:19,21:22,24:26,28,30:36,38,40:48,51,54:60,62:79,81:84,86:91,93:96) )

Data11<-addCol(Data1,value=c("market"="newyork"))
Data12<-addCol(Data2,value=c("market"="london"))
Data13<-addCol(Data3,value=c("market"="paris"))
Data14<-addCol(Data4,value=c("market"="Rio riodejaneiro"))
Data15<-addCol(Data5,value=c("market"="rome"))
Data16<-addCol(Data6,value=c("market"="sydney"))

calender1<-addCol(cl1,value=c("market"="london" ))
calender2<-addCol(cl2,value=c("market"="rome"))
calender3<-addCol(cl3,value=c("market"="newyork"))
calender4<-addCol(cl4,value=c("market"="paris"))
calender5<-addCol(cl5,value=c("market"="Rio riodejaneiro"))
calender6<-addCol(cl6,value=c("market"="sydney"))


Data21<-smartbind(Data11, Data12)
Data22<-smartbind(Data13, Data14)
Data23<-smartbind(Data15, Data16)
Data24<-smartbind(Data21, Data22)
Data25<-smartbind(Data24, Data23)


Calender_ID<-c(1:nrow(calender1))
calenderDF1<-data.frame(Calender_ID,calender1)
Calender_ID<-c( 27559691:38397635)
calenderDF2<-data.frame(Calender_ID,calender2)
Calender_ID<-c(38397636:56727935)
calenderDF3<-data.frame(Calender_ID,calender3)
Calender_ID<-c(56727936:79607595)
calenderDF4<-data.frame(Calender_ID,calender4)
Calender_ID<-c(79607596:93202020)
calenderDF5<-data.frame(Calender_ID,calender5)
Calender_ID<-c(93202021:105549605)
calenderDF6<-data.frame(Calender_ID,calender6)

write.csv(calenderDF1,"C:/Users/MOLAP/Desktop/AirBnb/output/Calender/CalenderDetail_1.csv",row.names = FALSE)
write.csv(calenderDF2,"C:/Users/MOLAP/Desktop/AirBnb/output/Calender/CalenderDetail_2.csv",row.names = FALSE)
write.csv(calenderDF3,"C:/Users/MOLAP/Desktop/AirBnb/output/Calender/CalenderDetail_3.csv",row.names = FALSE)
write.csv(calenderDF4,"C:/Users/MOLAP/Desktop/AirBnb/output/Calender/CalenderDetail_4.csv",row.names = FALSE)
write.csv(calenderDF5,"C:/Users/MOLAP/Desktop/AirBnb/output/Calender/CalenderDetail_5.csv",row.names = FALSE)
write.csv(calenderDF6,"C:/Users/MOLAP/Desktop/AirBnb/output/Calender/CalenderDetail_6.csv",row.names = FALSE)

write.csv(Data25,"C:/Users/MOLAP/Desktop/AirBnb/output/listings.csv", row.names = FALSE)

DatasetHost<-subset(Data25,select = c(2:6,16))
DatasetList<-subset(Data25,select = c(1:2,7:12,15:16))
names(DatasetList)[1]<-"List_ID"
DatasetReview<-subset(Data25,select = c(1,13:14))
names(DatasetReview)[1]<-"List_ID"
Review_ID<-c(1:nrow(DatasetReview))
DataSetFinalReviews<-data.frame(Review_ID,DatasetReview)
#HOST_UNIQE_ID<-c(1:nrow(DatasetHost))
#DataSetFinalHOST<-data.frame(HOST_UNIQE_ID,DatasetHost)
write.csv(DatasetHost,"C:/Users/MOLAP/Desktop/AirBnb/output/Host_Details.csv", row.names = FALSE)
write.csv(DatasetList,"C:/Users/MOLAP/Desktop/AirBnb/output/Listing_Details.csv", row.names = FALSE)
write.csv(DataSetFinalReviews,"C:/Users/MOLAP/Desktop/AirBnb/output/Review_Details.csv", row.names = FALSE)


