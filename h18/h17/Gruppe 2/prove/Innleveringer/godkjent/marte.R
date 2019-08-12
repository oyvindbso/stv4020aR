
###################
##### R-Prøve #####
##### STV4020 #####
# Marte Lund Saga #
###################

###### Oppgave 1 #####


# Laste inn datasett

setwd("~/R-seminar") # Setter working directory til R-mappen der jeg har lastet ned og lagret datasettet
steak_survey <- read.csv("steak_survey.csv", stringsAsFactors = FALSE)

# KOMMENTAR: Flott!

##### Oppgave 2 #####
#Lag et stolpediagram av variabelen steak prep. Kommenter hvilken verdi på variabelen som har høyest frekvens.

library(ggplot2) # Pakker ut ggplot-pakken

ggplot(steak_survey, aes(x = steak_prep, fill = steak_prep)) +
  geom_bar() + theme_classic()

# Verdien "Medium rare" har høyest frekvens 

# KOMMENTAR: Flott!

##### Oppgave 3 #####

# Lag en ny variabel steak prep2 som tar verdiene:
# "Rare" når steak prep er "Rare" eller Medium rare"
# "Medium" når steak prep er "Medium"
# "Well" når steak prep er "Medium Well" eller "Well"

table(steak_survey$steak_prep)

steak_survey$steak_prep2 <- NA # Lager først en tom variabel

steak_survey$steak_prep2[which(steak_survey$steak_prep == "Rare")] <- "Rare"
steak_survey$steak_prep2[which(steak_survey$steak_prep == "Medium rare")] <- "Rare"

steak_survey$steak_prep2[which(steak_survey$steak_prep == "Medium")] <- "Medium" 

steak_survey$steak_prep2[which(steak_survey$steak_prep == "Medium Well")] <- "Well"
steak_survey$steak_prep2[which(steak_survey$steak_prep == "Well")] <- "Well"

# Vet at jeg kunne gjort dette mer effektivt..

table(steak_survey$steak_prep2, useNA = "always") # Ser at variabelen nå har 3 kategorier: Medium, rare og well
# Har 118 NA:

# Medium   Rare   Well   <NA> 
#   132    189    111    118 

# KOMMENTAR: Flott! Effektivt, schmeffektivt :p


##### Oppgave 4 #####

# Gjør om den nye steak prep2 variabelen til en faktor, og sett kategorien med flest enheter til referansekategori.


#install.packages("car")
library(car)

steak_survey$steak_prep2_num <- recode(steak_survey$steak_prep2, " 'Rare'='0' ; 'Medium'='1' ; 'Well'='2'")

steak_survey$steak_prep2_fac <- as.factor(steak_survey$steak_prep2_num) 

# "Rare" skal være referansekategori, så jeg gjorde først variabelen numerisk for så å
# endre referansekategori ved å bruke pakken car. Vet at det er en annen måte å gjøre dette på men huska ikke. 

table(steak_survey$steak_prep2_fac)
#   0   1   2 
# 189 132 111 

# Nå stemmer i hvert fall rekkefølgen: Rare, Medium, Well

# KOMMENTAR: Flott!

##### Oppgave 5 #####

#Vis hvordan du finner korrelasjonen mellom variblene smoke og alcohol. Oppgi korrelasjonen i en kommentar.

cor(steak_survey[, c("smoke", "alcohol")], use = "complete.obs")

# Korrelasjonsmatrisen:

#              smoke    alcohol
# smoke   1.00000000 0.09890018
# alcohol 0.09890018 1.00000000

# Ikke veldig høy korrelasjon mellom disse to

# KOMMENTAR: Flott!

##### Oppgave 6 #####

#Lag et boxplot med steak prep2 på x-aksen og age på y-aksen. Hvilken kategori på steak prep2 har lavest median?

ggplot(steak_survey, aes(x = steak_prep2, y = age)) +
  geom_boxplot() + theme_classic()

# Det ser ut som at "Medium" har lavest median 

# KOMMENTAR: Flott!

##### Oppgave 7 #####
# Estimer en multinomisk logistisk regresjon med steak prep2 som avhengig variabel
# og age, hhold_income, smoke og alcohol som uavhengige variabler. Husk også å ta
# vare på informasjon om NA i regresjonen. Kommenter kort hva retningen for begge
# koeffisientene til smoke betyr.

library(nnet) # Pakker ut pakken nnet for å gjøre multinomisk logistisk regresjon

steak_reg <- multinom(steak_prep2_fac ~ age + hhold_income + smoke + alcohol,
                      data = steak_survey, na.action = "na.exclude", Hess = TRUE)

summary(steak_reg)


# Begge koeffisientene til smoke er negative. Det vil si at de som har verdien "Medium" eller "Well"
# på avhengig variabel, har lavere sannsynlighet for å være røykere enn de som har ref.kategori: "rare"
# Vi kan si at sannsynligheten synker, men ikke hvor mye fordi logits er ikke så intuitivt å tolke. 

# KOMMENTAR: Flott! Men du har tolket retningen av effekten feil: smoke -> steak_prep vs steak_prep -> smoke

##### Oppgave 8 #####

# Vis hvordan du sjekker konfidensintervallene på 5% nivå for effektene i regresjonen
# fra oppgave 6. Er effekten av age signifikant?


# Sjekker om effektene er signifikante på 5%-nivå
confint(steak_reg)

# Age er ikke signifikant

# KOMMENTAR: Flott!

##### Oppgave 9 #####

#Legg inn predikerte kategorier (ikke sannsynligheter) i datasettet fra regresjonen i
#oppgave 6. Lag en tabell over predikerte (forventede) og faktiske verdier på steak prep2.
#Kommenter kort hva tabellen viser.


# KOMMENTAR: Glemte du denne?


##### Oppgave 10 #####

#Lag datasett (test set) der alder går fra 18:90, hhold income er satt til median,
#smoke er satt til 0 og alcohol er satt til 1. Legg så inn predikerte sannsynligheter
#(løs regresjonsligningen) fra regresjonen (oppgave 7) i dette datasettet. Lag deretter
#et plot som har de forventede sannsynlighetene til test settet pa y-aksen, alder pa
#x-aksen og fargede linjer for hver av kategoriene pa steak prep2.

test_set <- data.frame(age = 18:90,
                       hhold_income = median(steak_survey$hhold_income, na.rm = TRUE),
                       smoke = 0, alcohol = 1)

predict(steak_reg, newdata = test_set)

plot_data <- cbind(test_set, predict(steak_reg, newdata = test_set, type = "probs"))

ggplot(plot_data, aes(x = age)) + 
  geom_point(aes(y = ))

# KOMMENTAR: Veldig nære! Gikk tida ut? Jeg kan gjøre resten for deg:

library(reshape2)
plot_data <- melt(plot_data, measure.vars = c("0", "1", "2"))
ggplot(plot_data, aes(x = age, y = value, color = variable)) + geom_line()


