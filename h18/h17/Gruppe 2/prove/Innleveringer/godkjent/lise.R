### R-PRØVE #####
rm(list = ls())
setwd("C:/Users/Lise R/Desktop/UiO - Master/STV4020A/RSeminar4020a/Data")

# Laster inn pakker
library(ggplot2)
library(nnet)
library(reshape2)

# Oppgaveteksten er limt inn for å gjøre det litt enklere for meg selv.

### OPPGAVE 1 #####
# Last inn data steak survey.csv. Enhetene i datasettet er respondenter i en survey.
# Du kan enten laste ned data fra fronter, linken:
# http://folk.uio.no/martigso/encrypt/
# eller direkte inn i R med:
# http://folk.uio.no/martigso/encrypt/steak_survey.csv

# Jeg laster ned filen fra fronter og lagrer den i mappen jeg har satt som
# working directory. Deretter laster jeg den inn i R. 
biff <- read.csv("steak_survey.csv")

# KOMMENTAR: Flott!

### OPPGAVE 2 ####
# Lag et stolpediagram av variabelen steak prep. Kommenter hvilken verdi p˚a variabelen
# som har høyest frekvens.

barplot(table(biff$steak_prep))
# Medium rare er den verdien med høyest frekvens.

# KOMMENTAR: Flott!

### OPPGAVE 3 ####
# Lag en ny variabel – steak prep2 – som tar verdiene:
# • “Rare” n˚ar steak prep er “Rare” eller “Medium rare”
# • “Medium” n˚ar steak prep er “Medium”
# • “Well” n˚ar steak prep er “Medium Well” eller “Well”
# Sjekk at variabelen ble kodet riktig med en tabell.

table(biff$steak_prep)
biff$steak_prep2 <- NA # Oppretter en ny variabel med bare NA
# Under får variabelen verdi basert på verdiene på opprinnelig variabel
biff$steak_prep2[which(biff$steak_prep == "Rare")] <- "Rare"
biff$steak_prep2[which(biff$steak_prep == "Medium rare")] <- "Rare"
biff$steak_prep2[which(biff$steak_prep == "Medium")] <- "Medium"
biff$steak_prep2[which(biff$steak_prep == "Medium Well")] <- "Well"
biff$steak_prep2[which(biff$steak_prep == "Well")] <- "Well"

table(biff$steak_prep2, biff$steak_prep, useNA = "always")
# Variabelen er kodet riktig i tabellen

# KOMMENTAR: Flott!

### OPPGAVE 4 ####
# Gjør om den nye steak prep2 variabelen til en faktor, og sett kategorien med flest
# enheter til referansekategori.

table(biff$steak_prep2)
# Bruker table for å finne den kategorien med flest enheter. Rare har 189 enheter
# og bør derfor settes til referansekategori. 
# Gjør om til faktor og ber om at kolonnen "Rare" settes som referansekategori.
biff$steak_prep2 <- factor(biff$steak_prep2, levels = c("Rare", "Medium", "Well"))

# KOMMENTAR: Flott!

### OPPGAVE 5 ####
# Vis hvordan du finner korrelasjonen mellom variblene smoke og alcohol. Oppgi korrelasjonen
# i en kommentar.

cor(biff$smoke, biff$alcohol, use ="complete.obs")
# Korrelasjonen mellom variablene smoke og alcohol er 0.09890018.
# Her er det brukt listwise deletion av missingverdier. 

# KOMMENTAR: Flott!

### OPPGAVE 6 ####
# Lag et boxplot med steak prep2 p˚a x-aksen og age p˚a y-aksen. Hvilken kategori p˚a
# steak prep2 har lavest median?

ggplot(biff, aes(x = steak_prep2, y = age)) +
  geom_boxplot()

# Medium er den kategorien som har lavest medianalder.

# KOMMENTAR: Flott!

### OPPGAVE 7 ####
# Estimer en multinomisk logistisk regresjon med steak prep2 som avhengig variabel
# og age, hhold income, smoke og alcohol som uavhengige variabler. Husk ogs˚a ˚a ta
# vare p˚a informasjon om NA i regresjonen. Kommenter kort hva retningen for begge
# koeffisientene til smoke betyr.

reg1 <- multinom(steak_prep2 ~ age + hhold_income + smoke + alcohol,
                 data = biff, Hess = TRUE, na.action = "na.exclude")
summary(reg1)
# Koeffisienten til smoke er negativ for både Medium og Well. Det betyr at 
# sannsynligheten for at noen røyker er lavere for de som liker biffen medium
# eller well done sammenlignet med de som liker biffen sin rare. 

# KOMMENTAR: Flott! Men kausalretningen på tolkningen er feil!

### OPPGAVE 8 #####
# Vis hvordan du sjekker konfidensintervallene p˚a 5% niv˚a for effektene i regresjonen
# fra oppgave 6. Er effekten av age signifikant?

# Konfidensintervaller på 5 % nivå finner en ved å ta koeffisienten pluss/minus
# standardfeilen * 1,96

# Øvre grense på 95 % KI for age for medium:
-0.0064856537 + (0.004230865*1.96)
# Øvre grense er 0.001806842

# NEdre grense på 95 % KI for age for medium:
-0.0064856537 - (0.004230865*1.96)
# Øvre grense er -0.01477815

# KI dekker 0 og vi kan derfor ikke si at koeffisienten er signifikant 
# forskjellig fra 0 på 5 prosents nivå

# KOMMENTAR: Flott! Kan også bare bruke:
confint(reg1)

### OPPGAVE 9 ####
# Legg inn predikerte kategorier (ikke sannsynligheter) i datasettet fra regresjonen i
# oppgave 6. Lag en tabell over predikerte (forventede) og faktiske verdier p˚a steak prep2.
# Kommenter kort hva tabellen viser.
biff$predz <- predict(reg1)

table(biff$steak_prep2, biff$predz)

# Tabellen viser oss hvor godt modellen predikerer data. I kolonnen "Rare
# ser vi at 138 av de som ble predikert til å ha verdien "Rare" faktisk har
# den verdien, mens 96 har verdien "Medium" og 78 har verdien "Well". Modellen
# vår predikerer ingen Well, selv om det faktisk var 83 som har svart at de 
# foretrekker "Well".

# KOMMENTAR: Flott!

### OPPGAVE 10 ####
# Lag datasett (test set) der alder g˚ar fra 18:90, hhold income er satt til median,
# smoke er satt til 0 og alcohol er satt til 1. Legg s˚a inn predikerte sannsynligheter
# (løs regresjonsligningen) fra regresjonen (oppgave 7) i dette datasettet. Lag deretter
# et plot som har de forventede sannsynlighetene til test settet p˚a y-aksen, alder p˚a
# x-aksen og fargede linjer for hver av kategoriene p˚a steak prep2.

# Lager et testset med de forutsetningene som er presentert i oppgaven
test_set <- data.frame(age = 18:90,
                        hhold_income = median(biff$hhold_income, na.rm = TRUE),
                        smoke = 0, alcohol = 1)
# Tilfører kolonne med predikerte sannsynligheter
test_set <- cbind(test_set, predict(reg1, newdata = test_set, type = "probs"))
head(test_set)

# Lager en kolonne for steak_prep2
test_set <- melt(test_set, measure.vars = c("Rare", "Medium", "Well"))

# Lager plott med egne farger
ggplot(test_set, aes(x = age, y = value, color = variable)) +
  geom_line() +
  theme_minimal() +
  scale_color_manual(values = c("darkred", "darkblue", "blue")) +
  labs(x = "Alder", y = "Forventet verdi på Y", color = "Kategori på steak_prep2")


# KOMMENTAR: Trampeklapp!