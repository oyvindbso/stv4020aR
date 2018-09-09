## GJENNOMGANG AV SEMINAR 4 ##

rm(list = ls())

setwd("C:/Users/Reidun Ryland/Documents/programseminar/data")

## LASTE INN DATA

load("ess_norge.rda")

head(ess_nor, 3)

## AV: PARTY_VOTE_SHORT (hvilket parti stemte du på ved forrige stortingsvalg)

table(ess_nor$party_vote_short, useNA = "always")

library(ggplot2)


ggplot(ess_nor, aes(x = party_vote_short, fill = party_vote_short)) + geom_bar()

# Vi endrer litt på plottet:
ggplot(ess_nor[which(is.na(ess_nor$party_vote_short) == FALSE), ],
       aes(x = party_vote_short, fill = party_vote_short)) +
  geom_bar() +
  scale_fill_manual(values = c("darkred", "darkblue", "blue", "yellow2", "seashell4",
                               "forestgreen", "red", "darkgreen", "red3", "green")) +
  labs(x = "Partistemmer", y = "Frekvens", fill = "Parti") +
  scale_y_continuous(breaks = seq(0, 260, 50)) +
  theme_minimal()+ 
  theme(panel.grid.minor = element_blank(),
        panel.grid.major.x = element_blank(),
        legend.position = "none")

# "which(is.na(ess_nor$party_vote_short) == FALSE)" trekker ut enheter uten missing
# "scale_fill_manual(...)" funksjon for å sette fargene på stolpene
# theme_minimal() setter bakgrunsestetikken

# theme(..):
# 'panel.grid.minor = element_blank(),' fjerner de horisontale linjene på 25/75 
# 'panel.grid.major.x = element_blank(),' fjerner de vertikale linjene
# 'legend.position = "none"' fjerner oversikten av hvilke partier som er hvilken farge 
# på høyre langside


## UV(1): TRUST_POLITICIANS

table(ess_nor$trust_politicians)
# Går fra 0-10, men hva betyr det?

attributes(ess_nor$trust_politicians)

attr(ess_nor$trust_politicians, "labels")
# finner frem samme info, men utelukker alt annet enn labels
# første linje er lable, linjen under hva den er kodet som osv.
# Går fra "No trust at all", til "Complete trust"
# ser ut til å være intervallnivå

class(ess_nor$trust_politicians)


## BIVARIAT MULTINOMISK LOGISTISK REGRESJON

install.packages("nnet")
library(nnet)
# Denne pakken brukes for multinomisk logistisk regresjon

party_reg <- multinom(party_vote_short ~ trust_politicians,
                      data = ess_nor,
                      na.action = "na.exclude", Hess = TRUE)

# 'Hess = TRUE' er for å beholde kovariansematrisen (fint å ha med, men ikke noe vi trenger å
# forholde oss til på dette kurset)



summary(party_reg)
# AP stod først og er dermed valgt som referansekategori, noe som forsåvidt er greit da det er
# det partiet flest har stemt på.
# Interceptet for FRP er logiten for å stemme FRP vs AP når trust_politicians er 0, mens 
# koeffisienten til høyre er hvor mye logiten øker/synker med når UV (trust_politicians), 
# øker med en enhet

exp(coef(party_reg))
# husk at venstre kolonne nå er odds, mens venstre er odds ratio


# Regner litt på AP vs FRP

exp(0.7870249)/(1 + exp(0.7870249))
# svar: 69% større sannsynlighet for å stemme FRP vs AP når trust_politicians er lik 0

exp(0.7870249 + (-0.34755333 * 10))/(1 + exp(0.7870249 + (-0.34755333 * 10)))
# svar: sannsynligheten for å stemme FRP vs AP når tillit til politikere er 10, er 6%

# En enkel måte å sjekke om effekten er signifikant på 5% nivå som funker på de fleste reg:

confint(party_reg)
# Står som default til 95% konfidensintervall
# Dersom konfidensintervallet ikke krysser 0 er det signifikant på 5 % nivå
# F.eks. er koeffisientene til FRP signifikante, men ikke for H


# Vi kan også se på hvordan modellen tenker med tanke på sannsynligheter
test_set <- data.frame(trust_politicians = 0:10)

predict(party_reg, newdata = test_set)
# Oppgir hvilket parti det er størst sannsynlighet for at en stemmer på, gitt verdi 
# på UV (tillit til politikere 0:10)
# 0-1 = FRP, 2-4 = H, 5-10 = AP

predict(party_reg, newdata = test_set, type = "probs")
# Gir sannsynligheten for å stemme på hvert avv partiene for alle verdier på x
# OBS! Når det står 1 i raden til vestre betyr det egentlig 0 (R oppgir bare alltid 1, ikke 0)


# Problemer med modellen:
#1) partiene KYST, MDG og RØDT får svært få stemmer, og dermed vil de alltid ha ganske lave
# sannsynligheter. De kan elimineres
#2) V mangler kontrollvariabler
#3) Kanskje AV er ordinal?


# *Eliminere småpartier*

# Vi må lage et subset der vi fjerner enheter fra de små partiene (OBS, legg merke til at 
# også SV, SP, KRF og V er nære smertegrensen og kan gi problemer)

larger_parties <- ess_nor[which(ess_nor$party_vote_short != "RØDT" &
                          ess_nor$party_vote_short != "KYST" &
                          ess_nor$party_vote_short != "MDG" &
                            is.na(ess_nor$party_vote_short) == FALSE), ]
# != betyr ikke det til høyre

table(larger_parties$party_vote_short, useNA = "always")
# Ser riktig ut


# *Kontrollvariabler*

# Vi skal kontrollere for fire ting: 
# 1-2) To mål på inntekt (income_feel, income_decile) 
# 3-4) Kjønn og alder


# To inntektsvariabler:

table(larger_parties$income_feel)
# et problem når en subsetter er at labels forsvinner (sammenlign med attributes(...) under)

attributes(larger_parties$income_feel)
# Får opp labels her, mens i seminaret skulle dette gi svaret "NULL". Skjønner ikke helt 
# hvorfor jeg får det opp her, men fortsetter som om jeg ikke gjorde det

attributes(ess_nor$income_feel)
# De gamle labels er ivaretatt i det gamle datasettet, slik at vi kan kopiere dem over

install.packages("labelled")
library(labelled)

larger_parties$income_feel <- copy_labels(ess_nor$income_feel, larger_parties$income_feel)
# Vi kopierer over labels fra det gamle datasettet

attr(larger_parties$income_feel, "labels")
# Suksess! MEN vi ser at 7, 8, og 9 (alt over 4) egentlig burde vært kodet NA...

larger_parties$income_feel2 <- ifelse(larger_parties$income_feel > 4, NA, 
                                      larger_parties$income_feel)
# Fikser det slik at 7, 8 og 9 blir NA i en ny variabel (income_feel2)


table(larger_parties$income_feel2, larger_parties$income_feel, useNA = "always")
# Vi ser at den ene enheten som hadde 8

#####

# Gjentar alt med income_decile (inntekt etter desil):

larger_parties$income_decile <- copy_labels(ess_nor$income_decile, 
                                            larger_parties$income_decile)

attr(larger_parties$income_decile, "labels")
# både 77, 88 og 99 (alt over 10) burde vært kodet NA

larger_parties$income_decile2 <- ifelse(larger_parties$income_decile > 10, NA, 
                                      larger_parties$income_decile)

table(larger_parties$income_decile2, larger_parties$income_decile, useNA = "always")
# Suksess!



# Kjønn og alder:

# Kjønn ser ut til å være kodet på en fornuftig måte, så her trenger vi ikke gjøre noe. 
# Alder kan vi regne ut med å trekke fødselsår fra året surveyen ble utført (2014). Så 
# sentrerer vi variabelen til median.

table(larger_parties$gender)
# omtrent like antall menn/kvinner, dvs referansekategori er ikke så nøye

larger_parties$age <- 2014 - larger_parties$year_born
#regner ut alder og legger inn i en ny variabel i datasettet kalt "age"

summary(larger_parties$age)
# når minimumsverdien er 19 år, og det dessuten ikke er noen under 18 som har stemmerett, gir
# det mening å sentrere ariabelen

larger_parties$age <- larger_parties$age - median(larger_parties$age, na.rm = TRUE) 
# Sentrerer variabelen age
# kunne droppet na.rm fordi ingen har NA

summary(larger_parties$age)
# Ser bra ut :)


# Multinomisk logistisk regresjon med kontroller:

party_reg2 <- multinom(party_vote_short ~ trust_politicians + income_feel2 + income_decile2 +
                         gender + age, data = larger_parties, Hess = TRUE, 
                       na.action = "na.exclude")

summary(party_reg2)
# Tolkning av koeffisientene til FRP (vs AP):
# *Interceptet: 
exp(0.17841649)/(1 + exp(0.17841649)) 
# Når en ikke har tillit til politikere (0), har en god følelse for egen øko,
# tilhører første inntektsdesil, er kvinne, og 50 år er sjansen for å stemme FRP vs AP 54%.
# Dvs at den har sunket en del med kontrollvariablene (var 67%)

#*Alderskoeffisienten:
exp(0.006931332)
# Når alder øker med en enhet (alt annet likt) er sjansen for å stemme FRP vs AP 
# 1.01 ganger større (mener dette blir riktig tolkning av OR)

#Sjansen for å stemme FRP om en er 19 år og alt annet holdes slik som i interceptet:
exp(0.17841649 + (0.003462876 *-31))/(1 + exp(0.17841649 + (0.003462876 *-31)))
# er 52 % dvs en nedgang på 2% fra 50 år

confint(party_reg2)
# for FRP er alle koefisientene med unntak av interceptet, income_feel2 & alder signifikante 
# ...


# Predikere sannsynligheter

test_set2 <- data.frame(trust_politicians = 0:10, 
                        income_feel2 = median(larger_parties$income_feel2, na.rm = TRUE), 
                        income_decile2 = median(larger_parties$income_decile2, na.rm = TRUE), 
                        age = 0, 
                        gender = "female")
# Hypotetisk datasett. Opprettes fordi vi ønsker å se på sannsynet for tillit til politikere 
# mens alt annet holdes konstant på en sentrert verdi

predict(party_reg2, newdata = test_set2)
# 0-3 = H, 4-10 = AP

#predict(party_reg2, newdata = test_set2, type = "probs")

plot_data <- cbind(test_set2, predict(party_reg2, newdata = test_set2, type = "probs"))
#

ggplot(plot_data, aes(x = trust_politicians, y = A, group = 1)) + geom_point() + geom_line()
#group = 1 betyr bare at vi har en gruppe 

ggplot(plot_data, aes(x = trust_politicians)) + 
  geom_point(aes(y = A)) +
  geom_point(aes(y = FRP)) +
  geom_line(aes(y = A, group = 1)) +
  geom_line(aes(y = FRP, group = 1))
# For å sammenligne to parti


## RANGER LOGISTISK REG (dette er bonus så det kan du se på senere)