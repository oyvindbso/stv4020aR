### R- PROVE  ###

##  OPPGAVE 1 ##

library(readr)
steak_survey <- read_csv("D:/R/steak_survey.csv")
# Lastet inn datasettet.

# KOMMENTAR: Flott!

##  OPPGAVE 2 ##
library(ggplot2)
ggplot(steak_survey,aes(x = steak_prep, fill = steak_prep)) +
  geom_bar()
#Medium-rare har høyest frekvens, det kan også lese av slik:
table(steak_survey$steak_prep)
#Dette viser mer nøyaktig at "medium rare" har frekvensen 166. 

# KOMMENTAR: Flott!

##  OPPGAVE 3 ##
steak_survey$steak_prep2 <- ifelse(steak_survey$steak_prep == "Medium", "Rare", steak_survey$steak_prep)
steak_survey$steak_prep2 <- ifelse(steak_survey$steak_prep == "Medium rare", "Rare", steak_survey$steak_prep)           
steak_survey$steak_prep2 <- ifelse(steak_survey$steak_prep == "Medium", "Medium", steak_survey$steak_prep)
steak_survey$steak_prep2 <- ifelse(steak_survey$steak_prep == "Well", "Well", steak_survey$steak_prep)
steak_survey$steak_prep2 <- ifelse(steak_survey$steak_prep == "Medium Well", "Well", steak_survey$steak_prep)
table(steak_survey$steak_prep2)
#Medium Medium rare        Rare        Well 
#  132         166          23         111 
#Jeg finner ikke ut hva som er galt så jeg fikk en følgefeil :(

# KOMMENTAR: Det er en litt feil måte å bruke ifelse på. Hvis du skal bruke ifelse() her må du neste:
steak_survey$steak_prep2 <- ifelse(steak_survey$steak_prep == "Medium", "Medium",
                                   ifelse(steak_survey$steak_prep == "Rare", "Rare",
                                          ifelse(steak_survey$steak_prep == "Medium rare", "Rare",
                                                 ifelse(steak_survey$steak_prep == "Well", "Well",
                                                        ifelse(steak_survey$steak_prep == "Medium Well", "Well", steak_survey$steak_prep)))))
table(steak_survey$steak_prep, steak_survey$steak_prep2)

# Kanskje enklere med:
steak_survey$steak_prep2 <- NA
steak_survey$steak_prep2[which(steak_survey$steak_prep == "Rare" | steak_survey$steak_prep == "Medium rare")] <- "Rare"
steak_survey$steak_prep2[which(steak_survey$steak_prep == "Medium")] <- "Medium"
steak_survey$steak_prep2[which(steak_survey$steak_prep == "Medium Well" | steak_survey$steak_prep == "Well")] <- "Well"

table(steak_survey$steak_prep, steak_survey$steak_prep2)

##  OPPGAVE 4 ##
# Gjør om den nye steak prep2 variabelen til en faktor, og sett kategorien med flestenheter til referansekategori.

faktor <- factor(steak_survey$steak_prep2)
summary(faktor)

# KOMMENTAR: Legg variablene i datasettet!

##  OPPGAVE 5 ##
cor(steak_survey[,c("smoke", "alcohol")],
    use = "complete.obs",
    method = "pearson")
#smoke    alcohol
#smoke   1.00000000 0.09890018
#alcohol 0.09890018 1.00000000
#Korrelasjonen mellom "smoke" og "alcohol" er 0.09890018 når man bruker listwise deletion som jeg gjorde for
#å fjerne "NA" verdier.

# KOMMENTAR: Flott! Listwise/pairwise har ikke noe å si mellom 2 variabler ;)

##  OPPGAVE 6 ##
ggplot(steak_survey, aes(x=steak_prep2, y=as.numeric(age))) +
  geom_boxplot()+
#  facet_wrap(~country)+
  theme_minimal()
#Kategorien ...... på steak prep har høyest median.

# KOMMENTAR: Her har du kopiert kode fra seminar! Fyfy! Ingen vits med facet_wrap() og vi har ingen "country"-variabel i data. Ellers riktig.

##  OPPGAVE 7 ##
library(nnet)
mlr <- multinom(steak_prep2 ~ age + hhold_income + smoke + alcohol, data = steak_survey, Hess = TRUE)
summary(mlr)
#Følgefeil fra "steak_prep2" variabel men nå er retningen til koeffisientene til 
#variabelene våre slik:

Coefficients:
            (Intercept)     age      hhold_income    smoke    alcohol
Medium rare  0.46340894 0.006341936 -2.846965e-06 0.12530157 -0.5245125
Rare        -2.27439301 0.007664782  1.867437e-06 0.45453348 -0.1874139
Well         0.08064767 0.005761674 -4.058048e-06 0.04118765 -0.4445501

Std. Errors:
             (Intercept)   age       hhold_income    smoke      alcohol
Medium rare 5.927284e-05 0.004343106 2.511347e-06 6.602964e-06 4.407882e-05
Rare        1.094775e-04 0.008491159 4.666924e-06 1.612427e-05 8.057547e-05
Well        6.585365e-05 0.004826448 2.868510e-06 7.499550e-06 4.741847e-05

Residual Deviance: 837.558 
AIC: 867.558 

# KOMMENTAR: Du trenger ikke kopiere inn tabellen, jeg får den opp når jeg kjører skriptet ditt. Det blir rotete 
              # Ellers fint. Følgefeil straffes ikke. Men lurt å øve seg på tolkning i ord!

##  OPPGAVE 8 ##
confint(mlr, level=0.95)
#                   2.5 %        97.5 %
#(Intercept)   8.051860e-02  8.077674e-02
#age          -3.697990e-03  1.522134e-02
#hhold_income -9.680224e-06  1.564129e-06
#smoke         4.117295e-02  4.120235e-02
#alcohol      -4.446430e-01 -4.444572e-01

# KOMMENTAR: Flott! Men samme som over.

## OPPGAVE 9  ##
steak_survey$predik_kat <- (predict(mlr))

Legg inn predikerte kategorier (ikke sannsynligheter) i datasettet fra regresjonen i
oppgave 6. Lag en tabell over predikerte (forventede) og faktiske verdier pa steak prep2.
Kommenter kort hva tabellen viser.
# KOMMENTAR: Her får du feilmelding fordi du har glemt "na.exclude" i regresjonen. Og du har ikke kommentert ut/fjernet oppgaveteksten

##  OPPGAVE 10  ##
library(labelled)
library(plyr)

Lag datasett (test set) der alder gar fra 18:90, hhold income er satt til median,
smoke er satt til 0 og alcohol er satt til 1. Legg sa inn predikerte sannsynligheter
(ls regresjonsligningen) fra regresjonen (oppgave 7) i dette datasettet. Lag deretter
et plot som har de forventede sannsynlighetene til test settet pa y-aksen, alder pa
x-aksen og fargede linjer for hver av kategoriene pa steak prep2.

test_set <- data.frame
test_set$hhold_income <- steak_survey$hhold_income - (median(steak_survey$hhold_income))

test_set$hhold_income_median <- steak_survey$hhold_income - (median(steak_survey$hhold_income))

smoke0 <- ifelse(steak_survey$smoke == 1, 0, 0)
smoke0 <- ifelse(steak_survey$smoke == 0, 1, 0)
alcohol1 <- ifelse(steak_survey$alcohol == 0, 1, 0)
alcohol1 <- ifelse(steak_survey$alcohol == 1, 0, 0)

test_set$smoke0 <- smoke0
test_set$smoke0 <- alchohol1

# Jeg innser at dette blir rotete.

test_set1 <- steak_survey[which(steak_survey$age != 18:90 &
                                  steak_survey$smoke != 0 &
                                  steak_survey$alcohol != 1 &
                                  steak_survey$predik_kat &
                                  is.na == FALSE), ]
table(test_set1)

# KOMMENTAR: Både rotete og feil! Løsning (gitt din regresjon):
test_set <- data.frame(age = min(steak_survey$age, na.rm = TRUE):max(steak_survey$age, na.rm = TRUE),
                       hhold_income = median(steak_survey$hhold_income, na.rm = TRUE),
                       smoke = 0,
                       alcohol = 1)


test_set <- cbind(test_set, predict(mlr, newdata = test_set, type = "probs"))

library(reshape2)

test_set <- melt(test_set, measure.vars = c("Rare", "Medium rare", "Medium", "Well"))
ggplot(test_set, aes(x = age, y = value, color = variable)) + geom_line()
