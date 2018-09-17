# Andre R-seminar
Erlend Langørgen  
29 august 2017  
# Velkommen!
<img src="../pics/kitty_welcome.jpg" width="243" />

## Dagens seminar: Hvordan lykkes med R, terping på basics og regresjonsdiagnostikk

Dagens seminar er strukturert som følger: 


1. Kort intro om gode vaner i R
2. Selvstendig arbeid med oppgaver, terping av basics. 
3. Andre time: Arbeid med regresjonsdiagnostikk
4. Hvis vi får tid: eksport av figurer og tabeller.


I første time i dagens R seminar skal vi snakke om hvordan dere kan gjøre R til et nyttig redskap (i stedet for å gjøre R til en evig frustrasjonskilde). Hemmeligheten er god organisering av R-script og arbeid i R. 




## Oppsett R-script 

### Kommentering
Som dere kanskje har lagt merke til, kan vi bruke `#` til å kommentere kode i R.
Bruk kommentarer flittig, det hjelper fremtids-deg og andre å lese og forstå koden din. 

I R-studio kan vi også lage seksjoner av kode, som man kan folde sammen. For å prøve dette, skriv `#### tekst ####` (flere `#` går også). På venstre side av tekstlinjen vil dere se en pil, skriv en setning kode under pilen og trykk på den.
Sammen med meningsfulle overskrifter, et innebygget søkesystem og godt kommentert kode, hjelper dette folde-systemet deg til å finne rask frem i R-scriptet ditt.

Jeg anbefaler at dere starter R script med en overskrift, samt en kort beskrivelse av R scriptet etter headingen deres ved hjelp av `#`. 

### Navngivning
Man kan spare mye tid og krefter på å gi lure navn til objekter. Her er noen regler, for flere tips, se [Stilguide for R](https://google.github.io/styleguide/Rguide.xml):

* R er sensitivt til store og små bokstaver (Forsøk å kjøre Y). Min anbefaling er derfor: bruk små bokstaver så langt det er mulig.
* Ikke gi objekter det samme navnet som en funksjon. Hvordan kan du teste om et navn ikke er brukt på en funksjon? 
* Bruk meningsfulle, men ganske korte navn. 
* Følg et system for navngivning *slavisk*. Eksempel:
     + Skill mellom ord i et objektnavn med `_`
     + Skill mellom ord i et variabelnavn med `.` 

### Nytt script
Dersom vi skal kjøre et nytt script, er det ofte ønskelig å fjerne objekter/arbeid fra andre script vi jobber med. Dette kan vi gjøre med `rm()`. Jeg pleier å benytte `rm(list=ls())`, som fjerner alle objekter vi har lagret i R.
R-scriptet deres bør fungere etter denne kommandoen, dere bør ikke skrive i flere script, på en slik måte at scriptene må kjøres i en spesiell rekkefølge for å fungere (unntaket er dersom dere kjører andre R-script med kode).

Vi installerer og laster inn alle pakker vi trenger etter `setwd()`. Etter at vi har lastet inn pakkene vi trenger, er vi ferdig med å skrive preamble til scriptet, resten av scriptet deler vi inn i seksjoner ved hjelp av `#### overskrift ####`. Dere bør nå ha en preamble som ser omtrent slik ut:

```r
#################################
#### R seminar 2           ######
#################################

## I dette seminaret skal vi gå gjennom:
## 1. organisering av R-script
## 2. R-oppgaver
## 3. regresjonsanalyse med diagnostikk
## 4. Output fra R (hvis vi får tid)

## Fjerner objekter fra R:
rm(list=ls())

## Setter working directory
setwd("C:/Users/Navn/R/der/du/vil/jobbe/fra")

## Installerer pakker (fjerne '#' og kjør dersom en pakke ikke er installert)
# install.packages("ggplot2"")
# install.packages("dplyr"")
# install.packages("moments")
# install.packages("car")
# install.packages("stargazer")
# install.packages("xtable")
# install.packages("texreg")

## Laster inn pakker:
library(ggplot2)
library(dplyr)
library(moments)
library(car)
library(texreg)
library(stargazer)
library(xtable)

#### Overskrift 1 #####
## Kort om hva jeg skal gjøre/produsere i seksjonen
2 + 2 # her starter jeg å kode, gjerne med å importere og forberede datasettet mitt
```

Denne organiseringen hjelper deg og andre med å finne frem i scriptet ditt, samt å oppdage feil. 


### Flere tips: 
1. Start en ny seksjon med en kommentar der du skriver hva du skal produsere i seksjonen, forsøk å bryte oppgaven ned i så mange små steg som du klarer. Dette gjør det ofte lettere å finne en fremgangsmåte som fungerer.
2. Test at ny kode fungerer hele tiden, fjern den koden som ikke trengs til å løse oppgavene du vil løse med scriptet ditt (skriv gjerne i et eget R-script du bruker som kladdeark dersom du famler i blinde). Forsøk å kjøre gjennom større segmenter av koden en gang i blant.

 

