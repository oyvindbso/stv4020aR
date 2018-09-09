# Oppgave 1

setwd("M:/pc/Dokumenter/R seminar gruppe 2")


biff <- read.csv("http://folk.uio.no/martigso/encrypt/steak_survey.csv", , stringsAsFactors = FALSE)

#table(biff)

# KOMMENTAR: Flott!

# Oppgave 2

table(biff$steak_prep)

steak_prep1 <- table(biff$steak_prep)

barplot(steak_prep1)

# Verdien medium rare har høyest frekvens

# KOMMENTAR: Flott!

# Oppgave 3
#rm(steak_prep2)

steak_prep2 <- ifelse(biff$steak_prep > "", 1, 0)


#steak_prep2 <- ifelse(steak_prep1 == "Rare" & "Medium rare", "Rare")
#Steak_prep2 <- ifelse(steak_prep1 == "Medium", "Medium")
#steak_prep2 <- ifelse(steak_prep1 == "Meduim Well" & "Well", "Well")


#table(steak_prep2)

#det her går ikke, bruker prep1 i resten av oppgaven

# KOMMENTAR: Lurt! Løsning:
biff$steak_prep2 <- NA
biff$steak_prep2[which(biff$steak_prep == "Rare" | biff$steak_prep == "Medium rare")] <- "Rare"
biff$steak_prep2[which(biff$steak_prep == "Medium")] <- "Medium"
biff$steak_prep2[which(biff$steak_prep == "Medium Well" | biff$steak_prep == "Well")] <- "Well"

table(biff$steak_prep, biff$steak_prep2, useNA = "always")

# Oppgave 4

biff_factor <- factor(biff$steak_prep1, levels = c("Medium rare", "Medium", "Medium Well", "Well", "Rare"))

table(biff_factor)

# KOMMENTAR: Dette ble ikke helt riktig; du har ingen steak_prep1 i datasettet. Den heter "steak_prep", bare

# Oppgave 5

cor(biff[, c("smoke", "alcohol")], use = "complete.obs")
#Korrelasjonen mellom variablene smoke og alcohol er 0.989

# KOMMENTAR: Flott!


# Oppgave 6
library(ggplot2)
library(car)


boxplot(age ~ steak_prep1, data = biff, main = "boxplot", xlab = "Age", ylab = "steal_prep1")

ggplot(biff, aes(x = steak_prep1, y = age)) +
  geom_boxplot() +
  theme_minimal()

# KOMMENTAR: Dette ble heller ikke helt riktig fordi du ikke har steak_prep1 i datasettet.

# Oppgave 7

library(nnet)


biffregmulti <- (multinom(steak_prep1 ~ age + hhold_income + smoke + alcohol, data = biff, Hess = TRUE, na.action = "na.exclude"))


# det her gikk ikke så bra. jeg fikk ikke til oppgave 3, og det er fullt av følgefeil. gg

# KOMMENTAR: Samme som over her også. Sjekk ut løsningsforslagene!




