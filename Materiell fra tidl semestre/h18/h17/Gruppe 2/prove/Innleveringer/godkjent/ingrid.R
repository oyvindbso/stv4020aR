setwd("M:/pc/Dokumenter/R SEMINAR/")

rm(list = ls())

# oppgave 1 
library(haven)

steak <- read.csv("http://folk.uio.no/martigso/encrypt/steak_survey.csv")

# KOMMENTAR: Flott!

# oppgave 2 

table(steak$steak_prep)

steak_prep <- table(steak$steak_prep)
                    
barplot(steak_prep) 

# medium rare har høyest frekvens 

# KOMMENTAR: Flott!

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

# KOMMENTAR: Dette ble ikke helt riktig. Løsning:
steak$steak_prep2 <- NA
steak$steak_prep2[which(steak$steak_prep == "Rare" | steak$steak_prep == "Medium rare")] <- "Rare"
steak$steak_prep2[which(steak$steak_prep == "Medium")] <- "Medium"
steak$steak_prep2[which(steak$steak_prep == "Medium Well" | steak$steak_prep == "Well")] <- "Well"

table(steak$steak_prep, steak$steak_prep2, useNA = "always")

# oppgave 4 
# gjøre om steak_prep2 til en factor, med "medium" som referansekategori (flest respondenter)

steak_prep2 <- as.factor(steak)

steak$steak_prep2[which(steak$steak_prep2 == "Medium")] <- 0
steak$steak_prep2[which(steak$steak_prep2 == "Well")] <- 1

# alt over gikk som du ser til helvete, men prøver videre :) 

# KOMMENTAR: Tappert forsøk! Løsning (gitt riktig oppgave 3):
steak$steak_prep2 <- factor(steak$steak_prep2, levels = c("Rare", "Medium", "Well"))


# oppgave 5 
# korrelasjonen mellom smoke og alcohol er 0.098 

cor(steak[, c ("smoke", "alcohol")], use = "pairwise.complete.obs")

# KOMMENTAR: Flott!

# oppgave 6
# boxplot med steak_prep2 på x-aksen og age på y-aksen

library(ggplot2)

ggplot(steak, aes(x = steak_prep2, y = age)) +
  geom_boxplot()

# hvilken kategori har lavest median? medium rare har lavest median

# KOMMENTAR: Flott! Men ser ut som "Medium" har lavest hos meg?

# oppgave 7
# estimere multinomisk logistisk regresjon
# med steak_prep2 som avhengig
# age, hhold_income, smoke og alcohol som uavhengige variabel

library(nnet)

steak_log <- multinom(steak_prep2 ~ age + hhold_income + smoke + alcohol, data = steak)

summary(steak_log)

# KOMMENTAR: Flott! Men mangler tolkning.

# oppgave 8
# konfidensintervallene på 5% nivå sjekkes med confint-funksjonen
# effekten av age er ikke signifikant på 5% nivå 

confint(steak_log)

# KOMMENTAR: Flott!

# oppgave 9
# predikterte kategorier for regresjonen i oppgave 6(7?)

table(predict(steak_log))

# KOMMENTAR: Ikke helt riktig. Løsning (men gitt "na.exclude" i regresjonen over):
steak$pred <- predict(steak_log)
table(steak$pred, steak$steak_prep2)


# oppgave 10
# test-set 

test.set <- data.frame (age = 18:90,
                      hhold_income = median(steak$hhold_income), 
                       smoke = 0, 
                       alcohol = 1)




# KOMMENTAR: Denne ble dessverre ikke riktig.