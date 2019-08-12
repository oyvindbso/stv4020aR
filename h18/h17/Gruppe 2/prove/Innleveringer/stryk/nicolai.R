###Prøve 09.10.2017###

#Oppgave 1#

steak_survey <- read.csv("Kursmappe Høst-2017/Kvantitativ/R-statistikk/steak_survey.csv")

# KOMMENTAR: Flott!

#Oppgave 2#

table(steak_prep)

library(ggplot2)
ggplot(steak_survey,aes(x = steak_prep, fill = steak_prep)) +
  geom_bar()

##Man ser at medium rare er høyest frekvens ut i fra stolpediagrammet.

# KOMMENTAR: Flott!

#Opgpave 3#

library(dplyr)

steak_survey$steak_prep2 <- factor(steak_prep, levels = c("Raw", "Medium", "Well"))


attatch(steak_survey$steak_prep)
steak_survey$steak_prep2[steak_survey$steak_prep >= "Medium"] <- "Well"

steak_survey$steak_prep2[steak_survey$steak_prep == "Medium"] <- "Medium"

steak_survey$steak_prep2[steak_survey$steak_prep <= "Medium"] <- "Raw"

table(steak_survey$steak_prep2)

#== bety er lik
#<= betyr midre eller lik
#>= betyr større eller lik


steak_survey$steak_prep2 <- factor(steak_survey$steak_prep, levels =c("Rare","Medium","Well")
                                   
table(steak_prep2)

##skulle nok ha brukt which

# KOMMENTAR: Det er jeg enig i at du burde gjort. Løsning: 
steak_survey$steak_prep2 <- NA
steak_survey$steak_prep2[which(steak_survey$steak_prep == "Rare" | steak_survey$steak_prep == "Medium rare")] <- "Rare"
steak_survey$steak_prep2[which(steak_survey$steak_prep == "Medium")] <- "Medium"
steak_survey$steak_prep2[which(steak_survey$steak_prep == "Medium Well" | steak_survey$steak_prep == "Well")] <- "Well"

table(steak_survey$steak_prep, steak_survey$steak_prep2, useNA = "always")

#Oppgave 4#

steak_prep2

# KOMMENTAR: Løsning:
steak_survey$steak_prep2 <- factor(steak_survey$steak_prep2, levels = c("Rare", "Medium", "Well"))

#Oppgave 5#
cor(steak_survey[,c("smoke", "alcohol")],
    use = "complete.obs",
    method = "pearson")

# korrelasjonen melllom smoke og alcohol har en veldig svak korelasjon på veriden 0.09890018. 

# KOMMENTAR: Flott!

#Oppgave 6#

library(ggplot2)

ggplot(steak_survey, aes(x=steak_prep2, y=age)) +
  geom_boxplot() +
  theme_minimal()

# KOMMENTAR: Flott! Den hadde blitt riktig om oppgave 3 var gjort riktig.

#Oppgave 7#

library(nnet)

multinomisk_reg <- multinom(steak_prep2 ~ age + smoke + hhold_income + alcohol data = steak_survey,
                            na.action= "na.exclude", Hess = TRUE)
# KOMMENTAR: Her mangler du et komma mellom alcohol og data + jeg ville brukt steak_prep når du ikke fikk til oppgave 3:
multinomisk_reg <- multinom(steak_prep ~ age + smoke + hhold_income + alcohol, data = steak_survey,
                            na.action= "na.exclude", Hess = TRUE)
summary(multinomisk_reg)

#Oppgave 8#
table(steak_survey$predlang <- steak_survey$pred > 0.05, steak_survey$age)

# KOMMENTAR: Dette ble ikke helt riktig... Løsning (gitt mitt forslag til løsning på oppgave 7):

steak_survey$pred <- predict(multinomisk_reg)
table(steak_survey$pred, steak_survey$steak_prep)
