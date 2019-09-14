library('tesseract')
image.Data<-ocr("C:/Users/MOLAP/Desktop/AirBnb/chartoftheday_14986_active_airbnb_listings_in_major_cities_n.jpg", engine = tesseract("eng"))
s1<-gsub("[[:punct:]]", "", image.Data)
image.Array<-strsplit(s1,'\n')
image.realData<-image.Array[[1]]
myData<-image.realData[4:15]
CityName<-NULL
activeRental<-NULL
BnbRate<-NULL
for (i in 1 :length(myData)){
  one.Data<-myData[i]
  words <- strsplit(one.Data, " ")[[1]]
  ls<-unique(tolower(words))
  print("--------------")
  for (j in 1 :length(ls)){
    print(ls[j])
  }
  if(i==1)
  {name<-ls[1]
  activeRent<-ls[4]
  dailyRate<-ls[5]
  }
  else if(i==2)
  {name<-ls[1]
  activeRent<-ls[4]
  dailyRate<-ls[6]
  }else if(i==3)
  {name<-paste(ls[1],ls[2])
  activeRent<-ls[5]
  dailyRate<-ls[7]
  }
  else if(i==4){name<-ls[1]
  activeRent<-ls[4]
  dailyRate<-ls[5]
  }else if(i==5)
  {name<-paste(ls[1],ls[2])
  activeRent<-ls[5]
  dailyRate<-ls[7]
  }else if(i==6)
  {name<-ls[1]
  activeRent<-ls[4]
  dailyRate<-ls[5]
  }
  else if(i==7)
  {name<-ls[1]
  activeRent<-ls[4]
  dailyRate<-ls[6]
  }else if(i==8)
  {name<-ls[1]
  activeRent<-ls[4]
  dailyRate<-ls[5]
  }else if(i==9)
  {name<-ls[1]
  activeRent<-ls[4]
  dailyRate<-ls[6]
  }else if(i==10)
  {name<-paste(ls[1],ls[2])
  activeRent<-ls[5]
  dailyRate<-ls[7]
  }else if(i==11)
  {name<-ls[1]
  activeRent<-ls[4]
  dailyRate<-ls[6]
  }else if(i==12)
  {name<-ls[1]
  activeRent<-ls[4]
  dailyRate<-ls[6]
  }
  CityName<-c(CityName,name)
  activeRental<-c(activeRental,activeRent)
  BnbRate<-c(BnbRate,dailyRate)
 # write.csv(name,"C:/Users/MOLAP/Desktop/AirBnb/output/leadingAirbnb.csv",append = TRUE)
    
}
BnB_ID<-c(1:length(activeRental))
BnB_RANK<-c(1:length(activeRental))
datafile<-data.frame(BnB_ID,BnB_RANK,CityName,activeRental,BnbRate)
write.csv(datafile,"C:/Users/MOLAP/Desktop/AirBnb/output/Leading_Bnb_Destinations.csv",row.names = FALSE)

