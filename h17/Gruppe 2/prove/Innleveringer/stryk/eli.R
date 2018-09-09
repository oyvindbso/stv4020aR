#Rprøve

###Oppgave 1###
getwd()
setwd("M:/pc/dokumenter")
steak_survey <- read.csv("http://folk.uio.no/martigso/encrypt/steak_survey.csv")

# KOMMENTAR: Flott!

###Oppgave 2###
install.packages("ggplot2")
library(ggplot2)
ggplot(steak_survey, aes(steak_prep)) + geom_bar()

#hvilken verdi på variabelen har høyest frekvens?

# KOMMENTAR: Flott! Mangler kommentar som oppgaven spør om
###Oppgave 3###
steak_survey$steak_prep2 <- ifelse(steak_survey$steak_prep == "Rare" + "Medium rare", "Rare",
                                   steak_survey$steak_prep == "Medium", "Medium"
                                   steak_survey$steak_prep == "Well" + "Medium Well", "Well",
                                   na.rm = TRUE)

steak_survey$steak_prep2[steak_prep = Rare & Medium rare] <- "Rare"

steak_sruvey$steak_prep <- (steak_survey$steak_prep, na.rm = TRUE)

steak_survey$steak_prep2 <- revalue(steak_survey$steak_prep, c("Rare" & "Medium Rare" = "Rare",
                                                               "Medium" = "Medium",
                                                               "Well" & "Medium Well" = "Well"))

steak_survey$steak_prep2 <- revalue(steak_survey$steak_prep, c("Rare" & "Medium Rare" = "Rare")

Rare <- ifelse(steak_survey$steak_prep == "Rare" + "Medium rare")

# KOMMENTAR: Dette ble ikke helt riktig

###Oppgave 5###
cor(steak_survey$smoke, steak_survey$alcohol, use = "complete.obs")
#Korrelasjonen er 0.09890018

# KOMMENTAR: Flott!

###Oppgave 6### 
ggplot(steak_survey, aes(x = steak_prep, y = age) + 
         geom_boxplot(~steak_prep) + 
         theme_minimal()
# KOMMENTAR: Her mangler en parentes på første linje, som gjør at koden ikke kjører + "~steak_prep" skal ikke stå i boxplot-koden. Den skal være tom.

###Oppgave 7###
install.packages("nnet")
library(nnet)
steak_reg <- multinom(steak_prep ~ age, hhold_income, smoke, alcohol,
                      data = steak_survey, Hess = TRUE, na.action = "na.exclude")

# KOMMENTAR: Her har du skrevet komma istedenfor "+" mellom de uavhengige variablene. Skulle være (gitt at du ikke fikk til å opprette steak_prep2):

steak_reg <- multinom(steak_prep ~ age + hhold_income + factor(smoke) + factor(alcohol), data = steak_survey, na.action = "na.exclude")
summary(steak_reg)
