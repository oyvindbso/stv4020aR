getwd()
setwd("M:/pc/dokumenter/Rseminar2AneJuul")

## Oppgave1 ##

steak <- read.csv("http://folk.uio.no/martigso/encrypt/steak_survey.csv")

#oppretter et objekt for datasettet steak_survey, og gir det navnet steak (for enkelhets skyld)

# KOMMENTAR: Flott!

## Oppgave 2 ##

#install.packages("ggplot2")
library(ggplot2)
ggplot(steak, aes(steak_prep)) + geom_bar()

#installerer og pakker ut pakken "ggplot2", og bruker funksjonene ggplot() og geom_bar() for å lage et stolpediagram.
#Stolpediagrammet viser at verdien "medium rare" har høyest frekvens på variabelen steak_prep.

# KOMMENTAR: Flott!

## Oppgave 3 ##

table(steak$steak_prep)

#sjekker verdiene til den opprinnelige variabelen steak_prep. 

steak$steak_prep1 <- ifelse(steak$steak_prep == "medium rare", "rare", steak$steak_prep)
steak$steak_prep2 <- ifelse(steak$steak_prep1 == "medium well", "well", steak$steak_prep1)

#Lager omkodet variabel steak_prep2 i to trinn.

table(steak$steak_prep2, steak$steak_prep, useNA = "always")

#sjekker omkodingen.

# KOMMENTAR: Her har du nok sett litt feil på oppgaveteksten. Skulle egentlig være:
steak_survey$steak_prep2 <- NA
steak_survey$steak_prep2[which(steak_survey$steak_prep == "Rare" | steak_survey$steak_prep == "Medium rare")] <- "Rare"
steak_survey$steak_prep2[which(steak_survey$steak_prep == "Medium")] <- "Medium"
steak_survey$steak_prep2[which(steak_survey$steak_prep == "Medium Well" | steak_survey$steak_prep == "Well")] <- "Well"

table(steak_survey$steak_prep, steak_survey$steak_prep2, useNA = "always")


## Oppgave 4 ##

steak$steak_prep2factor <- factor(steak$steak_prep2)

table(steak$steak_prep2factor)

#kategori 2 "medium rare" har flest enheter. 

# KOMMENTAR: Følgefeil, men du har heller ikke skiftet referansekategori, som oppgaven spør om. Løsning (gitt riktig oppgave 3):
steak_survey$steak_prep2 <- factor(steak_survey$steak_prep2, levels = c("Rare", "Medium", "Well"))

## Oppgave 5 ##

cor(steak$smoke, steak$alcohol)

#Kjører funksjonen cor() for å finne korrelasjon mellom smoke og alcohol, men ser at jeg må håndtere missing.

cor(steak$smoke, steak$alcohol, use = "complete.obs")

#Finner at korrelasjonen er på 0.09890018.

# KOMMENTAR: Flott!

## Oppgave 6 ##

library(ggplot2)

#Lager boxplot med funksjonen ggplot(). Utelater missing ved listwise exclusion. 
ggplot(steak, aes(x = steak_prep2, y = age, use = "complete.obs")) + 
  geom_boxplot() + 
  facet_wrap(~ steak_prep2) +
  theme_minimal()

#kategori 1, "medium", har lavest median.

# KOMMENTAR: Ok, men du trenger ikke facet_wrap() her og du må enten bruke den du gjorde opp til factor over, eller wrappe factor rundt den du bruker:
ggplot(steak, aes(x = factor(steak_prep2), y = age, use = "complete.obs")) + 
  geom_boxplot() + 
  theme_minimal()

## Oppgave 7 ##

#install.packages("nnet")
library(nnet)

#lager multinomisk regresjonsmodell
steak_reg <- multinom(steak_prep2 ~ age + hhold_income + smoke + 
                        alcohol, data = steak, Hess = TRUE, na.action = "na.exclude")

#install.packages("stargazer")
library(stargazer)

stargazer(steak_reg, type = "text")

#Skriver ut resultatene ved hjelp av funksjonen stargazer()
#siden koeffisientene til smoke er positive kan det virke som at logiten for å ha 
#sin biff stekt "rare", "medium rare", "well" og "medium well" over "medium" er høyere for folk som røyker
#enn dem som ikke røyker. 

# KOMMENTAR: Flott! Også her litt følgefeil, men det er ikke så farlig.

## Oppgave 8 ##

## Oppgave 9 ##

## Oppgave 10 ##

test_set <- data.frame(age = 18:90, 
                       hhold_income = median(steak$hhold_income, na.rm = TRUE), 
                       smoke = 0, 
                       alcohol = 1)
#lager test-set

steak_reg2 <- multinom(steak_prep2 ~ age + hhold_income + smoke + 
                        alcohol, data = test_set, Hess = TRUE, na.action = "na.exclude")


#Løser regresjonslikningen med det nye datasettet 


# KOMMENTAR: Dette ble ikke helt riktig. Du skal få for at du klarte å opprette test settet. Løsning (gitt din regresjon):
test_set <- cbind(test_set, predict(steak_reg, newdata = test_set, type = "probs"))

library(reshape2)

test_set <- melt(test_set, measure.vars = c("1", "2", "3", "4", "5"))
ggplot(test_set, aes(x = age, y = value, color = variable)) + geom_line()
