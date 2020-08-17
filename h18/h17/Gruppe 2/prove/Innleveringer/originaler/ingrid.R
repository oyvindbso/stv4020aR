setwd("M:/pc/Dokumenter/R SEMINAR/")

rm(list = ls())

# oppgave 1 
library(haven)

steak <- read.csv("http://folk.uio.no/martigso/encrypt/steak_survey.csv")

# oppgave 2 

table(steak$steak_prep)

steak_prep <- table(steak$steak_prep)
                    
barplot(steak_prep) 

# medium rare har høyest frekvens 

# oppgave 3 
# ny variabel
# steak_prep2 med "rare" når steak_prep er "rare" eller "medium rare"
# "medium" når steak prep er medium
# "well" når steak prep er "medium well" eller "well" 
# dette ble bare tull, men prøver å gå videre 

steak_prep2 <- steak$steak_prep

steak$steak_prep2[which(steak$steak_prep == "Rare")] <- Rare
steak$steak_prep2[which(steak$steak_prep == "Medium Rare")] <- Rare 
steak$steak_prep2[which(steak$steak_prep == "Medium")] <- Medium
steak$steak_prep2[which(steak$steak_prep == "Medium Well")] <- Well
steak$steak_prep2[which(steak$steak_prep == "Well")] <- Well

steak_prep2[steak_prep2 == "Rare"] <- Rare 
steak_prep2[steak_prep2 == "Medium Rare"] <- Rare
steak_prep2[steak_prep2 == "Medium"] <- Medium
steak_prep2[steak_prep2 == "Medium Well"] <- Well 
steak_prep2[steak_prep2 == "Well"] <- Well 

table(steak_prep2)
table(steak$steak_prep)

# oppgave 4 
# gjøre om steak_prep2 til en factor, med "medium" som referansekategori (flest respondenter)

steak_prep2 <- as.factor(steak)

steak$steak_prep2[which(steak$steak_prep2 == "Medium")] <- 0
steak$steak_prep2[which(steak$steak_prep2 == "Well")] <- 1

# alt over gikk som du ser til helvete, men prøver videre :) 

# oppgave 5 
# korrelasjonen mellom smoke og alcohol er 0.098 

cor(steak[, c ("smoke", "alcohol")], use = "pairwise.complete.obs")

# oppgave 6
# boxplot med steak_prep2 på x-aksen og age på y-aksen

library(ggplot2)

ggplot(steak, aes(x = steak_prep2, y = age)) +
  geom_boxplot()

# hvilken kategori har lavest median? medium rare har lavest median

# oppgave 7
# estimere multinomisk logistisk regresjon
# med steak_prep2 som avhengig
# age, hhold_income, smoke og alcohol som uavhengige variabel

library(nnet)

steak_log <- multinom(steak_prep2 ~ age + hhold_income + smoke + alcohol, data = steak)

summary(steak_log)

# oppgave 8
# konfidensintervallene på 5% nivå sjekkes med confint-funksjonen
# effekten av age er ikke signifikant på 5% nivå 

confint(steak_log)

# oppgave 9
# predikterte kategorier for regresjonen i oppgave 6(7?)

table(predict(steak_log))

# oppgave 10
# test-set 

test.set <- data.frame (age = 18:90,
                      hhold_income = median(steak$hhold_income), 
                       smoke = 0, 
                       alcohol = 1)




