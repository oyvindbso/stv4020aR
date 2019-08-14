---
title: "Introduksjonsforelesning"
author: "Erlend Langørgen"
date: "16 august 2019"
output:
  html_document:
    keep_md: yes
    self_contained: no
---



## R-undervisningen på STV 4020A:

Møt til seminarene, oppmøte 4 av 5 ganger er obligatorisk. Der kommer dere til å lære mye - dere bør møte hver gang. En forutsetning for å lykkes med en kvantitativ hjemmeoppgave, er å ha tilstrekkelige basisferdigheter. Dette fordrer noe egenarbeid i tillegg til seminarene. Min anbefaling å ta en titt på denne [egenstudieguiden](https://github.com/langoergen/stv4020aR/blob/master/docs/Studieguide_R.md) - her har jeg skrevet et forslag til hvordan dere kan gå frem for å lære tilstrekkelig R til å lykkes med hjemmeoppgaven på en effektiv måte. Jeg anbefaler også at dere samarbeider/hjelper hverandre med R-kode - i tillegg til å være effektivt er det en fin måte lære på. Mot slutten av semesteret blir det også R-hjelpetimer.


## Introduksjon til R for 4020 A


Velkommen til innføring i R!


**Mål for i dag:**

1. Få R og Rstudio til å virke på egen PC.
2. Gå frem i passelig tempo
3. Forstå hvordan R-studio er satt opp.
4. Forstå grunnleggende konsepter i R: indeksering, objekter, funksjoner m.m.
5. Laste inn et datasett og lage noen fine figurer.


**Format:** jeg går raskt gjennom et tema, dere løser småoppgaver etterpå. I mindre pustepauser, snakk med naboene dine dersom du lurer på noe!

**Notasjon:** alt som er skrevet som `"dette"` er R-kode.

Dette dokumentet gir mer utfyllende forklaringer enn scriptet vi jobber med i forelesningstimen. Jobb deg gjerne gjennom dokumentet senere i dag.


## Er det noen som ikke har lastet ned R og Rstudio?

Dersom du enda ikke har gjennomført [installasjonsguiden](https://github.com/langoergen/stv4020aR/blob/master/docs/installasjonsguide_R.md), ta en titt på den etterpå. I mellomtiden, finn deg en person som har R og Rstudio installert, og sett deg sammen med den personen.

Dersom du har gjennomført installasjonsguiden, uten å ha fått Rstudio til å virke, ta kontakt med meg etter forelesningen.




## Oppvarming: Min første R-kode, console og script

Vi skriver kode i script. Script kan lagres, og gjør arbeidet vårt reproduserbart for oss selv og andre. Etter at vi har skrevet kode i script, sender vi koden til console for evaluering med *ctrl/cmd + enter*. Dersom output fra koden ikke er et objekt eller plot, vises resultatet i console (vinduet under script). La oss forsøke med koden `"Hello World!"`



```r
"Hello world!"
```

```
## [1] "Hello world!"
```

R kan brukes som en kalkulator:


```r
1 + 1  # addisjon
```

```
## [1] 2
```

```r
2 - 3  # subtraksjon
```

```
## [1] -1
```

```r
4/2  # divisjon
```

```
## [1] 2
```

```r
2 * 2  # multiplikasjon
```

```
## [1] 4
```

```r
2^3  # potens
```

```
## [1] 8
```

```r
exp(2)  # eksponentiering
```

```
## [1] 7.389056
```

```r
log(2)  # logaritme (default er naturlig logaritme)
```

```
## [1] 0.6931472
```

```r
2 * (4 - 2)/(4 - 2)  # parentesregler fungerer som i vanlig algebra: den innerste parentesen regnes ut først
```

```
## [1] 2
```

```r
# kommentarere i R skrives forøvrig etter #
```


### Logiske tester

R kan evaluere logiske utsagn, og bedømme om de er `TRUE` eller `FALSE`:


```r
1 == 2  # tester om 1 er lik 2
```

```
## [1] FALSE
```

```r
2 == 2  # tester om 2 er lik 2
```

```
## [1] TRUE
```

```r
"Statsvitenskap" == "statsvitenskap"  # Logiske tester kan også brukes på tekst
```

```
## [1] FALSE
```

```r
"statsvitenskap" == "statsvitenskap"  # R er imidlertid sensitivt til store og små bokstaver.
```

```
## [1] TRUE
```

```r
1 <= 2  # tester om 1 er mindre enn eller lik 2
```

```
## [1] TRUE
```

```r
1 >= 2  # tester om 1 er større eller lik 2
```

```
## [1] FALSE
```

```r
1 != 2  # tester om 1 er ulik 2
```

```
## [1] TRUE
```

```r
1 == 2 | 1 == 1  # tester om en av de to påstandene 1 er lik 2 eller 1 er lik 1 er sanne
```

```
## [1] TRUE
```

```r
1 == 2 & 1 == 1  # tester om begge de to påstandene 1 er lik 2 og 1 er lik 1 er sanne.
```

```
## [1] FALSE
```


**Oversikt over logiske operatorer:**

| Operator      | Betydning     |
| ------------- |:-------------:|
| `==` | er lik |
| `<`  | mindre enn       |
| `>`  | større enn       |
| `<=` | mindre eller lik |
| `>=` | større eller lik |
| `!=` | ikke lik         |
| `!x` | ikke x           |
| `|`  | eller            |
| `&`  | og               |

Logiske operatorer er viktig å forstå i R. Dersom vi vil gjøre endringer i et datasett, bruker vi som regel en logisk test.


**Oppgave 1:** Skriv kode i scriptet ditt for å teste om `"R"` er forskjellig fra `"SPSS"` ved hjelp av logiske utsagn (to fremgangsmåter er mulig). Sjekk deretter om `3` er større eller lik den naturlige logaritmen av `20`.



```r
## Din løsning i script!
```

## Pakker:
R er open source og mange flinke utviklere bidrar til å gjøre R bedre. Disse utviklerne deler kode (i hovedsak funksjoner) gjennom pakker. For å kunne kode fra en pakke må vi kjøre følgende kodelinjer:

```r
install.packages("pakkenavn") # laster ned filene pakken består av fra nett til PC - må bare gjøres en gang
library(pakkenavn) # tilgjengeliggjør pakke i R sesjon, må gjøres hver gang du vil bruke kode fra pakken i en ny R sesjon.
```

Vi skal for det meste bruke kode som kommer fra pakker i [tidyverse](https://www.tidyverse.org/learn/). La oss installere disse pakkene:


```r
#install.packages("tidyverse") # Fjern hashtag på starten av denne og neste linje!
#install.packages("haven") # legg merke til at vi bruker "" i install.packages(), men ikke i library()
library(tidyverse)
```

```
## Warning: package 'tidyverse' was built under R version 3.5.3
```

```
## -- Attaching packages -------------------------------------------------------------------------------- tidyverse 1.2.1 --
```

```
## v ggplot2 3.1.0       v purrr   0.3.0  
## v tibble  2.0.1       v dplyr   0.8.0.1
## v tidyr   0.8.2       v stringr 1.4.0  
## v readr   1.3.1       v forcats 0.4.0
```

```
## Warning: package 'stringr' was built under R version 3.5.3
```

```
## Warning: package 'forcats' was built under R version 3.5.3
```

```
## -- Conflicts ----------------------------------------------------------------------------------- tidyverse_conflicts() --
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
library(haven)
```

## Objekter


**Oppgave 2:** Forklar kort til sidemannen/kvinnen hva et objekt er.









Objekter er grunnleggende byggesteiner i R. Vi lagrer informasjon av ulike typer som regresjonskoeffisienter, tekst og tall i objekter. Vi kan også lage objekter som representerer en enkelt verdi. Vi lager objekter ved hjelp av assignment operatoren `<-` :



```r
x <- 3  # lager objektet x
y <- 6  # lager objektet y
z <- x + y  # man kan lage objekter fra andre objekter

# Vi kan også gi andre navn til objekter:
gull <- 3
solv <- 1
bronse <- 1
medaljer <- gull + solv + bronse
```

Når vi lager objekter, returnerer ikke R en verdi i Console slik vi får når vi bruker R som en kalkulator. I stedet dukker objektet opp i vinduet `Global Environment`, hvor alle objekter vi har opprettet  vises. Vi kan imidlertid få vite verdien til et objekt ved å skrive navnet til objektet og trykke `ctrl/cmd + enter`:



```r
medaljer
```

```
## [1] 5
```


Vi kan også gi navn til objekter med `=`. Jeg oppfordrer dere imidlertid innstendig til å alltid bruke `<-` for å gi navn til objekter, **alle** følger denne konvensjonen.

En enda viktigere konvensjon er objektnavn. Feilskriving av objektnavn er en av de største kildene til frustrasjon og feil i R. Hold derfor navn korte, forståelige og enkle. Unngå gjerne store bokstaver, samt ikke-engelske bokstaver. Du kan lese flere gode råd [her](https://google.github.io/styleguide/Rguide.xml).


### Variabler

Det er mulig å opprette mange forskjellige objekttyper i R. Over opprettet vi objekter som representerte en enkelt tallverdi. Vi kan også lage objekter som inneholder flere verdier. Den enkleste objekttypen med flere verdier, er vektorer. I R kan en vektor defineres som en ordnet liste av verdier, dvs. at man lagrer verdier i en bestemt rekkefølge. I dette kurset kan du for det meste tenke på vektorer som variabler fra et datasett. Det finnes flere måter å lage vektorer på:



```r
## Ved å bruke parenteser rundt denne koden oppretter jeg objektet samtidig som jeg printer
## innholdet i objektet i console.
(x <- 1:3)  # med : teller vi på heltall mellom de to tallene
```

```
## [1] 1 2 3
```




```r
(y <- c(1:2, gull))  # med c() kan vi kombinere ulike tall/informasjon i den rekkefølgen vi vil. Vi kan også kombinere verdier fra objekter som 'gull'
```

```
## [1] 1 2 3
```

```r
x==y # Et eksempel på at det ofte er flere veier til samme resultat i R
```

```
## [1] TRUE TRUE TRUE
```

Legg også merke til at vi nå har overskrevet de tidligere verdiene til x og y, uten at R gir oss noen advarsel. Dette illustrerer viktigheten av å tenke gjennom objektnavn.

Vi kan også bruke `c()` til å lage vektorer med forskjellige typer innhold, som tekst.


```r
sunn_mat <- c("fisk", "potet", "gronnsak")
```
**Oppgave 3:** Bind sammen informasjonen i objektene x og sunn_mat til en vektor. Hint: du kan bruke `c()`

Jeg har skrevet et lite tillegg om variabler, vektorer og forskjellige objekttyper på slutten av dette dokumentet, som jeg anbefaler at du titter gjennom på egenhånd.


## Datasett
Dersom man har en rekke variabler (vektorer), kan man lage datasett. Datasett er også en objekt-type. I denne forelesningen fokuserer vi heretter på datasett.

Dere kan tenke på datasett som et sett av variabler/vektorer limt sammen i kolonner (for eksempel tidligere studiested og alder), der hver rad er en observasjon (for eksempel masterstudenter i statsvitenskap ved UiO). Vi kan lage vårt eget datasett av en samling vektorer på følgende måte:


```r
sunn_middag <- tibble(sunn_mat, x)
sunn_middag
```

```
## # A tibble: 3 x 2
##   sunn_mat     x
##   <chr>    <int>
## 1 fisk         1
## 2 potet        2
## 3 gronnsak     3
```

```r
test_data <- tibble(x = c(rep(1, 5), rep(0, 5)), y = seq(2, 20, 2), z = rnorm(10), w = "tekst",
    q = rep(c(1, 2), 5))
```

Kjør følgende kode for å laste inn deres første 'ordentlige' datasett i R:


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


Jeg har funnet dette datasettet hos [harvard dataverse](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/28165). Her finner man stort sett replikasjonsdata for empiriske statsvitenskapelige artikler. Dersom dere har lyst til å replisere en artikkel til hjemmeoppgaven, kan dere i tillegg til å lete i artikkelteksten/på siden til tidsskriftet sjekke harvard dataverse. Siden denne filen er av typen .dta, en stata-fil, brukte jeg `read_dta()` fra pakken `haven`, før jeg lastet opp data på github slik at dere kunne laste det ned med koden over. Funksjoner fra `haven`-pakken kan lese inn data fra de fleste andre statistikkprogrammer.


```r
library(haven)
aid <- read_dta("https://dataverse.harvard.edu/api/access/datafile/:persistentId?persistentId=doi:10.7910/DVN/28165/2OKZNY")
```


Her bruker vi funksjonen `read_dta()` for å laste inn en stata-fil fra en url (nettside). Funksjonen ville også fungert om vi erstattet urlen med en stien til filen dersom vi først lagret den på pcen. Det finnes andre funksjoner for å laste inn alle mulige typer filer, vi skal lære mer om dette i senere seminar.


## Funksjoner 1 - Hva er en funksjon?

Dersom vi ønsker å gjøre noe i r, får vi som regel en funksjon til å gjøre jobben for oss. En funksjon er en kodesnutt der vi spesiferer en input. Funksjonen utfører operasjoner basert på input, og produserer deretter et resultat (eller output). Det finnes funksjoner for å løse de fleste tenkelige og utenkelige problemer (en bursdag spilte en kamerat "Happy Birthday" for meg gjennom R......). Noen funksjoner er det lurt å kunne, fordi du får bruk for dem hele tiden, men det er altfor mange funksjoner til å lære seg alle. En av de viktigste ferdighetene i R, er derfor å lære seg hvordan man kan finne og anvende funksjoner for å løse utfordringer man står overfor.
Dette skal vi øve på i R-undervisningen.

Funksjoner har heldigvis stort sett alltid samme struktur:


```r
funksjonsnavn(argument1 = , argument2 = , ... argumentK =)

funksjonsnavn = NAVNET PÅ FUNKSJONEN
argument = "INSTILLINGER" TIL FUNKSJONEN.
# Disse linjene er ikke gyldig R-kode, men linjene viser den generelle syntaksen til funksjoner i R
```

Hjelpesiden til en funksjon finner man ved å kjøre `?funksjonsnavn`.
Der finner man argumentene til en funksjon, og standardinnstillingene for funksjonen.

**Merk:** Dersom man skriver argumenter i den rekkefølgen de står i hjelpefilen, trenger man ikke skrive inn argumentnavn. Dersom man ikke følger rekkefølgen i hjelpefilen, må man spesifisere argumentnavn.

Som regel er det første argumentet input, dvs. informasjonen som funksjonen skal bearbeide for å produsere output.
Dvs.: `funksjonsnavn(argument1 = input)`
Veldig ofte vil input til en funksjon være et objekt. Veldig ofte vil dette objektet være et datasett, eller variabler fra et datasett.

**Oppgave 4:** Snakk med naboen din - identifiser minst 2 funksjoner vi har brukt så langt. Åpne hjelpesiden for en av disse funksjonene. Hint: Let etter `funksjonsnavn()`

Her er noen nyttige funksjoner for å lære mer om datasett:


```r
class(aid)  # Er dette faktisk en data.frame, eller et annet type objekt? Les mer om class i siste del av dokumentet.
```

```
## [1] "spec_tbl_df" "tbl_df"      "tbl"         "data.frame"
```

```r
names(aid)  # denne funksjonen forteller deg navn du kan referere til i et objekt, mer om dette straks. For datasett er det variabelnavn
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
head(aid, 5)  # denne funksjonen viser deg de første observasjonene i datasettet.
```

```
## # A tibble: 5 x 52
##   country period periodstart periodend code  bdgdpg elrgdpg bdgdp elrgdp
##   <chr>    <dbl>       <dbl>     <dbl> <chr>  <dbl>   <dbl> <dbl>  <dbl>
## 1 AFG          1        1966      1969 AFG1      NA -0.0131    NA     NA
## 2 AFG          2        1970      1973 AFG2      NA -0.550     NA     NA
## 3 AFG          3        1974      1977 AFG3      NA  2.24      NA     NA
## 4 AFG          4        1978      1981 AFG4      NA -1.09      NA     NA
## 5 AFG          5        1982      1985 AFG5      NA  0.804     NA     NA
## # ... with 43 more variables: bdbb <dbl>, elrbb <dbl>, bdinfl <dbl>,
## #   elrinfl <dbl>, bdsacw <dbl>, elrsacw <dbl>, bdethnf <dbl>,
## #   elrethnf <dbl>, bdassas <dbl>, elrassas <dbl>, bdicrge <dbl>,
## #   elricrge <dbl>, bdm21 <dbl>, elrm21 <dbl>, bdssa <dbl>, elrssa <dbl>,
## #   bddn1900 <dbl>, elrdn1900 <dbl>, bdaid <dbl>, elraid <dbl>,
## #   bdlpop <dbl>, elrlpop <dbl>, bdeasia <dbl>, elreasia <dbl>,
## #   bdegypt <dbl>, elregypt <dbl>, bdcentam <dbl>, elrcentam <dbl>,
## #   bdfrz <dbl>, elrfrz <dbl>, bdarms1 <dbl>, elrarms1 <dbl>,
## #   originalcountries <dbl>, bddatap <dbl>, bddatao <dbl>,
## #   elrdatabdcos7093bdvarsp <dbl>, elrdatabdcos7093bdvarso <dbl>,
## #   elrdatabdcos7097bdvarsp <dbl>, elrdatabdcos7097bdvarso <dbl>,
## #   elrdata7093bdvarsp <dbl>, elrdata7093bdvarso <dbl>,
## #   elrdata7097bdvarsp <dbl>, elrdata7097bdvarso <dbl>
```

```r
str(aid) # Denne funksjonen viser deg strukturen til et objekt - du får masse nyttig informasjon om innhold.
```

```
## Classes 'spec_tbl_df', 'tbl_df', 'tbl' and 'data.frame':	1360 obs. of  52 variables:
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
##  - attr(*, "spec")=
##   .. cols(
##   ..   country = col_character(),
##   ..   period = col_double(),
##   ..   periodstart = col_double(),
##   ..   periodend = col_double(),
##   ..   code = col_character(),
##   ..   bdgdpg = col_double(),
##   ..   elrgdpg = col_double(),
##   ..   bdgdp = col_double(),
##   ..   elrgdp = col_double(),
##   ..   bdbb = col_double(),
##   ..   elrbb = col_double(),
##   ..   bdinfl = col_double(),
##   ..   elrinfl = col_double(),
##   ..   bdsacw = col_double(),
##   ..   elrsacw = col_double(),
##   ..   bdethnf = col_double(),
##   ..   elrethnf = col_double(),
##   ..   bdassas = col_double(),
##   ..   elrassas = col_double(),
##   ..   bdicrge = col_double(),
##   ..   elricrge = col_double(),
##   ..   bdm21 = col_double(),
##   ..   elrm21 = col_double(),
##   ..   bdssa = col_double(),
##   ..   elrssa = col_double(),
##   ..   bddn1900 = col_double(),
##   ..   elrdn1900 = col_double(),
##   ..   bdaid = col_double(),
##   ..   elraid = col_double(),
##   ..   bdlpop = col_double(),
##   ..   elrlpop = col_double(),
##   ..   bdeasia = col_double(),
##   ..   elreasia = col_double(),
##   ..   bdegypt = col_double(),
##   ..   elregypt = col_double(),
##   ..   bdcentam = col_double(),
##   ..   elrcentam = col_double(),
##   ..   bdfrz = col_double(),
##   ..   elrfrz = col_double(),
##   ..   bdarms1 = col_double(),
##   ..   elrarms1 = col_double(),
##   ..   originalcountries = col_double(),
##   ..   bddatap = col_double(),
##   ..   bddatao = col_double(),
##   ..   elrdatabdcos7093bdvarsp = col_double(),
##   ..   elrdatabdcos7093bdvarso = col_double(),
##   ..   elrdatabdcos7097bdvarsp = col_double(),
##   ..   elrdatabdcos7097bdvarso = col_double(),
##   ..   elrdata7093bdvarsp = col_double(),
##   ..   elrdata7093bdvarso = col_double(),
##   ..   elrdata7097bdvarsp = col_double(),
##   ..   elrdata7097bdvarso = col_double()
##   .. )
```


Dere kan også åpne datasettet ved å trykke på `View` i toppmenyen, skriv evt. `View(my_data)`, men ikke lagre denne kommandoen i scriptet ditt som en hovedregel - det er bare irriterende.




### Indeksering
Indeksering lar oss spesifisere et eller flere elementer i et objekt. Dette er essensielt når vi ønsker å gjennomføre statistiske analyser med R - vi ønsker som regel å anvende statistiske funksjoner på et utvalg av variablene - da må vi fortelle R hvilke variabler funksjonen skal jobbe med.

For å indeksere et objekt kan man skrive:

1. `objektnavn$x`
2. `objektnavn[x]`
3. `objektnavn[[x]]`

der `x` spesifiserer hvilke del av et objekt vi er interessert i. Disse metodene fungerer generelt, men virker litt forskjellig (forskjellene avhenger delvis av objekttype). I tillegg finnes det en rekke funksjoner som kan være til hjelp ved noen typer indeksering, jeg kommer til å bruke funksjoner fra pakken `dplyr`. Dersom du får problemer med indeksering finner du mer informasjon om indekseringsmetodene [her](https://cran.r-project.org/doc/manuals/r-release/R-lang.html#Indexing). Lister kan for eksempel være litt utfordrende å jobbe med, men [her](http://r4ds.had.co.nz/lists.html) er en god forklaring av hvordan det fungerer. Generelt kan vi bruke funksjonen `str()` til å lære om hvordan et objekt er strukturert, og hvordan det kan indekseres.

Vi skal i hovedsak indeksere variabler og datasett. Under får dere noen regler for hvordan dere kan indeksere datasett:


```r
# Det finnes mange måter å indeksere datasett på! For datasett skal vi skal holde oss til:

aid$country # Velg en variabel fra et datasett med $
aid$country[1:5] # Velg observasjon 1:5 på variabelen country

select(.data = aid, country, period, periodstart, periodend) # Velg flere variabler samtidig
select(.data = aid, 1:4) # Velg flere variabler samtidig basert på posisjon

filter(.data = aid, country == "AFG") # Velg observasjonser basert på verdi på en eller flere variabler spesifisert gjennom en logisk test
slice(aid, 1:5) # Velg rader basert på posisjon i datasettet

aid %>% # datasettargument, R forstår at vi på de neste linjene referer til observasjoner og variabler fra "aid"
  select(country, periodstart, periodend, elraid, elrgdpg) %>% # binder sammen funksjoner fra dplyr med %>%
  filter(country == "KEN") # Dermed kan vi velge på både variabler og verdiene til observasjoner samtidig
```

Funksjonene `select()`, `filter()` og `slice()` kommer fra pakken `dplyr`. Denne pakken er en del av tidyverse, og ble derfor lastet inn med `library(tidyverse)`. Det fungerer også med `library(dplyr)`.



**Oppgave 5:** Hvordan kan vi velge observasjoner som har positiv verdi både på variabelen elrgdpg (vekst i BNP) og variabelen elraid (økonomisk bistand)? Hint: logisk test + filter(). Dersom du synes dette var greit, kan du kombinere denne filtreringen med å velge de fem første variablene i datasettet.



## Funksjoner 2 - deskriptiv statistikk og grafikk

Nå er vi klare til å kombinere vår forståelse av indeksering og funksjoner for å utforske datasettet `aid` med deskriptiv statistikk.
Under viser jeg noen enkle funksjoner som kan brukes til å lære mer om hvordan variabler er fordelt:


```r
median(aid$elrgdpg) # median
sd(aid$elrgdpg) # standardavvik
quantile(aid$elrgdpg, na.rm = TRUE) # kvantiler, na.rm = TRUE betyr at observasjoner med missing-verdier på variabelen kastes ut.
summary(aid$elrgdpg) # diverse deskriptiv statistikk
summary(aid) # Kan også brukes på hele datasettet
table(aid$country) # fint for å se på tabeller som ikke er numeriske.
prop.table(table(aid$country)) # Prosentfordeling med prop.table()
table(aid$country, aid$period) # kan ta flere variabler - legg til enda flere ved hjelp av et ekstra komma og indeksering med $
```

Dersom du trenger en funksjon for å gjennomføre en statistisk operasjon eller noe annet, prøv google eller søk med `??mulig_funkskjonsnavn` i R.

**Oppgave 6:** Finn funksjonene for gjennomsnitt, minimumsverdi og maksimumsverid. Åpne hjelpesiden for en av funksjonene, og anvend den på `aid$elrgdpg`.

Dere finner flere funksjoner for univariat deskriptiv statistikk i pakken `moments`, f.eks. kurtose - `kurtosis()` og skjevhet `skewness()`. Syntaks er som for `median()`




### Plot-funksjoner

Vi skal stort sett bruke funksjonen `ggplot()` fra pakken `ggplot2` til å lage plot. I tillegg til denne funksjonen kommer jeg noen ganger til å bruke funksjonen `plot()` fra base-R til å lage raske spredningsplot for to variabler. Du kan gjøre stort sett alle de samme tingene med `plot()` og `ggplot()`. Jeg synes imidlertid det er lettere å bruke `ggplot()`, syntaksen ligner på databehandling med `dplyr()`, men i stedet for å bruke `%>%` bruker vi `+` for å binde sammen funksjoner. Videre er `ggplot2` pakken også en del av `tidyverse` så du har allerede lastet den inn.

Plot er en ypperlig måte å forstå data og for å skaffe seg en visuell forståelse av hvordan statistiske metoder fungerer. Bruk plot hyppig.



```r
# install.packages('ggplot2') # Kjør dersom ggplot2 ikke er installert
library(ggplot2)
```

Histogram:



```r
ggplot(aid, aes(elrgdpg)) + geom_histogram(bins = 50)
```

```
## Warning: Removed 369 rows containing non-finite values (stat_bin).
```

![](Introduksjonsforelesning_files/figure-html/unnamed-chunk-20-1.png)<!-- -->

Kontinuerlig fordeling:


```r
ggplot(aid, aes(elrgdpg)) + geom_density()
```

```
## Warning: Removed 369 rows containing non-finite values (stat_density).
```

![](Introduksjonsforelesning_files/figure-html/unnamed-chunk-21-1.png)<!-- -->


Scatterplot:



```r
ggplot(aid) + geom_point(aes(x = period, y = elrgdpg, col = elraid)) # Viser økonomisk utvikling over tid, punktene fargelegges basert på økonomisk bistand landene fikk i perioden
```

```
## Warning: Removed 369 rows containing missing values (geom_point).
```

![](Introduksjonsforelesning_files/figure-html/unnamed-chunk-22-1.png)<!-- -->

Scatterplot med regresjonslinje


```r
ggplot(aid) + geom_point(aes(x = period, y = elrgdpg, col = elraid)) + geom_smooth(aes(x = period, y = elrgdpg), method = "lm") # method = "lm" angir lineær regresjon (OLS)
```

```
## Warning: Removed 369 rows containing non-finite values (stat_smooth).
```

```
## Warning: Removed 369 rows containing missing values (geom_point).
```

![](Introduksjonsforelesning_files/figure-html/unnamed-chunk-23-1.png)<!-- -->

Scatterplot for hvert år separat:



```r
ggplot(aid) + geom_point(aes(x = period, y = elrgdpg, col = elraid)) + facet_wrap(~elrssa) # separate paneler land i Afrika Sør for Sahara, og land i andre regioner
```

```
## Warning: Removed 369 rows containing missing values (geom_point).
```

![](Introduksjonsforelesning_files/figure-html/unnamed-chunk-24-1.png)<!-- -->



## Funksjoner 3 - skriv din egen funksjon!

Funksjoner er helt sentralt i R. De over 10 000 pakkene som finnes til R på CRAN inneholder som regel funksjoner. Derfor kan et google-søk ofte finne en funksjon som passer til akkurat ditt formål. Ofte er det imidlertid minst like effektivt å skrive sin egen funksjon. Dersom du skal gjenta en operasjon mange ganger, kan en funksjon ofte være mer effektivt enn copy-paste (særlig med litt trening). En god tommelfingerregel for en erfaren R-bruker er at det vil lønne seg å skrive en funksjon hvis du må copy-paste mer enn 3 ganger. For en nybegynner vil det være betraktelig høyere terskel før det lønner seg å skrive en funksjon, men man må starte å øve for å bli flink til å skrive funksjoner. Dersom du forsøker å skrive funksjoner en gang i blant, vil du også øke din egen R-forståelse. Dersom du jobber deg gjennom del 3 av **R for Data Science** vil du få mer trening i å skrive funksjoner. Du trenger ikke å lære deg dette for å lykkes med hjemmeoppgaven, hensikten med denne delen er å gi deg en smaksprøve på neste nivå i R.


La oss forsøke å sentrere en variabel:


```r
aid$elrgdpg - mean(aid$elrgdpg, na.rm = T)  # kan vi skrive en funksjon for sentreringen vi gjør her?
```

Svaret er ja:


```r
center <- function(min_data_var) {
    # denne linjen definerer input i funksjonen, den skal alltid ha samme form

    centered <- min_data_var - mean(min_data_var, na.rm = T)  # denne linjen/innmat angir hva som skal gjøres med input

    return(centered)  # denne linjen angir hvilken output vi vil har, det er andre funksjoner som kan stå på denne linjen i stedet
}

center(aid$elrgdpg) == (aid$elrgdpg - mean(aid$elrgdpg, na.rm = T))  # vi har nå generalisert den første linjen
```




```r
# arg 1: velger et par numeriske variabler fra datasett, siden center ikke virker på factor
# arg 2: angir om operasjonen skal utføres på rader (1) eller kolonner (2), arg 3: angir
# funksjonen som skal anvendes
```


**Bonus-oppgave 1: (vanskelig!)**

Lag en funksjon som først snur skalaretningen til en numerisk variabel. Test først på variabelen `elraid` i datasettet `aid`. Deretter anvender du funksjonen på alle numeriske variabler i `aid` ved hjelp av `apply()` funksjonen. Hint: skriv først funksjonen og test den. Lag deretter ett nytt datasett som bare inneholder tall-variabler med `select`. Se deretter på hjelpefilen til `apply()` - du skal spesifisere tre argumenter, og et av argumentene skal ha verdien `2`.

## Et lite tillegg om variabler/vektorer og klasser

La oss opprette x, y og z på nytt:


```r
x <- 1:5  
y <- c(1,2,3,4,5)
z <- c(1,2,"tre","fire",5)
```


Vi kan utføre matematiske operasjoner på vektorer som bare består av tall. Dette er nyttig for omkoding/opprettelse av variabler. Her er noen eksempler:


```r
x * y
aid$elraid*aid$elrgdpg

x + y
aid$elraid + aid$elrgdpg

x * 2
aid$elraid*2
```

Dette fungerer naturlig nok ikke på vektorer som inneholder andre typer verdier enn tall. Forsøk selv for å kontrollere. En vektor som bare består av en type verdier (f.eks, bare tall), kalles **atomic vector**. En vektor som består av forskjellige typer verdier (f.eks. både tall og tekst) kalles **list**.

**Bonus-oppgave 2:** Lag en vektor `w`, bestående av heltall fra 6 til 2 i synkende rekkefølge. Bruk deretter matematiske operasjoner på variabelen for å få den til å bli lik variabelen `a`, gitt ved `a <- 1:5`. Test om du har fått det til ved å printe verdiene til variablene, samt en logisk test. Hint: `*` og `+`



### Ulike typer vektorer i R - grov inndeling:

------------------------------------------------------------

atomic vector | List
------------- | -------------
numeric       | Blanding
integer       |
character     |
factor        |
logical       |


En hyppig årsak til at en funksjon ikke fungerer, er at en vektor/variable ikke er i det formatet vi forventet. Dette fører ofte til uønskede resultater. Tabellen over gir en oversikt over variabeltypene vi skal jobbe med. Atomic vector har kun verdier av en type, mens lister kan ha flere typer verdier, samt bestå av flere variabler.

Hvilket format tror du x, y og z har? Vi kan sjekke med funksjonen `class()`.


```r
class(x)
```

```
## [1] "integer"
```

```r
class(y)
```

```
## [1] "numeric"
```

```r
class(z)
```

```
## [1] "character"
```

```r
class(list(1:5))
```

```
## [1] "list"
```

```r
class(aid)
```

```
## [1] "spec_tbl_df" "tbl_df"      "tbl"         "data.frame"
```

```r
class(aid$elraid)
```

```
## [1] "numeric"
```

Som dere ser, er x integer og y numerisk, mens z er character. Den siste vektoren jeg lager i koden over er helt lik x og y, men er en liste. Dette betyr ikke at det jeg sa i sted om  vektorer av typene *list* og *atomic.vector*  er galt. Dette  betyr at at alle verdiene i x er lest inn som en *integer*, alle verdiene i y er lest inn som *numeric*, alle verdiene i z er lest inn som *character*, mens den siste vektoren er lest inn som en liste. Dette kan være veldig forvirende, men som regel er dette lett å løse, med funksjoner som `as.character()`, `as.numeric()` og `as.factor()` (for de fleste praktiske
formål trenger vi ikke skille mellom *integer* og *numeric*). Med `unlist()` kan vi gjøre listen over om til en *atomic.vector*.



```r
class(as.character(x))
```

```
## [1] "character"
```

```r
class(as.list(y))
```

```
## [1] "list"
```

```r
class(as.numeric(z))
```

```
## Warning: NAs introduced by coercion
```

```
## [1] "numeric"
```

```r
as.numeric(z)
```

```
## Warning: NAs introduced by coercion
```

```
## [1]  1  2 NA NA  5
```

```r
class(unlist(list(1:5)))
```

```
## [1] "integer"
```


**Bonus-Oppgave 3:**

Opprett vektoren karaktersnitt, bestående av verdiene `6`, `5` og `4`. Transformer deretter variabelen til `factor` med `as.factor()`. Sjekk at transformasjonen virket med `class()`. Hva skjer dersom du forsøker å transformere variabelen direkte tilbake til tallverdier med `as.numeric()` (inspiser verdiene)? Se om du klarer å løse eventuelle problemer ved ytterligere transformasjoner av klasse. Hint: `as.character()`




```r
karaktersnitt <- as.factor(c(6, 5, 4))
karaktersnitt
```

```
## [1] 6 5 4
## Levels: 4 5 6
```

```r
as.numeric(karaktersnitt)
```

```
## [1] 3 2 1
```


Det er mer å si om forskjellige typer vektorer og objekter enn jeg kommer inn på her, dette burde imidlertid være nok til å hjelpe dere med å komme i gang med å løse problemer som skyldes at et objekt er av en annen type enn du forventet. Dersom koden din oppfører seg merkelig er det alltid en god idé og sjekke hva slags type objekt du har nærmere. Funksjoner som `class()`, `str()` og `dim()` er nyttig til dette. Les også advarsler i Console som handler om objektene dine.
