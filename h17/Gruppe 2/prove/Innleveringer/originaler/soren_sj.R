setwd("M:/pc/Dokumenter/R kollokvie")
library(ggplot)
library(ggplot2)

### Oppgave 1##

steak_survey <- read.csv("http://folk.uio.no/martigso/encrypt/steak_survey.csv")


### Oppgave 2 ###

barplot(table(steak_survey$steak_prep))
      
#medium rare har høyest frekvens


### Oppgave 3 ###

steak_prep2 <- steak_survey$steak_prep
steak_prep2[steak_prep2 =="Medium rare"] <- "Rare"
steak_prep2[steak_prep2 =="Medium Well"] <- "Well"

table(steak_prep2)

#her ble det to tomme kategorier til overs (klønete!), men det løses i neste oppgave


### Oppgave 4 ###

steak_prep2 <- factor(steak_prep2, levels = c("Rare", "Medium", "Well"))
table(steak_prep2)

#Rare har flest enheter


### Oppgave 5 ###

cor(steak_survey$smoke, steak_survey$alcohol, use = "complete.obs")

#Korrelasjonen er 0.09890018


### Oppgave 6 ###

ggplot(steak_survey, aes( x = steak_prep2, y = age)) +
  geom_boxplot() +
  theme_minimal()

#medium har lavest median


### Oppgave 7 ###

library(nnet)
multinom1 <- multinom(steak_prep2 ~ steak_survey$age + steak_survey$hhold_income + steak_survey$smoke + steak_survey$alcohol,
                      na.action = "na.exclude", Hess = TRUE)

summary(multinom1)

#Det er lavere odds for at man røyker hvis man will ha biffen medium eller well, i forhold til Rare


### Oppgave 8 ###

confint(multinom1)

#Age er ikke signifikant fordi den krysser 0


### Oppgave 9 ###

steak_survey$multinom1_pred <- predict(multinom1)
summary(steak_survey$multinom1_pred)
table(steak_survey$multinom1_pred)

table(steak_survey$multinom1_pred, steak_prep2)
table(steak_prep2)

#tabellen forteller oss hva prediksjonene våre har predikert riktig (0 riktige i well f.eks)


### Oppgave 10 ###
table(steak_survey$age)
table(steak_survey$smoke)
table(steak_survey$smoke)

test.set <- data.frame(age = steak_survey$age)
test.set$household_income <- median(steak_survey$hhold_income, na.rm = TRUE)

summary(test.set$household_income)                     

test.set$smoke <- steak_survey$smoke


#... times up


#Kommentar, det ble litt klønete med alle variablene i de tidligere oppgavene utenfor datasettet,
#i retrospekt kanskje lurere å legge noen inn i settet, ser bedre ut i summary av regresjon f.eks (mer tekst enn nødvendig)
#, men jeg var stressa!


