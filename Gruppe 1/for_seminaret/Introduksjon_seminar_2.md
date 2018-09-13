# Introduksjon seminar 2
Erlend Langørgen  
13 september 2018  



## Om seminaret i morgen

I neste seminar, skal vi i hovedsak bruke 1. time på å jobbe med oppgaver i databehandling med R. I andre time skal vi se på regresjonsdiagnostikk. Vi kommer til å fortsette å jobbe med utgangspukt i artikkelen til Burnside og Dollar (2000). I denne introduksjonen, viser jeg noen flere konsepter for databehandling i R, som kan være særlig nyttig til hjemmeoppgaven:

1. Kombinere datasett
2. Gruppere/aggregere data
3. Mer om funksjoner


### Kombinere datasett - merge funksjonen

> Når vi merger legges det flere variabler til datasettet vårt.

Noen ganger er vi interessert i å kombinere informasjon fra ulike datasett. Dette kan gjøres med `merge()`, eller med `right_join()` (og beslektede funksjoner) fra dplyr. Datasettet `bd_full.Rdata`, laget jeg ved å kombinere datasettet fra [New Data, New Doubts: Revisiting  "Aid, Policies and Growth"](https://dataverse.harvard.edu/dataverse/harvard?q=easterly+2003) (Easterly 2003) med datasettet til Burnside og Dollar (2000). Her er annotert kode for å gjøre sammenslåingen med `merge()`:


```r
# Plan: vi vet at observasjonene i datasettene er land-år. Vi vil beholde denne strukturen i data, og vil derfor 
# bruke variabler for land og år til å kombinere observasjoner fra datasettene

# pakke for å lese .dta
library(haven)
```

```
## Warning: package 'haven' was built under R version 3.4.3
```

```r
# laster inn de to datasettene
easterly <- read_stata("https://github.com/martigso/stv4020aR/raw/master/Gruppe%201/data/NDND.dta")
bd <- read.csv("https://raw.githubusercontent.com/martigso/stv1020R/master/data/aidgrowth.csv")

# sjekker hvilke variabelnavn det er i datasettene.
names(easterly)
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
```

```r
names(bd)
```

```
##  [1] "X"                      "country"               
##  [3] "period"                 "gdp_growth"            
##  [5] "aid"                    "policy"                
##  [7] "gdp_pr_capita"          "ethnic_frac"           
##  [9] "assasinations"          "sub_saharan_africa"    
## [11] "fast_growing_east_asia" "institutional_quality" 
## [13] "m2_gdp_lagged"
```

```r
# sjekker at verdiene til variablene er like - her er det også lurt å se på kodebok
table(bd$period)
```

```
## 
##  2  3  4  5  6  7 
## 56 56 56 56 54 53
```

```r
table(easterly$period)
```

```
## 
##   1   2   3   4   5   6   7   8 
## 170 170 170 170 170 170 170 170
```

```r
table(easterly$country)
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
table(bd$country)
```

```
## 
## ARG BOL BRA BWA CHL CIV CMR COL CRI DOM DZA ECU EGY ETH GAB GHA GMB GTM 
##   6   6   6   6   6   6   6   6   6   6   6   6   6   6   6   6   4   6 
## GUY HND HTI IDN IND JAM KEN KOR LKA MAR MDG MEX MLI MWI MYS NER NGA NIC 
##   5   6   6   6   6   6   6   6   6   6   6   6   6   6   6   6   6   4 
## PAK PER PHL PRY SEN SLE SLV SOM SYR TGO THA TTO TUN TUR TZA URY VEN ZAR 
##   6   6   6   6   6   6   6   6   6   6   6   6   6   6   6   6   6   6 
## ZMB ZWE 
##   6   6
```

```r
full <- merge(easterly, bd, 
              by.x = c("country", "period"), 
              by.y = c("country", "period"), 
              all.x = T)
# Forklaring: merge(data1, data2, 
#                   by.x = "merge.variabler fra data1",
#                   by.y = "merge.variabler fra data2",
#                   all.x = T) siste linje forteller at vi vil beholde alle observasjoner fra datasett 1.
str(full)
```

```
## 'data.frame':	1360 obs. of  63 variables:
##  $ country                : chr  "AFG" "AFG" "AFG" "AFG" ...
##  $ period                 : num  1 2 3 4 5 6 7 8 1 2 ...
##  $ periodstart            : num  1966 1970 1974 1978 1982 ...
##  $ periodend              : num  1969 1973 1977 1981 1985 ...
##  $ code                   : chr  "AFG1" "AFG2" "AFG3" "AFG4" ...
##  $ bdgdpg                 : num  NA NA NA NA NA NA NA NA NA NA ...
##  $ elrgdpg                : num  -0.0131 -0.5499 2.2372 -1.0907 0.8044 ...
##  $ bdgdp                  : num  NA NA NA NA NA ...
##  $ elrgdp                 : num  NA NA NA NA NA ...
##  $ bdbb                   : num  NA NA NA NA NA NA NA NA NA NA ...
##  $ elrbb                  : num  NA NA NA NA NA NA NA NA NA NA ...
##  $ bdinfl                 : num  NA NA NA NA NA NA NA NA NA NA ...
##  $ elrinfl                : num  NA NA NA NA NA NA NA NA NA NA ...
##  $ bdsacw                 : num  NA NA NA NA NA NA NA NA 0 0 ...
##  $ elrsacw                : num  NA NA NA NA NA NA NA NA NA NA ...
##  $ bdethnf                : num  NA NA NA NA NA NA NA NA NA NA ...
##  $ elrethnf               : num  NA NA NA NA NA ...
##  $ bdassas                : num  NA NA NA NA NA NA NA NA NA NA ...
##  $ elrassas               : num  0 0 0.25 1 0.25 0 0.25 0 NA NA ...
##  $ bdicrge                : num  NA NA NA NA NA NA NA NA NA NA ...
##  $ elricrge               : num  NA NA NA NA NA ...
##  $ bdm21                  : num  NA NA NA NA NA NA NA NA NA NA ...
##  $ elrm21                 : num  NA NA NA NA NA NA NA NA NA NA ...
##  $ bdssa                  : num  NA NA NA NA NA NA NA NA 0 0 ...
##  $ elrssa                 : num  0 0 0 0 0 0 0 0 1 1 ...
##  $ bddn1900               : num  NA NA NA NA NA NA NA NA 0 0 ...
##  $ elrdn1900              : num  NA NA NA NA NA NA NA NA 0 0 ...
##  $ bdaid                  : num  NA NA NA NA NA ...
##  $ elraid                 : num  NA NA NA NA NA ...
##  $ bdlpop                 : num  NA NA NA NA NA NA NA NA NA NA ...
##  $ elrlpop                : num  16.3 16.4 16.5 16.6 16.6 ...
##  $ bdeasia                : num  NA NA NA NA NA NA NA NA 0 0 ...
##  $ elreasia               : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ bdegypt                : num  NA NA NA NA NA NA NA NA NA NA ...
##  $ elregypt               : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ bdcentam               : num  NA NA NA NA NA NA NA NA NA NA ...
##  $ elrcentam              : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ bdfrz                  : num  NA NA NA NA NA NA NA NA NA NA ...
##  $ elrfrz                 : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ bdarms1                : num  NA NA NA NA NA NA NA NA NA NA ...
##  $ elrarms1               : num  0.176 0.345 0.311 0.243 0.756 ...
##  $ originalcountries      : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ bddatap                : num  NA NA NA NA NA NA NA NA NA NA ...
##  $ bddatao                : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ elrdatabdcos7093bdvarsp: num  NA NA NA NA NA NA NA NA NA NA ...
##  $ elrdatabdcos7093bdvarso: num  NA NA NA NA NA NA NA NA NA NA ...
##  $ elrdatabdcos7097bdvarsp: num  NA NA NA NA NA NA NA NA NA NA ...
##  $ elrdatabdcos7097bdvarso: num  NA NA NA NA NA NA NA NA NA NA ...
##  $ elrdata7093bdvarsp     : num  NA NA NA NA NA NA NA NA NA NA ...
##  $ elrdata7093bdvarso     : num  NA NA NA NA NA NA NA NA NA NA ...
##  $ elrdata7097bdvarsp     : num  NA NA NA NA NA NA NA NA NA NA ...
##  $ elrdata7097bdvarso     : num  NA NA NA NA NA NA NA NA NA NA ...
##  $ X                      : int  NA NA NA NA NA NA NA NA NA NA ...
##  $ gdp_growth             : num  NA NA NA NA NA NA NA NA NA NA ...
##  $ aid                    : num  NA NA NA NA NA NA NA NA NA NA ...
##  $ policy                 : num  NA NA NA NA NA NA NA NA NA NA ...
##  $ gdp_pr_capita          : int  NA NA NA NA NA NA NA NA NA NA ...
##  $ ethnic_frac            : num  NA NA NA NA NA NA NA NA NA NA ...
##  $ assasinations          : num  NA NA NA NA NA NA NA NA NA NA ...
##  $ sub_saharan_africa     : int  NA NA NA NA NA NA NA NA NA NA ...
##  $ fast_growing_east_asia : int  NA NA NA NA NA NA NA NA NA NA ...
##  $ institutional_quality  : num  NA NA NA NA NA NA NA NA NA NA ...
##  $ m2_gdp_lagged          : num  NA NA NA NA NA NA NA NA NA NA ...
```

```r
# Rask test av om merge fungerte ved å sammenligne missing - bør gjøres grundigere med lignende tabeller/deskriptiv statistikk.
table(is.na(bd$gdp_growth)) # is.na er en funksjon som tester for missing (NA), returnerer TRUE hvis noe er NA
```

```
## 
## FALSE  TRUE 
##   325     6
```

```r
table(is.na(full$gdp_growth))
```

```
## 
## FALSE  TRUE 
##   325  1035
```

```r
summary(bd$aid)
```

```
##      Min.   1st Qu.    Median      Mean   3rd Qu.      Max. 
## -0.007973  0.269372  0.998406  1.757570  2.628056 10.359500
```

```r
summary(full$aid) # 1360 - 331 = 1029 NA, lik fordeling i de to datasettene, ser bra ut.
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
## -0.0080  0.2694  0.9984  1.7576  2.6281 10.3595    1029
```


**Oppgave:** Last inn datasettene du finner bak disse urlene:

1. "https://raw.githubusercontent.com/martigso/stv4020aR/master/Gruppe%201/data/ucdp-brd-conf-171.csv"
2. "https://raw.githubusercontent.com/martigso/stv4020aR/master/Gruppe%201/data/ucdp-nonstate-171.csv"

Sjekke deretter hvordan er datasettene strukturert.

Slå til slutt sammen datasettene. Merge-variabler for det første datasettet er `"GWNoLoc"` og `"Year"`. Merge-variabler for det andre datasettet er `"gwnoloc"` og `"year"`. Behold alle observasjoner fra det første datasettet. Avslutt med deskriptiv statistikk/tabell for å sjekke at `merge()` fungerte.


### Gruppere/aggregere data:

> Når vi aggregerer grupperer vi data med utgangspunkt i en eller flere variabler, og oppsummerer informasjon om hver gruppe. Når vi oppretter et aggregert datasett, reduserer vi antall observasjoner gjennom gruppering.

Noen ganger ønsker vi å lage ett nytt datasett ved å aggregere data fra et datasett vi allerede har. Dette kan være fordi vi ønsker å gjennomføre en analyse på høyere aggregeringsnivå, men det kan også være for å undersøke systematiske forskjeller i ulike grupper i data med deskriptiv statistikk/plot. Under viser jeg hvordan man aggregerer data til region-perioder i datasettet `full` med utgangspunkt i `group_by()` og `summarise()` fra pakken `dplyr`:


```r
library(dplyr)
```

```
## Warning: package 'dplyr' was built under R version 3.4.4
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
# Oppretter region-variabel (se også oppgaver etter seminar 1, her bruker jeg andre variabler):
full$regions <- ifelse(full$elreasia==1, "East Asia", "Other")
full$regions <- ifelse(full$elrcentam==1, "Central America", full$regions)
full$regions <- ifelse(full$elrssa==1, "Sub Saharan Africa", full$regions)
table(full$regions)
```

```
## 
##    Central America          East Asia              Other 
##                 56                 64                856 
## Sub Saharan Africa 
##                384
```

```r
# oppretter aggregert versjon av datasettet full
agg_full <- full %>% # %>% brukes til å binde funksjoner sammen, som + i ggplot. Forteller først navn på data
  group_by(regions, period) %>% # group_by() angir variabler som brukes til å aggregere på
 # i summarise bestemmer man hvilken variabler som skal aggregeres, og hvordan de skal aggregeres
 # Syntaks:  ny_var_navn = funksjon_som_produserer_et_tall_for_gruppe(var_navn)   
  summarise(med_growth = median(gdp_growth, na.rm = T),
            var_growth = var(gdp_growth, na.rm = T),    
            mean_aid = mean(aid, na.rm = T),             
            var_aid = var(aid, na.rm = T),
            med_policy = median(policy, na.rm = T))
```

```
## Warning: package 'bindrcpp' was built under R version 3.4.4
```

```r
str(agg_full)
```

```
## Classes 'grouped_df', 'tbl_df', 'tbl' and 'data.frame':	32 obs. of  7 variables:
##  $ regions   : chr  "Central America" "Central America" "Central America" "Central America" ...
##  $ period    : num  1 2 3 4 5 6 7 8 1 2 ...
##  $ med_growth: num  NA 2.222 2.494 -0.637 -1.935 ...
##  $ var_growth: num  NA 3.66 0.39 24.87 1.49 ...
##  $ mean_aid  : num  NaN 0.465 0.505 1.013 2.385 ...
##  $ var_aid   : num  NA 0.027 0.104 0.532 1.484 ...
##  $ med_policy: num  NA 1.068 1.027 0.846 0.783 ...
##  - attr(*, "vars")= chr "regions"
##  - attr(*, "drop")= logi TRUE
```

```r
agg_full
```

```
## # A tibble: 32 x 7
## # Groups:   regions [?]
##    regions         period med_growth var_growth mean_aid var_aid med_policy
##    <chr>            <dbl>      <dbl>      <dbl>    <dbl>   <dbl>      <dbl>
##  1 Central America      1     NA         NA      NaN     NA          NA    
##  2 Central America      2      2.22       3.66     0.465  0.0270      1.07 
##  3 Central America      3      2.49       0.390    0.505  0.104       1.03 
##  4 Central America      4     -0.637     24.9      1.01   0.532       0.846
##  5 Central America      5     -1.94       1.49     2.38   1.48        0.783
##  6 Central America      6      0.340      1.14     2.43   1.79        1.75 
##  7 Central America      7      1.76       1.83     1.99   1.77        3.09 
##  8 Central America      8     NA         NA      NaN     NA          NA    
##  9 East Asia            1     NA         NA      NaN     NA          NA    
## 10 East Asia            2      4.57       3.34     0.488  0.0669      3.09 
## # ... with 22 more rows
```


**Oppgave:** Aggreger full på variabelen country. Opprett aggregerte variabler for minimums og maksimumsverdier på variablene `gdp_growth`, `aid` og `policy` for landene. 


### Mer om funksjoner:

I forrige seminar snakket vi om at funksjoner er grunnleggende byggeklosser i R sammen med objekter. Dere har nå lært at det finnes et hav av ferdiglagde funksjoner i R og i tilleggspakker til R, og vi har sett nærmere på noen nyttige funksjoner for omkoding av data. Siden R er et programmeringsspråk, lar det oss imidlertid også skrive våre egne funksjoner. Dette er som regel mye lettere enn man skulle tro. Syntaksen for å skrive en egen funksjon er:

```r
a_function <- function(arg1, arg2) {
  #operasjoner her
}
```
arg1 og arg2 kan være hva som helst. Når jeg koder skriver jeg funksjoner ofte, særlig når jeg jobber med å forberede data. Dersom jeg skal utføre en repetetiv oppgave, går det som regel raskere å skrive en funksjon til oppgaven enn å copy-paste. Dessuten er sjansen for å gjøre feil mye mindre enn når man copy-paster, for da må man gjerne bytte ut en haug med navn. Her er et eksempel på en typisk situasjon der det er nyttig å skrive en funksjon:

Vi har importert et datasett i spss format der missing på alle variabler er kodet som -999, - 998 og -997. En fremgangsmåte er å skrive:

```r
data <- data.frame(v1 = c(1:90, rep(-999,10)), v2 =c(-998,2), v3=c(200, 2)) # lager kunstig SPSS datasett
tail(data)
```

```
##       v1   v2  v3
## 95  -999 -998 200
## 96  -999    2   2
## 97  -999 -998 200
## 98  -999    2   2
## 99  -999 -998 200
## 100 -999    2   2
```

```r
data$v1 <- ifelse(data$v1==-999, NA, data$v1)
data$v1 <- ifelse(data$v1==-998, NA, data$v1)
data$v1 <- ifelse(data$v1==-997, NA, data$v1)
tail(data)
```

```
##     v1   v2  v3
## 95  NA -998 200
## 96  NA    2   2
## 97  NA -998 200
## 98  NA    2   2
## 99  NA -998 200
## 100 NA    2   2
```
Deretter kan man copy-paste ørten gannger, og bytte ut var1 med en annen variabel hver gang. Her er det imidlertid lett å glemme å bytte ut var1, noe som kan føre til feil. Alternativt kan vi skrive en funksjon:

```r
fix_na <- function(x) {
x <- ifelse(x==-999, NA, x)
x <- ifelse(x==-998, NA, x)
x <- ifelse(x==-997, NA, x)
x
}
```

Her utnytter vi at vi skal gjennom føre en repetitiv oppgave, der variabelnavn er det eneste som endres. I stedet for å måtte skrive hvert variabelnavn 9 ganger, må vi nå bare skrive det en gang. Dersom man ser slike mønstre i repetetive oppgaver kan man som regel lett skrive en funksjon.

I dette tilfellet kan vi faktisk gjøre enda bedre. Et annet mønster er at vi vil gjøre denne operasjonen på alle variablene i datasettet, vi gjennomfører på sett og vis en repetetiv oppgave når vi skriver alle variabelnavnene i datasettet. Funksjonen `apply()` passer perfekt til å gjøre jobben enda enklere (funksjonen `for()` kan gjøre en lignende jobb), da den lar oss kjøre funksjoner enten på alle rader (bytt 2 med 1 under) eller alle kolonner:

```r
data <-  apply(data, 2 , fix_na)
tail(data)
```

```
##        v1 v2  v3
##  [95,] NA NA 200
##  [96,] NA  2   2
##  [97,] NA NA 200
##  [98,] NA  2   2
##  [99,] NA NA 200
## [100,] NA  2   2
```
Vi ser at koden fungerer. Selv om det kan virke litt skummelt og vanskelig, oppfordrer jeg dere til å lære dere å skrive funksjoner så raskt som mulig, da dette kan gjøre arbeidet deres i R utrolig effektivt. Bare kreativiteten setter grenser for hva dere kan bruker funksjoner til, under har jeg skrevet en funksjon som forteller dere hva som er det beste statistikkprogrammet (om noen lurer, er dette en spøk, og en ganske dårlig funksjon):

```r
beste_statitistikkprogram <- function(input){
  svar <-c("R", "er", "best", "og", "mye", "bedre", "enn", "SPSS")
  ifelse(duplicated(rbind(input, svar[1]))[2]==T, 
        "#### Obviously! ####", 
        "######### Game over. ( Try to type 'R' next time) #######")
}

beste_statitistikkprogram("SPSS")
```

```
## [1] "######### Game over. ( Try to type 'R' next time) #######"
```

```r
beste_statitistikkprogram("stata")
```

```
## [1] "######### Game over. ( Try to type 'R' next time) #######"
```

```r
beste_statitistikkprogram("R")
```

```
## [1] "#### Obviously! ####"
```


**Oppgave:** Forsøk å skriv en funksjon som sentrerer en variabel rundt variabelens medianverdi (dette er en vanskelig oppgave, men se på funksjonen `center()` som jeg skrev mot slutten av [Introduksjonen](https://github.com/martigso/stv4020aR/blob/master/Gruppe%201/scripts/Introduksjon.md) for hint). 









