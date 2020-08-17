---
title: "Andre R-Seminar"
author: "Erlend Langørgen"
date: "15 august 2019"
output:
  html_document:
    keep_md: TRUE
    self_contained: no
---


## Introduksjon


## Organisering - prosjekter og script <a name="Rscript"></a>

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

### Renske R.
Dersom vi skal kjøre et nytt script, er det ofte ønskelig å fjerne objekter/arbeid fra andre script vi jobber med. Dette kan vi gjøre med `rm()`. Jeg pleier å benytte `rm(list=ls())`, som fjerner alle objekter vi har lagret i R.
R-scriptet deres bør fungere etter denne kommandoen, dere bør ikke skrive i flere script, på en slik måte at scriptene må kjøres i en spesiell rekkefølge for å fungere (unntaket er dersom dere kjører andre R-script med `source()` fra R-scriptet dere jobber i - men da skal fortsatt scriptet ditt fungere etter `rm(list = ls())`).

### Working directory

Working directory er den mappen  R forventer å hente og lagre filer i (mappe som i `Mine dokumenter`). Dere må spesifisere en sti gjennom mappene deres dersom dere vil hente filer fra andre steder på pcen. For å finne ut hvilken mappe dere jobber fra for øyeblikket, kan vi bruke `getwd()`. For å bestemme at en mappe skal være vår working directory bruker vi `setwd()`. I script dere skal dele med andre, fjern innholdet fra `setwd()`. Her er en demonstrasjon av `setwd()`, som fungerer litt ulikt på windows og mac/linux:

```r
setwd("C:/Users/Navn/R/der/du/vil/jobbe/fra") # For windows
setwd("~/R/der/du/vil/jobbe/fra")             # For mac/linux
```

For å slippe å knote med `working directory` og `setwd()` anbefaler jeg imidlertid at dere bruker prosjekter. Prosjekter kan åpnes via `File`-menyen øverst til venstre i Rstudio, og er knyttet til en bestemt mappe på datamaskinen din. Når du åpner et prosjekt vil dermed `working directory` bli satt til prosjekt-mappen automatisk. Dersom du lagrer alle filer til hjemmeoppgaven i en prosjektmappe, og alle filer til seminarene i en annen prosjektmappe, kan du også enkelt bytte mellom prosjektene via `File`. For å opprette et nytt prosjekt, trykk på `File` og deretter `New project` øverst til venstre i Rstudio. Velg deretter om du du vil opprette en ny mappe på datamaskinen din, eller om du vil knytte prosjektet til en eksisterende mappe. Prosjekter har også flere andre fordeler som dere kan utforske senere, men dere vil ha glede av prosjekter allerede nå pga. `working directory`. Jeg anbefaler derfor at dere alltid jobber fra R-prosjekt (det er ikke farlig å ha mange prosjekter), og at dere lagrer alle filer knyttet til prosjektet (data, bilder, script, figurer) i prosjektmappen.

**Oppgave:** Lag et R-prosjekt som heter *R-seminar*, og lagre en fil - for eksempel et R-script - i prosjekt-mappen.

Når vi har bestemt working directory, kan vi navigere til andre mapper med utgangspunkt i denne mappen. Vi kan for eksempel sjekke hvilke filer som finnes i mappen som er working directory, og i mappen på nivået under med:

```r
list.files()      # Filer i mappen vi er i
```



### Pakker
R er *open-source* software, som gjør det mulig for brukere å lage sine egne tilleggspakker til R. Det finnes over **10 000** slike pakker, mange av dem inneholder mange funksjoner som løser spesifikke oppgaver mer effektivt enn grunninstallasjonen av R. Vi installerer nye pakker med `install.packages("pakkenavn")`. For å bruke installerte pakker, må vi laste inn pakkene med `library(pakkenavn)`. Dersom dere skal dele kode, sett `#` foran `install.packages()`, slik at koden ikke kjøres, det er kjedelig å sette i gang et script som installerer 10 pakker man allerede har på nytt. Inkluder imidlertid `library`. Et godt tips er å skrive hvilken versjon av en pakke du bruker i en kommentar etter `library()`, da pakker noen ganger endres slik at koden din ikke fungerer. Det er mulig å laste inn historiske versjoner av pakker, dermed bidrar dette også til å sikre reproduserbarhet. I prosjekter kan du velge å bruke packrat, som sørger for at du bruker den samme versjonen av en pakke hver gang du jobber i et prosjekt Her er et eksempel på installasjon og innlasting av pakker:

```r
#### Kjør denne koden dersom du ikke har installert pakkene:
# install.packages("tidyverse")
# install.packages("moments")
#install.packages("stargazer")
#install.packages("xtable")
#install.packages("texreg")

#### Laster inn pakker:
library(tidyverse)
library(moments)
library(stargazer)
library(xtable)
library(texreg)
```


Vi installerer og laster inn alle pakker vi trenger etter `rm(list = ls())`. Etter at vi har lastet inn pakkene vi trenger, er vi ferdig med å skrive preamble til scriptet, resten av scriptet deler vi inn i seksjoner ved hjelp av `#### overskrift ####`. Dere bør nå ha en preamble som ser omtrent slik ut:

```r
#################################
#### R seminar 2           ######
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
```

Denne organiseringen hjelper deg og andre med å finne frem i scriptet ditt, samt å oppdage feil.


### Flere tips:
1. Start en ny seksjon med en kommentar der du skriver hva du skal produsere i seksjonen, forsøk å bryte oppgaven ned i så mange små steg som du klarer. Dette gjør det ofte lettere å finne en fremgangsmåte som fungerer.
2. Test at ny kode fungerer hele tiden, fjern den koden som ikke trengs til å løse oppgavene du vil løse med scriptet ditt (skriv gjerne i et eget R-script du bruker som kladdeark dersom du famler i blinde). Forsøk å kjøre gjennom større segmenter av koden en gang i blant.



## Lineær regresjon (OLS) <a name="ols"></a>


### Syntaks

For å kjøre en lineær regresjon i R, bruker vi funksjonen `lm()`, som har følgende syntaks:

```r
lm(avhengig.variabel ~ uavhengig.variabel, data=mitt_datasett)
# på mac får du ~ med alt + k + space
```

La oss se på et eksempel med `aid` datasettet vi har brukt så langt:

```r
aid <- read_csv("https://raw.githubusercontent.com/langoergen/stv4020aR/master/data/aid.csv")
```

```
## Parsed with column specification:
## cols(
##   .default = col_double(),
##   country = col_character(),
##   code = col_character()
## )
```

```
## See spec(...) for full column specifications.
```

```r
# Oppretter variablene policy og region på nytt, samme kode som i seminar 1:
aid <- aid %>% # samme kode som over, men nå overskriver jeg data slik at variabelen legges til - gjør dette etter at du har testet at koden fungerte
  mutate(policy = elrsacw + elrinfl + elrbb,
         policy2 = elrsacw*elrinfl*elrbb,
         region = ifelse(elrssa == 1, "Sub-Saharan Africa",
                               ifelse(elrcentam == 1, "Central America",
                               ifelse(elreasia == 1, "East Asia", "Other"))))



m1 <- lm(elrgdpg ~ elraid, data = aid) # lagrer m1 om objekt
summary(m1) # ser på resultatene med summary()
```

```
## 
## Call:
## lm(formula = elrgdpg ~ elraid, data = aid)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -14.3172  -2.2181   0.1205   2.1012  17.1528 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  1.80978    0.17362  10.424   <2e-16 ***
## elraid      -0.12581    0.05203  -2.418   0.0159 *  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 3.727 on 689 degrees of freedom
##   (669 observations deleted due to missingness)
## Multiple R-squared:  0.008414,	Adjusted R-squared:  0.006975 
## F-statistic: 5.846 on 1 and 689 DF,  p-value: 0.01587
```

```r
class(m1) # Legg merke til at vi har et objekt av en ny klasse!
```

```
## [1] "lm"
```

```r
str(m1) # Gir oss informasjon om hva objektet inneholder.
```

```
## List of 13
##  $ coefficients : Named num [1:2] 1.81 -0.126
##   ..- attr(*, "names")= chr [1:2] "(Intercept)" "elraid"
##  $ residuals    : Named num [1:691] -11.081 -1.722 -0.343 -11.384 2.43 ...
##   ..- attr(*, "names")= chr [1:691] "12" "13" "14" "15" ...
##  $ effects      : Named num [1:691] -41.2032 -9.0105 0.0716 -10.9908 2.799 ...
##   ..- attr(*, "names")= chr [1:691] "(Intercept)" "elraid" "" "" ...
##  $ rank         : int 2
##  $ fitted.values: Named num [1:691] 1.71 1.7 1.63 1.48 1.32 ...
##   ..- attr(*, "names")= chr [1:691] "12" "13" "14" "15" ...
##  $ assign       : int [1:2] 0 1
##  $ qr           :List of 5
##   ..$ qr   : num [1:691, 1:2] -26.287 0.038 0.038 0.038 0.038 ...
##   .. ..- attr(*, "dimnames")=List of 2
##   .. .. ..$ : chr [1:691] "12" "13" "14" "15" ...
##   .. .. ..$ : chr [1:2] "(Intercept)" "elraid"
##   .. ..- attr(*, "assign")= int [1:2] 0 1
##   ..$ qraux: num [1:2] 1.04 1.01
##   ..$ pivot: int [1:2] 1 2
##   ..$ tol  : num 1e-07
##   ..$ rank : int 2
##   ..- attr(*, "class")= chr "qr"
##  $ df.residual  : int 689
##  $ na.action    : 'omit' Named int [1:669] 1 2 3 4 5 6 7 8 9 10 ...
##   ..- attr(*, "names")= chr [1:669] "1" "2" "3" "4" ...
##  $ xlevels      : Named list()
##  $ call         : language lm(formula = elrgdpg ~ elraid, data = aid)
##  $ terms        :Classes 'terms', 'formula'  language elrgdpg ~ elraid
##   .. ..- attr(*, "variables")= language list(elrgdpg, elraid)
##   .. ..- attr(*, "factors")= int [1:2, 1] 0 1
##   .. .. ..- attr(*, "dimnames")=List of 2
##   .. .. .. ..$ : chr [1:2] "elrgdpg" "elraid"
##   .. .. .. ..$ : chr "elraid"
##   .. ..- attr(*, "term.labels")= chr "elraid"
##   .. ..- attr(*, "order")= int 1
##   .. ..- attr(*, "intercept")= int 1
##   .. ..- attr(*, "response")= int 1
##   .. ..- attr(*, ".Environment")=<environment: R_GlobalEnv> 
##   .. ..- attr(*, "predvars")= language list(elrgdpg, elraid)
##   .. ..- attr(*, "dataClasses")= Named chr [1:2] "numeric" "numeric"
##   .. .. ..- attr(*, "names")= chr [1:2] "elrgdpg" "elraid"
##  $ model        :'data.frame':	691 obs. of  2 variables:
##   ..$ elrgdpg: num [1:691] -9.3728 -0.0267 1.2893 -9.9032 3.7454 ...
##   ..$ elraid : num [1:691] 0.806 0.909 1.411 2.619 3.929 ...
##   ..- attr(*, "terms")=Classes 'terms', 'formula'  language elrgdpg ~ elraid
##   .. .. ..- attr(*, "variables")= language list(elrgdpg, elraid)
##   .. .. ..- attr(*, "factors")= int [1:2, 1] 0 1
##   .. .. .. ..- attr(*, "dimnames")=List of 2
##   .. .. .. .. ..$ : chr [1:2] "elrgdpg" "elraid"
##   .. .. .. .. ..$ : chr "elraid"
##   .. .. ..- attr(*, "term.labels")= chr "elraid"
##   .. .. ..- attr(*, "order")= int 1
##   .. .. ..- attr(*, "intercept")= int 1
##   .. .. ..- attr(*, "response")= int 1
##   .. .. ..- attr(*, ".Environment")=<environment: R_GlobalEnv> 
##   .. .. ..- attr(*, "predvars")= language list(elrgdpg, elraid)
##   .. .. ..- attr(*, "dataClasses")= Named chr [1:2] "numeric" "numeric"
##   .. .. .. ..- attr(*, "names")= chr [1:2] "elrgdpg" "elraid"
##   ..- attr(*, "na.action")= 'omit' Named int [1:669] 1 2 3 4 5 6 7 8 9 10 ...
##   .. ..- attr(*, "names")= chr [1:669] "1" "2" "3" "4" ...
##  - attr(*, "class")= chr "lm"
```

### Multivariat regresjon

Vi legger inn flere uavhengige variabler med `+`.



```r
summary(m2 <- lm(elrgdpg ~ elraid + policy + region, data = aid))
```

```
## 
## Call:
## lm(formula = elrgdpg ~ elraid + policy + region, data = aid)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -13.4683  -1.9352   0.2506   1.7596  16.0849 
## 
## Coefficients:
##                          Estimate Std. Error t value Pr(>|t|)    
## (Intercept)               0.42850    0.60838   0.704   0.4816    
## elraid                    0.03708    0.08996   0.412   0.6804    
## policy                   -0.37867    0.30521  -1.241   0.2154    
## regionEast Asia           4.91528    0.79888   6.153 1.79e-09 ***
## regionOther               1.35702    0.62485   2.172   0.0304 *  
## regionSub-Saharan Africa  0.03884    0.65428   0.059   0.9527    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 3.404 on 416 degrees of freedom
##   (938 observations deleted due to missingness)
## Multiple R-squared:  0.1328,	Adjusted R-squared:  0.1224 
## F-statistic: 12.74 on 5 and 416 DF,  p-value: 1.542e-11
```

```r
# Her kombinerer vi summary() og opprettelse av modellobjekt på samme linje
```

### Samspill

Vi legger inn samspill ved å sett `*` mellom to variabler. De individuelle regresjonskoeffisientene til variablene vi spesifisere samspill mellom blir automatisk lagt til.



```r
summary(m3 <- lm(elrgdpg ~ elraid*policy + region, data = aid))
```

```
## 
## Call:
## lm(formula = elrgdpg ~ elraid * policy + region, data = aid)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -13.608  -1.931   0.207   1.808  15.931 
## 
## Coefficients:
##                          Estimate Std. Error t value Pr(>|t|)    
## (Intercept)               0.48886    0.60959   0.802   0.4230    
## elraid                   -0.08525    0.12947  -0.658   0.5106    
## policy                   -0.65123    0.36892  -1.765   0.0783 .  
## regionEast Asia           5.08141    0.80816   6.288 8.18e-10 ***
## regionOther               1.45400    0.62866   2.313   0.0212 *  
## regionSub-Saharan Africa  0.20440    0.66577   0.307   0.7590    
## elraid:policy             0.20912    0.15931   1.313   0.1900    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 3.401 on 415 degrees of freedom
##   (938 observations deleted due to missingness)
## Multiple R-squared:  0.1364,	Adjusted R-squared:  0.1239 
## F-statistic: 10.93 on 6 and 415 DF,  p-value: 2.621e-11
```

### Andregradsledd og andre omkodinger

Vi kan legge inn andregradsledd eller andre omkodinger av variabler i regresjonsligningene våre.
Andregradsledd legger vi inn med `I(uavh.var^2)`. Under har jeg lagt inn en `log()` omkoding, en `as.factor()` omkoding og et andregradsledd. Merk at dere må legge inn førstegradsleddet separat når dere legger inn andregradsledd. Dersom en variabeltransformasjon krever mer enn en enkel funksjon, er det fint å opprette en ny variabel i datasettet.





```r
summary(m4 <- lm(elrgdpg ~ log(elrgdpg) + elricrge + I(elricrge^2) + region + elraid*policy +  as_factor(period), data = aid, na.action = "na.exclude"))
```

```
## Warning in log(elrgdpg): NaNs produced
```

```
## 
## Call:
## lm(formula = elrgdpg ~ log(elrgdpg) + elricrge + I(elricrge^2) + 
##     region + elraid * policy + as_factor(period), data = aid, 
##     na.action = "na.exclude")
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -2.0967 -0.6853 -0.3539  0.2819  9.2310 
## 
## Coefficients:
##                           Estimate Std. Error t value Pr(>|t|)    
## (Intercept)               1.105109   0.591508   1.868   0.0629 .  
## log(elrgdpg)              2.145885   0.100725  21.304   <2e-16 ***
## elricrge                  0.175502   0.231584   0.758   0.4493    
## I(elricrge^2)            -0.006909   0.023650  -0.292   0.7704    
## regionEast Asia           0.666546   0.386425   1.725   0.0858 .  
## regionOther              -0.134002   0.295488  -0.453   0.6506    
## regionSub-Saharan Africa -0.203824   0.336840  -0.605   0.5457    
## elraid                    0.125522   0.089942   1.396   0.1641    
## policy                   -0.274403   0.239694  -1.145   0.2534    
## as_factor(period)3       -0.245434   0.302096  -0.812   0.4173    
## as_factor(period)4       -0.512756   0.322830  -1.588   0.1135    
## as_factor(period)5       -0.616264   0.356135  -1.730   0.0848 .  
## as_factor(period)6       -0.353864   0.318398  -1.111   0.2675    
## as_factor(period)7       -0.483362   0.337341  -1.433   0.1532    
## as_factor(period)8       -0.396093   0.316462  -1.252   0.2119    
## elraid:policy             0.110606   0.100420   1.101   0.2718    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 1.294 on 241 degrees of freedom
##   (1103 observations deleted due to missingness)
## Multiple R-squared:  0.7355,	Adjusted R-squared:  0.719 
## F-statistic: 44.67 on 15 and 241 DF,  p-value: < 2.2e-16
```


**Oppgave:** hva blir den forventede effekten av bistand for medianverdien til bistand, og for maksimumsverdien til bistand, i henhold til regresjonen over?



## Finne og kombinere data fra flere kilder

Ofte vil ikke alle kontrollvariabler/variabler du er teoretisk interessert i være å finne i datasettet du starter å jobbe i, men være tilgjengelig i et annet datasett. Da kan du bruke en `join_` funksjon for å kombinere data (eller `merge()` fra base-R) fra flere forskjellige datasett. Dersom du behersker denne ferdigheten, åpner det seg mange flere muligheter i hjemmeoppgaven/dataanalysen din.

For å være i stand til å anvende denne ferdigheten effektivt er det imidlertid også en stor fordel å ha kjennskap til mulige datasett på forhånd, samt trene seg til å lete etter nye datasett på egenhånd.

Her er noen aktuelle datakilder:

* [Harvard Dataverse](https://dataverse.harvard.edu/) - sjekk også den medfølgende [R-pakken](https://cran.r-project.org/web/packages/dataverse/dataverse.pdf)
* [NSD](https://nsd.no/data-overview.html)
* * [Oversikt på ISVs hjemmesider](https://www.sv.uio.no/isv/tjenester/kunnskap/datasett/) - disse kan det være verdt å sjekke ut
* [V-Dem](https://www.v-dem.net/en/) - gode data om demokratiske institusjoner
* [Åpne offentlige data fra Norge](https://data.norge.no/)
* [Quality of government](https://qog.pol.gu.se/data)

Denne listen er på ingen måte komplett - for å finne relevante data kan det være lurt å google - og å se hva slags data artikler som skriver om lignende tema/observasjoner har brukt.

For å se om det er mulig å kombinere data fra ulike kilder, er det viktig å tenke gjennom hvilke(n) variabler du vil bruke som nøkkel for å knytte sammen informasjon fra de to datasettene. Dette er aller lettest dersom begge datasett inneholder en felles, spesialdesignet `nøkkel-variabel` - [her](http://www.correlatesofwar.org/data-sets/cow-country-codes) er et eksempel på en slik variabel du kan finne i konflikt-data. Deretter er det viktig å tenke gjennom datastruktur, og hvilke konsekvenser dette har for hvordan du kan kombinere informasjon fra de to datasettene dine.

Når du har bestemt deg for nøkkelvariabler og tenkt gjennom datastruktur kan du benytte en `join` funksjon. Opprett et nytt datasett, da er det ikke så farlig om koden ikke fungerer. Her er syntaks for den vanligste `join` funksjonen, `left_join()`. For mer, se kap. 13 i **R for Data Science**.


```r
nytt_datasett <- left_join(
  gammelt_datasett, # alle observasjoner herfra beholdes
  ekstra_datasett, # variabler fra dette datasettet legges til gammelt_datasett
  by = c("nøkkelvar_gammelt_datasett", "nøkkelvar_ekstradatasett") # navn på nøkkelvariabler i de to datasettene
)
# Det letteste er å sørge for at du har nøkkelvariabler med samme navn i begge datasett, du kan opprette nye variabler i et av datasettene dine for å sørge for at navn matcher
```
I neste seksjon viser jeg et løsningsforslag til første del av oppgaven fra forrige seminar. Der får du se mer bruk av `left_join`, og jakt etter datasett.

## Løsningsforslag oppgave til seminar 1

> Finn et datasett som inneholder informasjon om borgerkrig. Inkluder deretter informasjon om borgerkriger i en variabel i `aid` datasettet. Tips: det kan hende du vil være tjent med å aggregere borgerkrigsdata med `group_by()` og `summarise()` før du kombinerer data med en `join_` funksjon. Tenk gjennom forskjellige måter du kan operasjonalisere informasjonen i borgerkrigsvariabelen  en variabel i datasettet ditt. Lag en tabell eller en figur som viser verdien til borgerkrigsvariabelen for hvert observasjon i datasettet ditt. Opprett deretter et spredningsplot som viser sammenhengen mellom bistand, økonomisk vekst og borgerkrig.


Jeg fant datasettet Armed Conlift Dataset, version 19.1 hos [Uppsala Conflict data](https://ucdp.uu.se/downloads/) etter et google-søk på conflict data, her er [kodeboken](https://ucdp.uu.se/downloads/ucdpprio/ucdp-prio-acd-191.pdf). Disse dataene dekker stort sett hele verden etter andre verdenskrig.  Last ned disse dataene selv, og legg dem i prosjektmappen din. Jeg laster dataene inn under objektnavnet `conflict` - du må fikse filstien under, fordi jeg har en egen mappe i prosjektmappen min som heter `data`


```r
conflict <- read_csv("../data/ucdp-prio-acd-191.csv")
```

```
## Parsed with column specification:
## cols(
##   .default = col_character(),
##   conflict_id = col_double(),
##   incompatibility = col_double(),
##   year = col_double(),
##   intensity_level = col_double(),
##   cumulative_intensity = col_double(),
##   type_of_conflict = col_double(),
##   start_date = col_date(format = ""),
##   start_prec = col_double(),
##   start_date2 = col_date(format = ""),
##   start_prec2 = col_double(),
##   ep_end = col_double(),
##   ep_end_date = col_date(format = ""),
##   ep_end_prec = col_logical(),
##   version = col_double()
## )
```

```
## See spec(...) for full column specifications.
```

```r
conflict
```

```
## # A tibble: 2,384 x 28
##    conflict_id location side_a side_a_id side_a_2nd side_b side_b_id
##          <dbl> <chr>    <chr>  <chr>     <chr>      <chr>  <chr>    
##  1       13637 Afghani~ Gover~ 130       Governmen~ IS     234      
##  2       13637 Afghani~ Gover~ 130       Governmen~ IS     234      
##  3       13637 Afghani~ Gover~ 130       Governmen~ IS     234      
##  4       13637 Afghani~ Gover~ 130       Governmen~ IS     234      
##  5         333 Afghani~ Gover~ 130       <NA>       PDPA   291      
##  6         333 Afghani~ Gover~ 130       <NA>       Jam'i~ 292      
##  7         333 Afghani~ Gover~ 130       Governmen~ Harak~ 293, 299~
##  8         333 Afghani~ Gover~ 130       Governmen~ Harak~ 293, 299~
##  9         333 Afghani~ Gover~ 130       Governmen~ Harak~ 293, 299~
## 10         333 Afghani~ Gover~ 130       Governmen~ Harak~ 293, 299~
## # ... with 2,374 more rows, and 21 more variables: side_b_2nd <chr>,
## #   incompatibility <dbl>, territory_name <chr>, year <dbl>,
## #   intensity_level <dbl>, cumulative_intensity <dbl>,
## #   type_of_conflict <dbl>, start_date <date>, start_prec <dbl>,
## #   start_date2 <date>, start_prec2 <dbl>, ep_end <dbl>,
## #   ep_end_date <date>, ep_end_prec <lgl>, gwno_a <chr>, gwno_a_2nd <chr>,
## #   gwno_b <chr>, gwno_b_2nd <chr>, gwno_loc <chr>, region <chr>,
## #   version <dbl>
```

```r
names(conflict) # Legg merke til start_date variablene
```

```
##  [1] "conflict_id"          "location"             "side_a"              
##  [4] "side_a_id"            "side_a_2nd"           "side_b"              
##  [7] "side_b_id"            "side_b_2nd"           "incompatibility"     
## [10] "territory_name"       "year"                 "intensity_level"     
## [13] "cumulative_intensity" "type_of_conflict"     "start_date"          
## [16] "start_prec"           "start_date2"          "start_prec2"         
## [19] "ep_end"               "ep_end_date"          "ep_end_prec"         
## [22] "gwno_a"               "gwno_a_2nd"           "gwno_b"              
## [25] "gwno_b_2nd"           "gwno_loc"             "region"              
## [28] "version"
```

Jeg må først tenke gjennom hvordan jeg kan få en felles nøkkel som lar
meg knytte sammen informasjon om observasjonene fra de to datasettene. Jeg ser fra kodeboken at det er en variabel som heter `location` som angir den staten som er involvert i  konflikt-hendelsen. Kanskje burde vi også hatt en variabel som sa noe om i hvilke land det foregikk konflikter? Variablene `start_date`, `start_date2`,  `ep_end` og `ep_end_date` inneholder informasjon om tidspunkt. Fordi observasjonene i `aid` kan skilles fra hverandre med utgangspunkt i land og tidsperiode, tenker jeg at denne informasjonen kan brukes som nøkkel til å knytte sammen informasjon om observasjoner - dessverre kan det være nødvendig å omarbeide denne informasjonen først. La oss sjekke:



```r
# Ser på variabler med geografiks informasjon:
table(aid$country)
```

```
## 
## AFG AGO ALB ARE ARG ARM ASM ATG AZE BDI BEN BFA BGD BGR BHR BHS BIH BLR 
##   8   8   8   8   8   8   8   8   8   8   8   8   8   8   8   8   8   8 
## BLZ BOL BRA BRB BRN BTN BWA CAF CHL CHN CIV CMR COG COK COL COM CPV CRI 
##   8   8   8   8   8   8   8   8   8   8   8   8   8   8   8   8   8   8 
## CSK CUB CZE DJI DMA DOM DZA ECU EGY ERI EST ETH FJI FSM GAB GEO GHA GIN 
##   8   8   8   8   8   8   8   8   8   8   8   8   8   8   8   8   8   8 
## GLP GMB GNB GNQ GRD GTM GUY HKG HND HRV HTI HUN IDN IMY IND IRN IRQ JAM 
##   8   8   8   8   8   8   8   8   8   8   8   8   8   8   8   8   8   8 
## JOR KAZ KEN KGZ KHM KIR KNA KOR KWT LAO LBN LBR LBY LCA LKA LSO LTU LVA 
##   8   8   8   8   8   8   8   8   8   8   8   8   8   8   8   8   8   8 
## MAC MAR MDA MDG MDV MEX MHL MKD MLI MLT MMR MNG MOZ MRT MUS MWI MYS MYT 
##   8   8   8   8   8   8   8   8   8   8   8   8   8   8   8   8   8   8 
## NAM NER NGA NIC NPL NRU OMN PAK PAN PER PHL PLW PNG POL PRI PRK PRY ROM 
##   8   8   8   8   8   8   8   8   8   8   8   8   8   8   8   8   8   8 
## RUS RWA SAU SDN SEN SGP SLB SLE SLV SOM STP SUR SVK SWZ SYC SYR TCD TGO 
##   8   8   8   8   8   8   8   8   8   8   8   8   8   8   8   8   8   8 
## THA TJK TKM TON TTO TUN TUR TWN TZA UGA UKR URY UZB VCT VEN VIR VNM VUT 
##   8   8   8   8   8   8   8   8   8   8   8   8   8   8   8   8   8   8 
## WBG WSM YEM YUG ZAF ZAR ZMB ZWE 
##   8   8   8   8   8   8   8   8
```

```r
table(conflict$location)
```

```
## 
##                                               Afghanistan 
##                                                        45 
##                        Afghanistan, Russia (Soviet Union) 
##                                                         1 
##     Afghanistan, United Kingdom, United States of America 
##                                                         1 
##                                   Albania, United Kingdom 
##                                                         1 
##                                                   Algeria 
##                                                        38 
##                                          Algeria, Morocco 
##                                                         1 
##                                                    Angola 
##                                                        50 
##                                                 Argentina 
##                                                         6 
##                                 Argentina, United Kingdom 
##                                                         1 
## Australia, Iraq, United Kingdom, United States of America 
##                                                         1 
##                                                Azerbaijan 
##                                                        15 
##                                                Bangladesh 
##                                                        21 
##                                                   Bolivia 
##                                                         3 
##                                        Bosnia-Herzegovina 
##                                                         9 
##                                                    Brunei 
##                                                         1 
##                                              Burkina Faso 
##                                                         2 
##                                        Burkina Faso, Mali 
##                                                         1 
##                                                   Burundi 
##                                                        19 
##                                      Cambodia (Kampuchea) 
##                                                        38 
##                            Cambodia (Kampuchea), Thailand 
##                                                         3 
##             Cambodia (Kampuchea), Vietnam (North Vietnam) 
##                                                         3 
##                                                  Cameroon 
##                                                        13 
##                                         Cameroon, Nigeria 
##                                                         1 
##                                  Central African Republic 
##                                                         9 
##                                                      Chad 
##                                                        41 
##                                               Chad, Libya 
##                                                         1 
##                                             Chad, Nigeria 
##                                                         1 
##                                                     Chile 
##                                                         1 
##                                                     China 
##                                                         9 
##                                              China, India 
##                                                         2 
##                                    China, Myanmar (Burma) 
##                                                         1 
##                              China, Russia (Soviet Union) 
##                                                         1 
##                                             China, Taiwan 
##                                                         4 
##                            China, Vietnam (North Vietnam) 
##                                                        10 
##                                                  Colombia 
##                                                        54 
##                                                   Comoros 
##                                                         2 
##                                                     Congo 
##                                                         6 
##                                                Costa Rica 
##                                                         1 
##                                                   Croatia 
##                                                         3 
##                                                      Cuba 
##                                                         5 
##                                                    Cyprus 
##                                                         5 
##                                            Cyprus, Turkey 
##                                                         1 
##                                                  Djibouti 
##                                                         5 
##                                         Djibouti, Eritrea 
##                                                         1 
##                                        Dominican Republic 
##                                                         1 
##                                          DR Congo (Zaire) 
##                                                        31 
##                                             Ecuador, Peru 
##                                                         1 
##                                                     Egypt 
##                                                        13 
##                     Egypt, France, Israel, United Kingdom 
##                                                         1 
##               Egypt, Iraq, Israel, Jordan, Lebanon, Syria 
##                                                         2 
##                                             Egypt, Israel 
##                                                         4 
##                                     Egypt, United Kingdom 
##                                                         2 
##                                               El Salvador 
##                                                        14 
##                                     El Salvador, Honduras 
##                                                         1 
##                                                   Eritrea 
##                                                         3 
##                                         Eritrea, Ethiopia 
##                                                         4 
##                                                  Ethiopia 
##                                                       119 
##                                         Ethiopia, Somalia 
##                                                         4 
##                                                    France 
##                                                         2 
##                                          France, Thailand 
##                                                         1 
##                                           France, Tunisia 
##                                                         1 
##                                                     Gabon 
##                                                         1 
##                                                    Gambia 
##                                                         1 
##                                                   Georgia 
##                                                         8 
##                                                     Ghana 
##                                                         3 
##                                                    Greece 
##                                                         4 
##                         Grenada, United States of America 
##                                                         1 
##                                                 Guatemala 
##                                                        34 
##                                                    Guinea 
##                                                         2 
##                                             Guinea-Bissau 
##                                                        13 
##                                                     Haiti 
##                                                         3 
##                                       Honduras, Nicaragua 
##                                                         1 
##                            Hungary, Russia (Soviet Union) 
##                                                         1 
##                                                 Hyderabad 
##                                                         2 
##                                          Hyderabad, India 
##                                                         1 
##                                                     India 
##                                                       175 
##                                           India, Pakistan 
##                                                        23 
##                                                 Indonesia 
##                                                        47 
##                                       Indonesia, Malaysia 
##                                                         4 
##                                    Indonesia, Netherlands 
##                                                         1 
##                                                      Iran 
##                                                        44 
##                                                Iran, Iraq 
##                                                        10 
##                                              Iran, Israel 
##                                                         1 
##                                                      Iraq 
##                                                        60 
##                                              Iraq, Kuwait 
##                                                         2 
##                                                    Israel 
##                                                        75 
##                                            Israel, Jordan 
##                                                         1 
##                                             Israel, Syria 
##                                                         2 
##                                               Ivory Coast 
##                                                         4 
##                                                    Jordan 
##                                                         1 
##                                                     Kenya 
##                                                        10 
##                                                      Laos 
##                                                        24 
##                                            Laos, Thailand 
##                                                         3 
##                                                   Lebanon 
##                                                        13 
##                                                   Lesotho 
##                                                         1 
##                                                   Liberia 
##                                                         7 
##                                                     Libya 
##                                                         9 
##                                            Macedonia, FYR 
##                                                         1 
##                                     Madagascar (Malagasy) 
##                                                         2 
##                                                  Malaysia 
##                                                        21 
##                                                      Mali 
##                                                        19 
##                                                Mauritania 
##                                                         6 
##                                       Mauritania, Morocco 
##                                                         4 
##                                                    Mexico 
##                                                         2 
##                                                   Moldova 
##                                                         1 
##                                                   Morocco 
##                                                        20 
##                                                Mozambique 
##                                                        30 
##                                           Myanmar (Burma) 
##                                                       277 
##                                                     Nepal 
##                                                        14 
##                                                 Nicaragua 
##                                                        12 
##                                                     Niger 
##                                                        11 
##                                                   Nigeria 
##                                                        20 
##                                  North Korea, South Korea 
##                                                         5 
##                                                      Oman 
##                                                         8 
##                                                  Pakistan 
##                                                        35 
##                                                    Panama 
##                                                         1 
##                          Panama, United States of America 
##                                                         1 
##                                          Papua New Guinea 
##                                                         6 
##                                                  Paraguay 
##                                                         3 
##                                                      Peru 
##                                                        23 
##                                               Philippines 
##                                                       107 
##                                                   Rumania 
##                                                         1 
##                                     Russia (Soviet Union) 
##                                                        42 
##                                                    Rwanda 
##                                                        18 
##                                              Saudi Arabia 
##                                                         1 
##                                                   Senegal 
##                                                        10 
##                                       Serbia (Yugoslavia) 
##                                                         5 
##                                              Sierra Leone 
##                                                        11 
##                                                   Somalia 
##                                                        30 
##                                              South Africa 
##                                                        30 
##                                               South Sudan 
##                                                         8 
##                                        South Sudan, Sudan 
##                                                         1 
##                                             South Vietnam 
##                                                        10 
##                    South Vietnam, Vietnam (North Vietnam) 
##                                                        11 
##                                               South Yemen 
##                                                         5 
##                          South Yemen, Yemen (North Yemen) 
##                                                         2 
##                                                     Spain 
##                                                         9 
##                                                 Sri Lanka 
##                                                        27 
##                                                     Sudan 
##                                                        49 
##                                                  Suriname 
##                                                         1 
##                                                     Syria 
##                                                        24 
##                                                Tajikistan 
##                                                        10 
##                                          Tanzania, Uganda 
##                                                         1 
##                                                  Thailand 
##                                                        26 
##                                                      Togo 
##                                                         1 
##                                       Trinidad and Tobago 
##                                                         1 
##                                                   Tunisia 
##                                                         6 
##                                                    Turkey 
##                                                        42 
##                                                    Uganda 
##                                                        41 
##                                                   Ukraine 
##                                                         8 
##                                            United Kingdom 
##                                                        22 
##                                  United States of America 
##                                                        18 
##                                                   Uruguay 
##                                                         1 
##                                                Uzbekistan 
##                                                         3 
##                                                 Venezuela 
##                                                         3 
##                                   Vietnam (North Vietnam) 
##                                                         9 
##                                       Yemen (North Yemen) 
##                                                        26 
##                                       Zimbabwe (Rhodesia) 
##                                                         9
```

```r
# Ser at  aid$country har land-forkortelser, mens conflict$location har fulle landnavn

# Ser på variabler med informasjon om tid:
table(aid$periodstart)
```

```
## 
## 1966 1970 1974 1978 1982 1986 1990 1994 
##  170  170  170  170  170  170  170  170
```

```r
table(aid$periodend)
```

```
## 
## 1969 1973 1977 1981 1985 1989 1993 1997 
##  170  170  170  170  170  170  170  170
```

```r
table(conflict$start_date)
```

```
## 
## 1939-03-31 1941-12-31 1944-12-31 1945-08-30 1945-10-13 1945-11-19 
##          1          5          3         32          4          1 
## 1945-12-31 1946-03-31 1946-05-07 1946-05-31 1946-06-30 1946-07-18 
##          1         12          1         19          3          3 
## 1946-07-31 1946-08-31 1946-10-22 1946-11-20 1946-12-31 1947-02-28 
##         57          8          1          9          4          1 
## 1947-03-07 1947-03-29 1947-06-30 1948-01-31 1948-02-29 1948-03-03 
##          3          1          2         34         50          1 
## 1948-03-15 1948-04-15 1948-05-01 1948-05-15 1948-06-19 1948-09-13 
##         24          2         34         63         10          1 
## 1948-12-31 1949-05-31 1949-07-18 1949-10-31 1949-12-31 1950-08-05 
##        101          5         34          4         42          1 
## 1950-10-07 1950-10-30 1951-06-30 1951-10-18 1952-10-22 1953-04-30 
##          3          1         10          2          5          4 
## 1953-07-26 1953-11-07 1953-12-31 1954-11-01 1955-04-30 1955-06-02 
##          5          4          5          9         10          5 
## 1955-06-16 1955-07-20 1956-10-23 1956-10-31 1957-01-12 1957-05-01 
##          6         19          1          1          2          1 
## 1957-07-31 1957-09-30 1957-11-23 1957-12-31 1958-05-15 1958-07-14 
##          1          3          2         11         10         28 
## 1959-08-31 1959-11-12 1959-11-22 1960-01-31 1960-02-29 1960-08-31 
##          2         16         46          6         14          3 
## 1960-12-17 1961-02-04 1961-04-22 1961-07-20 1961-09-30 1961-10-27 
##         17         14          2          1         28          4 
## 1962-01-15 1962-06-03 1962-12-08 1963-02-28 1963-05-15 1963-10-08 
##          1          3          5         11         23          1 
## 1963-12-31 1964-01-03 1964-01-11 1964-02-10 1964-02-18 1964-11-19 
##         14         21         31          4          1         11 
## 1964-11-25 1964-12-31 1965-04-24 1965-07-28 1965-10-18 1965-12-31 
##          4         54          1         10         19         27 
## 1966-01-15 1966-02-23 1966-02-24 1966-04-29 1966-07-31 1966-08-26 
##         10         13          3          9         38         23 
## 1966-09-01 1967-04-30 1967-06-05 1967-07-06 1968-06-07 1968-10-31 
##          3         30          7          4          9          7 
## 1969-02-28 1969-03-02 1969-07-03 1970-04-13 1970-08-11 1970-08-20 
##          1          1          1          1         22         47 
## 1971-01-25 1971-03-26 1971-04-05 1971-04-30 1971-07-10 1971-07-22 
##         41          1          3          1          1         38 
## 1972-02-21 1972-03-25 1972-04-11 1972-08-13 1973-01-11 1973-05-18 
##          2         14         10         21         10         15 
## 1973-09-11 1974-01-19 1974-06-20 1974-08-31 1974-12-27 1975-02-28 
##          1         10          1         34         12         17 
## 1975-05-01 1975-06-30 1975-07-02 1975-07-27 1975-09-01 1975-11-11 
##          3          3         41         24         15         26 
## 1975-12-07 1975-12-10 1975-12-15 1977-12-31 1978-02-01 1978-11-11 
##         18          4          3         23          7          1 
## 1979-04-26 1979-05-30 1979-07-09 1979-11-20 1979-12-27 1980-01-27 
##         21          2         18          1          1          1 
## 1980-04-12 1981-07-30 1981-09-20 1981-10-08 1982-01-18 1982-04-02 
##          7          1         11          9         29          1 
## 1982-06-16 1982-08-01 1982-12-31 1983-04-18 1983-05-01 1983-10-25 
##          3          1          1          1         34          1 
## 1983-12-31 1984-02-06 1985-08-27 1985-12-25 1986-01-13 1986-08-21 
##         18         29         28          1          1          1 
## 1986-09-23 1986-09-30 1987-08-08 1987-10-15 1987-12-31 1988-12-31 
##          1         11          1          2          5         10 
## 1989-02-16 1989-04-03 1989-04-06 1989-05-02 1989-10-03 1989-11-27 
##         15          3          6          9          1          1 
## 1989-12-16 1989-12-17 1990-01-19 1990-01-20 1990-02-11 1990-04-05 
##          1          1          2          1         16          1 
## 1990-06-28 1990-07-27 1990-08-02 1990-10-01 1991-03-23 1991-06-03 
##          8          1          2         18         11         10 
## 1991-06-27 1991-07-09 1991-08-20 1991-10-10 1991-10-25 1991-11-12 
##          1          2          1          1          5          5 
## 1991-12-22 1991-12-29 1991-12-31 1992-03-01 1992-04-27 1992-04-29 
##          3         13          7          1          4          3 
## 1992-05-05 1992-05-12 1992-05-15 1992-08-14 1993-01-13 1993-07-21 
##         10          3          2          2          2          3 
## 1993-11-03 1993-12-16 1994-01-01 1994-01-19 1994-02-18 1994-02-21 
##          6          3          2          1          1          1 
## 1994-04-24 1994-05-27 1995-01-26 1995-03-23 1996-04-22 1997-03-16 
##          2         12          1          1          2          1 
## 1997-05-29 1997-09-03 1998-05-06 1998-06-07 1998-07-02 1998-09-04 
##          2          1          4          2          3          1 
## 1999-02-16 1999-08-29 2000-01-11 2000-06-20 2000-09-01 2001-05-27 
##          3          1          1          1          2          9 
## 2001-09-11 2001-10-07 2002-09-19 2003-03-20 2003-12-28 2004-06-04 
##         17          1          4          1          1          1 
## 2007-10-07 2008-06-10 2008-09-15 2009-06-14 2009-08-27 2011-02-28 
##          9          1          2          8          4          5 
## 2011-05-01 2011-08-20 2011-09-10 2012-03-27 2013-03-01 2013-05-14 
##          1          8          3          1          1          6 
## 2014-01-22 2014-04-12 2014-05-04 2014-06-25 2014-09-17 2014-10-10 
##          1          1          1          3          5          1 
## 2014-11-16 2015-01-05 2015-02-09 2015-03-13 2015-03-14 2015-03-15 
##          4          1          4          4          4          4 
## 2015-03-18 2015-03-19 2015-03-20 2015-03-21 2015-03-26 2015-04-19 
##          1          2          1          4          4          4 
## 2015-05-27 2015-07-23 2015-11-04 2015-12-06 2016-02-12 2016-03-02 
##          3          3          2          2          3          1 
## 2016-06-01 2016-08-15 2017-02-04 2017-09-16 2018-01-08 2018-02-10 
##          3          1          2          2          1          1
```

```r
table(conflict$year)
```

```
## 
## 1946 1947 1948 1949 1950 1951 1952 1953 1954 1955 1956 1957 1958 1959 1960 
##   17   14   20   20   18   14   14   16   15   13   17   17   18   16   15 
## 1961 1962 1963 1964 1965 1966 1967 1968 1969 1970 1971 1972 1973 1974 1975 
##   21   20   20   25   27   28   33   26   29   26   29   26   26   28   30 
## 1976 1977 1978 1979 1980 1981 1982 1983 1984 1985 1986 1987 1988 1989 1990 
##   32   36   38   41   41   41   44   43   42   38   44   47   39   40   49 
## 1991 1992 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 
##   52   49   43   48   41   41   39   40   40   38   39   33   32   33   32 
## 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 
##   33   35   38   37   31   38   33   37   42   52   53   50   52
```

```r
# Ser at det bare er informasjon om årstall i aid, mens conflict har informasjon om fulle datoer og år. Kan bare bruke minste felles multiplum - årstall
```

I dette tilfellet, er det litt komplisert å kombinere informasjonen fra de to datasettene:

* For informasjonen om tid må vi konvertere årstall (variabelen `year`) fra datasettet `conflict` til perioder. Dette kan vi gjøre ved å opprette en ny variabel gjennom omkoding.
* For den geografiske informasjonen, må vi oversette fra forkortelser til fulle landnavn. Dette kan trolig enklest gjøres ved å bruke enda flere datasett.

Årstall til perioder i `conflict`:


```r
# Oppretter periode-variabel i conflict datasettet, slik at jeg er klar til å merge. Verdiene til period-variabelen går fra 1-8, jeg vil gi de samme periodene. Her bruker jeg et en egenskap ved `as.numeric` på en faktor som ofte fører til feil i kode for å gjøre dette raskt:
table(aid$periodstart, aid$period)
```

```
##       
##          1   2   3   4   5   6   7   8
##   1966 170   0   0   0   0   0   0   0
##   1970   0 170   0   0   0   0   0   0
##   1974   0   0 170   0   0   0   0   0
##   1978   0   0   0 170   0   0   0   0
##   1982   0   0   0   0 170   0   0   0
##   1986   0   0   0   0   0 170   0   0
##   1990   0   0   0   0   0   0 170   0
##   1994   0   0   0   0   0   0   0 170
```

```r
table(aid$periodend, aid$period)
```

```
##       
##          1   2   3   4   5   6   7   8
##   1969 170   0   0   0   0   0   0   0
##   1973   0 170   0   0   0   0   0   0
##   1977   0   0 170   0   0   0   0   0
##   1981   0   0   0 170   0   0   0   0
##   1985   0   0   0   0 170   0   0   0
##   1989   0   0   0   0   0 170   0   0
##   1993   0   0   0   0   0   0 170   0
##   1997   0   0   0   0   0   0   0 170
```

```r
# Dersom jeg bruker 1966, 1970, 1974, 1978, 1982, 1986, 1990 og 1994 som kuttpunkt,
# bør jeg få de samme gruppene i conflict-datasettet som i aid

periodcutpoints <-  unique(c(aid$periodstart)) # henter ut ovennevnt årtsall med unique()
# Her buker jeg funksjonen cut(), jeg kunne også brukt ifelse(), men cut() er raskere her.
conflict$period <- cut(conflict$year, periodcutpoints)
table(conflict$year,conflict$period)
```

```
##       
##        (1966,1970] (1970,1974] (1974,1978] (1978,1982] (1982,1986]
##   1946           0           0           0           0           0
##   1947           0           0           0           0           0
##   1948           0           0           0           0           0
##   1949           0           0           0           0           0
##   1950           0           0           0           0           0
##   1951           0           0           0           0           0
##   1952           0           0           0           0           0
##   1953           0           0           0           0           0
##   1954           0           0           0           0           0
##   1955           0           0           0           0           0
##   1956           0           0           0           0           0
##   1957           0           0           0           0           0
##   1958           0           0           0           0           0
##   1959           0           0           0           0           0
##   1960           0           0           0           0           0
##   1961           0           0           0           0           0
##   1962           0           0           0           0           0
##   1963           0           0           0           0           0
##   1964           0           0           0           0           0
##   1965           0           0           0           0           0
##   1966           0           0           0           0           0
##   1967          33           0           0           0           0
##   1968          26           0           0           0           0
##   1969          29           0           0           0           0
##   1970          26           0           0           0           0
##   1971           0          29           0           0           0
##   1972           0          26           0           0           0
##   1973           0          26           0           0           0
##   1974           0          28           0           0           0
##   1975           0           0          30           0           0
##   1976           0           0          32           0           0
##   1977           0           0          36           0           0
##   1978           0           0          38           0           0
##   1979           0           0           0          41           0
##   1980           0           0           0          41           0
##   1981           0           0           0          41           0
##   1982           0           0           0          44           0
##   1983           0           0           0           0          43
##   1984           0           0           0           0          42
##   1985           0           0           0           0          38
##   1986           0           0           0           0          44
##   1987           0           0           0           0           0
##   1988           0           0           0           0           0
##   1989           0           0           0           0           0
##   1990           0           0           0           0           0
##   1991           0           0           0           0           0
##   1992           0           0           0           0           0
##   1993           0           0           0           0           0
##   1994           0           0           0           0           0
##   1995           0           0           0           0           0
##   1996           0           0           0           0           0
##   1997           0           0           0           0           0
##   1998           0           0           0           0           0
##   1999           0           0           0           0           0
##   2000           0           0           0           0           0
##   2001           0           0           0           0           0
##   2002           0           0           0           0           0
##   2003           0           0           0           0           0
##   2004           0           0           0           0           0
##   2005           0           0           0           0           0
##   2006           0           0           0           0           0
##   2007           0           0           0           0           0
##   2008           0           0           0           0           0
##   2009           0           0           0           0           0
##   2010           0           0           0           0           0
##   2011           0           0           0           0           0
##   2012           0           0           0           0           0
##   2013           0           0           0           0           0
##   2014           0           0           0           0           0
##   2015           0           0           0           0           0
##   2016           0           0           0           0           0
##   2017           0           0           0           0           0
##   2018           0           0           0           0           0
##       
##        (1986,1990] (1990,1994]
##   1946           0           0
##   1947           0           0
##   1948           0           0
##   1949           0           0
##   1950           0           0
##   1951           0           0
##   1952           0           0
##   1953           0           0
##   1954           0           0
##   1955           0           0
##   1956           0           0
##   1957           0           0
##   1958           0           0
##   1959           0           0
##   1960           0           0
##   1961           0           0
##   1962           0           0
##   1963           0           0
##   1964           0           0
##   1965           0           0
##   1966           0           0
##   1967           0           0
##   1968           0           0
##   1969           0           0
##   1970           0           0
##   1971           0           0
##   1972           0           0
##   1973           0           0
##   1974           0           0
##   1975           0           0
##   1976           0           0
##   1977           0           0
##   1978           0           0
##   1979           0           0
##   1980           0           0
##   1981           0           0
##   1982           0           0
##   1983           0           0
##   1984           0           0
##   1985           0           0
##   1986           0           0
##   1987          47           0
##   1988          39           0
##   1989          40           0
##   1990          49           0
##   1991           0          52
##   1992           0          49
##   1993           0          43
##   1994           0          48
##   1995           0           0
##   1996           0           0
##   1997           0           0
##   1998           0           0
##   1999           0           0
##   2000           0           0
##   2001           0           0
##   2002           0           0
##   2003           0           0
##   2004           0           0
##   2005           0           0
##   2006           0           0
##   2007           0           0
##   2008           0           0
##   2009           0           0
##   2010           0           0
##   2011           0           0
##   2012           0           0
##   2013           0           0
##   2014           0           0
##   2015           0           0
##   2016           0           0
##   2017           0           0
##   2018           0           0
```

```r
# Tabell viser at jeg må justere periodcutpoints for å få rett
periodcutpoints <- periodcutpoints - 1
table(periodcutpoints)
```

```
## periodcutpoints
## 1965 1969 1973 1977 1981 1985 1989 1993 
##    1    1    1    1    1    1    1    1
```

```r
periodcutpoints <- c(periodcutpoints, 1997) # legger til et siste kuttpunkt for å få med periode 8

# Forsøker på nytt:
conflict$period <- cut(conflict$year, periodcutpoints)
table(conflict$year,conflict$period)
```

```
##       
##        (1965,1969] (1969,1973] (1973,1977] (1977,1981] (1981,1985]
##   1946           0           0           0           0           0
##   1947           0           0           0           0           0
##   1948           0           0           0           0           0
##   1949           0           0           0           0           0
##   1950           0           0           0           0           0
##   1951           0           0           0           0           0
##   1952           0           0           0           0           0
##   1953           0           0           0           0           0
##   1954           0           0           0           0           0
##   1955           0           0           0           0           0
##   1956           0           0           0           0           0
##   1957           0           0           0           0           0
##   1958           0           0           0           0           0
##   1959           0           0           0           0           0
##   1960           0           0           0           0           0
##   1961           0           0           0           0           0
##   1962           0           0           0           0           0
##   1963           0           0           0           0           0
##   1964           0           0           0           0           0
##   1965           0           0           0           0           0
##   1966          28           0           0           0           0
##   1967          33           0           0           0           0
##   1968          26           0           0           0           0
##   1969          29           0           0           0           0
##   1970           0          26           0           0           0
##   1971           0          29           0           0           0
##   1972           0          26           0           0           0
##   1973           0          26           0           0           0
##   1974           0           0          28           0           0
##   1975           0           0          30           0           0
##   1976           0           0          32           0           0
##   1977           0           0          36           0           0
##   1978           0           0           0          38           0
##   1979           0           0           0          41           0
##   1980           0           0           0          41           0
##   1981           0           0           0          41           0
##   1982           0           0           0           0          44
##   1983           0           0           0           0          43
##   1984           0           0           0           0          42
##   1985           0           0           0           0          38
##   1986           0           0           0           0           0
##   1987           0           0           0           0           0
##   1988           0           0           0           0           0
##   1989           0           0           0           0           0
##   1990           0           0           0           0           0
##   1991           0           0           0           0           0
##   1992           0           0           0           0           0
##   1993           0           0           0           0           0
##   1994           0           0           0           0           0
##   1995           0           0           0           0           0
##   1996           0           0           0           0           0
##   1997           0           0           0           0           0
##   1998           0           0           0           0           0
##   1999           0           0           0           0           0
##   2000           0           0           0           0           0
##   2001           0           0           0           0           0
##   2002           0           0           0           0           0
##   2003           0           0           0           0           0
##   2004           0           0           0           0           0
##   2005           0           0           0           0           0
##   2006           0           0           0           0           0
##   2007           0           0           0           0           0
##   2008           0           0           0           0           0
##   2009           0           0           0           0           0
##   2010           0           0           0           0           0
##   2011           0           0           0           0           0
##   2012           0           0           0           0           0
##   2013           0           0           0           0           0
##   2014           0           0           0           0           0
##   2015           0           0           0           0           0
##   2016           0           0           0           0           0
##   2017           0           0           0           0           0
##   2018           0           0           0           0           0
##       
##        (1985,1989] (1989,1993] (1993,1997]
##   1946           0           0           0
##   1947           0           0           0
##   1948           0           0           0
##   1949           0           0           0
##   1950           0           0           0
##   1951           0           0           0
##   1952           0           0           0
##   1953           0           0           0
##   1954           0           0           0
##   1955           0           0           0
##   1956           0           0           0
##   1957           0           0           0
##   1958           0           0           0
##   1959           0           0           0
##   1960           0           0           0
##   1961           0           0           0
##   1962           0           0           0
##   1963           0           0           0
##   1964           0           0           0
##   1965           0           0           0
##   1966           0           0           0
##   1967           0           0           0
##   1968           0           0           0
##   1969           0           0           0
##   1970           0           0           0
##   1971           0           0           0
##   1972           0           0           0
##   1973           0           0           0
##   1974           0           0           0
##   1975           0           0           0
##   1976           0           0           0
##   1977           0           0           0
##   1978           0           0           0
##   1979           0           0           0
##   1980           0           0           0
##   1981           0           0           0
##   1982           0           0           0
##   1983           0           0           0
##   1984           0           0           0
##   1985           0           0           0
##   1986          44           0           0
##   1987          47           0           0
##   1988          39           0           0
##   1989          40           0           0
##   1990           0          49           0
##   1991           0          52           0
##   1992           0          49           0
##   1993           0          43           0
##   1994           0           0          48
##   1995           0           0          41
##   1996           0           0          41
##   1997           0           0          39
##   1998           0           0           0
##   1999           0           0           0
##   2000           0           0           0
##   2001           0           0           0
##   2002           0           0           0
##   2003           0           0           0
##   2004           0           0           0
##   2005           0           0           0
##   2006           0           0           0
##   2007           0           0           0
##   2008           0           0           0
##   2009           0           0           0
##   2010           0           0           0
##   2011           0           0           0
##   2012           0           0           0
##   2013           0           0           0
##   2014           0           0           0
##   2015           0           0           0
##   2016           0           0           0
##   2017           0           0           0
##   2018           0           0           0
```

```r
conflict$period <- as.numeric(as_factor(conflict$period))
table(conflict$year,conflict$period)
```

```
##       
##         1  2  3  4  5  6  7  8
##   1946  0  0  0  0  0  0  0  0
##   1947  0  0  0  0  0  0  0  0
##   1948  0  0  0  0  0  0  0  0
##   1949  0  0  0  0  0  0  0  0
##   1950  0  0  0  0  0  0  0  0
##   1951  0  0  0  0  0  0  0  0
##   1952  0  0  0  0  0  0  0  0
##   1953  0  0  0  0  0  0  0  0
##   1954  0  0  0  0  0  0  0  0
##   1955  0  0  0  0  0  0  0  0
##   1956  0  0  0  0  0  0  0  0
##   1957  0  0  0  0  0  0  0  0
##   1958  0  0  0  0  0  0  0  0
##   1959  0  0  0  0  0  0  0  0
##   1960  0  0  0  0  0  0  0  0
##   1961  0  0  0  0  0  0  0  0
##   1962  0  0  0  0  0  0  0  0
##   1963  0  0  0  0  0  0  0  0
##   1964  0  0  0  0  0  0  0  0
##   1965  0  0  0  0  0  0  0  0
##   1966 28  0  0  0  0  0  0  0
##   1967 33  0  0  0  0  0  0  0
##   1968 26  0  0  0  0  0  0  0
##   1969 29  0  0  0  0  0  0  0
##   1970  0 26  0  0  0  0  0  0
##   1971  0 29  0  0  0  0  0  0
##   1972  0 26  0  0  0  0  0  0
##   1973  0 26  0  0  0  0  0  0
##   1974  0  0 28  0  0  0  0  0
##   1975  0  0 30  0  0  0  0  0
##   1976  0  0 32  0  0  0  0  0
##   1977  0  0 36  0  0  0  0  0
##   1978  0  0  0 38  0  0  0  0
##   1979  0  0  0 41  0  0  0  0
##   1980  0  0  0 41  0  0  0  0
##   1981  0  0  0 41  0  0  0  0
##   1982  0  0  0  0 44  0  0  0
##   1983  0  0  0  0 43  0  0  0
##   1984  0  0  0  0 42  0  0  0
##   1985  0  0  0  0 38  0  0  0
##   1986  0  0  0  0  0 44  0  0
##   1987  0  0  0  0  0 47  0  0
##   1988  0  0  0  0  0 39  0  0
##   1989  0  0  0  0  0 40  0  0
##   1990  0  0  0  0  0  0 49  0
##   1991  0  0  0  0  0  0 52  0
##   1992  0  0  0  0  0  0 49  0
##   1993  0  0  0  0  0  0 43  0
##   1994  0  0  0  0  0  0  0 48
##   1995  0  0  0  0  0  0  0 41
##   1996  0  0  0  0  0  0  0 41
##   1997  0  0  0  0  0  0  0 39
##   1998  0  0  0  0  0  0  0  0
##   1999  0  0  0  0  0  0  0  0
##   2000  0  0  0  0  0  0  0  0
##   2001  0  0  0  0  0  0  0  0
##   2002  0  0  0  0  0  0  0  0
##   2003  0  0  0  0  0  0  0  0
##   2004  0  0  0  0  0  0  0  0
##   2005  0  0  0  0  0  0  0  0
##   2006  0  0  0  0  0  0  0  0
##   2007  0  0  0  0  0  0  0  0
##   2008  0  0  0  0  0  0  0  0
##   2009  0  0  0  0  0  0  0  0
##   2010  0  0  0  0  0  0  0  0
##   2011  0  0  0  0  0  0  0  0
##   2012  0  0  0  0  0  0  0  0
##   2013  0  0  0  0  0  0  0  0
##   2014  0  0  0  0  0  0  0  0
##   2015  0  0  0  0  0  0  0  0
##   2016  0  0  0  0  0  0  0  0
##   2017  0  0  0  0  0  0  0  0
##   2018  0  0  0  0  0  0  0  0
```

Landnavn til land-forkortelser i `conflict`: Dette kan vi gjøre selv manuelt, men det vil nok kreve en god del arbeid. En annen fremgangsmåte er å finne et tredje datasett, som inneholder både landnavn og forkortelser - en del datasett har dette. Et tredje alternativ, er å søke på nett etter en r-pakke som kan gjøre jobben for oss. Ved å google `convert country names to abbreviations r package` fant jeg [countrycode pakken](https://cran.r-project.org/web/packages/countrycode/countrycode.pdf). La oss forsøke den først:

```r
# Tester pakken countrycode:
#install.packages("countrycode")
library(countrycode)

?countrycode()
```

```
## starting httpd help server ... done
```

```r
# Argumentene origin og destination må spesifiseres
?codelist # country.name og iso3c/iso.name.en ser lovende ut

countrycode(conflict$location, origin = "country.name", destination = "iso3c")
```

```
## Warning in countrycode(conflict$location, origin = "country.name", destination = "iso3c"): Some values were not matched unambiguously: Afghanistan, Russia (Soviet Union), Afghanistan, United Kingdom, United States of America, Albania, United Kingdom, Algeria, Morocco, Argentina, United Kingdom, Australia, Iraq, United Kingdom, United States of America, Burkina Faso, Mali, Cambodia (Kampuchea), Thailand, Cambodia (Kampuchea), Vietnam (North Vietnam), Cameroon, Nigeria, Chad, Libya, Chad, Nigeria, China, India, China, Myanmar (Burma), China, Russia (Soviet Union), China, Vietnam (North Vietnam), Cyprus, Turkey, Djibouti, Eritrea, Ecuador, Peru, Egypt, France, Israel, United Kingdom, Egypt, Iraq, Israel, Jordan, Lebanon, Syria, Egypt, Israel, Egypt, United Kingdom, El Salvador, Honduras, Eritrea, Ethiopia, Ethiopia, Somalia, France, Thailand, France, Tunisia, Grenada, United States of America, Honduras, Nicaragua, Hungary, Russia (Soviet Union), Hyderabad, India, Pakistan, Indonesia, Malaysia, Indonesia, Netherlands, Iran, Iraq, Iran, Israel, Iraq, Kuwait, Israel, Jordan, Israel, Syria, Laos, Thailand, Mauritania, Morocco, Panama, United States of America, South Yemen, South Yemen, Yemen (North Yemen), Tanzania, Uganda, Yemen (North Yemen)
```

```
## Warning in countrycode(conflict$location, origin = "country.name", destination = "iso3c"): Some strings were matched more than once, and therefore set to <NA> in the result: Afghanistan, Russia (Soviet Union),AFG,RUS; Afghanistan, United Kingdom, United States of America,AFG,GBR,USA; Albania, United Kingdom,ALB,GBR; Algeria, Morocco,DZA,MAR; Argentina, United Kingdom,ARG,GBR; Australia, Iraq, United Kingdom, United States of America,AUS,IRQ,GBR,USA; Burkina Faso, Mali,BFA,MLI; Cambodia (Kampuchea), Thailand,KHM,THA; Cambodia (Kampuchea), Vietnam (North Vietnam),KHM,VNM; Cameroon, Nigeria,CMR,NGA; Chad, Libya,TCD,LBY; Chad, Nigeria,TCD,NGA; China, India,CHN,IND; China, Myanmar (Burma),CHN,MMR; China, Russia (Soviet Union),CHN,RUS; China, Vietnam (North Vietnam),CHN,VNM; Cyprus, Turkey,CYP,TUR; Djibouti, Eritrea,DJI,ERI; Ecuador, Peru,ECU,PER; Egypt, France, Israel, United Kingdom,EGY,FRA,ISR,GBR; Egypt, Iraq, Israel, Jordan, Lebanon, Syria,EGY,IRQ,ISR,JOR,LBN,SYR; Egypt, Israel,EGY,ISR; Egypt, United Kingdom,EGY,GBR; El Salvador, Honduras,SLV,HND; Eritrea, Ethiopia,ERI,ETH; Ethiopia, Somalia,ETH,SOM; France, Thailand,FRA,THA; France, Tunisia,FRA,TUN; Grenada, United States of America,GRD,USA; Honduras, Nicaragua,HND,NIC; Hungary, Russia (Soviet Union),HUN,RUS; India, Pakistan,IND,PAK; Indonesia, Malaysia,IDN,MYS; Indonesia, Netherlands,IDN,NLD; Iran, Iraq,IRN,IRQ; Iran, Israel,IRN,ISR; Iraq, Kuwait,IRQ,KWT; Israel, Jordan,ISR,JOR; Israel, Syria,ISR,SYR; Laos, Thailand,LAO,THA; Mauritania, Morocco,MRT,MAR; Panama, United States of America,PAN,USA; Tanzania, Uganda,UGA,TZA
```

```
##    [1] "AFG" "AFG" "AFG" "AFG" "AFG" "AFG" "AFG" "AFG" "AFG" "AFG" "AFG"
##   [12] "AFG" "AFG" "AFG" "AFG" "AFG" "AFG" "AFG" "AFG" "AFG" "AFG" "AFG"
##   [23] "AFG" "AFG" "AFG" "AFG" "AFG" "AFG" "AFG" "AFG" "AFG" "AFG" "AFG"
##   [34] "AFG" "AFG" "AFG" "AFG" "AFG" "AFG" "AFG" "AFG" "AFG" "AFG" "AFG"
##   [45] "AFG" NA    NA    NA    "DZA" "DZA" "DZA" "DZA" "DZA" "DZA" "DZA"
##   [56] "DZA" "DZA" "DZA" "DZA" "DZA" "DZA" "DZA" "DZA" "DZA" "DZA" "DZA"
##   [67] "DZA" "DZA" "DZA" "DZA" "DZA" "DZA" "DZA" "DZA" "DZA" "DZA" "DZA"
##   [78] "DZA" "DZA" "DZA" "DZA" "DZA" "DZA" "DZA" "DZA" "DZA" NA    "AGO"
##   [89] "AGO" "AGO" "AGO" "AGO" "AGO" "AGO" "AGO" "AGO" "AGO" "AGO" "AGO"
##  [100] "AGO" "AGO" "AGO" "AGO" "AGO" "AGO" "AGO" "AGO" "AGO" "AGO" "AGO"
##  [111] "AGO" "AGO" "AGO" "AGO" "AGO" "AGO" "AGO" "AGO" "AGO" "AGO" "AGO"
##  [122] "AGO" "AGO" "AGO" "AGO" "AGO" "AGO" "AGO" "AGO" "AGO" "AGO" "AGO"
##  [133] "AGO" "AGO" "AGO" "AGO" "AGO" "ARG" "ARG" "ARG" "ARG" "ARG" "ARG"
##  [144] NA    NA    "AZE" "AZE" "AZE" "AZE" "AZE" "AZE" "AZE" "AZE" "AZE"
##  [155] "AZE" "AZE" "AZE" "AZE" "AZE" "AZE" "BGD" "BGD" "BGD" "BGD" "BGD"
##  [166] "BGD" "BGD" "BGD" "BGD" "BGD" "BGD" "BGD" "BGD" "BGD" "BGD" "BGD"
##  [177] "BGD" "BGD" "BGD" "BGD" "BGD" "BOL" "BOL" "BOL" "BIH" "BIH" "BIH"
##  [188] "BIH" "BIH" "BIH" "BIH" "BIH" "BIH" "BRN" "BFA" "BFA" NA    "BDI"
##  [199] "BDI" "BDI" "BDI" "BDI" "BDI" "BDI" "BDI" "BDI" "BDI" "BDI" "BDI"
##  [210] "BDI" "BDI" "BDI" "BDI" "BDI" "BDI" "BDI" "KHM" "KHM" "KHM" "KHM"
##  [221] "KHM" "KHM" "KHM" "KHM" "KHM" "KHM" "KHM" "KHM" "KHM" "KHM" "KHM"
##  [232] "KHM" "KHM" "KHM" "KHM" "KHM" "KHM" "KHM" "KHM" "KHM" "KHM" "KHM"
##  [243] "KHM" "KHM" "KHM" "KHM" "KHM" "KHM" "KHM" "KHM" "KHM" "KHM" "KHM"
##  [254] "KHM" NA    NA    NA    NA    NA    NA    "CMR" "CMR" "CMR" "CMR"
##  [265] "CMR" "CMR" "CMR" "CMR" "CMR" "CMR" "CMR" "CMR" "CMR" NA    "CAF"
##  [276] "CAF" "CAF" "CAF" "CAF" "CAF" "CAF" "CAF" "CAF" "TCD" "TCD" "TCD"
##  [287] "TCD" "TCD" "TCD" "TCD" "TCD" "TCD" "TCD" "TCD" "TCD" "TCD" "TCD"
##  [298] "TCD" "TCD" "TCD" "TCD" "TCD" "TCD" "TCD" "TCD" "TCD" "TCD" "TCD"
##  [309] "TCD" "TCD" "TCD" "TCD" "TCD" "TCD" "TCD" "TCD" "TCD" "TCD" "TCD"
##  [320] "TCD" "TCD" "TCD" "TCD" "TCD" NA    NA    "CHL" "CHN" "CHN" "CHN"
##  [331] "CHN" "CHN" "CHN" "CHN" "CHN" "CHN" NA    NA    NA    NA    "TWN"
##  [342] "TWN" "TWN" "TWN" NA    NA    NA    NA    NA    NA    NA    NA   
##  [353] NA    NA    "COL" "COL" "COL" "COL" "COL" "COL" "COL" "COL" "COL"
##  [364] "COL" "COL" "COL" "COL" "COL" "COL" "COL" "COL" "COL" "COL" "COL"
##  [375] "COL" "COL" "COL" "COL" "COL" "COL" "COL" "COL" "COL" "COL" "COL"
##  [386] "COL" "COL" "COL" "COL" "COL" "COL" "COL" "COL" "COL" "COL" "COL"
##  [397] "COL" "COL" "COL" "COL" "COL" "COL" "COL" "COL" "COL" "COL" "COL"
##  [408] "COL" "COM" "COM" "COG" "COG" "COG" "COG" "COG" "COG" "CRI" "HRV"
##  [419] "HRV" "HRV" "CUB" "CUB" "CUB" "CUB" "CUB" "CYP" "CYP" "CYP" "CYP"
##  [430] "CYP" NA    "DJI" "DJI" "DJI" "DJI" "DJI" NA    "DOM" "COD" "COD"
##  [441] "COD" "COD" "COD" "COD" "COD" "COD" "COD" "COD" "COD" "COD" "COD"
##  [452] "COD" "COD" "COD" "COD" "COD" "COD" "COD" "COD" "COD" "COD" "COD"
##  [463] "COD" "COD" "COD" "COD" "COD" "COD" "COD" NA    "EGY" "EGY" "EGY"
##  [474] "EGY" "EGY" "EGY" "EGY" "EGY" "EGY" "EGY" "EGY" "EGY" "EGY" NA   
##  [485] NA    NA    NA    NA    NA    NA    NA    NA    "SLV" "SLV" "SLV"
##  [496] "SLV" "SLV" "SLV" "SLV" "SLV" "SLV" "SLV" "SLV" "SLV" "SLV" "SLV"
##  [507] NA    "ERI" "ERI" "ERI" NA    NA    NA    NA    "ETH" "ETH" "ETH"
##  [518] "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH"
##  [529] "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH"
##  [540] "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH"
##  [551] "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH"
##  [562] "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH"
##  [573] "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH"
##  [584] "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH"
##  [595] "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH"
##  [606] "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH"
##  [617] "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH"
##  [628] "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" NA    NA    NA    NA    "FRA"
##  [639] "FRA" NA    NA    "GAB" "GMB" "GEO" "GEO" "GEO" "GEO" "GEO" "GEO"
##  [650] "GEO" "GEO" "GHA" "GHA" "GHA" "GRC" "GRC" "GRC" "GRC" NA    "GTM"
##  [661] "GTM" "GTM" "GTM" "GTM" "GTM" "GTM" "GTM" "GTM" "GTM" "GTM" "GTM"
##  [672] "GTM" "GTM" "GTM" "GTM" "GTM" "GTM" "GTM" "GTM" "GTM" "GTM" "GTM"
##  [683] "GTM" "GTM" "GTM" "GTM" "GTM" "GTM" "GTM" "GTM" "GTM" "GTM" "GTM"
##  [694] "GIN" "GIN" "GNB" "GNB" "GNB" "GNB" "GNB" "GNB" "GNB" "GNB" "GNB"
##  [705] "GNB" "GNB" "GNB" "GNB" "HTI" "HTI" "HTI" NA    NA    NA    NA   
##  [716] "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND"
##  [727] "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND"
##  [738] "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND"
##  [749] "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND"
##  [760] "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND"
##  [771] "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND"
##  [782] "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND"
##  [793] "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND"
##  [804] "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND"
##  [815] "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND"
##  [826] "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND"
##  [837] "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND"
##  [848] "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND"
##  [859] "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND"
##  [870] "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND"
##  [881] "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND"
##  [892] NA    NA    NA    NA    NA    NA    NA    NA    NA    NA    NA   
##  [903] NA    NA    NA    NA    NA    NA    NA    NA    NA    NA    NA   
##  [914] NA    "IDN" "IDN" "IDN" "IDN" "IDN" "IDN" "IDN" "IDN" "IDN" "IDN"
##  [925] "IDN" "IDN" "IDN" "IDN" "IDN" "IDN" "IDN" "IDN" "IDN" "IDN" "IDN"
##  [936] "IDN" "IDN" "IDN" "IDN" "IDN" "IDN" "IDN" "IDN" "IDN" "IDN" "IDN"
##  [947] "IDN" "IDN" "IDN" "IDN" "IDN" "IDN" "IDN" "IDN" "IDN" "IDN" "IDN"
##  [958] "IDN" "IDN" "IDN" "IDN" NA    NA    NA    NA    NA    "IRN" "IRN"
##  [969] "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" "IRN"
##  [980] "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" "IRN"
##  [991] "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" "IRN"
## [1002] "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" NA    NA   
## [1013] NA    NA    NA    NA    NA    NA    NA    NA    NA    "IRQ" "IRQ"
## [1024] "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ"
## [1035] "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ"
## [1046] "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ"
## [1057] "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ"
## [1068] "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ"
## [1079] "IRQ" "IRQ" "IRQ" NA    NA    "ISR" "ISR" "ISR" "ISR" "ISR" "ISR"
## [1090] "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR"
## [1101] "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR"
## [1112] "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR"
## [1123] "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR"
## [1134] "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR"
## [1145] "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR"
## [1156] "ISR" "ISR" "ISR" NA    NA    NA    "CIV" "CIV" "CIV" "CIV" "JOR"
## [1167] "KEN" "KEN" "KEN" "KEN" "KEN" "KEN" "KEN" "KEN" "KEN" "KEN" "LAO"
## [1178] "LAO" "LAO" "LAO" "LAO" "LAO" "LAO" "LAO" "LAO" "LAO" "LAO" "LAO"
## [1189] "LAO" "LAO" "LAO" "LAO" "LAO" "LAO" "LAO" "LAO" "LAO" "LAO" "LAO"
## [1200] "LAO" NA    NA    NA    "LBN" "LBN" "LBN" "LBN" "LBN" "LBN" "LBN"
## [1211] "LBN" "LBN" "LBN" "LBN" "LBN" "LBN" "LSO" "LBR" "LBR" "LBR" "LBR"
## [1222] "LBR" "LBR" "LBR" "LBY" "LBY" "LBY" "LBY" "LBY" "LBY" "LBY" "LBY"
## [1233] "LBY" "MKD" "MDG" "MDG" "MYS" "MYS" "MYS" "MYS" "MYS" "MYS" "MYS"
## [1244] "MYS" "MYS" "MYS" "MYS" "MYS" "MYS" "MYS" "MYS" "MYS" "MYS" "MYS"
## [1255] "MYS" "MYS" "MYS" "MLI" "MLI" "MLI" "MLI" "MLI" "MLI" "MLI" "MLI"
## [1266] "MLI" "MLI" "MLI" "MLI" "MLI" "MLI" "MLI" "MLI" "MLI" "MLI" "MLI"
## [1277] "MRT" "MRT" "MRT" "MRT" "MRT" "MRT" NA    NA    NA    NA    "MEX"
## [1288] "MEX" "MDA" "MAR" "MAR" "MAR" "MAR" "MAR" "MAR" "MAR" "MAR" "MAR"
## [1299] "MAR" "MAR" "MAR" "MAR" "MAR" "MAR" "MAR" "MAR" "MAR" "MAR" "MAR"
## [1310] "MOZ" "MOZ" "MOZ" "MOZ" "MOZ" "MOZ" "MOZ" "MOZ" "MOZ" "MOZ" "MOZ"
## [1321] "MOZ" "MOZ" "MOZ" "MOZ" "MOZ" "MOZ" "MOZ" "MOZ" "MOZ" "MOZ" "MOZ"
## [1332] "MOZ" "MOZ" "MOZ" "MOZ" "MOZ" "MOZ" "MOZ" "MOZ" "MMR" "MMR" "MMR"
## [1343] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1354] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1365] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1376] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1387] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1398] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1409] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1420] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1431] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1442] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1453] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1464] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1475] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1486] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1497] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1508] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1519] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1530] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1541] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1552] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1563] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1574] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1585] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1596] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1607] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "NPL"
## [1618] "NPL" "NPL" "NPL" "NPL" "NPL" "NPL" "NPL" "NPL" "NPL" "NPL" "NPL"
## [1629] "NPL" "NPL" "NIC" "NIC" "NIC" "NIC" "NIC" "NIC" "NIC" "NIC" "NIC"
## [1640] "NIC" "NIC" "NIC" "NER" "NER" "NER" "NER" "NER" "NER" "NER" "NER"
## [1651] "NER" "NER" "NER" "NGA" "NGA" "NGA" "NGA" "NGA" "NGA" "NGA" "NGA"
## [1662] "NGA" "NGA" "NGA" "NGA" "NGA" "NGA" "NGA" "NGA" "NGA" "NGA" "NGA"
## [1673] "NGA" "PRK" "PRK" "PRK" "PRK" "PRK" "OMN" "OMN" "OMN" "OMN" "OMN"
## [1684] "OMN" "OMN" "OMN" "PAK" "PAK" "PAK" "PAK" "PAK" "PAK" "PAK" "PAK"
## [1695] "PAK" "PAK" "PAK" "PAK" "PAK" "PAK" "PAK" "PAK" "PAK" "PAK" "PAK"
## [1706] "PAK" "PAK" "PAK" "PAK" "PAK" "PAK" "PAK" "PAK" "PAK" "PAK" "PAK"
## [1717] "PAK" "PAK" "PAK" "PAK" "PAK" "PAN" NA    "PNG" "PNG" "PNG" "PNG"
## [1728] "PNG" "PNG" "PRY" "PRY" "PRY" "PER" "PER" "PER" "PER" "PER" "PER"
## [1739] "PER" "PER" "PER" "PER" "PER" "PER" "PER" "PER" "PER" "PER" "PER"
## [1750] "PER" "PER" "PER" "PER" "PER" "PER" "PHL" "PHL" "PHL" "PHL" "PHL"
## [1761] "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL"
## [1772] "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL"
## [1783] "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL"
## [1794] "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL"
## [1805] "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL"
## [1816] "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL"
## [1827] "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL"
## [1838] "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL"
## [1849] "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL"
## [1860] "PHL" "PHL" "PHL" "ROU" "RUS" "RUS" "RUS" "RUS" "RUS" "RUS" "RUS"
## [1871] "RUS" "RUS" "RUS" "RUS" "RUS" "RUS" "RUS" "RUS" "RUS" "RUS" "RUS"
## [1882] "RUS" "RUS" "RUS" "RUS" "RUS" "RUS" "RUS" "RUS" "RUS" "RUS" "RUS"
## [1893] "RUS" "RUS" "RUS" "RUS" "RUS" "RUS" "RUS" "RUS" "RUS" "RUS" "RUS"
## [1904] "RUS" "RUS" "RWA" "RWA" "RWA" "RWA" "RWA" "RWA" "RWA" "RWA" "RWA"
## [1915] "RWA" "RWA" "RWA" "RWA" "RWA" "RWA" "RWA" "RWA" "RWA" "SAU" "SEN"
## [1926] "SEN" "SEN" "SEN" "SEN" "SEN" "SEN" "SEN" "SEN" "SEN" "SRB" "SRB"
## [1937] "SRB" "SRB" "SRB" "SLE" "SLE" "SLE" "SLE" "SLE" "SLE" "SLE" "SLE"
## [1948] "SLE" "SLE" "SLE" "SOM" "SOM" "SOM" "SOM" "SOM" "SOM" "SOM" "SOM"
## [1959] "SOM" "SOM" "SOM" "SOM" "SOM" "SOM" "SOM" "SOM" "SOM" "SOM" "SOM"
## [1970] "SOM" "SOM" "SOM" "SOM" "SOM" "SOM" "SOM" "SOM" "SOM" "SOM" "SOM"
## [1981] "ZAF" "ZAF" "ZAF" "ZAF" "ZAF" "ZAF" "ZAF" "ZAF" "ZAF" "ZAF" "ZAF"
## [1992] "ZAF" "ZAF" "ZAF" "ZAF" "ZAF" "ZAF" "ZAF" "ZAF" "ZAF" "ZAF" "ZAF"
## [2003] "ZAF" "ZAF" "ZAF" "ZAF" "ZAF" "ZAF" "ZAF" "ZAF" "SSD" "SSD" "SSD"
## [2014] "SSD" "SSD" "SSD" "SSD" "SSD" "SSD" "VNM" "VNM" "VNM" "VNM" "VNM"
## [2025] "VNM" "VNM" "VNM" "VNM" "VNM" "VNM" "VNM" "VNM" "VNM" "VNM" "VNM"
## [2036] "VNM" "VNM" "VNM" "VNM" "VNM" NA    NA    NA    NA    NA    NA   
## [2047] NA    "ESP" "ESP" "ESP" "ESP" "ESP" "ESP" "ESP" "ESP" "ESP" "LKA"
## [2058] "LKA" "LKA" "LKA" "LKA" "LKA" "LKA" "LKA" "LKA" "LKA" "LKA" "LKA"
## [2069] "LKA" "LKA" "LKA" "LKA" "LKA" "LKA" "LKA" "LKA" "LKA" "LKA" "LKA"
## [2080] "LKA" "LKA" "LKA" "LKA" "SDN" "SDN" "SDN" "SDN" "SDN" "SDN" "SDN"
## [2091] "SDN" "SDN" "SDN" "SDN" "SDN" "SDN" "SDN" "SDN" "SDN" "SDN" "SDN"
## [2102] "SDN" "SDN" "SDN" "SDN" "SDN" "SDN" "SDN" "SDN" "SDN" "SDN" "SDN"
## [2113] "SDN" "SDN" "SDN" "SDN" "SDN" "SDN" "SDN" "SDN" "SDN" "SDN" "SDN"
## [2124] "SDN" "SDN" "SDN" "SDN" "SDN" "SDN" "SDN" "SDN" "SDN" "SUR" "SYR"
## [2135] "SYR" "SYR" "SYR" "SYR" "SYR" "SYR" "SYR" "SYR" "SYR" "SYR" "SYR"
## [2146] "SYR" "SYR" "SYR" "SYR" "SYR" "SYR" "SYR" "SYR" "SYR" "SYR" "SYR"
## [2157] "SYR" "TJK" "TJK" "TJK" "TJK" "TJK" "TJK" "TJK" "TJK" "TJK" "TJK"
## [2168] NA    "THA" "THA" "THA" "THA" "THA" "THA" "THA" "THA" "THA" "THA"
## [2179] "THA" "THA" "THA" "THA" "THA" "THA" "THA" "THA" "THA" "THA" "THA"
## [2190] "THA" "THA" "THA" "THA" "THA" "TGO" "TTO" "TUN" "TUN" "TUN" "TUN"
## [2201] "TUN" "TUN" "TUR" "TUR" "TUR" "TUR" "TUR" "TUR" "TUR" "TUR" "TUR"
## [2212] "TUR" "TUR" "TUR" "TUR" "TUR" "TUR" "TUR" "TUR" "TUR" "TUR" "TUR"
## [2223] "TUR" "TUR" "TUR" "TUR" "TUR" "TUR" "TUR" "TUR" "TUR" "TUR" "TUR"
## [2234] "TUR" "TUR" "TUR" "TUR" "TUR" "TUR" "TUR" "TUR" "TUR" "TUR" "TUR"
## [2245] "UGA" "UGA" "UGA" "UGA" "UGA" "UGA" "UGA" "UGA" "UGA" "UGA" "UGA"
## [2256] "UGA" "UGA" "UGA" "UGA" "UGA" "UGA" "UGA" "UGA" "UGA" "UGA" "UGA"
## [2267] "UGA" "UGA" "UGA" "UGA" "UGA" "UGA" "UGA" "UGA" "UGA" "UGA" "UGA"
## [2278] "UGA" "UGA" "UGA" "UGA" "UGA" "UGA" "UGA" "UGA" "UKR" "UKR" "UKR"
## [2289] "UKR" "UKR" "UKR" "UKR" "UKR" "GBR" "GBR" "GBR" "GBR" "GBR" "GBR"
## [2300] "GBR" "GBR" "GBR" "GBR" "GBR" "GBR" "GBR" "GBR" "GBR" "GBR" "GBR"
## [2311] "GBR" "GBR" "GBR" "GBR" "GBR" "USA" "USA" "USA" "USA" "USA" "USA"
## [2322] "USA" "USA" "USA" "USA" "USA" "USA" "USA" "USA" "USA" "USA" "USA"
## [2333] "USA" "URY" "UZB" "UZB" "UZB" "VEN" "VEN" "VEN" "VNM" "VNM" "VNM"
## [2344] "VNM" "VNM" "VNM" "VNM" "VNM" "VNM" NA    NA    NA    NA    NA   
## [2355] NA    NA    NA    NA    NA    NA    NA    NA    NA    NA    NA   
## [2366] NA    NA    NA    NA    NA    NA    NA    NA    NA    NA    "ZWE"
## [2377] "ZWE" "ZWE" "ZWE" "ZWE" "ZWE" "ZWE" "ZWE" "ZWE"
```

```r
# ser at dette fører til en del missing - kan rettes manuelt
?codelist
# Ser imidlertid at jeg har en annen variabel, gwno_a som kan fungere bedre:
countrycode(conflict$gwno_a, origin = "gwn", destination = "iso3c")
```

```
## Warning in countrycode(conflict$gwno_a, origin = "gwn", destination = "iso3c"): Some values were not matched unambiguously: 345, 55, 651, 645, 663, 660, 652, 678, 680, 751, 900, 200, 2
```

```
##    [1] "AFG" "AFG" "AFG" "AFG" "AFG" "AFG" "AFG" "AFG" "AFG" "AFG" "AFG"
##   [12] "AFG" "AFG" "AFG" "AFG" "AFG" "AFG" "AFG" "AFG" "AFG" "AFG" "AFG"
##   [23] "AFG" "AFG" "AFG" "AFG" "AFG" "AFG" "AFG" "AFG" "AFG" "AFG" "AFG"
##   [34] "AFG" "AFG" "AFG" "AFG" "AFG" "AFG" "AFG" "AFG" "AFG" "AFG" "AFG"
##   [45] "AFG" "AFG" "AFG" "ALB" "DZA" "FRA" "FRA" "FRA" "FRA" "FRA" "FRA"
##   [56] "FRA" "FRA" "FRA" "DZA" "DZA" "DZA" "DZA" "DZA" "DZA" "DZA" "DZA"
##   [67] "DZA" "DZA" "DZA" "DZA" "DZA" "DZA" "DZA" "DZA" "DZA" "DZA" "DZA"
##   [78] "DZA" "DZA" "DZA" "DZA" "DZA" "DZA" "DZA" "DZA" "DZA" "DZA" "PRT"
##   [89] "PRT" "PRT" "PRT" "PRT" "PRT" "PRT" "PRT" "PRT" "PRT" "PRT" "PRT"
##  [100] "PRT" "PRT" "AGO" "AGO" "AGO" "AGO" "AGO" "AGO" "AGO" "AGO" "AGO"
##  [111] "AGO" "AGO" "AGO" "AGO" "AGO" "AGO" "AGO" "AGO" "AGO" "AGO" "AGO"
##  [122] "AGO" "AGO" "AGO" "AGO" "AGO" "AGO" "AGO" "AGO" "AGO" "AGO" "AGO"
##  [133] "AGO" "AGO" "AGO" "AGO" "AGO" "ARG" "ARG" "ARG" "ARG" "ARG" "ARG"
##  [144] "ARG" NA    "AZE" "AZE" "AZE" "AZE" "AZE" "AZE" "AZE" "AZE" "AZE"
##  [155] "AZE" "AZE" "AZE" "AZE" "AZE" "AZE" "BGD" "BGD" "BGD" "BGD" "BGD"
##  [166] "BGD" "BGD" "BGD" "BGD" "BGD" "BGD" "BGD" "BGD" "BGD" "BGD" "BGD"
##  [177] "BGD" "BGD" "BGD" "BGD" "BGD" "BOL" "BOL" "BOL" "BIH" "BIH" "BIH"
##  [188] "BIH" "BIH" "BIH" "BIH" "BIH" "BIH" "GBR" "BFA" "BFA" "BFA" "BDI"
##  [199] "BDI" "BDI" "BDI" "BDI" "BDI" "BDI" "BDI" "BDI" "BDI" "BDI" "BDI"
##  [210] "BDI" "BDI" "BDI" "BDI" "BDI" "BDI" "BDI" "FRA" "FRA" "FRA" "FRA"
##  [221] "FRA" "FRA" "FRA" "FRA" "KHM" "KHM" "KHM" "KHM" "KHM" "KHM" "KHM"
##  [232] "KHM" "KHM" "KHM" "KHM" "KHM" "KHM" "KHM" "KHM" "KHM" "KHM" "KHM"
##  [243] "KHM" "KHM" "KHM" "KHM" "KHM" "KHM" "KHM" "KHM" "KHM" "KHM" "KHM"
##  [254] "KHM" "KHM" "KHM" "KHM" "KHM" "KHM" "KHM" "CMR" "CMR" "CMR" "CMR"
##  [265] "FRA" "FRA" "FRA" "CMR" "CMR" "CMR" "CMR" "CMR" "CMR" "CMR" "CAF"
##  [276] "CAF" "CAF" "CAF" "CAF" "CAF" "CAF" "CAF" "CAF" "TCD" "TCD" "TCD"
##  [287] "TCD" "TCD" "TCD" "TCD" "TCD" "TCD" "TCD" "TCD" "TCD" "TCD" "TCD"
##  [298] "TCD" "TCD" "TCD" "TCD" "TCD" "TCD" "TCD" "TCD" "TCD" "TCD" "TCD"
##  [309] "TCD" "TCD" "TCD" "TCD" "TCD" "TCD" "TCD" "TCD" "TCD" "TCD" "TCD"
##  [320] "TCD" "TCD" "TCD" "TCD" "TCD" "TCD" "TCD" "CHL" "CHN" "CHN" "CHN"
##  [331] "CHN" "CHN" "CHN" "CHN" "CHN" "CHN" "CHN" "CHN" "CHN" "CHN" "CHN"
##  [342] "CHN" "CHN" "CHN" "CHN" "CHN" "CHN" "CHN" "CHN" "CHN" "CHN" "CHN"
##  [353] "CHN" "CHN" "COL" "COL" "COL" "COL" "COL" "COL" "COL" "COL" "COL"
##  [364] "COL" "COL" "COL" "COL" "COL" "COL" "COL" "COL" "COL" "COL" "COL"
##  [375] "COL" "COL" "COL" "COL" "COL" "COL" "COL" "COL" "COL" "COL" "COL"
##  [386] "COL" "COL" "COL" "COL" "COL" "COL" "COL" "COL" "COL" "COL" "COL"
##  [397] "COL" "COL" "COL" "COL" "COL" "COL" "COL" "COL" "COL" "COL" "COL"
##  [408] "COL" "COM" "COM" "COG" "COG" "COG" "COG" "COG" "COG" "CRI" "HRV"
##  [419] "HRV" "HRV" "CUB" "CUB" "CUB" "CUB" "CUB" "GBR" "GBR" "GBR" "GBR"
##  [430] "GBR" "CYP" "DJI" "DJI" "DJI" "DJI" "DJI" "DJI" "DOM" "COD" "COD"
##  [441] "COD" "COD" "COD" "COD" "COD" "COD" "COD" "COD" "COD" "COD" "COD"
##  [452] "COD" "COD" "COD" "COD" "COD" "COD" "COD" "COD" "COD" "COD" "COD"
##  [463] "COD" "COD" "COD" "COD" "COD" "COD" "COD" "ECU" "EGY" "EGY" "EGY"
##  [474] "EGY" "EGY" "EGY" "EGY" "EGY" "EGY" "EGY" "EGY" "EGY" "EGY" "EGY"
##  [485] NA    NA    "EGY" "EGY" "EGY" "EGY" "EGY" "EGY" "SLV" "SLV" "SLV"
##  [496] "SLV" "SLV" "SLV" "SLV" "SLV" "SLV" "SLV" "SLV" "SLV" "SLV" "SLV"
##  [507] "SLV" "ERI" "ERI" "ERI" "ERI" "ERI" "ERI" "ERI" "ETH" "ETH" "ETH"
##  [518] "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH"
##  [529] "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH"
##  [540] "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH"
##  [551] "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH"
##  [562] "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH"
##  [573] "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH"
##  [584] "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH"
##  [595] "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH"
##  [606] "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH"
##  [617] "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH"
##  [628] "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "ETH" "FRA"
##  [639] "FRA" "FRA" "FRA" "GAB" "GMB" "GEO" "GEO" "GEO" "GEO" "GEO" "GEO"
##  [650] "GEO" "GEO" "GHA" "GHA" "GHA" "GRC" "GRC" "GRC" "GRC" NA    "GTM"
##  [661] "GTM" "GTM" "GTM" "GTM" "GTM" "GTM" "GTM" "GTM" "GTM" "GTM" "GTM"
##  [672] "GTM" "GTM" "GTM" "GTM" "GTM" "GTM" "GTM" "GTM" "GTM" "GTM" "GTM"
##  [683] "GTM" "GTM" "GTM" "GTM" "GTM" "GTM" "GTM" "GTM" "GTM" "GTM" "GTM"
##  [694] "GIN" "GIN" "PRT" "PRT" "PRT" "PRT" "PRT" "PRT" "PRT" "PRT" "PRT"
##  [705] "PRT" "PRT" "GNB" "GNB" "HTI" "HTI" "HTI" "HND" "HUN" NA    NA   
##  [716] NA    "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND"
##  [727] "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND"
##  [738] "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND"
##  [749] "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND"
##  [760] "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND"
##  [771] "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND"
##  [782] "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND"
##  [793] "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND"
##  [804] "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND"
##  [815] "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND"
##  [826] "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND"
##  [837] "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND"
##  [848] "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND"
##  [859] "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND"
##  [870] "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND"
##  [881] "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND"
##  [892] "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND"
##  [903] "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND" "IND"
##  [914] "IND" "NLD" "NLD" "NLD" "NLD" "IDN" "IDN" "IDN" "IDN" "IDN" "IDN"
##  [925] "IDN" "IDN" "IDN" "IDN" "IDN" "IDN" "IDN" "IDN" "IDN" "IDN" "IDN"
##  [936] "IDN" "IDN" "IDN" "IDN" "IDN" "IDN" "IDN" "IDN" "IDN" "IDN" "IDN"
##  [947] "IDN" "IDN" "IDN" "IDN" "IDN" "IDN" "IDN" "IDN" "IDN" "IDN" "IDN"
##  [958] "IDN" "IDN" "IDN" "IDN" "IDN" "IDN" "IDN" "IDN" "IDN" "IRN" "IRN"
##  [969] "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" "IRN"
##  [980] "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" "IRN"
##  [991] "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" "IRN"
## [1002] "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" "IRN"
## [1013] "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" "IRN" "IRQ" "IRQ"
## [1024] "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ"
## [1035] "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ"
## [1046] "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ"
## [1057] "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ"
## [1068] "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "IRQ"
## [1079] "IRQ" "IRQ" "IRQ" "IRQ" "IRQ" "GBR" "ISR" "ISR" "ISR" "ISR" "ISR"
## [1090] "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR"
## [1101] "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR"
## [1112] "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR"
## [1123] "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR"
## [1134] "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR"
## [1145] "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "ISR"
## [1156] "ISR" "ISR" "ISR" "ISR" "ISR" "ISR" "CIV" "CIV" "CIV" "CIV" "JOR"
## [1167] "KEN" "KEN" "KEN" "KEN" "GBR" "GBR" "GBR" "GBR" "GBR" "KEN" "FRA"
## [1178] "FRA" "FRA" "FRA" "FRA" "FRA" "FRA" "FRA" "LAO" "LAO" "LAO" "LAO"
## [1189] "LAO" "LAO" "LAO" "LAO" "LAO" "LAO" "LAO" "LAO" "LAO" "LAO" "LAO"
## [1200] "LAO" "LAO" "LAO" "LAO" "LBN" "LBN" "LBN" "LBN" "LBN" "LBN" "LBN"
## [1211] "LBN" "LBN" "LBN" "LBN" "LBN" "LBN" "LSO" "LBR" "LBR" "LBR" "LBR"
## [1222] "LBR" "LBR" "LBR" "LBY" "LBY" "LBY" "LBY" "LBY" "LBY" "LBY" "LBY"
## [1233] "LBY" "MKD" "FRA" "MDG" "MYS" "GBR" "GBR" "GBR" "GBR" "GBR" "GBR"
## [1244] "GBR" "GBR" "GBR" "GBR" "MYS" "MYS" "MYS" "MYS" "MYS" "MYS" "MYS"
## [1255] "MYS" "MYS" "MYS" "MLI" "MLI" "MLI" "MLI" "MLI" "MLI" "MLI" "MLI"
## [1266] "MLI" "MLI" "MLI" "MLI" "MLI" "MLI" "MLI" "MLI" "MLI" "MLI" "MLI"
## [1277] "MRT" "MRT" "MRT" "MRT" "MRT" "MRT" "FRA" "FRA" "ESP" "ESP" "MEX"
## [1288] "MEX" "MDA" "FRA" "FRA" "FRA" "FRA" "MAR" "MAR" "MAR" "MAR" "MAR"
## [1299] "MAR" "MAR" "MAR" "MAR" "MAR" "MAR" "MAR" "MAR" "MAR" "MAR" "MAR"
## [1310] "PRT" "PRT" "PRT" "PRT" "PRT" "PRT" "PRT" "PRT" "PRT" "PRT" "PRT"
## [1321] "MOZ" "MOZ" "MOZ" "MOZ" "MOZ" "MOZ" "MOZ" "MOZ" "MOZ" "MOZ" "MOZ"
## [1332] "MOZ" "MOZ" "MOZ" "MOZ" "MOZ" "MOZ" "MOZ" "MOZ" "MMR" "MMR" "MMR"
## [1343] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1354] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1365] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1376] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1387] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1398] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1409] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1420] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1431] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1442] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1453] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1464] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1475] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1486] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1497] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1508] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1519] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1530] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1541] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1552] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1563] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1574] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1585] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1596] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR"
## [1607] "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "MMR" "NPL"
## [1618] "NPL" "NPL" "NPL" "NPL" "NPL" "NPL" "NPL" "NPL" "NPL" "NPL" "NPL"
## [1629] "NPL" "NPL" "NIC" "NIC" "NIC" "NIC" "NIC" "NIC" "NIC" "NIC" "NIC"
## [1640] "NIC" "NIC" "NIC" "NER" "NER" "NER" "NER" "NER" "NER" "NER" "NER"
## [1651] "NER" "NER" "NER" "NGA" "NGA" "NGA" "NGA" "NGA" "NGA" "NGA" "NGA"
## [1662] "NGA" "NGA" "NGA" "NGA" "NGA" "NGA" "NGA" "NGA" "NGA" "NGA" "NGA"
## [1673] "NGA" "PRK" "PRK" "PRK" "PRK" "PRK" "OMN" "OMN" "OMN" "OMN" "OMN"
## [1684] "OMN" "OMN" "OMN" "PAK" "PAK" "PAK" "PAK" "PAK" "PAK" "PAK" "PAK"
## [1695] "PAK" "PAK" "PAK" "PAK" "PAK" "PAK" "PAK" "PAK" "PAK" "PAK" "PAK"
## [1706] "PAK" "PAK" "PAK" "PAK" "PAK" "PAK" "PAK" "PAK" "PAK" "PAK" "PAK"
## [1717] "PAK" "PAK" "PAK" "PAK" "PAK" "PAN" "PAN" "PNG" "PNG" "PNG" "PNG"
## [1728] "PNG" "PNG" "PRY" "PRY" "PRY" "PER" "PER" "PER" "PER" "PER" "PER"
## [1739] "PER" "PER" "PER" "PER" "PER" "PER" "PER" "PER" "PER" "PER" "PER"
## [1750] "PER" "PER" "PER" "PER" "PER" "PER" "PHL" "PHL" "PHL" "PHL" "PHL"
## [1761] "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL"
## [1772] "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL"
## [1783] "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL"
## [1794] "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL"
## [1805] "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL"
## [1816] "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL"
## [1827] "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL"
## [1838] "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL"
## [1849] "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL" "PHL"
## [1860] "PHL" "PHL" "PHL" "ROU" "RUS" "RUS" "RUS" "RUS" "RUS" "RUS" "RUS"
## [1871] "RUS" "RUS" "RUS" "RUS" "RUS" "RUS" "RUS" "RUS" "RUS" "RUS" "RUS"
## [1882] "RUS" "RUS" "RUS" "RUS" "RUS" "RUS" "RUS" "RUS" "RUS" "RUS" "RUS"
## [1893] "RUS" "RUS" "RUS" "RUS" "RUS" "RUS" "RUS" "RUS" "RUS" "RUS" "RUS"
## [1904] "RUS" "RUS" "RWA" "RWA" "RWA" "RWA" "RWA" "RWA" "RWA" "RWA" "RWA"
## [1915] "RWA" "RWA" "RWA" "RWA" "RWA" "RWA" "RWA" "RWA" "RWA" "SAU" "SEN"
## [1926] "SEN" "SEN" "SEN" "SEN" "SEN" "SEN" "SEN" "SEN" "SEN" NA    NA   
## [1937] NA    NA    NA    "SLE" "SLE" "SLE" "SLE" "SLE" "SLE" "SLE" "SLE"
## [1948] "SLE" "SLE" "SLE" "SOM" "SOM" "SOM" "SOM" "SOM" "SOM" "SOM" "SOM"
## [1959] "SOM" "SOM" "SOM" "SOM" "SOM" "SOM" "SOM" "SOM" "SOM" "SOM" "SOM"
## [1970] "SOM" "SOM" "SOM" "SOM" "SOM" "SOM" "SOM" "SOM" "SOM" "SOM" "SOM"
## [1981] "ZAF" "ZAF" "ZAF" "ZAF" "ZAF" "ZAF" "ZAF" "ZAF" "ZAF" "ZAF" "ZAF"
## [1992] "ZAF" "ZAF" "ZAF" "ZAF" "ZAF" "ZAF" "ZAF" "ZAF" "ZAF" "ZAF" "ZAF"
## [2003] "ZAF" "ZAF" "ZAF" "ZAF" "ZAF" "ZAF" "ZAF" "ZAF" "SSD" "SSD" "SSD"
## [2014] "SSD" "SSD" "SSD" "SSD" "SSD" "SSD" "VNM" "VNM" "VNM" "VNM" "VNM"
## [2025] "VNM" "VNM" "VNM" "VNM" "VNM" "VNM" "VNM" "VNM" "VNM" "VNM" "VNM"
## [2036] "VNM" "VNM" "VNM" "VNM" "VNM" "GBR" "GBR" "GBR" "GBR" NA    NA   
## [2047] NA    "ESP" "ESP" "ESP" "ESP" "ESP" "ESP" "ESP" "ESP" "ESP" "LKA"
## [2058] "LKA" "LKA" "LKA" "LKA" "LKA" "LKA" "LKA" "LKA" "LKA" "LKA" "LKA"
## [2069] "LKA" "LKA" "LKA" "LKA" "LKA" "LKA" "LKA" "LKA" "LKA" "LKA" "LKA"
## [2080] "LKA" "LKA" "LKA" "LKA" "SDN" "SDN" "SDN" "SDN" "SDN" "SDN" "SDN"
## [2091] "SDN" "SDN" "SDN" "SDN" "SDN" "SDN" "SDN" "SDN" "SDN" "SDN" "SDN"
## [2102] "SDN" "SDN" "SDN" "SDN" "SDN" "SDN" "SDN" "SDN" "SDN" "SDN" "SDN"
## [2113] "SDN" "SDN" "SDN" "SDN" "SDN" "SDN" "SDN" "SDN" "SDN" "SDN" "SDN"
## [2124] "SDN" "SDN" "SDN" "SDN" "SDN" "SDN" "SDN" "SDN" "SDN" "SUR" "SYR"
## [2135] "SYR" "SYR" "SYR" "SYR" "SYR" "SYR" "SYR" "SYR" "SYR" "SYR" "SYR"
## [2146] "SYR" "SYR" "SYR" "SYR" "SYR" "SYR" "SYR" "SYR" "SYR" "SYR" "SYR"
## [2157] "SYR" "TJK" "TJK" "TJK" "TJK" "TJK" "TJK" "TJK" "TJK" "TJK" "TJK"
## [2168] "TZA" "THA" "THA" "THA" "THA" "THA" "THA" "THA" "THA" "THA" "THA"
## [2179] "THA" "THA" "THA" "THA" "THA" "THA" "THA" "THA" "THA" "THA" "THA"
## [2190] "THA" "THA" "THA" "THA" "THA" "TGO" "TTO" "TUN" "FRA" "FRA" "FRA"
## [2201] "FRA" "TUN" "TUR" "TUR" "TUR" "TUR" "TUR" "TUR" "TUR" "TUR" "TUR"
## [2212] "TUR" "TUR" "TUR" "TUR" "TUR" "TUR" "TUR" "TUR" "TUR" "TUR" "TUR"
## [2223] "TUR" "TUR" "TUR" "TUR" "TUR" "TUR" "TUR" "TUR" "TUR" "TUR" "TUR"
## [2234] "TUR" "TUR" "TUR" "TUR" "TUR" "TUR" "TUR" "TUR" "TUR" "TUR" "TUR"
## [2245] "UGA" "UGA" "UGA" "UGA" "UGA" "UGA" "UGA" "UGA" "UGA" "UGA" "UGA"
## [2256] "UGA" "UGA" "UGA" "UGA" "UGA" "UGA" "UGA" "UGA" "UGA" "UGA" "UGA"
## [2267] "UGA" "UGA" "UGA" "UGA" "UGA" "UGA" "UGA" "UGA" "UGA" "UGA" "UGA"
## [2278] "UGA" "UGA" "UGA" "UGA" "UGA" "UGA" "UGA" "UGA" "UKR" "UKR" "UKR"
## [2289] "UKR" "UKR" "UKR" "UKR" "UKR" "GBR" "GBR" "GBR" "GBR" "GBR" "GBR"
## [2300] "GBR" "GBR" "GBR" "GBR" "GBR" "GBR" "GBR" "GBR" "GBR" "GBR" "GBR"
## [2311] "GBR" "GBR" "GBR" "GBR" "GBR" "USA" "USA" "USA" "USA" "USA" "USA"
## [2322] "USA" "USA" "USA" "USA" "USA" "USA" "USA" "USA" "USA" "USA" "USA"
## [2333] "USA" "URY" "UZB" "UZB" "UZB" "VEN" "VEN" "VEN" "FRA" "FRA" "FRA"
## [2344] "FRA" "FRA" "FRA" "FRA" "FRA" "FRA" NA    NA    NA    NA    NA   
## [2355] NA    NA    NA    NA    NA    NA    NA    NA    NA    NA    NA   
## [2366] NA    NA    NA    NA    NA    NA    NA    NA    NA    NA    "ZWE"
## [2377] "ZWE" "ZWE" "ZWE" "ZWE" "ZWE" "ZWE" "ZWE" "ZWE"
```

```r
# ser ut til å fungere bra! Oppretter ny variabel
conflict$country <- countrycode(conflict$gwno_a, origin = "gwn", destination = "iso3c")
```

```
## Warning in countrycode(conflict$gwno_a, origin = "gwn", destination = "iso3c"): Some values were not matched unambiguously: 345, 55, 651, 645, 663, 660, 652, 678, 680, 751, 900, 200, 2
```

```r
table(is.na(conflict$country)) # kan se om det er mulig å fikse missing manuelt, men er ikke så mange observasjoner
```

```
## 
## FALSE  TRUE 
##  2343    41
```

Da har vi forhåpentligvis variabler som kan fungere som nøkler i begge datasettene. Neste steg er å endre på datastrukturen i datasettet `conflict`, slik at den blir lik som i `aid`. For å få til dette, må vi endre observasjonene i `conflict` til land-perioder. Dette kan vi gjøre med `group_by` og `summarise()`. På dette stadiet, må vi tenke datastruktur, og gjøre metodologiske valg om hvordan vi skal operasjonalisere informasjonen om konflikter. Under viser jeg to0 muligheter, i hjemmeoppgaven er dette et punkt der jeg vil anbefale at du tenker grundig gjennom de metodologiske implikasjonene av valgene du tar - tenk gjennom hva som er best og skriv koden din etterpå - ikke fall i fellen kode først, metode etterpå.


```r
agg_con <- conflict %>%
  filter(is.na(period)==F) %>% # fjerner data som ikke finnes i aid
  group_by(country, period) %>%
  summarise(conflict_n = n(), # teller antall konflikter i perioden i ett land
            conflict_years = length(unique(year))) # teller antall år landet var i konflikt i perioden

# Her kunne jeg skilt mellom ulike typer konflikter (se kodebok), men lar det være.
```

Nå som data fra `conflict` er i samme format som i `aid`, er vi klare til å kombinere informasjonen med `left_join`:


```r
# husk: ?left_join for å forstå funksjonen
aid2 <- left_join(aid, agg_con)
```

```
## Joining, by = c("country", "period")
```

```r
# Sjekker missing:
table(is.na(aid2$conflict_n))
```

```
## 
## FALSE  TRUE 
##   271  1089
```

```r
table(is.na(aid2$conflict_years))
```

```
## 
## FALSE  TRUE 
##   271  1089
```

```r
# Antar at missing har verdi 0 på disse variablene i følgende omkoding:
aid2 <- aid2 %>%
  mutate(c_years = ifelse(is.na(conflict_years)==T, 0 , conflict_years),
         c_n = ifelse(is.na(conflict_n)==T, 0 , conflict_n))
names(aid2)
```

```
##  [1] "country"                 "period"                 
##  [3] "periodstart"             "periodend"              
##  [5] "code"                    "bdgdpg"                 
##  [7] "elrgdpg"                 "bdgdp"                  
##  [9] "elrgdp"                  "bdbb"                   
## [11] "elrbb"                   "bdinfl"                 
## [13] "elrinfl"                 "bdsacw"                 
## [15] "elrsacw"                 "bdethnf"                
## [17] "elrethnf"                "bdassas"                
## [19] "elrassas"                "bdicrge"                
## [21] "elricrge"                "bdm21"                  
## [23] "elrm21"                  "bdssa"                  
## [25] "elrssa"                  "bddn1900"               
## [27] "elrdn1900"               "bdaid"                  
## [29] "elraid"                  "bdlpop"                 
## [31] "elrlpop"                 "bdeasia"                
## [33] "elreasia"                "bdegypt"                
## [35] "elregypt"                "bdcentam"               
## [37] "elrcentam"               "bdfrz"                  
## [39] "elrfrz"                  "bdarms1"                
## [41] "elrarms1"                "originalcountries"      
## [43] "bddatap"                 "bddatao"                
## [45] "elrdatabdcos7093bdvarsp" "elrdatabdcos7093bdvarso"
## [47] "elrdatabdcos7097bdvarsp" "elrdatabdcos7097bdvarso"
## [49] "elrdata7093bdvarsp"      "elrdata7093bdvarso"     
## [51] "elrdata7097bdvarsp"      "elrdata7097bdvarso"     
## [53] "policy"                  "policy2"                
## [55] "region"                  "conflict_n"             
## [57] "conflict_years"          "c_years"                
## [59] "c_n"
```

```r
# Lager en korrelasjonsmatrise:
aid2 %>%
  select(c_years, c_n, elrgdpg, elraid, policy) %>%
  cor(, use = "pairwise.complete.obs")
```

```
##             c_years         c_n      elrgdpg      elraid       policy
## c_years  1.00000000  0.79623583 -0.112082439 -0.08221364 -0.072435319
## c_n      0.79623583  1.00000000 -0.073052536 -0.09015997 -0.146434261
## elrgdpg -0.11208244 -0.07305254  1.000000000 -0.09172658 -0.009197539
## elraid  -0.08221364 -0.09015997 -0.091726585  1.00000000 -0.067595683
## policy  -0.07243532 -0.14643426 -0.009197539 -0.06759568  1.000000000
```

**Merk:** Dette er ment som en illustrasjon av prosessen beskrevet i seminar 1 - ikke en perfekt løsning. Jeg har tatt flere snarveier, som gjør at løsningen min ikke er ideell. Dersom du legger nok tid ned i å fingranske løsningsforslaget vil du nok finne noen av disse. Når du skriver din egen hjemmeoppgave, vær nøye med å forstå hva som skjer i hvert eneste steg i koden din. Les kodebok - skaff deg forståelse av verdier i datasett, og sjekk hva som skjer etter hvert steg i koden din.
