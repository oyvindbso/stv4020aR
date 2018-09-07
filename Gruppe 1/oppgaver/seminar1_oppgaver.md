# Oppgaver til 1. seminar
Erlend Langørgen  
September 6, 2018  



## Instruksjoner

Dersom koden deres ikke virker i løpet av dagens seminar, start med å se etter **skrivefeil**. Sammenlign så koden din med naboens kode, se om hun/han/hen kan hjelpe deg. R er svært pirkete på skrivefeil, parenteser, komma og små/store bokstaver. Vi skal lære mer om strategier for å unngå feil i neste seminar. Dersom koden fortsatt ikke virker, spør dere meg om hjelp. Ikke nøl med å spørre meg, jeg vil ikke at dere skal sitte og lete lenge etter løsningen på egenhånd i dagens seminar. Fasit lastes opp på slutten av seminaret, men jeg har lagt noen hint nederst i dette dokumentet som du kan se på dersom du står fast. 

Den første delen av oppgavene gir trening/repetisjon i grunnleggende R-ferdigheter. Dersom du ikke har holdt på med R så lenge, er disse oppgavene god trening. De første oppgavene inneholder også forberedelse av data, og undersøkelse av hva slags datasett dere har fått å jobbe med. 

Oppgavene tar dere gjennom dataforberedelser og nærmere undersøkelse av hypotesen til Burnside og Dollar (2000).


## Del 1

### Oppgave 1:

Kjør følgende kode:

```r
aid <- read.csv("https://raw.githubusercontent.com/martigso/stv1020R/master/data/aidgrowth.csv")
str(aid)
```

```
## 'data.frame':	331 obs. of  13 variables:
##  $ X                     : int  34 35 36 37 38 39 154 155 156 157 ...
##  $ country               : Factor w/ 56 levels "ARG","BOL","BRA",..: 1 1 1 1 1 1 2 2 2 2 ...
##  $ period                : int  2 3 4 5 6 7 2 3 4 5 ...
##  $ gdp_growth            : num  1.7 1.08 -1.12 -2.55 -1.1 ...
##  $ aid                   : num  0.0182 0.0172 0.024 0.03 0.0157 ...
##  $ policy                : num  0.657 -0.579 -0.136 -1.348 -1.09 ...
##  $ gdp_pr_capita         : int  5637 6168 5849 5487 5624 4706 1661 1838 2015 1864 ...
##  $ ethnic_frac           : num  0.31 0.31 0.31 0.31 0.31 0.31 0.68 0.68 0.68 0.68 ...
##  $ assasinations         : num  2.75 9.75 1 0 0.25 0 0.75 0 0.25 0 ...
##  $ sub_saharan_africa    : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ fast_growing_east_asia: int  0 0 0 0 0 0 0 0 0 0 ...
##  $ institutional_quality : num  4.28 4.28 4.28 4.28 4.28 ...
##  $ m2_gdp_lagged         : num  24.8 28.8 30.2 29.7 20.3 ...
```

Ekskluder den første variabelen, `X` fra datasettet.


### Oppgave 2:

Opprett en ny variabel i datasettet ditt, `aid$gdp_pr_capita_log` ved å log-transformere `aid$gdp_pr_capita`

### Oppgave 3:

- Indekser deg frem til observasjoner som har verdi på `aid` større enn 5.
- Indekser deg frem til observasjoner som har verdi på `gdp_growth` lavere enn -5 (sett -5 i parentes) 
- Indekser deg frem til observasjoner som har verdi på `policy`større enn 3. 

### Oppgave 4:
Opprett variabelen `aid$regions`, der observasjoner som har verdien `1` på variabelen `aid$sub_saharan_africa` får verdien `"Sub-Saharan Africa"`, observasjoner som har verdien `1` på variabelen `aid$fast_growing_east_asia` får verdien `"East Asia"`, mens de resterende observasjonene får verdien `"Other"`. Bruk `ifelse()` til dette.
Omkode deretter variabelen til klassen faktor.

### Del 2:

### Oppgave 5:

Kjør følgende regresjonsmodell (fordrer at du har gjort oppgave 1) - regresjonsmodell 5 fra artikkelen til Burnside og Dollar (2000):


```r
m5 <- lm(gdp_growth ~ gdp_pr_capita_log + ethnic_frac * assasinations +
               institutional_quality + m2_gdp_lagged + regions + policy * aid +
               factor(period),
             data = aid, na.action = "na.exclude")
```

Tolk samspillet mellom `policy` og `aid` substansielt ved å se på effekten av 1 enhets økning i `aid` for ulike verdier av `policy`. Er det støtte for hypotesen til Burnside og Dollar (2000) om en samspillseffekt (vurder både om forventet effekt er substansiell, og statistisk signifikans)?

### Oppgave 6: 

Les om hvordan variabelen `policy` er kodet [nederst på side 849 og på side 855 i artikkelen til Burnside og Dollar](https://www.jstor.org/stable/117311?seq=1#metadata_info_tab_contents). 
Last inn datasettet `bd_full.Rdata` som objektet `full`. (https://github.com/martigso/stv4020aR/raw/master/Gruppe%201/data/bd_full.Rdata). I tillegg til alle variablene fra aid, inneholder dette datasettet inneholder variablene `bdbb` (budsjettbalanse), `bdsacw` (åpenhet) og `bdinfl` (inflasajon). Erstatt `policy` med disse variablene i regresjonsmodellen over (kjør 3 separate regresjoner, 1 for hver komponentvariabel)
Konstruer deretter  en versjon av `policy`, `policy2` ved å ta `full$bdbb + (-1)*full$bdinfl + full$bdsacw`, og se på effekten av å bruke denne indeksen i modell 5.

### Oppgave 7: 

Se på scatterplot, der du:

1. ser på sammenhengen mellom de ulike komponentvariablene i policy-indeksen og BNP-vekst i de forskjellige regionene i datasettet. 
2. ser på sammenhengene mellome de ulike komponentvariablene i policy-indeksen og bistand i de forskjellige regionene i datasettet.





## Hint

**Oppgave 1:** Indekser med `[,]` eller `select(-var)` (fra dplyr), og overskriv det gamle objektet.

**Oppgave 2:** Bruk `log()`

**Oppgave 3:** Bruk `aid[which(),]`, eller `fillter()` fra `dplyr` pakken.

**Oppgave 4:** Bruk to linjer med `ifelse`:
På linje 1 (fyll ut): `ifelse(logisk test 1, "Sub-Saharan Africa", "Other")`
På linje 2 (fyll ut): `ifelse(logisk test 2, "East Asia", aid$regions)`

Bruk `as.factor()` til slutt.

**Oppgave 7:** Bruk `facet_wrap()` og `geom_point()`
