rm(list=ls())


setwd("M:/pc/Dokumenter/dataseminar")

####PRØVE I R##

##Oppgave 1. 

biff <-read.csv("steak_survey.csv", stringsAsFactors = FALSE)

View(biff)
summary(biff)

##Oppgave 2.

barplot(table(biff$steak_prep))

#Medium rare er variabelen som har høyest frekvens

##Oppgave 3.


biff$steak_prep2 <- ifelse(biff$steak_prep == "Rare", "Medium rare", Rare, "Medium", Medium, "Medium well", "Well", Well
                           , biff$steak_prep)
                             
#Får ikke denne til, ville sjekket om det var riktig slik:

table(biff$steak_prep, biff$steak_prep2, useNA = "always")

##Oppgave 4.

#Får her følgefeil, men prøver

biff$steak_prep2 <- factor(biff$steak_prep, levels=c())


                             
##Oppgave 5.

cor(biff$smoke, biff$alcohol, use = "complete.obs")
  
# Korrelasjonen mellom alkohol og røyk er 0.098. 
# dersom det var flere enn to variabler ville man håndtert missing med listwise og pairwise exclusion


##Oppgave 6. 

#Da jeg ikke klarte å kode om variablene får jeg problemer videre. Bruker den opprinnelige variabelen.

library(ggplot2)

ggplot(biff, aes(x=biff$steak_prep, y=biff$age)) + geom_boxplot()

# Det er Medium som har den laveste medianen 


#Oppgave 7.

library(nnet)

biff_reg <-multinom(steak_prep ~ age + hhold_income + smoke + alcohol, data=biff, na.action = "na.exclude", Hess = TRUE)

summary(biff_reg)




#Oppgave 8.

confint(biff_reg)

#Smoke er signifikant på 5%


#Oppgave 9.

biff$pred <- predict(biff_reg)
biff$resid<- resid(biff_reg)

summary(biff_reg)

#Fikk ikke tid til å gjøre det med alle kategoriene. 

table(biff$pred, biff_reg$steak_prep)


#Jeg får masse følgefeil i denne prøven. Fullstendig hjerneteppe og altfor liten tid. 









