#################################
#### R seminar 2             ####
#### STV 4020A               ####
#################################

## I dette seminaret skal vi gå gjennom:
## 1. organisering av R-script
## 2. Import av data
## 3. regresjonsanalyse

## Hovedfokus blir på arbeid med regresjon

## Fjerner objekter fra R:
rm(list=ls())

## Setter working directory - trengs ikke dersom du jobber fra et prosjekt
#setwd("C:/Users/Navn/R/der/du/vil/jobbe/fra")

## Installerer pakker (fjerne '#' og kjør dersom en pakke ikke er installert)

# install.packages("tidyverse")
# install.packages("moments")
# install.packages("stargazer")
# install.packages("xtable")
# install.packages("texreg")

#### Laster inn pakker:
library(tidyverse)
library(moments)
library(stargazer)
library(xtable)
library(texreg)
#### Overskrift 1 #####
## Kort om hva jeg skal gjøre/produsere i seksjonen
2+2 # her starter jeg å kode


### Flere tips:
# 1. Start en ny seksjon med en kommentar der du skriver hva du skal produsere i seksjonen,
# forsøk å bryte oppgaven ned i så mange små steg som du klarer. Dette gjør det ofte lettere 
# å finne en fremgangsmåte som fungerer.

#2 . Test at ny kode fungerer hele tiden, fjern den koden som ikke trengs til å løse oppgavene 
# vil løse med scriptet ditt (skriv gjerne i et eget R-script du bruker som kladdeark dersom du
# famler i blinde). Forsøk å kjøre gjennom større segmenter av koden en gang i blant.


### Denne organiseringen hjelper deg og andre med å finne frem i scriptet ditt, 
### samt å oppdage feil.


##############################
#### Lineær regresjon OLS ####
##############################

### Syntaks

#For å kjøre en lineær regresjon i R, bruker vi funksjonen `lm()`, som har følgende syntaks:

#lm(avhengig.variabel ~ uavhengig.variabel, data=mitt_datasett)
# på mac får du ~ med alt + k + space


# La oss se på et eksempel med `aid` datasettet vi har brukt så langt:

aid <- read_csv("https://raw.githubusercontent.com/langoergen/stv4020aR/master/data/aid.csv")

# Oppretter variablene policy og region på nytt, samme kode som i seminar 1:
aid <- aid %>% # samme kode som over, men nå overskriver jeg data slik at variabelen legges til - gjør dette etter at du har testet at koden fungerte
  mutate(policy = elrsacw + elrinfl + elrbb,
         policy2 = elrsacw*elrinfl*elrbb,
         region = ifelse(elrssa == 1, "Sub-Saharan Africa",
                         ifelse(elrcentam == 1, "Central America",
                                ifelse(elreasia == 1, "East Asia", "Other"))))



m1 <- lm(elrgdpg ~ elraid, data = aid) # lagrer m1 om objekt
summary(m1) # ser på resultatene med summary()
class(m1) # Legg merke til at vi har et objekt av en ny klasse!
str(m1) # Gir oss informasjon om hva objektet inneholder.


### Multivariat regresjon

# Vi legger inn flere uavhengige variabler med `+`.


summary(m2 <- lm(elrgdpg ~ elraid + policy + region, data = aid))
# Her kombinerer vi summary() og opprettelse av modellobjekt på samme linje

### Samspill

#Vi legger inn samspill ved å sett `*` mellom to variabler. De individuelle 
#regresjonskoeffisientene til variablene vi spesifisere samspill mellom blir automatisk 
#lagt til.



summary(m3 <- lm(elrgdpg ~ elraid*policy + region, data = aid))


### Andregradsledd og andre omkodinger

#Vi kan legge inn andregradsledd eller andre omkodinger av variabler i regresjonsligningene 
# våre. Andregradsledd legger vi inn med `I(uavh.var^2)`. Under har jeg lagt inn en `log()`
#omkoding, en `as.factor()` omkoding og et andregradsledd. Merk at dere må legge inn
# førstegradsleddet separat når dere legger inn andregradsledd. Dersom en
#variabeltransformasjon krever mer enn en enkel funksjon, er det fint å opprette en ny
#variabel i datasettet. For andregradsledd/høyeregrads polynomer bør imidlertid
# transformasjonen skje ved hjelp av I() inne i lm() funksjonen - dette gjør plotting lettere.





summary(m4 <- lm(elrgdpg ~ log(elrgdpg) + elricrge + I(elricrge^2) + region + elraid*policy +  as_factor(period), data = aid, na.action = "na.exclude"))



#**Oppgave:** hva blir den forventede effekten av bistand for medianverdien til bistand,
# og for maksimumsverdien til bistand, i henhold til regresjonen over?



## For løsningsforslaget til oppgavene fra seminar 1, se på slutten av dokumentet til dagens
## seminar!

