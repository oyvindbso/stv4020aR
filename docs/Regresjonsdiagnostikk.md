---
title: "Regresjonsdiagnostikk"
author: "Erlend Langørgen"
date: "8 september 2019"
output:
  html_document:
    keep_md: TRUE
---



## Forutsetninger for regresjon

Dere vil se forutsetningene for OLS formulert på litt forskjellige måter i ulike metodetekster. Det er blant annet forskjell på forutsetninger for at OLS skal være forventningsrett og konsistent, og at OLS skal være BLUE. Det er også mulig å formulere de samme forutsetningene i ulik språkdrakt, selv når forutsetningene bygger på de samme matematiske formuleringene. Noen ganger vil dere også se at forutsetningene om restledd er utelatt, andre ganger vil dere kunne se en antagelse om at kurtosen ikke er uendelig stor. Noen vil kategorisere ingen innflytelsesrike observasjoner og ikke perfekt multikolinearitet som antagelser, mens andre vil kategorisere det som problemer/trusler. Dere forholder dere til pensum, jeg følger Cristophersens forelesning her. Det bør forøvrig nevnes at **Lær deg R** av Silje Synnøve Lyder Hermansen gir en ypperlig gjennomgang av regresjonsdiagnostikk.

**Kritiske aspekter i modellvurdering - OLS:**

1. Ingen utelatt variabelskjevhet
2. Lineær sammenheng mellom variablene
3. Ingen autokorrelasjon/Uavhengige observasjoner
4. Normalfordelte residualer
5. Homoskedastiske residualer
6. Ingen perfekt multikollinearitet
7. Manglende opplysninger(missing values)


### Ingen utelatt variabelskjevhet
Hva innebærer denne antagelsen? 

* Dersom vi vil tolke alle variablene i modellen vår substansielt, må alle variabler som påvirker vår avhengige variabel, og som er korrelert med en uavhengig variabel inkluderes i modellen.
* Dersom vi vil tolke en uavhengig variabel, kan vi tenke på de resterende variablene som kontrollvariabler, som er korrelert med uavhengig variabel og påvirker avhengig variabel.

**Merk:** korrelasjon er lineær sammenheng mellom to variabler, ikke et årsaksforhold. Så lenge to variabler påvirker den avhengige variabelen, og de er korrelert (selv om de ikke påvirker hverandre på noe vis), får vi utelatt variabelskjevhet dersom vi ikke kontrollerer for den andre variabelen. 

Denne antagelsen kan vi ikke teste, dersom vi ikke har data for alle variabler. Det finnes imidlertid metoder for å estimere effekten av utelatte variabler med ulike egenskaper. Denne formen for robusthetstesting kalles *sensivity analysis*

### Lineær sammenheng mellom variablene
Metoden vi bruker for å regne ut lineær regresjon tar blant annet utgangspunkt i kovarians mellom uavhengige variabler og avhengige variabler. I likhet med korrelasjon, er kovarians et mål på lineær sammenheng mellom to variabler. Derfor forutsetter lineær regresjon en lineær sammenheng mellom uavhengig av avhengig variabel. Brudd på denne forutsetningen kan potensielt gi svært missvisende resultater, f.eks. ved å gjøre en U-formet sammenheng om til *ingen lineær sammenheng*.

**Huskregel:** Hver gang vi opphøyer en uavhengig variabel, tillater vi en ekstra *sving* i sammenhengen mellom den avhengige og uavhengige variabelen. 

Dersom hypotesen vår er at det er en positiv sammenheng mellom to variabler, står vi fritt til å legge til andregradsledd og tredjegradsledd, osv, fordi vi ikke påstår at sammenhengen er perfekt lineær, bare at den er positiv. Dette er det vanligste. Vi står dermed fritt til å slenge inn andregrads og tredjegradsledd. Vær imidlertid forsiktig med å opphøye en uavhengig variabel for mye. Da står man i fare for **overfitting**, dvs. å finne en svært spesifikk sammenheng i datasettet ditt, som du ikke finner dersom du samler inn samme type data på nytt. 

I noen tilfeller er hypotesen vår er mer spesifikk, for eksempel at en sammenheng er U-formet (konveks), da må vi teste om: 

1. Vi får en U-formet sammenheng når vi legger inn et annengradsledd.
2. Om regresjonen med et andregradsledd passer til data.


Det finnes flere måter å teste linearitetsantagelsen på. Man kan gjøre en grafisk test, ved å plotte residualene til den avhengige variabelen mot residualene til den uavhengige variabelen vi er interessert i. Jeg viser en annen test som gjør samme nytten, men som har noen fordeler.

**Viktig:** Dersom dere legger inn andregradsledd eller andre polynomer, husk på å tolke alle leddene for den variabelen sammen. Det er lettest å gjøre dette ved hjelp av plot (eller derivasjon for dem som er glad i matte).

### Uavhengighet/Ingen autokorrelasjon

Denne antagelsen holder dersom vi har et tilfeldig utvalg fra en populasjon, på et tidspunkt. Da vil observasjonene være statistisk uavhengige (alle observasjonene er trukket tilfeldig), og likt distribuert (alle observasjonene er trukket fra samme populasjon). Dersom vi ikke har et slikt utvalg, vil det kunne være sammenhenger mellom observasjoner. Dersom vi f.eks. har data for statsbudsjettet over tid, vil vi trolig se **autokorrelasjon** fra ett år til det neste fordi budsjettet endres inkrementelt. Andre typer avhengighet enn autokorrelasjon er også mulig, som geografisk avhengighet.  

### Normalfordelte residualer:
Residualene fra modellen er normalfordelt, og har gjennomsnitt tilnærmet lik 0. 

### Homoskedastiske residualer:
Variansen til residualene skal være konstante for ulike nivå av uavhengig variabel.

### Ingen perfekt multikolinearitet:
Det skal ikke være en perfekt lineær sammenheng mellom et sett av de uavhengige variablene. Dette fører til at regresjonen ikke lar seg estimere, og skyldes som regel at man har lagt inn dummyvariabler for alle kategorier av en variabel, som en dummy for mann og en for kvinne. Høy multikolinearitet kan også være problematisk, men er ikke en forutsetning for at regresjon ikke skal fungere.


## Regresjonsdiagnostikk i R
Jeg anbefaler `car` pakken til John Fox til regresjonsdiagnostikk. Den gir ikke like vakre figurer som `ggplot`, men er veldig lett å bruke for nybegynnere, og inneholder alle slags funksjoner man trenger for regresjonsdiagnostikk. På sikt kan dere lære dere å konstruere disse plottene selv med `ggplot`. Pass imidlertid på at dere forstår hva plot dere bruker faktisk innebærer (det er lov å spørre om hjelp på **slack**). I kapittel 6 av boken *An R Companion to Applied Regression* (Fox og Weisberg), gjennomgås diagnostikk med `car` i detalj. En annen pakke som er god, er `lmtest`. Til testing av autokorrelasjon på paneldata er det lettest å bruke pakken `plm` 

I tillegg til å teste antagelsene over (med unntak av antagelse 1), skal vi også se på innflytelsesrike observasjoner, og multikolinearitet. 

### Data - Burnside og Dollar 2000

I dag skal vi se på en ekte artikkel, og gjøre regresjonsdiagnostikk på denne.
Jeg har valgt en artikkel som tidligere var på pensum i fordypningsemnet i statistikk, 4020B. jeg har altså hatt replikasjon av denne artikkelen som hjemmeoppgave. I tillegg til diagnostikken som vi gjør i seminaret, er det fint å se på deskriptiv statistikk, effektplot, samt diskusjon av data. 

### Linearitet
Vi kan bruke funksjonen `ceresPlot()` fra pakken `car` til å teste om sammenhengen mellom en uavhengig og en avhengig variabel er lineær. Denne funksjonen fungerer både for lineær regresjon, og for logistisk regresjon (`glm`). Denne funksjonen fungerer imidlertid ikke for regresjon med samspill, ta kontakt med meg dersom dere vil teste linearitet i en regresjon med samspill, så kan jeg vise en annen metode for det. 

Det denne funksjonen gjør, er å legge sammen residualene fra en regresjon med parameterestimatet til en variabel (på y-aksen), og plotte mot variabelens verdi. Deretter tegnes det en grønn linje som passer data, dersom denne ikke er lineær, kan man prøve en transformasjon eller et polynom. 

### Uavhengighet
Man kan teste for autkorrelasjon med Durbin-Watson testen. En funksjon for dette er `pdwtest()` fra pakken `plm` - denne fungerer både på tidsserier og paneldata, mens `durbinWatsonTest()` fra `car` bare virker på tidsserier.

### Normalfordelte residualer:
Vi kan teste for normalfordelte residualer ved å plotte studentiserte residualer fra regresjonen vår mot kvantiler fra den kummulative normalfordelingen. Dette kalles qq-plot, og kan kjøres i R med `qqPlot()`.

**Studentiserte residualer:** Alternativ måte å standardisere på, i beregning av varians for hver enkelt observasjon, fjerner man observasjonen. Formålet med dette er at vi får statistisk uavhengighe mellom teller og nevner, noe som lar oss bruke residualene til statistiske tester.

### Homoskedastiske restledd:
Vi kan teste for heteroskedastisitet ved hjelp av plot av studentiserte residualer mot standardiserte predikerte verdier fra modellen. Dette kan gjøres med `spreadLevelPlot()`, dere kan også se på Martin sitt script fra seminar 3, der han bruker `ggplot()` i stedet.

### Multikolinearitet:
Vi kan teste for multikolinearitet ved hjelp av en vif-test. Funksjonen for dette er `vif()`. Med vif tester vi om det er en sterk lineær sammenheng mellom uavhengige variabler, dersom dette er tilfellet er det gjerne nødvendig med store mengder data for å skille effektene av ulike variabler fra hverandre/få presise estimater (små standardfeil), men bortsett fra å samle mer data er det ikke så mye vi gjøre dersom vi mener begge variablene må være med i modellen. 

### Outliers, leverage og innflytelsesrike observasjoner

Observasjoner med uvanlige/ekstreme verdier på de uvahengige variablene (når man tar høyde for korrelasjonsmønstre), har høy leverage (Vi bruker gjerne hatte-verdier som mål på leverage observasjoner i lineær regresjon). Observasjoner med høy leverage vil ha stor innflytelse på regresjonslinjen, hvis modellen predikerer slike observasjoner dårlig. Observasjoner som blir predikert dårlig av en modell får store residualer. Vi kaller gjerne slike observasjoner "regression outliers" (Studentiserte residualer brukes ofte som mål på "regression outliers"). Innflytelsesrike observasjoner har dermed høy leverage/er dårlig predikert av modellen, og "trekker" regresjonslinjen mot seg med stor kraft. 

 

Det er ofte lurt å se nærmere på innflytelsesrike enheter og uteliggere, vi kan bruke `influenceIndexPlot()` til å identifisere slike observasjoner. Spesifiser hvor mange observasjoner du vil ha nummerert med argumentet `id.n = 5`. Deretter kan vi se nærmere på disse observasjonene ved hjelp av indeksering. En form for robusthetstesting er å kjøre regresjonen på nytt uten uteliggere og innflytelsesrike observasjoner, for å sjekke om man får samme resultat. Dersom man ikke gjør dette, er ikke resultatene dine særlig robuste.

Vi kan også se på Cook's distance, som kombinerer informasjon om uteliggere, leverage og innflytelsesrike observasjoner. `influenceIndexPlot()` gir oss alle disse målene.

Dersom du kun er interessert i observasjoners innflytelse på en enkeltvariabel, kan du bruke funksjonen `dfbetas()`, som gir deg hver observasjons innflytelse på koeffisientene til alle variablene i en modell.

### Observasjoner med manglende informasjon (Missing)


Mye kan sies om manglende informasjon (missing) - her viser jeg måter du kan bruke R til å identifisere missing. Jeg viser også noen enkle måter du kan bruke R til å få et inntrykk av konsekvensene av missing på.

I R kan missing være kodet på flere måter. Dersom missing er eksplisitt definert i R, vil vi se missing som `NA` når vi ser på datasettet. Noen ganger leses ikke missing inn som `NA`. Missing på variabler i datasett fra andre statistikkprogramm kan f.eks. leses som `character` med verdi `" "`, eller som `numeric` med verdi `-99`. For å sjekke dette, bør du lese kodebok. Det er ikke sikkert at `" "` bør omkodes til missing. Du kan også se på en tabell, for å identifisere suspekte verdier:

```r
library(tidyverse)
```

```
## -- Attaching packages -------------------------------------------------------- tidyverse 1.2.1 --
```

```
## v ggplot2 3.2.0     v purrr   0.3.2
## v tibble  2.1.3     v dplyr   0.8.3
## v tidyr   0.8.3     v stringr 1.4.0
## v readr   1.3.1     v forcats 0.4.0
```

```
## -- Conflicts ----------------------------------------------------------- tidyverse_conflicts() --
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

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
aid <- aid %>% # Forteller at vi skal jobbe med aid-datasettet
       mutate(region = ifelse(elrssa == 1, "Sub-Saharan Africa",
                               ifelse(elrcentam == 1, "Central America",
                               ifelse(elreasia == 1, "East Asia", "Other"))))

table(aid$country) # ingen suspekte verdier
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

Moral: **alltid sjekk kodeboken**, og se på verdiene til data med tabell for å identifisere missing. 

Når du kjører en lineær regresjonsanalyse i R, kastes observasjoner som har manglende informasjon (missing, angitt som `NA` i R) på en eller flere av variablene du legger inn i modellen din ut. Derfor er det viktig å sjekke hvilke observasjoner som faktisk blir kastet ut ava analysen din pga. missing, og hva slags informasjon du faktisk sitter igjen med i analysen din.   

Her er noen nyttige funksjoner for å jobbe missing:




Vi kan bruke variabelen `reg_miss` til plot. Både spredningsplot og boxplot kan gi god innsikt i hvordan observasjoner med missing skiller seg fra andre. Et annet alternativ, er å se på en logistisk regresjon, med den nye dummyen som avhengig variabel. Her fjerner jeg de variablene som fører til flest missing:


**Missing i paneldata*

Når du jobber med paneldata, vil du gjerne være interessert i om du har et balansert eller ubalansert panel. Dersom du har et ubalansert panel, vil du ha implisitt missing - det vil si at R ikke forteller deg at du mangler informasjon om observasjoner du egentlig burde ha hatt informasjon om. Vi kan for eksempel ha et datasett med boligprisene for en gjennomsnittlig treromsleilighet fra 2013 til i dag i 2 bydeler som ser slik ut:


```r
boligpris <- data.frame(year = c(2013, 2015:2017), bydel = c(rep("Sagene", 4), rep("Manglerud", 4)), pris = c(2.8, 3.6, 4.2, 4, 2.6, 3.1, 3.4, 3.3))
table(is.na(boligpris))
```

```
## 
## FALSE 
##    24
```

```r
boligpris
```

```
##   year     bydel pris
## 1 2013    Sagene  2.8
## 2 2015    Sagene  3.6
## 3 2016    Sagene  4.2
## 4 2017    Sagene  4.0
## 5 2013 Manglerud  2.6
## 6 2015 Manglerud  3.1
## 7 2016 Manglerud  3.4
## 8 2017 Manglerud  3.3
```

Her er det ingen eksplisitte missing, men all informasjon for 2014 er implisitt missing. Pass opp for denne typen missing, særlig i paneldata eller data som inneholder en annen type struktur med gjentatte observasjoner av enheter. 
En lettvint måte å kikke etter slike metoder er å vise den grunnleggende datastrukturen med `table()`, der du legger inn variablene som danner grunnlaget for datastrukturen (land og periode i datasettet `aid`). Vi kan også bruke funksjonen `complete()` til å sjekke for ubalanserte panel - denne viser om du har observasjoner for alle mulige kombinasjoner av variablene som abngir strukturen til paneldata. Det er imidlertid viktig å skille mellom observasjoner som finnes i data, og observasjoner som brukes i analysen. 



Dersom det er mange observasjoner som kastes ut pga missing, som i eksempelet over, er det lurt å danne seg et inntrykk av konsekvense dette får for analysen din.  Under skisserer jeg noen måter dere kan bruke R på for å lære mer om missingstruktur: 

**Metode 1: korrelasjonsmatriser**

Korrelasjonsmatriser viser korrelasjoner mellom variabler av klassene `numeric` og `integer`.
Dersom vi vil få et raskt inntrykk av konsekvensene av missing i en modell, kan vi lage en korrelasjonsmatrise med variablene som inngår i modellen, og varierer hvordan vi håndterer missing i korrelasjonsmatrisen. Her er et eksempel:


```r
m1 <- lm(bdgdpg ~ bdaid*policy + as.factor(period) + bdlpop + elrethnf*elrassas, data = aid )
summary(m1) # output viser at 1077 observasjoner fjernes pga. missing
```

```
## 
## Call:
## lm(formula = bdgdpg ~ bdaid * policy + as.factor(period) + bdlpop + 
##     elrethnf * elrassas, data = aid)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -11.9291  -1.8273  -0.0695   2.0939  10.9230 
## 
## Coefficients:
##                    Estimate Std. Error t value Pr(>|t|)    
## (Intercept)        -0.79474    2.32226  -0.342 0.732424    
## bdaid               0.06059    0.13342   0.454 0.650068    
## policy              1.46725    0.48739   3.010 0.002834 ** 
## as.factor(period)3 -0.32962    0.71362  -0.462 0.644494    
## as.factor(period)4 -1.47180    0.70880  -2.076 0.038714 *  
## as.factor(period)5 -3.49253    0.71267  -4.901 1.58e-06 ***
## as.factor(period)6 -2.06145    0.72819  -2.831 0.004959 ** 
## as.factor(period)7 -2.89308    0.76569  -3.778 0.000191 ***
## bdlpop              0.24150    0.14336   1.685 0.093122 .  
## elrethnf           -1.30275    0.72801  -1.789 0.074560 .  
## elrassas           -0.78239    0.34610  -2.261 0.024510 *  
## bdaid:policy       -0.35217    0.16982  -2.074 0.038969 *  
## elrethnf:elrassas   1.08555    0.71350   1.521 0.129216    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 3.417 on 296 degrees of freedom
##   (1051 observations deleted due to missingness)
## Multiple R-squared:  0.1606,	Adjusted R-squared:  0.1266 
## F-statistic:  4.72 on 12 and 296 DF,  p-value: 4.692e-07
```

Lager korrelasjonsmatrise med variablene som inngår:

```r
# Siden as.factor(period) lager en dummvariabel for alle perioder unntatt periode 1, må vi gjøre dette for å inkludere denne variabelen i korrelasjonsmatrisen (inkluder gjerne også periode 1 i matrise):

aid$period2 <- ifelse(aid$period==2, 1, 0)
aid$period3 <- ifelse(aid$period==3, 1, 0)
aid$period4 <- ifelse(aid$period==4, 1, 0)
aid$period5 <- ifelse(aid$period==5, 1, 0)
aid$period6 <- ifelse(aid$period==6, 1, 0)
aid$period7 <- ifelse(aid$period==7, 1, 0)
aid$period8 <- ifelse(aid$period==8, 1, 0)

aid %>% 
  select(bdgdpg,bdaid,policy,bdlpop, elrethnf,elrassas,period2,period3,period4,period5,period6,period7) %>%
  cor(, use = "pairwise.complete.obs")
```

```
##                 bdgdpg       bdaid        policy      bdlpop      elrethnf
## bdgdpg    1.0000000000 -0.03217491  3.663049e-02  0.01094811 -1.122439e-01
## bdaid    -0.0321749068  1.00000000 -5.882599e-02 -0.30316017  9.737572e-02
## policy    0.0366304945 -0.05882599  1.000000e+00  0.03992821 -1.226754e-01
## bdlpop    0.0109481098 -0.30316017  3.992821e-02  1.00000000  1.798864e-01
## elrethnf -0.1122438592  0.09737572 -1.226754e-01  0.17988637  1.000000e+00
## elrassas -0.0709313904 -0.12728327  7.081371e-02  0.15511017 -7.821121e-02
## period2   0.1120746461 -0.11622813 -1.473274e-01 -0.06845450 -2.128887e-20
## period3   0.0847155933 -0.09063401 -1.204031e-01 -0.04088022 -1.383286e-20
## period4   0.0290984091 -0.02258524 -1.243624e-01 -0.01299697 -7.161693e-21
## period5  -0.1015614376  0.02411195 -1.004446e-01  0.01427018 -4.807164e-21
## period6   0.0009199064  0.10074206  4.979195e-05  0.04097350 -1.353854e-20
## period7  -0.2108102264  0.10459338  2.356650e-01  0.06708800 -1.991539e-20
##              elrassas       period2       period3       period4
## bdgdpg   -0.070931390  1.120746e-01  8.471559e-02  2.909841e-02
## bdaid    -0.127283271 -1.162281e-01 -9.063401e-02 -2.258524e-02
## policy    0.070813707 -1.473274e-01 -1.204031e-01 -1.243624e-01
## bdlpop    0.155110172 -6.845450e-02 -4.088022e-02 -1.299697e-02
## elrethnf -0.078211213 -2.128887e-20 -1.383286e-20 -7.161693e-21
## elrassas  1.000000000 -1.945101e-02 -3.763907e-03  3.615118e-02
## period2  -0.019451013  1.000000e+00 -1.428571e-01 -1.428571e-01
## period3  -0.003763907 -1.428571e-01  1.000000e+00 -1.428571e-01
## period4   0.036151179 -1.428571e-01 -1.428571e-01  1.000000e+00
## period5  -0.037658716 -1.428571e-01 -1.428571e-01 -1.428571e-01
## period6  -0.046501818 -1.428571e-01 -1.428571e-01 -1.428571e-01
## period7   0.049676055 -1.428571e-01 -1.428571e-01 -1.428571e-01
##                period5       period6       period7
## bdgdpg   -1.015614e-01  9.199064e-04 -2.108102e-01
## bdaid     2.411195e-02  1.007421e-01  1.045934e-01
## policy   -1.004446e-01  4.979195e-05  2.356650e-01
## bdlpop    1.427018e-02  4.097350e-02  6.708800e-02
## elrethnf -4.807164e-21 -1.353854e-20 -1.991539e-20
## elrassas -3.765872e-02 -4.650182e-02  4.967605e-02
## period2  -1.428571e-01 -1.428571e-01 -1.428571e-01
## period3  -1.428571e-01 -1.428571e-01 -1.428571e-01
## period4  -1.428571e-01 -1.428571e-01 -1.428571e-01
## period5   1.000000e+00 -1.428571e-01 -1.428571e-01
## period6  -1.428571e-01  1.000000e+00 -1.428571e-01
## period7  -1.428571e-01 -1.428571e-01  1.000000e+00
```

```r
# Alternativet "pairwise.complete.obs" fjerner bare missing for de enkelte bivariate korrelasjonene

aid %>% 
  select(bdgdpg,bdaid,policy,bdlpop, elrethnf,elrassas,period2,period3,period4,period5,period6,period7) %>%
  cor(, use = "complete.obs")
```

```
##               bdgdpg        bdaid      policy      bdlpop     elrethnf
## bdgdpg    1.00000000 -0.165021419  0.06831574  0.07465350 -0.079132002
## bdaid    -0.16502142  1.000000000 -0.17258844 -0.30686629  0.145612334
## policy    0.06831574 -0.172588440  1.00000000  0.07829744 -0.091492213
## bdlpop    0.07465350 -0.306866290  0.07829744  1.00000000  0.176727842
## elrethnf -0.07913200  0.145612334 -0.09149221  0.17672784  1.000000000
## elrassas -0.07376172 -0.127859690  0.09784269  0.13560637 -0.078390552
## period2   0.18135195 -0.141273371 -0.14236768 -0.05753957 -0.022919759
## period3   0.16067581 -0.086801958 -0.10211715 -0.06224599 -0.012601489
## period4   0.01924612 -0.026763007 -0.09861059 -0.03039880  0.015488502
## period5  -0.20924064  0.008229454 -0.06637091  0.01112630  0.008556115
## period6  -0.01169359  0.077286221  0.06906544  0.06192552  0.006413685
## period7  -0.11910370  0.151865846  0.31890912  0.06902037  0.002788249
##             elrassas     period2     period3     period4      period5
## bdgdpg   -0.07376172  0.18135195  0.16067581  0.01924612 -0.209240644
## bdaid    -0.12785969 -0.14127337 -0.08680196 -0.02676301  0.008229454
## policy    0.09784269 -0.14236768 -0.10211715 -0.09861059 -0.066370914
## bdlpop    0.13560637 -0.05753957 -0.06224599 -0.03039880  0.011126301
## elrethnf -0.07839055 -0.02291976 -0.01260149  0.01548850  0.008556115
## elrassas  1.00000000 -0.03910929 -0.01735201  0.04833699 -0.042195979
## period2  -0.03910929  1.00000000 -0.17665606 -0.18294113 -0.182941132
## period3  -0.01735201 -0.17665606  1.00000000 -0.19991854 -0.199918540
## period4   0.04833699 -0.18294113 -0.19991854  1.00000000 -0.207031250
## period5  -0.04219598 -0.18294113 -0.19991854 -0.20703125  1.000000000
## period6  -0.05203530 -0.18502065 -0.20219104 -0.20938460 -0.209384603
## period7   0.09701895 -0.18915907 -0.20671352 -0.21406798 -0.214067977
##               period6      period7
## bdgdpg   -0.011693595 -0.119103699
## bdaid     0.077286221  0.151865846
## policy    0.069065441  0.318909115
## bdlpop    0.061925520  0.069020371
## elrethnf  0.006413685  0.002788249
## elrassas -0.052035304  0.097018954
## period2  -0.185020649 -0.189159067
## period3  -0.202191042 -0.206713516
## period4  -0.209384603 -0.214067977
## period5  -0.209384603 -0.214067977
## period6   1.000000000 -0.216501317
## period7  -0.216501317  1.000000000
```

```r
# Alternativet "complete.obs" fjerner alle observasjoner som har missing på en av variablene som inngår, mao. det samme som regresjonsanalysen.
```


**Metode 2: Analyse av dummy-variabler for missing**

Ved å sammenligne disse korrelasjonsmatrisene, kan vi få et inntrykk av konsekvensene av å fjerne missing med listwise deletion. En alternativ metode å utforske missing i en analyse på, er med funksjonen `complete.cases()`, som gjør en logisk test av om en observasjon har missing. Vi kan bruke denne funksjonen til å lage en dummy for observasjoner som har missing/ikke har missing på noen av observasjonene som inngår i analysen vår.






```r
miss_mod <- glm(reg_miss ~ bdaid*policy + bdlpop + as.factor(period), data = aid)
summary(miss_mod) # ingen store forskjeller, signifikante uavh. var her er ikke bra.
```

```
## 
## Call:
## glm(formula = reg_miss ~ bdaid * policy + bdlpop + as.factor(period), 
##     data = aid)
## 
## Deviance Residuals: 
##      Min        1Q    Median        3Q       Max  
## -0.96942  -0.00055   0.00917   0.01965   0.05258  
## 
## Coefficients:
##                     Estimate Std. Error t value Pr(>|t|)    
## (Intercept)         1.083140   0.065542  16.526   <2e-16 ***
## bdaid              -0.001153   0.003741  -0.308    0.758    
## policy              0.010399   0.013748   0.756    0.450    
## bdlpop             -0.006729   0.003932  -1.711    0.088 .  
## as.factor(period)3  0.002851   0.020214   0.141    0.888    
## as.factor(period)4  0.005086   0.020057   0.254    0.800    
## as.factor(period)5  0.024215   0.020287   1.194    0.234    
## as.factor(period)6  0.024962   0.020639   1.209    0.227    
## as.factor(period)7  0.023316   0.021732   1.073    0.284    
## bdaid:policy       -0.001770   0.004837  -0.366    0.715    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for gaussian family taken to be 0.009584697)
## 
##     Null deviance: 2.9712  on 312  degrees of freedom
## Residual deviance: 2.9042  on 303  degrees of freedom
##   (1047 observations deleted due to missingness)
## AIC: -554.6
## 
## Number of Fisher Scoring iterations: 2
```

I dette særtilfellet, kan vi også bruke utvidelsen av det originale datasettet til Burnside og Dollar fra Easterly til å gjøre samme test:


```r
miss_mod2 <- glm(reg_miss ~ elraid + elrsacw + elrbb + elrinfl + elrlpop + as.factor(period), data = aid)
summary(miss_mod2)
```

```
## 
## Call:
## glm(formula = reg_miss ~ elraid + elrsacw + elrbb + elrinfl + 
##     elrlpop + as.factor(period), data = aid)
## 
## Deviance Residuals: 
##      Min        1Q    Median        3Q       Max  
## -0.97432   0.00226   0.01528   0.02965   0.09517  
## 
## Coefficients:
##                     Estimate Std. Error t value Pr(>|t|)    
## (Intercept)         1.063085   0.077954  13.637  < 2e-16 ***
## elraid             -0.003997   0.003578  -1.117  0.26457    
## elrsacw             0.003546   0.016581   0.214  0.83075    
## elrbb              -0.188304   0.166981  -1.128  0.26009    
## elrinfl            -0.012269   0.018413  -0.666  0.50557    
## elrlpop            -0.008060   0.004683  -1.721  0.08599 .  
## as.factor(period)3  0.045995   0.026699   1.723  0.08568 .  
## as.factor(period)4  0.031575   0.026455   1.194  0.23333    
## as.factor(period)5  0.048875   0.026531   1.842  0.06616 .  
## as.factor(period)6  0.055753   0.026422   2.110  0.03544 *  
## as.factor(period)7  0.072672   0.027143   2.677  0.00771 ** 
## as.factor(period)8  0.073061   0.027630   2.644  0.00850 ** 
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for gaussian family taken to be 0.01821193)
## 
##     Null deviance: 7.8512  on 429  degrees of freedom
## Residual deviance: 7.6126  on 418  degrees of freedom
##   (930 observations deleted due to missingness)
## AIC: -488.33
## 
## Number of Fisher Scoring iterations: 2
```

```r
# Her er koeffisienten til bistand negativ og signifikant. Dette indikerer at land som fjernes pga missing, får mindre bistand enn land som ikke fjernes. Ser også at land med større befolkning i mindre grad fjernes pga. missing.
```

Vi kunne også definert dummy-variabler for missing på de enkeltvariablene vi er mest interessert i (her: `bdgdpg`, `bdaid` og `policy`), og gjennomført tilsvarende analyser, ved hjelp av funksjonen `is.na()`. 

I de fleste tilfeller er `ifelse()` en fin funksjon til å definere missing. Statistiske R-funksjoner har stort sett et eller flere argumenter der du kan velge hvordan missing skal håndteres (se for eksempel `?cor`, og argumentene `use` og `na.rm`). Husk på det dere har lært på forelesning, og ta aktive valg om hvordan missing bør håndteres. 




## Logistisk regresjon:
Mange av metodene for diagnostikk som vi har sett på i dag fungerer også for logistisk regresjon. Funksjonene `ceresplot()`, `dfbetas()`, `influenceIndexPlot()` m.m. fungerer også for logistisk regresjon. Husk forøvrig på at forutsetninger om homoskedastiske, normalfordelte restledd ikke gjelder logistisk regresjon. I tillegg viser jeg hvordan du kan lage ROC-kurver [her](https://github.com/martigso/stv4020aR/blob/master/Gruppe%201/docs/Introduksjon_seminar4.md). 

Tomme celler vil føre til at modellen ikke lar seg estimere, eller at du ikke får estimert standardfeil/ekstremt høye standardfeil, og er således greit å oppdage. Spredningsplot mellom variabler fra regresjonen kan brukes til å undersøke nærmere.

Vi kan gjøre nøstede likelihood-ratio tester med `anova()`.

Vi kan gjøre hosmer-lemeshow med `hoslem.test()` fra pakken `ResourceSelection`

Se medfølgende script for demonstrarsjon av de to siste funksjonene.

**Husk:** I tillegg til formell diagnostikk, må du aldri glemme generelle validitets/metode-vurderinger.



















