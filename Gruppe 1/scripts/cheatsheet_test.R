#################################
### Oversikt over basics:     ###
### cheatsheet til R-prøven   ###
### STV 4020A Høsten 2018     ###
#################################

## Merk: jeg viser ikke alle aktuelle anvendelser av alle funksjonene. Det kan være at du blir spurt om å bruke en funksjon
## på en måte som ikke er beskrevet i dette scriptet. 
## For mer avanserte statistiske metoder, diagnostikk, plotting av  regresjon, aggregering m.m.,
## henviser jeg til undervisningsmaterial for seminarene. Dette dokumentet er ment som
## en oversikt over basics.


##### Basics ######


###   NOEN TIPS TIL Å MANØVRERE SEG I RSTUDIO: ###
##  I SCRIPTET SKRIVER VI KODE. SÅ SENDER VI KODEN TIL KONSOLLEN. I KONSOLLEN SKJER MAGIEN.
##  CTRL/CMD + ENTER: SENDER KODE
##  CTRL/CMD + ENTER: HVIS DU HAR MARKERT ET STYKKE KODE, SÅ SENDER DEN ALL KODE DU HAR MARKERT
##  CTRL/CMD + ENTER: HVIS DU IKKE HAR MARKERT NOE KODE, SENDER DEN KODELINJEN MARKØREN ER PÅ (DETTE ER LINJE 14, SE TIL VENSTRE)

## <<<--- DISSE GJØR AT JEG KAN SKRIVE KOMMENTARER. ALT ETTER # BLIR IKKE "EVALUERT" AV KONSOLLEN. OM DU SKRIVER 2, 5 ELLER 100 # GJØR INGEN FORSKJELL.

##? foran funksjonsnavn åpner hjelpefilen til en funksjon:
?summary()
## ?? søker etter en funksjon, bruk denne dersom ? ikke fungerer:
?skewness()
??skewness() # søker også i pakker som ikke er lastet inn.

## getwd() sjekker nåværende working directory 
getwd()
## setwd() endrer working directory, pass på å bruke / for å skille mellom mapper i filstier.
setwd("C:/Users/Navn/R/der/du/vil/jobbe/fra") # For windows
setwd("~/R/der/du/vil/jobbe/fra")             # For mac/linux

## install.packages() - installerer pakker, dvs. at filer lastes ned fra internett og lagres som tillegg til R
## Dersom filene til en pakke er lastet ned, trenger du ikke kjøre koden på nytt, med mindre du vil oppdatere pakken.
install.packages("moments")

## library()  - brukes til å laste inn pakker i R, gjør funksjoner, data og annet som finnes i pakker tilgjengelig i
## din nåværende R-sesjon. Må kjøres på nytt for hver R-sesjon.
library(moments)


## Rydde opp: 
# rm() fjerner objekter, rm(list = ls()) fjerner alle objekter
et_objekt <- 1

rm(et_objekt)

#####     R SOM EN KALKULATOR:    #####

## Disse funksjonene kan også brukes på variabler/vektorer:

3+2 # addisjon
3-2 # subtraksjon
3*2 # multiplikasjon
3/2 # divisjon
3^2 # potens
sqrt(3) # kvadratrot
exp(3)  # eksponentialfunksjon
log(3)  # naturlig logaritme (kan endre grunntall med argumenter)
sum(c(1,5))   # summerer tall  
round(1.53)   # runder av til nærmeste heltall, kan styre antall desimaler med tilleggsargument

##### Opprette objekter #####

# syntaks: mitt_objekt <- x
# 'x' kan være et tall, en vektor, et datasett, et plot, en regresjonsmodell, m.m.
# '<-' er en assignment operator. Informasjonen som kommer etter denne blir lagret lokalt i R,
# slik at du kan hente ut informasjonen når du ønsker. Det er også mulig å bruke '=', men vi skal
# kun bruke '=' til å styre argumenter inne i funksjoner. 
# mitt_objekt er et vilkårlig navn du kan velge fritt, men det er lurt å velge nanv som ikke fører til skrivefeil.

dager_til_sommerferie <- 31 + 30 + 6 # tallobjekt

nedtelling_til_sommerferien <- 67:1 # vektorobjekt.

## Vektorfunksjoner: 

# Vektorer er en ordnet rekke av informasjon av samme klasse.
# Vi har gjennomgått 5 klasser, numeric, integer, character, factor og logical.


# Funksjoner til å jobbe med klasse:
# class() - test klassen til et objekt (fungerer på alle typer objekter):
class(nedtelling_til_sommerferien)
# str() - klasse og mer info om et objekt (fungerer på alle typer objekter):
str(nedtelling_til_sommerferien)

## Endre klasse:
# as.factor()
# as.numeric()
# as.integer()
# as.character()
# as.logical() - ikke pensum !!!!

## factor er en spesiell klasse, vi har lært to funksjoner for å jobbe med factorer:
# factor() - opprett en factor-variabel
# levels() - se de ulike kategoriene på en variabel
# relevel() - endre referansekategori
min_factor <- factor(c("liten", "liten", "stor", "medium", "liten"))
levels(min_factor)
relevel(min_factor, ref= "stor")
## Funksjoner som kan brukes til å lage vektorer:
# ':'  - teller fra tall før kolon til tall etter kolon i heltall:
10:1
1:10
1.5:10.5

# c() - binder sammen alle elementer, hvis elementer er av forskjellig type transformeres alt til laveste målenivå
c("Per", 1, TRUE, NA, 5.1) # blir til tekstvektor, men NA regnes som missing.


## funksjoner for å opprette datasett med utgangpunkt i ny informasjon:

## informasjon du lager selv:
#data.frame() - bind sammen variabler til et datasett
data.frame(var1 = 1:10, var2 = 10:1)
#rbind() - bind sammen observasjoner (rader) til et datasett
rbind(c("Per", 20), c("Kari", 30))
#cbind() - bind sammen kolonner til et datasett 
cbind(1:10, 10:1)
#as.data.frame() - tving en matrise til å bli til data.frame (matriser er en objekttype som ligner datasett
# , men med variabler av kun en type):
class(cbind(1:10, 10:1))
class(as.data.frame(cbind(1:10, 10:1)))

## Endre variabelnavn:
colnames(data) <- c("var1", "var2", "var3")
colnames(data)[1] <- "VAR1"
## Informasjon i en ekstern data-fil

#load("datasett.Rdata") # .Rdata er R sitt eget filformat
#data <- read.csv("datasett.csv") # .csv er en filtype som brukes mye, og som stammer fra excel.
#data <- read.table("datasett.txt") # Beslektet med read.csv. Har argumenter for å angi strukturen til tabeller
#data <- read_spss("datasett.sav")  # Leser .sav og .por filer fra SPSS, funksjonen stammer fra pakken haven
#data <- read_stata("datasett.dat")  # Leser .dat filer fra STATA, funksjonen stammer fra pakken haven

# Lagre data i en ekstern fil
# write.csv(data, file = "mittdatasett_csv")
# save(data, file  = "mittdatasett.Rdata")


##### Logiske tester: #######
3==2 # er lik
3>=2 # større eller lik
3<=2 # mindre eller lik
3>2  # større enn
3<2  # mindre enn
3!=2 # er ikke lik
3>2&2>3 # & binder sammen to tester, krever at begge testene er TRUE for å gi output TRUE
3>2|2>3 # | betyr eller, binder sammen to tester og krever at en av testene er TRUE for å gi TRUE som output
is.na(C(1,2,NA,4)) # test for missing i en vektor, TRUE betyr missing
complete.cases(data.frame(1:10, rep(c(NA,1), 5))) # test for missing hos observasjoner, TRUE betyr ingen missing,


###### Indeksering: ######

## For å sjekke hvordan et objekt kan indekseres:
# str()
# dim()
# class()
# names()
# rownames()
# colnames()
# length()
# View()
# head()
# tail()

str(mtcars)
dim(mtcars)
class(mtcars)
names(mtcars)
colnames(mtcars)
rownames(mtcars)
length(mtcars$mpg)
# View(mtcars)
head(mtcars)
tail(mtcars)
## Vi kan enten indeksere ved å angi plasseringen/navnet til informasjonen vi er ute etter i objektet (rad, kolonne)
## eller ved å spesifisere et søk etter den informasjonen vi er ute etter ved hjelp av logiske tester

## indeksere en vektor: 
a <- 10:1
a[8] # velger element 8, indekserer etter plassering 
a[a==3] # søker etter elementer som er lik 3, indeksering ved hjelp av logisk test 

## Indeksere et datasett:
# Datasett har to dimensjoner, rader (observasjoner) og kolonner (variabler). 
# Når vi indekserer datasett må vi derfor angi om vi vil indeksere rader eller kolonner.

# Indeksere rader:
mtcars[1:5,] # Før komma i klammeparentes - indeksering av rader. Her indekserer jeg ut fra plassering
mtcars[which(mtcars$cyl>4),] # Her indekserer jeg ved hjelp av en logisk test, jeg spesifiserer et søk
subset(mtcars, cyl>4) # Her indekserer jeg ved hjelp av en logisk test i subset-funksjonen. 

# which: angir plasseringen til elementer som får TRUE på en logisk test

# Indeksere kolonner:
mtcars[,1:3] # indekserer ut fra plassering
mtcars[,c("mpg", "cyl", "disp")] # indekserer ut fra navn

# kolonnene har ikke tallverdier, vi har ikke lært logiske tester for tekst. Dersom vi skulle indeksert kolonner ved å søke etter informasjon
# måtte vi gjort dette (det er mulig, og nyttig for datasett med svært mange observasjoner).

## Indeksering med dplyr:
library(dplyr)
mtcars %>% filter(cyl>4) # valg av rader (observasjoner) med logisk test
mtcars %>% select(mpg, cyl, disp) # Valg av variabler (kolonner) ut fra navn

###### Omkoding     ######

## Ved omkoding skal vi alltid opprette nye variabler. For å gi oss selv angrerett ved en omkoding, kan vi ikke overskrive den opprinnelige variabelen

# ifelse() er svært nyttig til omkoding. Her er to måter å anvende funksjonen på:
# opprettelse av dummy
mtcars$eight_cyl <- ifelse(mtcars$cyl == 8, 1, 0) 

# opprettelse av kategorisk variabel med flere kategorier:
mtcars$mpg_cat <- NA
mtcars$mpg_cat <- ifelse(mtcars$mpg<15, "low", mtcars$mpg_cat)
mtcars$mpg_cat <- ifelse(mtcars$mpg>=15 & mtcars$mpg < 18.5, "medium", mtcars$mpg_cat)
mtcars$mpg_cat <- ifelse(mtcars$mpg>=18.5, "high", mtcars$mpg_cat)



###### plot  ######
## Vi har først og fremst brukt ggplot() fra pakken ggplot2(), 
## men vi har også sett på noen andre plotte-funksjoner. De fleste av disse er for 
## regresjonsdiagnostikk, men følgende to funksjoner kan erstatte histogram og spredsningslot med ggplot.
hist(mtcars$disp)
plot(mtcars$disp, mtcars$mpg)

dev.off() # bruk før du lager ggplot etter at du har laget et plot med en annen type funksjon, fjerner grafiske parametre

# Husk at ggplot er en funksjon fra pakken ggplot2!
library(ggplot2)
# enkelt scatterplot
ggplot(mtcars, aes(x = disp, y = mpg)) +
  geom_point() 

# enkelt histogram  
ggplot(mtcars, aes(x = disp)) +
  geom_histogram() 

# enkelt density-plot
ggplot(mtcars, aes(x = disp)) +
  geom_density()

# enkelt regresjonsplot
ggplot(mtcars, aes(x = disp, y = mpg)) +
  geom_smooth(method= "lm") 

# enkelt barplot
ggplot(mtcars, aes(x=factor(cyl), y = mpg)) +
  geom_boxplot()  # legg merke til at x bør være en factor!

# Mer avanserte plot - scatterploteksempel:

# legger til regresjon:
ggplot(mtcars, aes(x = disp, y = mpg)) +
  geom_point() +
  geom_smooth(method="lm")

# legger til farge og form:
ggplot(mtcars, aes(x = disp, y = mpg)) +
  geom_point(aes(col=hp, shape = factor(cyl))) +
  geom_smooth(method="lm")

# legger til "pynt"
ggplot(mtcars, aes(x = disp, y = mpg)) +
  geom_point(aes(col=hp, shape = factor(cyl))) +
  geom_smooth(method="lm") + 
  theme_bw() +
  labs(x = "et nytt navn", y = "miles per gallon") +
  ggtitle("Et eksempelplot")


###### Statistikk #######

## Husk å sjekke for missing dersom du får rare resultater!!


### Univariat statistikk
# De fleste funksjoner for univariat statistikk har et argument som heter na.rm = , som kan brukes til å håndtere missing, 
# e.g. mean(mtcars$mpg, na.rm = TRUE). Dette argumentet er som regel satt til FALSE by default.

mean(mtcars$mpg) # gjennomsnitt
median(mtcars$mpg) # median
max(mtcars$mpg)
min(mtcars$mpg)
sd(mtcars$mpg)
var(mtcars$mpg)
quantile(mtcars$mpg)
summary(mtcars$mpg)
table(mtcars$mpg)
# fra moments:
library(moments)
skewness(mtcars$mpg)
kurtosis(mtcars$mpg)

### Bivariat statistikk:
# Her har vi først og fremst fokusert på to funksjoner for pearsons R:
# cor.test - for signifikanstest av korrelasjon mellom to variabler
# cor - for bivariate korrelasjoner mellom to eller flere variabler

cor.test(mtcars$mpg, mtcars$disp)
cor(mtcars$mpg, mtcars$disp) # bivariate korrelasjoner mellom to variabler.

cor(mtcars[,3:8], use = "complete.obs") # korrelasjonsmatrise, krever numerisk data.frame, missing håndteres ved å sette use =, her listwise deletion
cor(mtcars[,3:8], use = "pairwise.complete.obs") # korrelasjonsmatrise, pairwise deletion av missing