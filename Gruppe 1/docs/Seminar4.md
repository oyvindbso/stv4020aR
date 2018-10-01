# Seminar 4
Erlend Langørgen  
21 september 2017  



## Forutsetninger for regresjon

Dere vil se forutsetningene for OLS formulert på litt forskjellige måter i ulike metodetekster. Det er blant annet forskjell på forutsetninger for at OLS skal være forventningsrett og konsistent, og at OLS skal være BLUE. Det går også ann å formulere de samme forutsetningene i ulik språkdrakt, selv når forutsetningene bygger på de samme matematiske formuleringene. Noen ganger vil dere også se at forutsetningene om restledd er utelatt, fordi det antas at man bruker en eller annen form for robuste standardfeil som passer til data, andre ganger vil dere kunne se en antagelse om at kurtosen ikke er uendelig stor. Noen vil kategorisere ingen innflytelsesrike observasjoner og ikke perfekt multikolinearitet som antagelser, mens andre vil kategorisere det som problemer/trusler. Dere forholder dere til pensum, jeg følger Cristophersens forelesning her (tettere enn Skog):

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
Jeg anbefaler `car` pakken til John Fox til regresjonsdiagnostikk. Den gir ikke like vakre figurer som `ggplot`, men er veldig lett å bruke for nybegynnere, og inneholder alle slags funksjoner man trenger for regresjonsdiagnostikk. På sikt kan dere lære dere å konstruere disse plottene selv med `ggplot`. Pass imidlertid på at dere forstår hva plot dere bruker faktisk innebærer (det er lov å spørre om hjelp på **slack**). I kapittel 6 av boken *An R Companion to Applied Regression* (Fox og Weisberg), gjennomgås diagnostikk med `car` i detalj.

I tillegg til å teste antagelsene over (med unntak av antagelse 1), skal vi også se på innflytelsesrike observasjoner, og multikolinearitet. 

### Data - Burnside og Dollar 2000

I dag skal vi se på en ekte artikkel, og gjøre regresjonsdiagnostikk på denne.
Jeg har valgt en artikkel som tidligere var på pensum i fordypningsemnet i statistikk som holdes av Håvard Strand, jeg har altså hatt replikasjon av denne artikkelen som hjemmeoppgave. I tillegg til diagnostikken som vi gjør i seminaret, er det fint å se på deskriptiv statistikk, effektplot, samt diskusjon av data. Jeg skal laste opp et tilleggsnotat som dere kan se nærmere på med deskriptiv statistikk og diskusjon av data til denne artikkelen etterpå. Til sammen utgjør dermed dagens seminar og tilleggsnotatet fine ressurser for dem som er interessert i å gjøre replikasjon i hjemmeoppgaven sin. Dersom noen er interessert, kan jeg også tipse om noen nyttige artikler om replikasjon gjennom **slack**.

### Linearitet
Vi kan bruke funksjonen `ceresPlot()` fra pakken `car` til å teste om sammenhengen mellom en uavhengig og en avhengig variabel er lineær. Denne funksjonen fungerer både for lineær regresjon, og for logistisk regresjon (`glm`). Denne funksjonen fungerer imidlertid ikke for regresjon med samspill, ta kontakt med meg dersom dere vil teste linearitet i en regresjon med samspill, så kan jeg vise en annen metode for det. 

Det denne funksjonen gjør, er å legge sammen residualene fra en regresjon med parameterestimatet til en variabel (på y-aksen), og plotte mot variabelens verdi. Deretter tegnes det en grønn linje som passer data, dersom denne ikke er lineær, kan man prøve en transformasjon eller et polynom. 

### Uavhengighet
Man kan teste for autkorrelasjon med Durbin-Watson testen. En funksjon for dette er `durbinWatsonTest()`.

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

### Manglende informasjon/missing:

**Å identifisere missing i R:**

I R kan missing være kodet på flere måter. Dersom missing er eksplisitt definert i R, vil vi se missing som `NA` når vi ser på datasettet. Vi vil også kunne sjekke om vi har missing på en variabel med `table(is.na(data$myvar))`. La oss teste:

```r
load("../data/bd_full.Rdata")
table(is.na(full$bdaid)) # Burnside og Dollar sin originale variabel
```

```
## 
## FALSE  TRUE 
##   612   748
```

```r
table(is.na(full$elraid)) # Easterly sin utvidede variabel
```

```
## 
## FALSE  TRUE 
##   731   629
```

Noen ganger leses ikke missing inn som `NA`. Missing på variabler i datasett fra andre statistikkprogramm kan f.eks. leses som `character` med verdi `" "`, eller som `numeric` med verdi `-99`. For å sjekke dette, bør du lese kodebok. Det er ikke sikkert at `" "` bør omkodes til missing. Du kan også se på en tabell, for å identifisere suspekte verdier:

```r
table(full$regions) # ingen suspekte verdier
```

```
## 
##              Other Sub-Saharan Africa          East Asia 
##                177                124                 30
```

Moral: **alltid sjekk kodeboken**, og se på verdiene til data med tabell for å identifisere missing. 


En annen måte data kan være missing på, er at en hel observasjon simpelthen er utelatt fra datasettet. Vi kan for eksempel ha et datasett med boligprisene for en gjennomsnittlig treromsleilighet fra 2013 til i dag i 2 bydeler som ser slik ut:

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
Her er det ingen eksplisitte missing, men all informasjon for 2014 er implisitt missing. Pass opp for denne typen missing, særlig i panel data. 
En lettvint måte å kikke etter slike metoder er å vise den grunnleggende datastrukturen med `table()`, der du legger inn variablene som danner grunnlaget for datastrukturen (land og år i datasettet `full`). Heldigvis er det sjeldent at vi får ubalanserte datasett når vi bruker ferdiglagde datasett.

Til slutt er det viktig å være oppmerksom på konsekvensene av missing på en eller flere variabler når vi gjennomfører en statistisk analyse. I regresjonsmodelle blir observasjoner som har missing på en av variablene som inngår i en modell kastet ut av analysen. I regresjonsoutput fra `summary(model)` får vi vite hvor mange observasjoner som blir fjernet. Dette er fin informasjon, men vi kan også undersøke konsekvensene av missing nærmere. Under skisserer jeg noen måter dere kan bruke R på for å lære mer om missingstruktur:

**Metode 1: korrelasjonsmatriser**

Korrelasjonsmatriser viser korrelasjoner mellom variabler av klassene `numeric` og `integer`.
Dersom vi vil få et raskt inntrykk av konsekvensene av missing i en modell, kan vi lage en korrelasjonsmatrise med variablene som inngår i modellen, og varierer hvordan vi håndterer missing i korrelasjonsmatrisen. Her er et eksempel:


```r
m1 <- lm(bdgdpg ~ bdaid*policy + as.factor(period) + bdlpop + ethnic_frac*assasinations, data = full )
summary(m1) # output viser at 1077 observasjoner fjernes pga. missing
```

```
## 
## Call:
## lm(formula = bdgdpg ~ bdaid * policy + as.factor(period) + bdlpop + 
##     ethnic_frac * assasinations, data = full)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -11.6066  -1.4981  -0.0862   1.6759  12.2156 
## 
## Coefficients:
##                           Estimate Std. Error t value Pr(>|t|)    
## (Intercept)               -5.73003    2.22507  -2.575 0.010551 *  
## bdaid                      0.04325    0.15001   0.288 0.773322    
## policy                     1.30474    0.19893   6.559 2.75e-10 ***
## as.factor(period)3         0.20168    0.61744   0.327 0.744193    
## as.factor(period)4        -1.28724    0.61916  -2.079 0.038561 *  
## as.factor(period)5        -3.21009    0.62625  -5.126 5.65e-07 ***
## as.factor(period)6        -2.05272    0.63563  -3.229 0.001394 ** 
## as.factor(period)7        -3.01083    0.66926  -4.499 1.02e-05 ***
## bdlpop                     0.47332    0.13625   3.474 0.000597 ***
## ethnic_frac               -1.71211    0.67058  -2.553 0.011226 *  
## assasinations             -0.73009    0.29827  -2.448 0.015012 *  
## bdaid:policy               0.07583    0.09446   0.803 0.422778    
## ethnic_frac:assasinations  1.19541    0.61754   1.936 0.053940 .  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 2.941 on 270 degrees of freedom
##   (1077 observations deleted due to missingness)
## Multiple R-squared:  0.3712,	Adjusted R-squared:  0.3432 
## F-statistic: 13.28 on 12 and 270 DF,  p-value: < 2.2e-16
```

Lager korrelasjonsmatrise med variablene som inngår:

```r
# Siden as.factor(period) lager en dummvariabel for alle perioder unntatt periode 1, må vi gjøre dette for å inkludere denne variabelen i korrelasjonsmatrisen (inkluder gjerne også periode 1 i matrise):

full$period2 <- ifelse(full$period==2, 1, 0)
full$period3 <- ifelse(full$period==3, 1, 0)
full$period4 <- ifelse(full$period==4, 1, 0)
full$period5 <- ifelse(full$period==5, 1, 0)
full$period6 <- ifelse(full$period==6, 1, 0)
full$period7 <- ifelse(full$period==7, 1, 0)
full$period8 <- ifelse(full$period==8, 1, 0)

cor(full[, c("bdgdpg", "bdaid", "policy", "bdlpop", "ethnic_frac", "assasinations", "period2", "period3", "period4", "period5", "period6", "period7")], use = "pairwise.complete.obs")
```

```
##                      bdgdpg       bdaid      policy      bdlpop
## bdgdpg         1.0000000000 -0.03217491  0.45346637  0.01094811
## bdaid         -0.0321749068  1.00000000 -0.14758229 -0.30316017
## policy         0.4534663671 -0.14758229  1.00000000  0.07266388
## bdlpop         0.0109481098 -0.30316017  0.07266388  1.00000000
## ethnic_frac   -0.1246418815  0.28573905 -0.05375693  0.11155204
## assasinations -0.0638101089 -0.15372098 -0.01143047  0.11757936
## period2        0.1120746461 -0.11622813  0.02233928 -0.06845450
## period3        0.0847155933 -0.09063401 -0.06220243 -0.04088022
## period4        0.0290984091 -0.02258524 -0.06367073 -0.01299697
## period5       -0.1015614376  0.02411195 -0.16002539  0.01427018
## period6        0.0009199064  0.10074206  0.03692845  0.04097350
## period7       -0.2108102264  0.10459338  0.24028406  0.06708800
##                 ethnic_frac assasinations       period2       period3
## bdgdpg        -0.1246418815   -0.06381011  0.1120746461  0.0847155933
## bdaid          0.2857390543   -0.15372098 -0.1162281328 -0.0906340118
## policy        -0.0537569312   -0.01143047  0.0223392784 -0.0622024299
## bdlpop         0.1115520413    0.11757936 -0.0684544989 -0.0408802184
## ethnic_frac    1.0000000000   -0.08658713  0.0001371322  0.0001371322
## assasinations -0.0865871279    1.00000000 -0.0640572060 -0.0130669004
## period2        0.0001371322   -0.06405721  1.0000000000 -0.1428571429
## period3        0.0001371322   -0.01306690 -0.1428571429  1.0000000000
## period4        0.0001371322    0.05931683 -0.1428571429 -0.1428571429
## period5        0.0001371322   -0.04193407 -0.1428571429 -0.1428571429
## period6        0.0011598021   -0.04754414 -0.1428571429 -0.1428571429
## period7       -0.0017293739    0.10841360 -0.1428571429 -0.1428571429
##                     period4       period5       period6      period7
## bdgdpg         0.0290984091 -0.1015614376  0.0009199064 -0.210810226
## bdaid         -0.0225852375  0.0241119493  0.1007420554  0.104593377
## policy        -0.0636707337 -0.1600253888  0.0369284468  0.240284061
## bdlpop        -0.0129969693  0.0142701810  0.0409735049  0.067088001
## ethnic_frac    0.0001371322  0.0001371322  0.0011598021 -0.001729374
## assasinations  0.0593168341 -0.0419340675 -0.0475441407  0.108413597
## period2       -0.1428571429 -0.1428571429 -0.1428571429 -0.142857143
## period3       -0.1428571429 -0.1428571429 -0.1428571429 -0.142857143
## period4        1.0000000000 -0.1428571429 -0.1428571429 -0.142857143
## period5       -0.1428571429  1.0000000000 -0.1428571429 -0.142857143
## period6       -0.1428571429 -0.1428571429  1.0000000000 -0.142857143
## period7       -0.1428571429 -0.1428571429 -0.1428571429  1.000000000
```

```r
# Alternativet "pairwise.complete.obs" fjerner bare missing for de enkelte bivariate korrelasjonene

cor(full[, c("bdgdpg", "bdaid", "policy", "bdlpop", "ethnic_frac", "assasinations", "period2", "period3", "period4", "period5", "period6", "period7")], use = "complete.obs")
```

```
##                     bdgdpg        bdaid      policy       bdlpop
## bdgdpg         1.000000000 -0.163268793  0.45356785  0.138139682
## bdaid         -0.163268793  1.000000000 -0.14342838 -0.346394074
## policy         0.453567853 -0.143428381  1.00000000  0.073740338
## bdlpop         0.138139682 -0.346394074  0.07374034  1.000000000
## ethnic_frac   -0.098074862  0.266263842 -0.04942033  0.123694145
## assasinations -0.077911729 -0.138718823 -0.01217813  0.101509682
## period2        0.184487425 -0.149985596  0.02060803 -0.065072184
## period3        0.178520491 -0.067445477 -0.06208268 -0.073105602
## period4       -0.007052255  0.007802611 -0.05839454 -0.052256394
## period5       -0.275963915  0.048299871 -0.16229948 -0.003681074
## period6       -0.020471898  0.093558859  0.03511158  0.061605603
## period7       -0.052385079  0.063462589  0.23898094  0.135840603
##                ethnic_frac assasinations     period2     period3
## bdgdpg        -0.098074862   -0.07791173  0.18448743  0.17852049
## bdaid          0.266263842   -0.13871882 -0.14998560 -0.06744548
## policy        -0.049420328   -0.01217813  0.02060803 -0.06208268
## bdlpop         0.123694145    0.10150968 -0.06507218 -0.07310560
## ethnic_frac    1.000000000   -0.08864021 -0.02743536 -0.02111523
## assasinations -0.088640214    1.00000000 -0.05245223 -0.03014763
## period2       -0.027435362   -0.05245223  1.00000000 -0.19369514
## period3       -0.021115228   -0.03014763 -0.19369514  1.00000000
## period4        0.012015521    0.05882137 -0.19608106 -0.21198111
## period5        0.023063278   -0.04151071 -0.19369514 -0.20940171
## period6        0.018297094   -0.04992095 -0.19130014 -0.20681251
## period7       -0.006452537    0.11657710 -0.18161679 -0.19634394
##                    period4      period5     period6      period7
## bdgdpg        -0.007052255 -0.275963915 -0.02047190 -0.052385079
## bdaid          0.007802611  0.048299871  0.09355886  0.063462589
## policy        -0.058394539 -0.162299484  0.03511158  0.238980941
## bdlpop        -0.052256394 -0.003681074  0.06160560  0.135840603
## ethnic_frac    0.012015521  0.023063278  0.01829709 -0.006452537
## assasinations  0.058821372 -0.041510714 -0.04992095  0.116577101
## period2       -0.196081061 -0.193695137 -0.19130014 -0.181616790
## period3       -0.211981106 -0.209401709 -0.20681251 -0.196343939
## period4        1.000000000 -0.211981106 -0.20936001 -0.198762490
## period5       -0.211981106  1.000000000 -0.20681251 -0.196343939
## period6       -0.209360009 -0.206812507  1.00000000 -0.193916193
## period7       -0.198762490 -0.196343939 -0.19391619  1.000000000
```

```r
# Alternativet "complete.obs" fjerner alle observasjoner som har missing på en av variablene som inngår, mao. det samme som regresjonsanalysen.
```


**Metode 2: Analyse av dummy-variabler for missing**

Ved å sammenligne disse korrelasjonsmatrisene, kan vi få et inntrykk av konsekvensene av å fjerne missing med listwise deletion. En alternativ metode å utforske missing i en analyse på, er med funksjonen `complete.cases()`, som gjør en logisk test av om en observasjon har missing. Vi kan bruke denne funksjonen til å lage en dummy for observasjoner som har missing/ikke har missing på noen av observasjonene som inngår i analysen vår.


```r
table(complete.cases(full[, c("bdgdpg", "bdaid", "policy", "bdlpop", "ethnic_frac", "assasinations", "period2", "period3", "period4", "period5", "period6", "period7")]))
```

```
## 
## FALSE  TRUE 
##  1077   283
```

```r
full$m1_miss <- complete.cases(full[, c("bdgdpg", "bdaid", "policy", "bdlpop", "ethnic_frac", "assasinations", "period2", "period3", "period4", "period5", "period6", "period7")])
```

Vi kan bruke denne variabelen til plot. Både spredningsplot og boxplot kan gi god innsikt i hvordan observasjoner med missing skiller seg fra andre. Et annet alternativ, er å se på en logistisk regresjon, med den nye dummyen som avhengig variabel. Her fjerner jeg de variablene som fører til flest missing:


```r
miss_mod <- glm(m1_miss ~ bdaid*policy + bdlpop + as.factor(period), data = full)
summary(miss_mod) # ingen store forskjeller, signifikante uavh. var her er ikke bra.
```

```
## 
## Call:
## glm(formula = m1_miss ~ bdaid * policy + bdlpop + as.factor(period), 
##     data = full)
## 
## Deviance Residuals: 
##      Min        1Q    Median        3Q       Max  
## -0.98971  -0.00447   0.00489   0.02263   0.06201  
## 
## Coefficients:
##                     Estimate Std. Error t value Pr(>|t|)    
## (Intercept)         1.087644   0.075745  14.359   <2e-16 ***
## bdaid              -0.008006   0.004776  -1.676   0.0948 .  
## policy             -0.001339   0.006828  -0.196   0.8446    
## bdlpop             -0.005035   0.004539  -1.109   0.2682    
## as.factor(period)3 -0.017494   0.021248  -0.823   0.4111    
## as.factor(period)4 -0.032704   0.021227  -1.541   0.1245    
## as.factor(period)5  0.006728   0.021667   0.311   0.7564    
## as.factor(period)6  0.007621   0.021967   0.347   0.7289    
## as.factor(period)7  0.008786   0.022808   0.385   0.7004    
## bdaid:policy        0.001910   0.003241   0.589   0.5562    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for gaussian family taken to be 0.01037719)
## 
##     Null deviance: 2.9685  on 285  degrees of freedom
## Residual deviance: 2.8641  on 276  degrees of freedom
##   (1074 observations deleted due to missingness)
## AIC: -483.04
## 
## Number of Fisher Scoring iterations: 2
```

I dette særtilfellet, kan vi også bruke utvidelsen av det originale datasettet til Burnside og Dollar fra Easterly til å gjøre samme test:


```r
miss_mod2 <- glm(m1_miss ~ elraid + elrsacw + elrbb + elrinfl + elrlpop + as.factor(period), data = full)
summary(miss_mod2)
```

```
## 
## Call:
## glm(formula = m1_miss ~ elraid + elrsacw + elrbb + elrinfl + 
##     elrlpop + as.factor(period), data = full)
## 
## Deviance Residuals: 
##      Min        1Q    Median        3Q       Max  
## -0.90914  -0.09745   0.16095   0.24801   0.58506  
## 
## Coefficients:
##                    Estimate Std. Error t value Pr(>|t|)    
## (Intercept)         0.34389    0.22513   1.528   0.1274    
## elraid             -0.04241    0.01033  -4.104 4.89e-05 ***
## elrsacw            -0.02226    0.04788  -0.465   0.6423    
## elrbb              -0.50952    0.48223  -1.057   0.2913    
## elrinfl             0.03698    0.05318   0.695   0.4872    
## elrlpop             0.02864    0.01352   2.117   0.0348 *  
## as.factor(period)3  0.01122    0.07711   0.146   0.8843    
## as.factor(period)4  0.01313    0.07640   0.172   0.8637    
## as.factor(period)5 -0.02599    0.07662  -0.339   0.7346    
## as.factor(period)6 -0.07160    0.07630  -0.938   0.3486    
## as.factor(period)7 -0.11860    0.07839  -1.513   0.1311    
## as.factor(period)8 -0.74979    0.07980  -9.396  < 2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for gaussian family taken to be 0.1518918)
## 
##     Null deviance: 101.916  on 429  degrees of freedom
## Residual deviance:  63.491  on 418  degrees of freedom
##   (930 observations deleted due to missingness)
## AIC: 423.74
## 
## Number of Fisher Scoring iterations: 2
```

```r
# Her er koeffisienten til bistand negativ og signifikant. Dette indikerer at land som fjernes pga missing, får mindre bistand enn land som ikke fjernes. Ser også at land med større befolkning i mindre grad fjernes pga. missing.
```

Vi kunne også definert dummy-variabler for missing på de enkeltvariablene vi er mest interessert i (her: `bdgdpg`, `bdaid` og `policy`), og gjennomført tilsvarende analyser, ved hjelp av funksjonen `is.na()`. 

I de fleste tilfeller er `ifelse()` en fin funksjon til å definere missing. Statistiske R-funksjoner har stort sett et eller flere argumenter der du kan velge hvordan missing skal håndteres (se for eksempel `?cor`, og argumentene `use` og `na.rm`). Husk på det dere har lært på forelesning, og ta aktive valg om hvordan missing bør håndteres. 




## Logistisk regresjon:
Mange av metodene for diagnostikk som vi har sett på i dag fungerer også for logistisk regresjon. Funksjonene `ceresplot()`, `dfbetas()`, `influenceIndexPlot()` m.m. fungerer også for logistisk regresjon. Husk forøvrig på at forutsetninger om homoskedastiske, normalfordelte restledd ikke gjelder logistisk regresjon. I tillegg viste jeg hvordan du kan lage ROC-kurver i introduksjonen til [dagens seminar](https://github.com/martigso/stv4020aR/blob/master/Gruppe%201/docs/Introduksjon_seminar4.md). 

Tomme celler vil føre til at modellen ikke lar seg estimere, eller at du ikke får estimert standardfeil/ekstremt høye standardfeil, og er således greit å oppdage. Spredningsplot mellom variabler fra regresjonen kan brukes til å undersøke nærmere.

Vi kan gjøre nøstede likelihood-ratio tester med `anova()`.

Vi kan gjøre hosmer-lemeshow med `hoslem.test()` fra pakken `ResourceSelection`

Se medfølgende script for demonstrarsjon av de to siste funksjonene.

**Husk:** I tillegg til formell diagnostikk, må du aldri glemme generelle validitets/metode-vurderinger.



















