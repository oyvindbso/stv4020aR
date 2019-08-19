---
title: "Første R-Seminar"
author: "Erlend Langørgen"
date: "15 august 2019"
output:
  html_document:
    keep_md: TRUE
    self_contained: no

---




# Velkommen!

![](../pics/welcome.jpg)<!-- -->


# Seminaropplegg

De fleste seminarene vil bestå av to deler:

1. En introduksjon fra seminarleder til dagens emner
2. Oppgaver som trener deg i å jobbe med dagens emner - trening på anvendelse er nødvendig for å skaffe seg tilstrekkelig god forståelse. Vi har gjort vårt beste for å lage oppgaver som trener deg i ferdigheter som du ikke visste at du trengte, men som du vil få bruk for i hjemmeoppgaven.

Løsningsforslag til oppgavene vil bli lagt ut etter seminarene. Alt seminaropplegg vil bli lenket til under moduler på Canvas - vi forbeholder oss retten til å gjøre endringer i undervisningsmateriale helt frem til seminaret.

Dersom du skal skrive hjemmeoppgave med R, anbefaler vi at du forbereder deg til seminaret ved å se gjennom relevante kapitler fra **R for Data Science** eller tilsvarende ressurs. Det er også en svært stor fordel å være ajour med statistikkpensum før seminarene - dess færre nye momenter du blir introdusert til, dess lettere er det å tilegne seg nye kunnnskaper. Det er kjedelig å falle av i R-seminarene pga. at du ikke aner hva regresjonsanalyse er. Når det er sagt, har vi full forståelse for at dere har et travelt semester - gjør deres beste!

Vi rekker ikke gå gjennom alt som kan være relevant av R-ferdigheter til hjemmeoppgaven, derfor har vi laget [studieguiden](https://github.com/langoergen/stv4020aR/blob/master/docs/Studieguide_R.md) til **R for Data Science**, samt noe ekstra undervisningsmateriale som viser hvordan du gjennomfører faktoranalyse og flernivåanalyse i hjemmeoppgaven. Dersom dere tror at det kan være aktuelt å bruke noen av disse analysemetodene til hjemmeoppgaven - ta en titt på dette undervisningsmaterialet før siste seminar. Da vil du få anledning til å spørre seminarleder om ting du lurer på.


## Om å lære R:

Øvelse gjør mester, jeg håper derfor at alle vil gjøre sitt beste med tiden dere har til rådighet i seminarene. Vi vil også anbefale dere å komme i gang med hjemmeoppgaven før de to siste R-seminarene. Dette vil gjøre det lettere for dere å lære R på en mer målrettet måte og øke utbytte fra seminarene. Dere vil også få betydelig bedre hjelp i skisseseminarene dersom dere allerede har valgt datasett og kjørt noen analyser (det er bedre å finne noen data og bruke dem i skissen enn å ikke bruke noen, selv om du bytter data senere).

Still masse spørsmål, særlig i starten dersom alt er nytt og fremmed(gjørende) - det er slik du lærer. Bruk medstudenter aktivt, samarbeid og hjelp hverandre.

Mot slutten av semesteret vil dere oppleve at dess mer du kan, dess bedre blir spørsmålene dine og hjelpen du får fra oss som underviser. Dersom du kan nok til å forstå problemet ditt, og til å vite at løsningen ikke finnes rett foran nesen din i et seminardokument eller **R for Data Science** vil du få gode svar. Dersom du spør om ting som ble gjennomgått i første seminar, vil du selvfølgelig få hjelp, men det kan hende at en del av hjelpen er at du blir bedt om å kikke på dokumentet til første seminar en gang til.

Jeg vil at dere skal skrive mest mulig selvstendig kode i seminarene. Dette er den beste måten å trene dere til å løse hjemmeoppgaven, og den beste måten å sørge for at det ikke blir ubehagelige overraskelser på prøven. Det gir også meg muligheten til å gå rundt å gi individuell oppfølging til dere. For at dette skal fungere effektivt, må dere gjøre noe forberedelser. Derfor foreslår jeg at alle i det minste bruker en halvtime/et kvarter på å se på relevante kapitler i R for Data Science før seminaret, samt gjør sitt beste for å holde seg oppdatert på statistikkpensum.

Undervisningsmateriell blir lenket til på Canvas. Selve opplegget blir lastet opp på [github](https://github.com/langoergen/stv4020aR). For øyeblikket ligger fjorårets opplegg ute, jeg kommer til å oppdatere alle seminaren i løpet av semester, da jeg har endret seminarstrukturen en god del.


## Læringsressurser og nyttige R-lenker

- [Gratis innføringsbok på nett - R for Data Science](http://r4ds.had.co.nz/)
- **Hjelpefilene i R:** Det krever litt trening å lære seg å forstå hjelpefiler, men det er en av de beste investeringene du kan gjøre - finn all informasjonen du trenger ved hjelp av `?` og `??` i R
- [Quick-R - et bra sted å søke etter ting, lett å forstå for nybegynnere](https://www.statmethods.net/)
- [Interaktiv R-intro fra datacamp](https://www.datacamp.com/courses/free-introduction-to-r)
- [Interaktiv tidyverse-intro fra datacamp](https://www.datacamp.com/courses/introduction-to-the-tidyverse)
- [Stackoverflow - har svar på det R-problemet du sliter med](https://stackoverflow.com/questions/tagged/r)
- [R-bloggers - har gode, kortfattede tutorials](https://www.r-bloggers.com/)
- [Guide til ggplot2](http://docs.ggplot2.org/current/)
- [Facebookgruppe for R for statsvitere på UiO - bruk!](https://www.facebook.com/groups/427792970608618/)
- [Stilguide for R](https://google.github.io/styleguide/Rguide.xml)
- [Bruke prosjekter i R](https://support.rstudio.com/hc/en-us/articles/200526207-Using-Projects)

Du kan også finne videoer, flere gratis bøker m.m. hvis du googler/søker på stackoverflow/søker på youtube. Noe av det aller vikti Det viktigste er nok imidlertid å lære seg å lese og forstå hjelpefiler i R og stackoverflow. For å bli god i R er det lurt å huske noen grunnbegreper (dvs. en god del av det som du lærer i seminarene og **R for Data Science**), men ut over det bruker man hjelpefiler i R/stackoverflow som ordbøker hele tiden.


## Dagens seminar: En første dataanalyse med R.

I dagens seminar skal vi øve på å forberede og utforske data. Dette er som regel første del av enhver dataanalyse - også hjemmeoppgaven.
Vi skal også øve på å forstå hjelpefiler til funksjoner.


1. [Kort om funksjoner og hjelpefiler](#funksjoner)
2. [Forberede og Manipulere data](#manipulere)
3. [Utforsking av data og deskriptiv statistikk.](#deskriptiv)
4. [Plotte-funksjonen `ggplot`.](#ggplot)


Som i introduksjonsforelesningen, kommer det til å være noe kode dere kjører der vi ikke forklarer alt som skjer - vi kommer til å dekke mesteparten av dette i neste seminar, men det er også fint å prøve å forstå dette på egenhånd ved hjelp av hjelpfiler og **R for Data Science**

Dere vil få oppgaver som trener dere i disse ferdighetene, samt i grunnleggende forståelse av R som språk. Dersom dere sliter med å forstå indeksering, funksjoner, objekter e.l., kan dere kikke på introduksjonsforelesningen, eller lese i **R for Data Science**, boken til Silje (**Lær deg R**) eller en tilsvarende ressurs. Vi kommer til å fortsette med å trene litt på basisferdigheter også i neste seminar.


## Kort om  funksjoner og hjelpefiler <a name="funksjoner"></a>

En grunnleggende byggestein i R er funksjoner. En funksjon tar i mot verdi(er), gjerne lagret i form av et R-objekt, utfører operasjoner basert på input, og produserer nye verdier. En typisk R-funksjon har følgende *syntaks*:


```r
aFunction(x = "R-objekt", arg = "alternativ for funksjonens oppførsel")d
## Merk: dette er ikke en faktisk funksjon i R. Funksjoner kan også ha andre syntakser.
```
Funksjoner som `c()`, `log()`, `summary()`, `str()` og `read_csv()` er eksempler på funksjoner.
Dersom vi vil lære mer om en funksjon, kan vi spørre R om hjelp med `?`. Kjør `?c()` og `?log()`

Dersom vi er på jakt etter en funksjon til et spesielt formål, kan vi bruke `??` (eller google).
Si at vi har lyst til å lage en sekvens av tall, som med `:` (som teller på heltall), men bare inkludere partall. La oss se om vi kan finne en funksjon til å gjøre dette med følgende kode: `??sequence`

Søket med `??` tyder på at funksjonen `seq()` kan gjøre jobben.
La oss åpne hjelpefilen til `seq()` ved hjelp av `?seq()`

**Oppgave:** Bruk to minutter på å lese hjelpefilen, og skriv ned hva du tror de to linjene med kode kommer til å gjøre:


```r
seq(from = 2, to = 20, by =2)
```

```
##  [1]  2  4  6  8 10 12 14 16 18 20
```

```r
seq(from = 20, to = 2, by = -2)
```

```
##  [1] 20 18 16 14 12 10  8  6  4  2
```
Dersom en funksjon produserer output av en type som fungerer som input i en annen funksjon, kan vi plassere funksjoner inne i andre funksjoner:

```r
c(seq(20 ,2 , -2), rep(1, 2), seq(2, 20, 2))
```

```
##  [1] 20 18 16 14 12 10  8  6  4  2  1  1  2  4  6  8 10 12 14 16 18 20
```
Som dere ser trenger vi ikke skrive argumentene, kjør `?rep` for å finne ut hva funksjonen i midten gjør. Fortsett å bruke `?` til å lære om nye funksjoner som introduseres resten av seminaret. Øv på å lese syntaks fra hjelpefilene, sammen med googling vil evnen til å lese syntaks sette dere i stand til å finne løsninger på alle slags problemer, med litt trening går dette stort sett ganske raskt.

Mange funksjoner er i eksterne pakker (det finnes over 10 000!) som må lastes ned fra nettet med `install.packages("pakkenavn")` og gjøres tilgjengelig i R-sesjonen din før du kan bruke dem med `library(pakkenavn)`. Dersom du Lukker og åpner Rstudio på nytt trenger du altså ikke å kjøre `install.packages("pakkenavn")` på nytt, men du må kjøre `library(pakkenavn)` for å få tilgang på funksjoner fra pakkene i tidyverse.

I dagens seminar skal dere innom `tidyverse`- pakkene `ggplot2`, `haven`, og `dplyr`, samt pakken `moments`.
Under viser jeg koden for å installere `moments`. Skriv koden for å installere og laste inn de andre pakkene selv i scriptet ditt!

```r
#install.packages("moments") # dersom pakken allerede er installert trenger du ikke kjøre denne, klikk på packages i viduet nede til høyre for å sjekke, eller se om neste linje med kode kjører uten problemer.
library(moments)
```

### Laste inn data - read_funksjoner()

Vi skal starte med å laste inn data som et objekt i R. Funksjoner for å laste inn ulike datatyper har stort sett ganske lik syntaks (det kan være små variasjoner og ulike tilleggalternativ - dette finner du raskt ut av i hjelpefilen!)


```r
library(tidyverse) # read_funksjoner fra readr i tidyvsere
datasett <- read_filtype("filnavn.filtype")
read_csv("filnavn.csv") # for .csv, sjekk også read.table
load("")

aid <-  read_csv("https://raw.githubusercontent.com/langoergen/stv4020aR/master/data/aid.csv")

library(haven)
# Fra haven-pakken - dette skal vi se på i senere seminar
read_spss("filnavn.sav")  # for .sav-filer fra spss
read_dta("filnavn.dta") # for .dta-filer fra stata
```

Vi skal bruke samme kode for å laste inn datasettet `aid` som på introduksjonsforelesningen. Ta en kjapp titt på hjelpefilen, hva heter argumentet vi har spesifisert?


```r
# install.packages(tidyverse)
library(tidyverse)
```

```
## Warning: package 'tidyverse' was built under R version 3.5.3
```

```
## -- Attaching packages -------------------------------------------------------- tidyverse 1.2.1 --
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
## -- Conflicts ----------------------------------------------------------- tidyverse_conflicts() --
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
aid <-  read_csv("https://raw.githubusercontent.com/langoergen/stv4020aR/master/data/aid.csv")
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

**Legg merke til:** eksterne filer, som uinstallerte pakker og datasett som ikke er lastet inn som objekter, må alltid skrives i `" "` når vi refererer til dem. Informasjon som er lagret internt, som nedlastede pakker og opprettede objekter, refererer vi ikke til med `" "`

Vi kommer til å snakke mer om import og kombinering av ulike typer data i senere seminarer.

# Forberede og manipulere data <a name="manipulere"></a>

Vi lærer R for å kunne gjøre statistiske analyser. Noen ganger er man så heldig å få et analyserklart datasett som har alle variablene man ønsker, men dette hører trolig til sjeldenhetene. Veldig ofte må man jobbe litt med å forberede og manipulere data, f.eks. ved å omkode variabler, eller hente inn variabler fra andre datakilder. Forberedelse av data er ikke rutinearbeid - det innbefatter svært ofte viktige metodologiske beslutninger, som f.eks. hvordan du ønsker å operasjonalisere når en konflikt ble avsluttet. Forsøk derfor alltid å tenke på metodologiske implikasjoner når du forbereder data. Dersom du lager en klar slagplan for hvordan du ønsker at dataene dine skal se ut på forhånd, blir det lettere å forberede data. Datamanipulasjon og dataforberedelser handler derfor om å stille seg selv følgende spørsmål:

1. Hva slags data ønsker jeg?
2. Hva slags data har jeg?
3. Hva må jeg gjøre for å omarbeide de dataene jeg har til dataene jeg ønsker meg?

Når du har svart på disse spørsmålene, har du laget en plan med et sett av oppgaver, datamanipuleringer du vet at du må gjøre - disse skal vi lære å løse i R. Dersom du ikke har en slik plan, blir datamanipulering vanskeligere. Tenk gjennom disse spørsmålene (særlig spm. 1 og 2) allerede før du åpner R, med utgangspunkt i teori, og det du vet om dataene dine fra kodebok eller artikklene du repliserer. Vi skal imidlertid lære hvordan R også kan være til stor hjelp for å lage arbeidsplanen din - også for å svare på spm. 1 og 2. Dersom du blir flink på koder for å manipulere data, blir denne planleggingsprosessen både lettere og mer kreativ fordi du ser flere muligheter.


I dagens seminar, skal vi jobbe med utgangspunkt i følgende hypotese:  bistand fører til økonomisk vekst, men bare dersom de fører en god makroøkonomisk politikk. Datasettet `aid` som vi brukte i introduksjonsforelesningen, og som vi lastet inn i sted, ble brukt i en forskningsartikkel - *Aid, policies and growth* (**Burnside og Dollar, 2000**) - for å teste denne hypotesen. Disse dataene har observasjoner av en rekke land over flere tidsperioder. Dersom dere hadde lest denne artikkelen og kodeboken på nett - slik vi har gjort for dere - ville dere også visst at vi har data som blant annet inneholder:

* Økonomisk vekst i prosent av BNP - variabelen `elrgdpg`
* Økonomisk bistand som prosentandel av landets BNP - variabelen `elraid`
* Tre variabler som ble brukt til å opprette en indeks for makroøkonomisk politikk - `elrsacw` (øk. åpenhet), `elrbb` (budsjettbalanse) og `elrinfl` (inflasjon).
* En rekke potensielle kontrollvariabler

Dersom vi har lyst til å kjøre den samme testen av hypotesen som det **Burnside og Dollar** gjorde - dette bør man alltid gjøre som første del av en replikasjon - er vi nødt til å opprette en indeks-variabel, som kombinerer de tre variablene som omhandler makroøkonomisk politikk. Dermed inneholder i hvert fall planen vår denne arbeidsoppgaven.



### Sjekke strukturen til data

Nå som vi har laget en tentativ plan for hva som må gjøre, og lastet inn et datasett, er det tid for å skaffe seg en enda bedre forståelse av hva slags data vi har ved hjelp av R. Husk at du i tillegg til å bruke R, **alltid** bør se på kodeboken/beskrivelsen av data i artikkelen du repliserer i denne fasen av analysen din. R og kodebok komplementerer hverandre.

For å skaffe deg en forståelse av datasettet ditt i R, vil du som regel stille spørsmål av følgende type:

1. Hva er observasjonene i datasettet? Ønsker jeg å omarbeide informasjonen slik at jeg får andre typer enheter?
2. Hva heter variablene mine?
3. Hva slags klasse har variablene mine? Hva slags informasjon inneholder variablene mine?
4. Er det mange observasjoner som har manglende informasjon på noen av variablene jeg er interessert i?

Spørsmål 1-3. bør du kunne svare på delvis ut fra kodeboken. Spørsmål 4. kan ofte bare besvares ved hjelp av et statistikkprogram som R. Uansett er det nyttig å bruke følgende koder i R for å svare på disse spørsmålene. Under viser jeg hvordan:

1. Hva er enhetene i datasettet? Ønsker jeg å omarbeide informasjonen slik at jeg får andre enheter?

**Klikk** på datasettet i Environment - da åpnes det i et nytt vindu. Legg merke til at koden `View(aid)` blir evaluert i Console. Les informasjonen langs en rad, og forsøk å tenke gjennom hvilke sentrale karakteristikker som skiller en enhet fra en annen - Nordmenn kan f.eks. skilles med utgangspunkt i fødselsnummer, eller med utgangspunkt i navn. Du kan også kjøre følgende koder:



2. Hva heter variablene mine?

```r
names(aid)
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
3. Hva slags klasse har variablene mine? Hva slags informasjon inneholder variablene mine?

Disse funksjonene er fine for å få en rask oversikt over data


```r
str(aid) # gir deg klasse for alle variabler samt noe informasjon om verdier
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

```r
class(aid) # klasse aid datasettet
```

```
## [1] "spec_tbl_df" "tbl_df"      "tbl"         "data.frame"
```

```r
class(aid$elrgdpg) # gir deg klasse for en variabel
```

```
## [1] "numeric"
```

```r
table(aid$country, aid$period) # Fungerer bra for å se nærmere på verdiene til variabler som ikke er kontinuerlige (numeriske). Her får vi (ikke helt) tilfeldigvis også en oversikt over enhetene i datasettet.
```

```
##      
##       1 2 3 4 5 6 7 8
##   AFG 1 1 1 1 1 1 1 1
##   AGO 1 1 1 1 1 1 1 1
##   ALB 1 1 1 1 1 1 1 1
##   ARE 1 1 1 1 1 1 1 1
##   ARG 1 1 1 1 1 1 1 1
##   ARM 1 1 1 1 1 1 1 1
##   ASM 1 1 1 1 1 1 1 1
##   ATG 1 1 1 1 1 1 1 1
##   AZE 1 1 1 1 1 1 1 1
##   BDI 1 1 1 1 1 1 1 1
##   BEN 1 1 1 1 1 1 1 1
##   BFA 1 1 1 1 1 1 1 1
##   BGD 1 1 1 1 1 1 1 1
##   BGR 1 1 1 1 1 1 1 1
##   BHR 1 1 1 1 1 1 1 1
##   BHS 1 1 1 1 1 1 1 1
##   BIH 1 1 1 1 1 1 1 1
##   BLR 1 1 1 1 1 1 1 1
##   BLZ 1 1 1 1 1 1 1 1
##   BOL 1 1 1 1 1 1 1 1
##   BRA 1 1 1 1 1 1 1 1
##   BRB 1 1 1 1 1 1 1 1
##   BRN 1 1 1 1 1 1 1 1
##   BTN 1 1 1 1 1 1 1 1
##   BWA 1 1 1 1 1 1 1 1
##   CAF 1 1 1 1 1 1 1 1
##   CHL 1 1 1 1 1 1 1 1
##   CHN 1 1 1 1 1 1 1 1
##   CIV 1 1 1 1 1 1 1 1
##   CMR 1 1 1 1 1 1 1 1
##   COG 1 1 1 1 1 1 1 1
##   COK 1 1 1 1 1 1 1 1
##   COL 1 1 1 1 1 1 1 1
##   COM 1 1 1 1 1 1 1 1
##   CPV 1 1 1 1 1 1 1 1
##   CRI 1 1 1 1 1 1 1 1
##   CSK 1 1 1 1 1 1 1 1
##   CUB 1 1 1 1 1 1 1 1
##   CZE 1 1 1 1 1 1 1 1
##   DJI 1 1 1 1 1 1 1 1
##   DMA 1 1 1 1 1 1 1 1
##   DOM 1 1 1 1 1 1 1 1
##   DZA 1 1 1 1 1 1 1 1
##   ECU 1 1 1 1 1 1 1 1
##   EGY 1 1 1 1 1 1 1 1
##   ERI 1 1 1 1 1 1 1 1
##   EST 1 1 1 1 1 1 1 1
##   ETH 1 1 1 1 1 1 1 1
##   FJI 1 1 1 1 1 1 1 1
##   FSM 1 1 1 1 1 1 1 1
##   GAB 1 1 1 1 1 1 1 1
##   GEO 1 1 1 1 1 1 1 1
##   GHA 1 1 1 1 1 1 1 1
##   GIN 1 1 1 1 1 1 1 1
##   GLP 1 1 1 1 1 1 1 1
##   GMB 1 1 1 1 1 1 1 1
##   GNB 1 1 1 1 1 1 1 1
##   GNQ 1 1 1 1 1 1 1 1
##   GRD 1 1 1 1 1 1 1 1
##   GTM 1 1 1 1 1 1 1 1
##   GUY 1 1 1 1 1 1 1 1
##   HKG 1 1 1 1 1 1 1 1
##   HND 1 1 1 1 1 1 1 1
##   HRV 1 1 1 1 1 1 1 1
##   HTI 1 1 1 1 1 1 1 1
##   HUN 1 1 1 1 1 1 1 1
##   IDN 1 1 1 1 1 1 1 1
##   IMY 1 1 1 1 1 1 1 1
##   IND 1 1 1 1 1 1 1 1
##   IRN 1 1 1 1 1 1 1 1
##   IRQ 1 1 1 1 1 1 1 1
##   JAM 1 1 1 1 1 1 1 1
##   JOR 1 1 1 1 1 1 1 1
##   KAZ 1 1 1 1 1 1 1 1
##   KEN 1 1 1 1 1 1 1 1
##   KGZ 1 1 1 1 1 1 1 1
##   KHM 1 1 1 1 1 1 1 1
##   KIR 1 1 1 1 1 1 1 1
##   KNA 1 1 1 1 1 1 1 1
##   KOR 1 1 1 1 1 1 1 1
##   KWT 1 1 1 1 1 1 1 1
##   LAO 1 1 1 1 1 1 1 1
##   LBN 1 1 1 1 1 1 1 1
##   LBR 1 1 1 1 1 1 1 1
##   LBY 1 1 1 1 1 1 1 1
##   LCA 1 1 1 1 1 1 1 1
##   LKA 1 1 1 1 1 1 1 1
##   LSO 1 1 1 1 1 1 1 1
##   LTU 1 1 1 1 1 1 1 1
##   LVA 1 1 1 1 1 1 1 1
##   MAC 1 1 1 1 1 1 1 1
##   MAR 1 1 1 1 1 1 1 1
##   MDA 1 1 1 1 1 1 1 1
##   MDG 1 1 1 1 1 1 1 1
##   MDV 1 1 1 1 1 1 1 1
##   MEX 1 1 1 1 1 1 1 1
##   MHL 1 1 1 1 1 1 1 1
##   MKD 1 1 1 1 1 1 1 1
##   MLI 1 1 1 1 1 1 1 1
##   MLT 1 1 1 1 1 1 1 1
##   MMR 1 1 1 1 1 1 1 1
##   MNG 1 1 1 1 1 1 1 1
##   MOZ 1 1 1 1 1 1 1 1
##   MRT 1 1 1 1 1 1 1 1
##   MUS 1 1 1 1 1 1 1 1
##   MWI 1 1 1 1 1 1 1 1
##   MYS 1 1 1 1 1 1 1 1
##   MYT 1 1 1 1 1 1 1 1
##   NAM 1 1 1 1 1 1 1 1
##   NER 1 1 1 1 1 1 1 1
##   NGA 1 1 1 1 1 1 1 1
##   NIC 1 1 1 1 1 1 1 1
##   NPL 1 1 1 1 1 1 1 1
##   NRU 1 1 1 1 1 1 1 1
##   OMN 1 1 1 1 1 1 1 1
##   PAK 1 1 1 1 1 1 1 1
##   PAN 1 1 1 1 1 1 1 1
##   PER 1 1 1 1 1 1 1 1
##   PHL 1 1 1 1 1 1 1 1
##   PLW 1 1 1 1 1 1 1 1
##   PNG 1 1 1 1 1 1 1 1
##   POL 1 1 1 1 1 1 1 1
##   PRI 1 1 1 1 1 1 1 1
##   PRK 1 1 1 1 1 1 1 1
##   PRY 1 1 1 1 1 1 1 1
##   ROM 1 1 1 1 1 1 1 1
##   RUS 1 1 1 1 1 1 1 1
##   RWA 1 1 1 1 1 1 1 1
##   SAU 1 1 1 1 1 1 1 1
##   SDN 1 1 1 1 1 1 1 1
##   SEN 1 1 1 1 1 1 1 1
##   SGP 1 1 1 1 1 1 1 1
##   SLB 1 1 1 1 1 1 1 1
##   SLE 1 1 1 1 1 1 1 1
##   SLV 1 1 1 1 1 1 1 1
##   SOM 1 1 1 1 1 1 1 1
##   STP 1 1 1 1 1 1 1 1
##   SUR 1 1 1 1 1 1 1 1
##   SVK 1 1 1 1 1 1 1 1
##   SWZ 1 1 1 1 1 1 1 1
##   SYC 1 1 1 1 1 1 1 1
##   SYR 1 1 1 1 1 1 1 1
##   TCD 1 1 1 1 1 1 1 1
##   TGO 1 1 1 1 1 1 1 1
##   THA 1 1 1 1 1 1 1 1
##   TJK 1 1 1 1 1 1 1 1
##   TKM 1 1 1 1 1 1 1 1
##   TON 1 1 1 1 1 1 1 1
##   TTO 1 1 1 1 1 1 1 1
##   TUN 1 1 1 1 1 1 1 1
##   TUR 1 1 1 1 1 1 1 1
##   TWN 1 1 1 1 1 1 1 1
##   TZA 1 1 1 1 1 1 1 1
##   UGA 1 1 1 1 1 1 1 1
##   UKR 1 1 1 1 1 1 1 1
##   URY 1 1 1 1 1 1 1 1
##   UZB 1 1 1 1 1 1 1 1
##   VCT 1 1 1 1 1 1 1 1
##   VEN 1 1 1 1 1 1 1 1
##   VIR 1 1 1 1 1 1 1 1
##   VNM 1 1 1 1 1 1 1 1
##   VUT 1 1 1 1 1 1 1 1
##   WBG 1 1 1 1 1 1 1 1
##   WSM 1 1 1 1 1 1 1 1
##   YEM 1 1 1 1 1 1 1 1
##   YUG 1 1 1 1 1 1 1 1
##   ZAF 1 1 1 1 1 1 1 1
##   ZAR 1 1 1 1 1 1 1 1
##   ZMB 1 1 1 1 1 1 1 1
##   ZWE 1 1 1 1 1 1 1 1
```

Disse funksjonene for univariat statistikke er fine for å få en forståelse av fordelingen til kontinuerlige variabler vi er særlig interessert i.


```r
min(aid$elrgdpg, na.rm = TRUE)  # minimumsverdi, na.rm = T spesifiserer at missing skal droppes i beregning.
```

```
## [1] -43.64145
```

```r
max(aid$elrgdpg, na.rm = TRUE)  # maksimumsverdi
```

```
## [1] 56.08551
```

```r
mean(aid$elrgdpg, na.rm = TRUE) # gjennomsnitt
```

```
## [1] 1.330477
```

```r
median(aid$elrgdpg, na.rm =T )  # median
```

```
## [1] 1.662594
```

```r
sd(aid$elrgdpg, na.rm = T)      # standardavvik
```

```
## [1] 5.397031
```

```r
var(aid$elrgdpg, na.rm = T)     # varians
```

```
## [1] 29.12795
```

```r
quantile(aid$elrgdpg, na.rm = T)
```

```
##          0%         25%         50%         75%        100% 
## -43.6414490  -0.8738849   1.6625940   3.8163580  56.0855103
```

```r
#install.packages("moments")
library(moments)
skewness(aid$elrgdpg) # skjevhet - fra moments
```

```
## [1] NA
```

```r
kurtosis(aid$elrgdpg) # kurtose - fra moments
```

```
## [1] NA
```

```r
summary(aid$elrgdpg) # forskjellig deskriptiv statistikk for en variabel
```

```
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max.     NA's 
## -43.6414  -0.8739   1.6626   1.3305   3.8164  56.0855      369
```

```r
summary(aid)            # deskriptiv statistikk for alle variabler i datasettet
```

```
##    country              period      periodstart     periodend   
##  Length:1360        Min.   :1.00   Min.   :1966   Min.   :1969  
##  Class :character   1st Qu.:2.75   1st Qu.:1973   1st Qu.:1976  
##  Mode  :character   Median :4.50   Median :1980   Median :1983  
##                     Mean   :4.50   Mean   :1980   Mean   :1983  
##                     3rd Qu.:6.25   3rd Qu.:1987   3rd Qu.:1990  
##                     Max.   :8.00   Max.   :1994   Max.   :1997  
##                                                                 
##      code               bdgdpg            elrgdpg             bdgdp      
##  Length:1360        Min.   :-56.4871   Min.   :-43.6414   Min.   :  294  
##  Class :character   1st Qu.: -0.9493   1st Qu.: -0.8739   1st Qu.:  885  
##  Mode  :character   Median :  1.6893   Median :  1.6626   Median : 1712  
##                     Mean   :  1.1635   Mean   :  1.3305   Mean   : 2500  
##                     3rd Qu.:  4.0273   3rd Qu.:  3.8164   3rd Qu.: 3320  
##                     Max.   : 62.8700   Max.   : 56.0855   Max.   :24322  
##                     NA's   :471        NA's   :369        NA's   :633    
##      elrgdp           bdbb             elrbb             bdinfl       
##  Min.   :  270   Min.   :-0.5775   Min.   :-0.4503   Min.   :-0.1667  
##  1st Qu.:  899   1st Qu.:-0.0603   1st Qu.:-0.0556   1st Qu.: 0.0454  
##  Median : 1780   Median :-0.0284   Median :-0.0284   Median : 0.0938  
##  Mean   : 2622   Mean   :-0.0385   Mean   :-0.0361   Mean   : 0.1770  
##  3rd Qu.: 3431   3rd Qu.:-0.0073   3rd Qu.:-0.0083   3rd Qu.: 0.1566  
##  Max.   :24322   Max.   : 0.3951   Max.   : 0.4776   Max.   : 3.8784  
##  NA's   :471     NA's   :764       NA's   :655       NA's   :660      
##     elrinfl            bdsacw          elrsacw         bdethnf      
##  Min.   :-0.0633   Min.   :0.0000   Min.   :0.000   Min.   :0.0000  
##  1st Qu.: 0.0489   1st Qu.:0.0000   1st Qu.:0.000   1st Qu.:0.1600  
##  Median : 0.0959   Median :0.0000   Median :0.000   Median :0.5500  
##  Mean   : 0.2055   Mean   :0.2105   Mean   :0.267   Mean   :0.4725  
##  3rd Qu.: 0.1723   3rd Qu.:0.0000   3rd Qu.:0.750   3rd Qu.:0.7225  
##  Max.   : 3.8784   Max.   :1.0000   Max.   :1.000   Max.   :0.9300  
##  NA's   :569       NA's   :758      NA's   :611     NA's   :952     
##     elrethnf         bdassas           elrassas          bdicrge     
##  Min.   :0.0000   Min.   : 0.0000   Min.   : 0.0000   Min.   :2.271  
##  1st Qu.:0.1675   1st Qu.: 0.0000   1st Qu.: 0.0000   1st Qu.:3.603  
##  Median :0.5350   Median : 0.0000   Median : 0.0000   Median :4.553  
##  Mean   :0.4694   Mean   : 0.3172   Mean   : 0.2157   Mean   :4.706  
##  3rd Qu.:0.7225   3rd Qu.: 0.2500   3rd Qu.: 0.0000   3rd Qu.:5.578  
##  Max.   :0.9300   Max.   :11.5000   Max.   :11.5000   Max.   :8.560  
##  NA's   :656      NA's   :936       NA's   :297       NA's   :976    
##     elricrge         bdm21             elrm21            bdssa       
##  Min.   :1.580   Min.   :  6.855   Min.   :  2.716   Min.   :0.0000  
##  1st Qu.:3.082   1st Qu.: 19.848   1st Qu.: 17.091   1st Qu.:0.0000  
##  Median :4.700   Median : 26.035   Median : 24.025   Median :0.0000  
##  Mean   :4.687   Mean   : 30.834   Mean   : 30.714   Mean   :0.1867  
##  3rd Qu.:5.900   3rd Qu.: 36.555   3rd Qu.: 36.800   3rd Qu.:0.0000  
##  Max.   :9.600   Max.   :159.364   Max.   :167.482   Max.   :1.0000  
##  NA's   :528     NA's   :950       NA's   :587       NA's   :310     
##      elrssa          bddn1900        elrdn1900           bdaid        
##  Min.   :0.0000   Min.   :0.0000   Min.   :-1.0000   Min.   :-0.0080  
##  1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:-1.0000   1st Qu.: 0.2733  
##  Median :0.0000   Median :0.0000   Median : 0.0000   Median : 1.3247  
##  Mean   :0.2824   Mean   :0.2467   Mean   :-0.3455   Mean   : 2.5963  
##  3rd Qu.:1.0000   3rd Qu.:0.0000   3rd Qu.: 0.0000   3rd Qu.: 3.6661  
##  Max.   :1.0000   Max.   :1.0000   Max.   : 0.0000   Max.   :24.8543  
##                   NA's   :310      NA's   :480       NA's   :748      
##      elraid             bdlpop         elrlpop         bdeasia       
##  Min.   :-12.7330   Min.   :12.08   Min.   :10.17   Min.   :0.00000  
##  1st Qu.:  0.1785   1st Qu.:14.95   1st Qu.:14.03   1st Qu.:0.00000  
##  Median :  0.9166   Median :15.85   Median :15.31   Median :0.00000  
##  Mean   :  1.9607   Mean   :15.91   Mean   :15.13   Mean   :0.04667  
##  3rd Qu.:  2.8420   3rd Qu.:16.95   3rd Qu.:16.40   3rd Qu.:0.00000  
##  Max.   : 18.9440   Max.   :20.59   Max.   :20.91   Max.   :1.00000  
##  NA's   :629        NA's   :928     NA's   :92      NA's   :310      
##     elreasia          bdegypt          elregypt           bdcentam     
##  Min.   :0.00000   Min.   :0.0000   Min.   :0.000000   Min.   :0.0000  
##  1st Qu.:0.00000   1st Qu.:0.0000   1st Qu.:0.000000   1st Qu.:0.0000  
##  Median :0.00000   Median :0.0000   Median :0.000000   Median :0.0000  
##  Mean   :0.04706   Mean   :0.0116   Mean   :0.005882   Mean   :0.0833  
##  3rd Qu.:0.00000   3rd Qu.:0.0000   3rd Qu.:0.000000   3rd Qu.:0.0000  
##  Max.   :1.00000   Max.   :1.0000   Max.   :1.000000   Max.   :1.0000  
##                    NA's   :928                         NA's   :928     
##    elrcentam           bdfrz           elrfrz           bdarms1       
##  Min.   :0.00000   Min.   :0.000   Min.   :0.00000   Min.   :  0.000  
##  1st Qu.:0.00000   1st Qu.:0.000   1st Qu.:0.00000   1st Qu.:  0.325  
##  Median :0.00000   Median :0.000   Median :0.00000   Median :  1.350  
##  Mean   :0.04118   Mean   :0.125   Mean   :0.07647   Mean   :  4.921  
##  3rd Qu.:0.00000   3rd Qu.:0.000   3rd Qu.:0.00000   3rd Qu.:  4.250  
##  Max.   :1.00000   Max.   :1.000   Max.   :1.00000   Max.   :116.350  
##                    NA's   :928                       NA's   :935      
##     elrarms1       originalcountries    bddatap           bddatao        
##  Min.   :-0.2984   Min.   :0.0000    Min.   :-4.5035   Min.   :0.000000  
##  1st Qu.: 0.0032   1st Qu.:0.0000    1st Qu.: 0.6747   1st Qu.:0.000000  
##  Median : 0.0160   Median :0.0000    Median : 0.9944   Median :0.000000  
##  Mean   : 0.0668   Mean   :0.3294    Mean   : 1.2596   Mean   :0.003677  
##  3rd Qu.: 0.0513   3rd Qu.:1.0000    3rd Qu.: 1.6105   3rd Qu.:0.000000  
##  Max.   : 2.4612   Max.   :1.0000    Max.   : 4.5245   Max.   :1.000000  
##  NA's   :526                         NA's   :944                         
##  elrdatabdcos7093bdvarsp elrdatabdcos7093bdvarso elrdatabdcos7097bdvarsp
##  Min.   :-5.074          Min.   :0.0000          Min.   :-5.136         
##  1st Qu.: 0.904          1st Qu.:0.0000          1st Qu.: 1.012         
##  Median : 1.084          Median :0.0000          Median : 1.241         
##  Mean   : 1.570          Mean   :0.0219          Mean   : 1.491         
##  3rd Qu.: 3.221          3rd Qu.:0.0000          3rd Qu.: 2.648         
##  Max.   : 3.841          Max.   :1.0000          Max.   : 3.594         
##  NA's   :873             NA's   :1086            NA's   :873            
##  elrdatabdcos7097bdvarso elrdata7093bdvarsp elrdata7093bdvarso
##  Min.   :0.0000          Min.   :-5.048     Min.   :0.00      
##  1st Qu.:0.0000          1st Qu.: 0.852     1st Qu.:0.00      
##  Median :0.0000          Median : 1.135     Median :0.00      
##  Mean   :0.0373          Mean   : 1.494     Mean   :0.03      
##  3rd Qu.:0.0000          3rd Qu.: 2.867     3rd Qu.:0.00      
##  Max.   :1.0000          Max.   : 4.072     Max.   :1.00      
##  NA's   :1038            NA's   :873        NA's   :1060      
##  elrdata7097bdvarsp elrdata7097bdvarso
##  Min.   :-5.3453    Min.   :0.0000    
##  1st Qu.: 0.9723    1st Qu.:0.0000    
##  Median : 1.2896    Median :0.0000    
##  Mean   : 1.4182    Mean   :0.0309    
##  3rd Qu.: 2.3485    3rd Qu.:0.0000    
##  Max.   : 3.7832    Max.   :1.0000    
##  NA's   :873        NA's   :1004
```

4. Er det mange observasjoner som har manglende informasjon på noen av variablene jeg er interessert i?

```r
table(complete.cases(aid)) # tester hvor mange rader som ikke har missing
```

```
## 
## FALSE  TRUE 
##  1104   256
```

```r
table(is.na(aid$elrgdpg)) # tester hvor mange observasjoner som har missing på variabelen aid$elrgdpg
```

```
## 
## FALSE  TRUE 
##   991   369
```

```r
aid %>%
complete(country, period) # Tester alle mulige teoretiske kombinasjoner av verdier for variablene vi setter inn - ta utgangspunkt i variabler som definerer forskjellen på observasjonene. Dersom vi for eksempel har spurt et panel av førstegangsvelgere hva de har tenkt å stemme i mange runder, skiller vi med utgangspunkt i individ og spørsmålsrunde.
```

```
## # A tibble: 1,360 x 52
##    country period periodstart periodend code  bdgdpg elrgdpg bdgdp elrgdp
##    <chr>    <dbl>       <dbl>     <dbl> <chr>  <dbl>   <dbl> <dbl>  <dbl>
##  1 AFG          1        1966      1969 AFG1      NA -0.0131    NA     NA
##  2 AFG          2        1970      1973 AFG2      NA -0.550     NA     NA
##  3 AFG          3        1974      1977 AFG3      NA  2.24      NA     NA
##  4 AFG          4        1978      1981 AFG4      NA -1.09      NA     NA
##  5 AFG          5        1982      1985 AFG5      NA  0.804     NA     NA
##  6 AFG          6        1986      1989 AFG6      NA NA         NA     NA
##  7 AFG          7        1990      1993 AFG7      NA NA         NA     NA
##  8 AFG          8        1994      1997 AFG8      NA NA         NA     NA
##  9 AGO          1        1966      1969 AGO1      NA NA       1066   1066
## 10 AGO          2        1970      1973 AGO2      NA NA       1165   1165
## # ... with 1,350 more rows, and 43 more variables: bdbb <dbl>,
## #   elrbb <dbl>, bdinfl <dbl>, elrinfl <dbl>, bdsacw <dbl>, elrsacw <dbl>,
## #   bdethnf <dbl>, elrethnf <dbl>, bdassas <dbl>, elrassas <dbl>,
## #   bdicrge <dbl>, elricrge <dbl>, bdm21 <dbl>, elrm21 <dbl>, bdssa <dbl>,
## #   elrssa <dbl>, bddn1900 <dbl>, elrdn1900 <dbl>, bdaid <dbl>,
## #   elraid <dbl>, bdlpop <dbl>, elrlpop <dbl>, bdeasia <dbl>,
## #   elreasia <dbl>, bdegypt <dbl>, elregypt <dbl>, bdcentam <dbl>,
## #   elrcentam <dbl>, bdfrz <dbl>, elrfrz <dbl>, bdarms1 <dbl>,
## #   elrarms1 <dbl>, originalcountries <dbl>, bddatap <dbl>, bddatao <dbl>,
## #   elrdatabdcos7093bdvarsp <dbl>, elrdatabdcos7093bdvarso <dbl>,
## #   elrdatabdcos7097bdvarsp <dbl>, elrdatabdcos7097bdvarso <dbl>,
## #   elrdata7093bdvarsp <dbl>, elrdata7093bdvarso <dbl>,
## #   elrdata7097bdvarsp <dbl>, elrdata7097bdvarso <dbl>
```

Manglende informasjon/missing data kan ha store implikasjoner, og kan håndteres på forskjellige måter - mer om dette senere. I første runde konsentrerer vi oss om å avdekke missing. Legg merke til at disse funksjonene er logiske tester - de tester om noe er sant eller galt.


### Noen omkodingsfunksjoner:


Etter at vi har kartlagt datastrukturen og hvilke variabler vi har, er det på tide å svare på følgende spørsmål en gang til: Hvilke endringer i data er det nødvendig å gjøre?

Ofte vil en del av svaret være at det er nødvendig å omkode en eller flere variabler. Omkoding av variabler betyr at vi tar informasjon som finnes i en eller flere variabler og omarbeider denne informasjonen, slik at vi får en ny variabel. Dersom du synes dette høres ut som om noe du kan bruke en funksjon til, tenker du rett. Før vi gjennomgår noen funksjoner som er nyttig til å omkode variabker, skal dere få et godt råd. Ikke gjør en omkoding som overskriver variabler som allerede finnes, **opprett alltid nye variabler**, ellers kan det bli veldig kjedelig å gjøre feil (særlig dersom du har den eneste kopien av rådata-filen til masteroppgaven din).


Den generelle syntaksen vi skal bruke for å omkode variabler er som følger:


```r
data$ny_var <- funksjon(data$gammel_var)
# Vi anvender en funksjon som omarbeider informasjonen i en gammel variabel i datasettet vårt, og legger den til datasettet vårt med et nytt navn
```
For å kjøre samme analyse som Burnside og Dollar (2000) må vi som nevnt opprette en ny variabel - en makroøkonimisk politkk-indeks - med utgangspunkt i variablene for inflasjon (`aid$elrinfl`), budsjettbalanse (`aid$elrbb`) og økonomisk åpenhet (`aid$elrsacw`)


```r
# oppretter policy-indeks variabel
aid$policy <- aid$elrinfl + aid$elrbb + aid$elrsacw
```

I `tidyverse` og `dplyr` pakken bruker man som regel `mutate()` funksjonen sammen med andre funksjoner for å opprette nye variabler. Ved hjelp av `mutate()` kan du gjøre mange omkodinger i slengen - dette gir mer ryddig kode.


```r
aid %>% # Spesifiserer at vi skal jobbe med datasettet aid - R vil da lete etter variabler vi referer til her, slik at vi slipper aid$var
  mutate(policy = elrsacw + elrinfl + elrbb) # lager variabelen policy ved å summere budsjettbalanse, inflasjon og en indeks for øk. åpenhet
```

```
## # A tibble: 1,360 x 53
##    country period periodstart periodend code  bdgdpg elrgdpg bdgdp elrgdp
##    <chr>    <dbl>       <dbl>     <dbl> <chr>  <dbl>   <dbl> <dbl>  <dbl>
##  1 AFG          1        1966      1969 AFG1      NA -0.0131    NA     NA
##  2 AFG          2        1970      1973 AFG2      NA -0.550     NA     NA
##  3 AFG          3        1974      1977 AFG3      NA  2.24      NA     NA
##  4 AFG          4        1978      1981 AFG4      NA -1.09      NA     NA
##  5 AFG          5        1982      1985 AFG5      NA  0.804     NA     NA
##  6 AFG          6        1986      1989 AFG6      NA NA         NA     NA
##  7 AFG          7        1990      1993 AFG7      NA NA         NA     NA
##  8 AFG          8        1994      1997 AFG8      NA NA         NA     NA
##  9 AGO          1        1966      1969 AGO1      NA NA       1066   1066
## 10 AGO          2        1970      1973 AGO2      NA NA       1165   1165
## # ... with 1,350 more rows, and 44 more variables: bdbb <dbl>,
## #   elrbb <dbl>, bdinfl <dbl>, elrinfl <dbl>, bdsacw <dbl>, elrsacw <dbl>,
## #   bdethnf <dbl>, elrethnf <dbl>, bdassas <dbl>, elrassas <dbl>,
## #   bdicrge <dbl>, elricrge <dbl>, bdm21 <dbl>, elrm21 <dbl>, bdssa <dbl>,
## #   elrssa <dbl>, bddn1900 <dbl>, elrdn1900 <dbl>, bdaid <dbl>,
## #   elraid <dbl>, bdlpop <dbl>, elrlpop <dbl>, bdeasia <dbl>,
## #   elreasia <dbl>, bdegypt <dbl>, elregypt <dbl>, bdcentam <dbl>,
## #   elrcentam <dbl>, bdfrz <dbl>, elrfrz <dbl>, bdarms1 <dbl>,
## #   elrarms1 <dbl>, originalcountries <dbl>, bddatap <dbl>, bddatao <dbl>,
## #   elrdatabdcos7093bdvarsp <dbl>, elrdatabdcos7093bdvarso <dbl>,
## #   elrdatabdcos7097bdvarsp <dbl>, elrdatabdcos7097bdvarso <dbl>,
## #   elrdata7093bdvarsp <dbl>, elrdata7093bdvarso <dbl>,
## #   elrdata7097bdvarsp <dbl>, elrdata7097bdvarso <dbl>, policy <dbl>
```

```r
aid <- aid %>% # samme kode som over, men nå overskriver jeg data slik at variabelen legges til - gjør dette etter at du har testet at koden fungerte
  mutate(policy = elrsacw + elrinfl + elrbb,
         policy2 = elrsacw*elrinfl*elrbb)
# Her lager jeg to versjoner av policyindeksen - en additiv og en multiplikativ indeks. Hva er den teoretiske forskjellen?
# Dette er en ryddig måte å samle alle omkodinger på!
```


Her brukte vi enkle matematiske operasjoner, `+` og `*` for å opprette nye variabler. Andre nyttige matematiske funksjoner til omkoding er funksjoner som `log()`, `exp()` og `sqrt()`. Mot slutten av dokumentet til introduksjonsforelesningen viste jeg sentrering - dvs. å sørge for at gjennomsnittet til en variabel blir 0. Så lenge vi jobber med variabler av klassene `integer` eller `numeric` kan vi utføre omkodinger ved hjelp av alle slags matematiske operasjoner - bare teoretiske og metodologiske hensyn setter begrensninger. For variabler som ikke inneholder tall, vil naturlig nok denne typen omkoding ikke fungere. Vi kommer til å se såvidt på noen funksjoner for omkoding med utgangspunkt i tekstvariabler i et senere seminar.

**Oppgave:** Sentrer de to nye variablene `policy` og `policy2`. Det er lov å bruke alle hjelpemidler!


En annen type enkel omkoding består i å endre klassen til en variabel. Dette kan gjøres med utgangspunkt i to begrunnelser:

1. Endre målenivå til en variabel - variabler av klassene `numeric` og `integer` vil stort sett behandles som kontinuerlige variabler. Variabler av klassene `factor` vil derimot stort sett håndteres som nominal-nivå variabler i statistiske funksjoner (her er det noen ganger forskjell mellom funksjoner - se på hjelpefil dersom du er i tvil).
2. Endre klassen til en variabel for at en R-funksjon skal fungere på variabelen. Tenk gjennom konsekvensene for målenivå når du gjør dette.

For å endre klassen til en variabel, bruk en funksjon av typen `as.klassenavn(data$variabel)` - her er noen eksempler på hvordan disse funksjonene brukes:


```r
library(tidyverse)
as_factor(aid$period)
```

```
##    [1] 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2
##   [35] 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4
##   [69] 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6
##  [103] 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8
##  [137] 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2
##  [171] 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4
##  [205] 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6
##  [239] 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8
##  [273] 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2
##  [307] 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4
##  [341] 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6
##  [375] 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8
##  [409] 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2
##  [443] 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4
##  [477] 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6
##  [511] 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8
##  [545] 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2
##  [579] 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4
##  [613] 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6
##  [647] 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8
##  [681] 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2
##  [715] 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4
##  [749] 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6
##  [783] 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8
##  [817] 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2
##  [851] 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4
##  [885] 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6
##  [919] 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8
##  [953] 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2
##  [987] 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4
## [1021] 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6
## [1055] 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8
## [1089] 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2
## [1123] 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4
## [1157] 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6
## [1191] 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8
## [1225] 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2
## [1259] 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4
## [1293] 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6
## [1327] 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8 1 2 3 4 5 6 7 8
## Levels: 1 2 3 4 5 6 7 8
```

```r
as.numeric(as_factor(aid$country)) # Denne fungerer bare hvis variabelen inneholder noe som kan leses som tall, legg merke til hva den gjør med faktor-variabler!
```

```
##    [1]   1   1   1   1   1   1   1   1   2   2   2   2   2   2   2   2   3
##   [18]   3   3   3   3   3   3   3   4   4   4   4   4   4   4   4   5   5
##   [35]   5   5   5   5   5   5   6   6   6   6   6   6   6   6   7   7   7
##   [52]   7   7   7   7   7   8   8   8   8   8   8   8   8   9   9   9   9
##   [69]   9   9   9   9  10  10  10  10  10  10  10  10  11  11  11  11  11
##   [86]  11  11  11  12  12  12  12  12  12  12  12  13  13  13  13  13  13
##  [103]  13  13  14  14  14  14  14  14  14  14  15  15  15  15  15  15  15
##  [120]  15  16  16  16  16  16  16  16  16  17  17  17  17  17  17  17  17
##  [137]  18  18  18  18  18  18  18  18  19  19  19  19  19  19  19  19  20
##  [154]  20  20  20  20  20  20  20  21  21  21  21  21  21  21  21  22  22
##  [171]  22  22  22  22  22  22  23  23  23  23  23  23  23  23  24  24  24
##  [188]  24  24  24  24  24  25  25  25  25  25  25  25  25  26  26  26  26
##  [205]  26  26  26  26  27  27  27  27  27  27  27  27  28  28  28  28  28
##  [222]  28  28  28  29  29  29  29  29  29  29  29  30  30  30  30  30  30
##  [239]  30  30  31  31  31  31  31  31  31  31  32  32  32  32  32  32  32
##  [256]  32  33  33  33  33  33  33  33  33  34  34  34  34  34  34  34  34
##  [273]  35  35  35  35  35  35  35  35  36  36  36  36  36  36  36  36  37
##  [290]  37  37  37  37  37  37  37  38  38  38  38  38  38  38  38  39  39
##  [307]  39  39  39  39  39  39  40  40  40  40  40  40  40  40  41  41  41
##  [324]  41  41  41  41  41  42  42  42  42  42  42  42  42  43  43  43  43
##  [341]  43  43  43  43  44  44  44  44  44  44  44  44  45  45  45  45  45
##  [358]  45  45  45  46  46  46  46  46  46  46  46  47  47  47  47  47  47
##  [375]  47  47  48  48  48  48  48  48  48  48  49  49  49  49  49  49  49
##  [392]  49  50  50  50  50  50  50  50  50  51  51  51  51  51  51  51  51
##  [409]  52  52  52  52  52  52  52  52  53  53  53  53  53  53  53  53  54
##  [426]  54  54  54  54  54  54  54  55  55  55  55  55  55  55  55  56  56
##  [443]  56  56  56  56  56  56  57  57  57  57  57  57  57  57  58  58  58
##  [460]  58  58  58  58  58  59  59  59  59  59  59  59  59  60  60  60  60
##  [477]  60  60  60  60  61  61  61  61  61  61  61  61  62  62  62  62  62
##  [494]  62  62  62  63  63  63  63  63  63  63  63  64  64  64  64  64  64
##  [511]  64  64  65  65  65  65  65  65  65  65  66  66  66  66  66  66  66
##  [528]  66  67  67  67  67  67  67  67  67  68  68  68  68  68  68  68  68
##  [545]  69  69  69  69  69  69  69  69  70  70  70  70  70  70  70  70  71
##  [562]  71  71  71  71  71  71  71  72  72  72  72  72  72  72  72  73  73
##  [579]  73  73  73  73  73  73  74  74  74  74  74  74  74  74  75  75  75
##  [596]  75  75  75  75  75  76  76  76  76  76  76  76  76  77  77  77  77
##  [613]  77  77  77  77  78  78  78  78  78  78  78  78  79  79  79  79  79
##  [630]  79  79  79  80  80  80  80  80  80  80  80  81  81  81  81  81  81
##  [647]  81  81  82  82  82  82  82  82  82  82  83  83  83  83  83  83  83
##  [664]  83  84  84  84  84  84  84  84  84  85  85  85  85  85  85  85  85
##  [681]  86  86  86  86  86  86  86  86  87  87  87  87  87  87  87  87  88
##  [698]  88  88  88  88  88  88  88  89  89  89  89  89  89  89  89  90  90
##  [715]  90  90  90  90  90  90  91  91  91  91  91  91  91  91  92  92  92
##  [732]  92  92  92  92  92  93  93  93  93  93  93  93  93  94  94  94  94
##  [749]  94  94  94  94  95  95  95  95  95  95  95  95  96  96  96  96  96
##  [766]  96  96  96  97  97  97  97  97  97  97  97  98  98  98  98  98  98
##  [783]  98  98  99  99  99  99  99  99  99  99 100 100 100 100 100 100 100
##  [800] 100 101 101 101 101 101 101 101 101 102 102 102 102 102 102 102 102
##  [817] 103 103 103 103 103 103 103 103 104 104 104 104 104 104 104 104 105
##  [834] 105 105 105 105 105 105 105 106 106 106 106 106 106 106 106 107 107
##  [851] 107 107 107 107 107 107 108 108 108 108 108 108 108 108 109 109 109
##  [868] 109 109 109 109 109 110 110 110 110 110 110 110 110 111 111 111 111
##  [885] 111 111 111 111 112 112 112 112 112 112 112 112 113 113 113 113 113
##  [902] 113 113 113 114 114 114 114 114 114 114 114 115 115 115 115 115 115
##  [919] 115 115 116 116 116 116 116 116 116 116 117 117 117 117 117 117 117
##  [936] 117 118 118 118 118 118 118 118 118 119 119 119 119 119 119 119 119
##  [953] 120 120 120 120 120 120 120 120 121 121 121 121 121 121 121 121 122
##  [970] 122 122 122 122 122 122 122 123 123 123 123 123 123 123 123 124 124
##  [987] 124 124 124 124 124 124 125 125 125 125 125 125 125 125 126 126 126
## [1004] 126 126 126 126 126 127 127 127 127 127 127 127 127 128 128 128 128
## [1021] 128 128 128 128 129 129 129 129 129 129 129 129 130 130 130 130 130
## [1038] 130 130 130 131 131 131 131 131 131 131 131 132 132 132 132 132 132
## [1055] 132 132 133 133 133 133 133 133 133 133 134 134 134 134 134 134 134
## [1072] 134 135 135 135 135 135 135 135 135 136 136 136 136 136 136 136 136
## [1089] 137 137 137 137 137 137 137 137 138 138 138 138 138 138 138 138 139
## [1106] 139 139 139 139 139 139 139 140 140 140 140 140 140 140 140 141 141
## [1123] 141 141 141 141 141 141 142 142 142 142 142 142 142 142 143 143 143
## [1140] 143 143 143 143 143 144 144 144 144 144 144 144 144 145 145 145 145
## [1157] 145 145 145 145 146 146 146 146 146 146 146 146 147 147 147 147 147
## [1174] 147 147 147 148 148 148 148 148 148 148 148 149 149 149 149 149 149
## [1191] 149 149 150 150 150 150 150 150 150 150 151 151 151 151 151 151 151
## [1208] 151 152 152 152 152 152 152 152 152 153 153 153 153 153 153 153 153
## [1225] 154 154 154 154 154 154 154 154 155 155 155 155 155 155 155 155 156
## [1242] 156 156 156 156 156 156 156 157 157 157 157 157 157 157 157 158 158
## [1259] 158 158 158 158 158 158 159 159 159 159 159 159 159 159 160 160 160
## [1276] 160 160 160 160 160 161 161 161 161 161 161 161 161 162 162 162 162
## [1293] 162 162 162 162 163 163 163 163 163 163 163 163 164 164 164 164 164
## [1310] 164 164 164 165 165 165 165 165 165 165 165 166 166 166 166 166 166
## [1327] 166 166 167 167 167 167 167 167 167 167 168 168 168 168 168 168 168
## [1344] 168 169 169 169 169 169 169 169 169 170 170 170 170 170 170 170 170
```

```r
# Legg merke til . i as.numeric.
as.character(aid$elrgdpg)
```

```
##    [1] "-0.0131123000755906"   "-0.549876391887665"   
##    [3] "2.23717403411865"      "-1.09067595005035"    
##    [5] "0.804371118545532"     NA                     
##    [7] NA                      NA                     
##    [9] NA                      NA                     
##   [11] NA                      "-9.37276744842529"    
##   [13] "-0.0266571007668972"   "1.28926002979279"     
##   [15] "-9.90323543548584"     "3.74542808532715"     
##   [17] NA                      NA                     
##   [19] NA                      "3.70792889595032"     
##   [21] "-0.887869894504547"    "1.0083099603653"      
##   [23] "-8.35022354125977"     "3.86887001991272"     
##   [25] NA                      NA                     
##   [27] "-3.6748468875885"      "1.38181602954865"     
##   [29] "-8.34111213684082"     "-5.46229076385498"    
##   [31] "-1.69814801216125"     "1.43386697769165"     
##   [33] "2.78798007965088"      "1.60446000099182"     
##   [35] "0.99717652797699"      "-0.44332081079483"    
##   [37] "-3.08304190635681"     "-1.24094700813293"    
##   [39] "5.62999105453491"      "2.80937600135803"     
##   [41] NA                      NA                     
##   [43] NA                      NA                     
##   [45] NA                      NA                     
##   [47] "-22.0656604766846"     "4.99447584152222"     
##   [49] NA                      NA                     
##   [51] NA                      NA                     
##   [53] NA                      NA                     
##   [55] NA                      NA                     
##   [57] NA                      NA                     
##   [59] NA                      "6.32702302932739"     
##   [61] "5.30553722381592"      "7.3567042350769"      
##   [63] "2.27084994316101"      "2.8373429775238"      
##   [65] NA                      NA                     
##   [67] NA                      NA                     
##   [69] NA                      "-7.3276219367981"     
##   [71] "-16.0366191864014"     "-7.12387609481812"    
##   [73] "2.21109008789062"      "5.19811391830444"     
##   [75] "3.1947329044342"       "0.860346794128418"    
##   [77] "0.845855414867401"     "0.94584459066391"     
##   [79] "-1.69642901420593"     "-6.78354978561401"    
##   [81] "0.720597982406616"     "0.341211497783661"    
##   [83] "-1.30549097061157"     "3.36201190948486"     
##   [85] "0.298772990703583"     "-2.79212498664856"    
##   [87] "0.641196727752686"     "2.22551202774048"     
##   [89] "1.60539901256561"      "-0.809882879257202"   
##   [91] "2.87755799293518"      "0.916320621967316"    
##   [93] "1.63604605197906"      "1.24595296382904"     
##   [95] "1.56205999851227"      "2.14255309104919"     
##   [97] "0.29084900021553"      "-5.08665323257446"    
##   [99] "2.23547601699829"      "3.72149205207825"     
##  [101] "1.62950003147125"      "0.93255227804184"     
##  [103] "2.90552592277527"      "2.96790504455566"     
##  [105] NA                      NA                     
##  [107] NA                      "4.71127986907959"     
##  [109] "2.77951097488403"      "4.64545392990112"     
##  [111] "-5.48186683654785"     "-2.66255593299866"    
##  [113] NA                      NA                     
##  [115] NA                      "-10.2806100845337"    
##  [117] "-4.62913417816162"     "1.19113004207611"     
##  [119] "6.32812404632568"      "-0.841638207435608"   
##  [121] "4.68973112106323"      "-2.34709596633911"    
##  [123] "-6.28353214263916"     "7.15556287765503"     
##  [125] "5.19693994522095"      "0.471362203359604"    
##  [127] "-2.03998303413391"     "0.0444092005491257"   
##  [129] NA                      NA                     
##  [131] NA                      NA                     
##  [133] NA                      NA                     
##  [135] NA                      "56.0855102539062"     
##  [137] NA                      NA                     
##  [139] NA                      NA                     
##  [141] NA                      "5.81268405914307"     
##  [143] "-5.10018491744995"     "-1.6716810464859"     
##  [145] "3.19455003738403"      "4.64869022369385"     
##  [147] "3.91015410423279"      "5.16340780258179"     
##  [149] "-2.37646889686584"     "6.69816303253174"     
##  [151] "4.90916776657104"      "0.384298801422119"    
##  [153] "-1.20787799358368"     "1.75549304485321"     
##  [155] "2.98483300209045"      "-1.5507550239563"     
##  [157] "-4.30255699157715"     "-0.488225996494293"   
##  [159] "1.53628098964691"      "2.24386501312256"     
##  [161] "4.81471014022827"      "8.89698791503906"     
##  [163] "4.67745494842529"      "1.34043395519257"     
##  [165] "0.498644411563873"     "1.82136404514313"     
##  [167] "-1.21636497974396"     "2.59281706809998"     
##  [169] "6.90876007080078"      "3.48714399337769"     
##  [171] "0.52454537153244"      "3.54953598976135"     
##  [173] "-0.545667707920074"    "5.07866477966309"     
##  [175] "-3.57889199256897"     "3.3010790348053"      
##  [177] NA                      NA                     
##  [179] "4.85842895507812"      "-2.7074921131134"     
##  [181] "-1.87234795093536"     "-2.88663506507874"    
##  [183] "-1.36384499073029"     "0.34248548746109"     
##  [185] NA                      NA                     
##  [187] NA                      "7.94074821472168"     
##  [189] "3.9681351184845"       "6.12266111373901"     
##  [191] "2.62360811233521"      "3.99161696434021"     
##  [193] "6.42022609710693"      "18.5765399932861"     
##  [195] "6.22504901885986"      "7.835618019104"       
##  [197] "6.75541496276855"      "7.32142496109009"     
##  [199] "1.94291305541992"      "2.38994288444519"     
##  [201] "1.48891198635101"      "-0.726593792438507"   
##  [203] "1.75224900245667"      "-4.18778276443481"    
##  [205] "0.481715500354767"     "-1.6063779592514"     
##  [207] "-4.19709300994873"     "0.498483687639236"    
##  [209] "3.06503105163574"      "-0.437824010848999"   
##  [211] "-0.750248610973358"    "5.67419481277466"     
##  [213] "-1.29857695102692"     "5.75762701034546"     
##  [215] "5.95088481903076"      "6.19335985183716"     
##  [217] "0.644629001617432"     "4.94062423706055"     
##  [219] "1.69483995437622"      "5.92022609710693"     
##  [221] "10.5179595947266"      "6.96100807189941"     
##  [223] "8.83460521697998"      "9.27156543731689"     
##  [225] "5.42523288726807"      "3.30032300949097"     
##  [227] "4.08202695846558"      "-2.2780499458313"     
##  [229] "-4.04840898513794"     "-1.76491904258728"    
##  [231] "-3.60888695716858"     "2.32802891731262"     
##  [233] "-1.06823801994324"     "1.10390102863312"     
##  [235] "4.61798095703125"      "7.65429401397705"     
##  [237] "4.54608678817749"      "-4.02498817443848"    
##  [239] "-6.68878507614136"     "0.277013599872589"    
##  [241] "2.06399893760681"      "4.93276405334473"     
##  [243] "-0.889638602733612"    "9.72966003417969"     
##  [245] "5.80211400985718"      "-3.41500806808472"    
##  [247] "-1.77018201351166"     "-4.99359083175659"    
##  [249] NA                      NA                     
##  [251] NA                      NA                     
##  [253] NA                      NA                     
##  [255] NA                      NA                     
##  [257] "2.66535902023315"      "4.27921009063721"     
##  [259] "1.87972295284271"      "2.73765110969543"     
##  [261] "0.128504201769829"     "2.62449407577515"     
##  [263] "1.92958700656891"      "2.16545009613037"     
##  [265] NA                      NA                     
##  [267] NA                      "1.48468601703644"     
##  [269] "1.85437202453613"      "-1.81539797782898"    
##  [271] "0.183540105819702"     "-4.01498889923096"    
##  [273] NA                      NA                     
##  [275] NA                      NA                     
##  [277] "7.04356288909912"      "2.25128793716431"     
##  [279] "1.06486105918884"      "3.20507502555847"     
##  [281] "2.76000499725342"      "4.71601390838623"     
##  [283] "2.7773699760437"       "-0.58819591999054"    
##  [285] "-1.76892399787903"     "1.90194296836853"     
##  [287] "2.96851992607117"      "1.61861896514893"     
##  [289] NA                      NA                     
##  [291] NA                      NA                     
##  [293] NA                      NA                     
##  [295] NA                      NA                     
##  [297] NA                      NA                     
##  [299] NA                      NA                     
##  [301] NA                      NA                     
##  [303] NA                      "3.81134104728699"     
##  [305] NA                      NA                     
##  [307] NA                      NA                     
##  [309] NA                      NA                     
##  [311] "-3.93749308586121"     "2.98945808410645"     
##  [313] NA                      NA                     
##  [315] NA                      NA                     
##  [317] NA                      "-5.79546785354614"    
##  [319] "-7.28348112106323"     "-3.96281409263611"    
##  [321] NA                      NA                     
##  [323] NA                      NA                     
##  [325] NA                      NA                     
##  [327] NA                      NA                     
##  [329] "3.82137489318848"      "10.0759601593018"     
##  [331] "3.16382598876953"      "1.72202599048615"     
##  [333] "-0.57878702878952"     "3.20444488525391"     
##  [335] "-0.140668705105782"    "4.30749082565308"     
##  [337] "3.07015204429626"      "4.02902698516846"     
##  [339] "3.379723072052"        "1.98092699050903"     
##  [341] "2.02373909950256"      "-1.88698196411133"    
##  [343] "-2.55732393264771"     "0.101626701653004"    
##  [345] "0.908325374126434"     "9.86927890777588"     
##  [347] "3.94472098350525"      "2.31832098960876"     
##  [349] "-0.8988196849823"      "-0.456904113292694"   
##  [351] "1.14149904251099"      "0.88521808385849"     
##  [353] "0.383520603179932"     "1.05034399032593"     
##  [355] "7.45873498916626"      "3.80122089385986"     
##  [357] "4.78779602050781"      "1.39738798141479"     
##  [359] "1.3138769865036"       "2.79602003097534"     
##  [361] NA                      NA                     
##  [363] NA                      NA                     
##  [365] NA                      NA                     
##  [367] "-4.96666479110718"     "4.07242822647095"     
##  [369] NA                      NA                     
##  [371] NA                      "0.708745121955872"    
##  [373] "2.40773606300354"      "1.94578397274017"     
##  [375] "-10.3872699737549"     "5.96428918838501"     
##  [377] NA                      NA                     
##  [379] NA                      NA                     
##  [381] "-5.59492206573486"     "2.99222588539124"     
##  [383] "-0.171969696879387"    "3.40066289901733"     
##  [385] "3.61945009231567"      "7.36879301071167"     
##  [387] "1.07719302177429"      "2.63228702545166"     
##  [389] "-3.28754496574402"     "2.84644794464111"     
##  [391] "1.20209503173828"      "0.970816373825073"    
##  [393] NA                      NA                     
##  [395] NA                      NA                     
##  [397] NA                      "1.05525302886963"     
##  [399] "3.93201589584351"      "-3.21616911888123"    
##  [401] "4.73689079284668"      "7.16723823547363"     
##  [403] "16.5501194000244"      "-6.77873516082764"    
##  [405] "-1.01798796653748"     "-2.10908389091492"    
##  [407] "-0.353410392999649"    "2.57015895843506"     
##  [409] "4.69689178466797"      "5.03716087341309"     
##  [411] "6.50001382827759"      "5.43166303634644"     
##  [413] "3.30306792259216"      "-2.86599588394165"    
##  [415] "-28.6469497680664"     "-4.51692008972168"    
##  [417] "-0.522322118282318"    "1.11465799808502"     
##  [419] "-3.66044592857361"     "-1.23413598537445"    
##  [421] "-2.73518800735474"     "1.47134101390839"     
##  [423] "1.17373394966125"      "1.84769296646118"     
##  [425] NA                      NA                     
##  [427] NA                      NA                     
##  [429] NA                      "1.59904003143311"     
##  [431] "0.242217406630516"     "2.46337509155273"     
##  [433] NA                      NA                     
##  [435] NA                      NA                     
##  [437] NA                      NA                     
##  [439] NA                      NA                     
##  [441] "1.21750402450562"      "0.668221771717072"    
##  [443] "3.85739898681641"      "0.567205309867859"    
##  [445] "-0.0224996004253626"   "0.10661269724369"     
##  [447] "-0.817636370658875"    "-1.08668100833893"    
##  [449] NA                      "0.0150364004075527"   
##  [451] "-0.490708291530609"    "1.11069202423096"     
##  [453] "1.39360797405243"      "0.819001317024231"    
##  [455] "1.04226195812225"      "4.06430816650391"     
##  [457] NA                      NA                     
##  [459] NA                      NA                     
##  [461] NA                      "-1.82448101043701"    
##  [463] "2.66165208816528"      "26.5303001403809"     
##  [465] NA                      NA                     
##  [467] NA                      "3.59771203994751"     
##  [469] "4.88645792007446"      "6.39036703109741"     
##  [471] "0.882798194885254"     "3.01777005195618"     
##  [473] "2.93966698646545"      "3.45127296447754"     
##  [475] "3.18854188919067"      "1.0202260017395"      
##  [477] "-3.98230910301208"     "0.393354505300522"    
##  [479] "1.29408097267151"      "1.39975094795227"     
##  [481] "2.32587695121765"      "0.39542880654335"     
##  [483] "3.06157803535461"      "-0.644715070724487"   
##  [485] "-5.37816715240479"     "-1.54970097541809"    
##  [487] "4.63909721374512"      "6.5012640953064"      
##  [489] "4.43551301956177"      "8.47462844848633"     
##  [491] "5.88242101669312"      "6.74822092056274"     
##  [493] "3.09963202476501"      "7.53200912475586"     
##  [495] "4.24637794494629"      "2.21412301063538"     
##  [497] "1.72238898277283"      "2.32215094566345"     
##  [499] "2.13529396057129"      "1.07531702518463"     
##  [501] "-1.55905103683472"     "0.840950489044189"    
##  [503] "0.83852082490921"      "0.0928208976984024"   
##  [505] NA                      NA                     
##  [507] NA                      NA                     
##  [509] NA                      NA                     
##  [511] "-13.6328096389771"     "8.31409454345703"     
##  [513] "-1.37829804420471"     "0.942742228507996"    
##  [515] "1.55557096004486"      "2.48322200775146"     
##  [517] "-2.33036994934082"     "-1.69793605804443"    
##  [519] "-4.73783493041992"     "-2.09729194641113"    
##  [521] "6.14919900894165"      "5.49412679672241"     
##  [523] "4.16618919372559"      "2.27043390274048"     
##  [525] "1.79133498668671"      "2.00491690635681"     
##  [527] "-4.51558399200439"     "2.93773007392883"     
##  [529] "3.47140598297119"      "5.65246105194092"     
##  [531] "4.76182317733765"      "6.06195306777954"     
##  [533] "3.1262629032135"       "4.81129121780396"     
##  [535] "6.24838590621948"      "5.34774398803711"     
##  [537] NA                      NA                     
##  [539] NA                      NA                     
##  [541] NA                      NA                     
##  [543] NA                      NA                     
##  [545] "2.00245189666748"      "-0.466479986906052"   
##  [547] "2.5040500164032"       "1.13525605201721"     
##  [549] "2.90289688110352"      "4.33250999450684"     
##  [551] "2.17659902572632"      "4.92785120010376"     
##  [553] NA                      NA                     
##  [555] "3.79502105712891"      "-11.706130027771"     
##  [557] "3.66562294960022"      "-5.13784503936768"    
##  [559] "5.6669659614563"       "1.53735494613647"     
##  [561] "1.36633896827698"      "2.27948689460754"     
##  [563] "5.28793478012085"      "-5.64704608917236"    
##  [565] "0.398855596780777"     "-8.84823894500732"    
##  [567] "-42.4681701660156"     NA                     
##  [569] "2.36475396156311"      "4.82806205749512"     
##  [571] "-4.42069387435913"     "-2.30702209472656"    
##  [573] "-2.10268211364746"     "4.06408977508545"     
##  [575] "3.20168089866638"      "-1.11161303520203"    
##  [577] NA                      NA                     
##  [579] "11.3614101409912"      "9.2970142364502"      
##  [581] "1.46830499172211"      "-4.7981390953064"     
##  [583] "0.519546926021576"     "0.792876899242401"    
##  [585] NA                      NA                     
##  [587] NA                      NA                     
##  [589] NA                      NA                     
##  [591] "-7.29827213287354"     "-3.47734308242798"    
##  [593] "5.06668996810913"      "6.43116188049316"     
##  [595] "0.44065061211586"      "2.04477405548096"     
##  [597] "-1.26268494129181"     "2.63969111442566"     
##  [599] "-1.47444999217987"     "0.76910799741745"     
##  [601] NA                      NA                     
##  [603] NA                      NA                     
##  [605] NA                      "4.35058689117432"     
##  [607] "-8.70969390869141"     "-3.26625299453735"    
##  [609] NA                      NA                     
##  [611] NA                      NA                     
##  [613] NA                      "4.42059087753296"     
##  [615] "1.76826095581055"      "2.04906988143921"     
##  [617] NA                      "8.44931411743164"     
##  [619] "3.15541195869446"      "-16.2851295471191"    
##  [621] "0.933585524559021"     "-0.461129993200302"   
##  [623] "-0.766093492507935"    "1.12572598457336"     
##  [625] NA                      NA                     
##  [627] NA                      "5.88123893737793"     
##  [629] "4.82420301437378"      "9.64471340179443"     
##  [631] "3.64768409729004"      "5.88086223602295"     
##  [633] "8.67764568328857"      "6.34028720855713"     
##  [635] "6.90310287475586"      "3.51975011825562"     
##  [637] "6.76730489730835"      "8.59601593017578"     
##  [639] "6.25260019302368"      "6.09232711791992"     
##  [641] "-2.62131500244141"     "-3.62430191040039"    
##  [643] "-7.83344411849976"     "-9.99575424194336"    
##  [645] "-4.17056179046631"     "3.49908900260925"     
##  [647] "30.4606094360352"      "-3.28795289993286"    
##  [649] NA                      NA                     
##  [651] NA                      NA                     
##  [653] "1.94844496250153"      "1.20233905315399"     
##  [655] "3.24015593528748"      "4.68279790878296"     
##  [657] NA                      NA                     
##  [659] NA                      NA                     
##  [661] NA                      "-43.6414489746094"    
##  [663] "16.7665901184082"      "3.74042296409607"     
##  [665] "3.57918906211853"      "0.366108894348145"    
##  [667] "-0.916648387908936"    "-2.62355804443359"    
##  [669] "-4.7599778175354"      "-3.57762694358826"    
##  [671] NA                      NA                     
##  [673] "14.5546798706055"      "-7.1710958480835"     
##  [675] "1.78953802585602"      "-4.62523603439331"    
##  [677] "-9.2100248336792"      "-5.37103414535522"    
##  [679] NA                      NA                     
##  [681] NA                      NA                     
##  [683] NA                      "1.84842598438263"     
##  [685] "1.242506980896"        "7.9545841217041"      
##  [687] "7.43935489654541"      "-0.00819330010563135" 
##  [689] "3.83247709274292"      "1.27287697792053"     
##  [691] "2.9803900718689"       "4.01924610137939"     
##  [693] "3.34021902084351"      "1.20965802669525"     
##  [695] "4.3031759262085"       "4.02405500411987"     
##  [697] "0.877061188220978"     "6.1889181137085"      
##  [699] "5.32616806030273"      "2.5272970199585"      
##  [701] "1.45434105396271"      "3.60064506530762"     
##  [703] "2.56655192375183"      "4.2796049118042"      
##  [705] NA                      NA                     
##  [707] NA                      NA                     
##  [709] NA                      "6.26854610443115"     
##  [711] "-8.70884418487549"     "1.5412529706955"      
##  [713] "5.84941816329956"      "5.77201700210571"     
##  [715] "4.42203617095947"      "3.07332301139832"     
##  [717] "2.62297391891479"      "3.8405909538269"      
##  [719] "-14.5819101333618"     "4.14634799957275"     
##  [721] NA                      NA                     
##  [723] NA                      NA                     
##  [725] "2.58849811553955"      "4.67619705200195"     
##  [727] "5.82497215270996"      "-0.0147468997165561"  
##  [729] "3.78326797485352"      "1.49864101409912"     
##  [731] "5.05167198181152"      "-0.260800302028656"   
##  [733] "2.66584897041321"      "2.46865701675415"     
##  [735] "-0.470849812030792"    "1.66721999645233"     
##  [737] NA                      NA                     
##  [739] NA                      "-1.59245300292969"    
##  [741] "2.57762098312378"      "3.202064037323"       
##  [743] "-12.1786499023438"     "-8.94585132598877"    
##  [745] "2.13245892524719"      "-1.18182098865509"    
##  [747] "-1.88328301906586"     "-2.89739799499512"    
##  [749] "-2.10718393325806"     "-0.118810698390007"   
##  [751] "-2.49362111091614"     "-1.11600399017334"    
##  [753] NA                      NA                     
##  [755] NA                      NA                     
##  [757] "12.034930229187"       "5.93102884292603"     
##  [759] "4.83983898162842"      "7.19558620452881"     
##  [761] "2.92375493049622"      "3.30810809135437"     
##  [763] "1.85634398460388"      "6.47309589385986"     
##  [765] "-1.78422200679779"     "-1.06635701656342"    
##  [767] "1.82965099811554"      "0.895736217498779"    
##  [769] NA                      NA                     
##  [771] NA                      NA                     
##  [773] NA                      NA                     
##  [775] NA                      NA                     
##  [777] NA                      NA                     
##  [779] NA                      NA                     
##  [781] NA                      NA                     
##  [783] "-7.21922397613525"     "-0.877090215682983"   
##  [785] "-0.36950820684433"     "1.13608598709106"     
##  [787] "5.34635400772095"      "-2.1004900932312"     
##  [789] "-0.866727828979492"    "-0.742359697818756"   
##  [791] "-1.18991100788116"     "1.82623398303986"     
##  [793] "8.13265991210938"      "7.8987889289856"      
##  [795] "12.930230140686"       "6.38842391967773"     
##  [797] "2.76549196243286"      "5.17369985580444"     
##  [799] "4.48334693908691"      "4.30853700637817"     
##  [801] "-1.07312905788422"     "0.317726910114288"    
##  [803] "3.0118989944458"       "4.25713109970093"     
##  [805] "2.47391605377197"      "-4.83802223205566"    
##  [807] "2.67501497268677"      "4.76524782180786"     
##  [809] NA                      NA                     
##  [811] NA                      NA                     
##  [813] "3.65874791145325"      "3.44375610351562"     
##  [815] "-7.5948429107666"      "2.3912250995636"      
##  [817] NA                      NA                     
##  [819] NA                      "2.27314591407776"     
##  [821] "-8.96984767913818"     "5.82056283950806"     
##  [823] "-0.0363567993044853"   "4.79279899597168"     
##  [825] "1.63104903697968"      "-0.137346893548965"   
##  [827] "1.01778101921082"      "0.239416196942329"    
##  [829] "-2.24805402755737"     "1.09143698215485"     
##  [831] "-0.511766612529755"    "1.54647994041443"     
##  [833] "-2.14071011543274"     "4.42056894302368"     
##  [835] "8.28848552703857"      "-0.715756297111511"   
##  [837] "3.42984199523926"      "6.62195205688477"     
##  [839] "4.60324811935425"      "3.92249703407288"     
##  [841] "3.55877709388733"      "3.29655408859253"     
##  [843] "2.55763697624207"      "-0.897992074489594"   
##  [845] "0.791649699211121"     "-1.68822002410889"    
##  [847] "2.18222999572754"      "2.34967303276062"     
##  [849] "3.35728597640991"      "5.5767822265625"      
##  [851] "4.66049718856812"      "5.12054395675659"     
##  [853] "2.01496911048889"      "3.29332494735718"     
##  [855] "6.56011915206909"      "6.4362678527832"      
##  [857] NA                      NA                     
##  [859] NA                      NA                     
##  [861] NA                      NA                     
##  [863] NA                      NA                     
##  [865] NA                      NA                     
##  [867] NA                      "-0.841239094734192"   
##  [869] "-2.88134908676147"     "-1.41798198223114"    
##  [871] "0.32148739695549"      "2.72795701026917"     
##  [873] "-3.95665597915649"     "-6.07031202316284"    
##  [875] "0.558988392353058"     "1.57957601547241"     
##  [877] "-6.02579689025879"     "0.392607808113098"    
##  [879] "-4.07587099075317"     "-0.278855413198471"   
##  [881] "-1.90421497821808"     "8.98757457733154"     
##  [883] "2.29072594642639"      "-4.89860820770264"    
##  [885] "-3.18720698356628"     "1.75781905651093"     
##  [887] "1.59903299808502"      "-0.46229749917984"    
##  [889] "1.23058998584747"      "0.0625917986035347"   
##  [891] "3.60190200805664"      "-8.94463539123535"    
##  [893] "-3.39308500289917"     "-6.16921806335449"    
##  [895] "-2.77501201629639"     "1.50365102291107"     
##  [897] "0.723061501979828"     "-0.96612012386322"    
##  [899] "1.72464799880981"      "1.11046695709229"     
##  [901] "1.98038494586945"      "2.26582598686218"     
##  [903] "2.31685709953308"      "3.04114294052124"     
##  [905] NA                      NA                     
##  [907] NA                      NA                     
##  [909] NA                      NA                     
##  [911] NA                      NA                     
##  [913] "40.8900413513184"      "-0.147384703159332"   
##  [915] "9.61046695709229"      "0.502548277378082"    
##  [917] "9.66587352752686"      "-1.02373099327087"    
##  [919] "1.38723695278168"      "0.522801399230957"    
##  [921] "3.09520888328552"      "1.7443710565567"      
##  [923] "1.0235470533371"       "4.40724802017212"     
##  [925] "3.69533801078796"      "3.42448306083679"     
##  [927] "2.33454704284668"      "0.992188513278961"    
##  [929] "4.83270883560181"      "3.64757490158081"     
##  [931] "-0.870679497718811"    "3.68400192260742"     
##  [933] "0.0451476015150547"    "-4.45558786392212"    
##  [935] "5.75281190872192"      "1.23918199539185"     
##  [937] "1.23847699165344"      "1.72555100917816"     
##  [939] "0.977603614330292"     "1.45569801330566"     
##  [941] "-3.34409999847412"     "-2.60908198356628"    
##  [943] "-1.45327198505402"     "5.85511589050293"     
##  [945] "1.83594405651093"      "2.97869110107422"     
##  [947] "3.06968402862549"      "2.19119095802307"     
##  [949] "-4.59817314147949"     "2.73132991790771"     
##  [951] "-1.02489805221558"     "2.76575088500977"     
##  [953] NA                      NA                     
##  [955] NA                      NA                     
##  [957] NA                      NA                     
##  [959] NA                      NA                     
##  [961] "3.15442895889282"      "4.80628108978271"     
##  [963] "-2.52631211280823"     "-0.546463787555695"   
##  [965] "-0.788684189319611"    "-0.268194407224655"   
##  [967] "7.009202003479"        "-0.971498429775238"   
##  [969] NA                      NA                     
##  [971] NA                      NA                     
##  [973] NA                      NA                     
##  [975] "-0.493448585271835"    "6.11890316009521"     
##  [977] "5.83199977874756"      "5.25332880020142"     
##  [979] "0.570033013820648"     "2.58005809783936"     
##  [981] "0.678140580654144"     "5.16221809387207"     
##  [983] "2.13840889930725"      "1.85230505466461"     
##  [985] NA                      NA                     
##  [987] NA                      NA                     
##  [989] NA                      NA                     
##  [991] NA                      NA                     
##  [993] "1.75170195102692"      "3.54825901985168"     
##  [995] "5.1135139465332"       "8.09428310394287"     
##  [997] "-2.7758150100708"      "0.959528088569641"    
##  [999] "-0.0160165000706911"   "0.357951611280441"    
## [1001] NA                      NA                     
## [1003] "9.91883563995361"      "2.97588491439819"     
## [1005] "3.58228588104248"      "-2.6834568977356"     
## [1007] "-6.06457185745239"     "2.46492695808411"     
## [1009] "6.89157104492188"      "6.41557884216309"     
## [1011] "4.73148584365845"      "2.80962109565735"     
## [1013] "2.36909699440002"      "1.70141494274139"     
## [1015] "-7.94114303588867"     "-4.60422277450562"    
## [1017] "4.68546581268311"      "-0.476021289825439"   
## [1019] "1.8778840303421"       "5.40701580047607"     
## [1021] "-1.15519094467163"     "-0.377885788679123"   
## [1023] "-4.33224821090698"     "-0.010792899876833"   
## [1025] "4.84997892379761"      "11.2483797073364"     
## [1027] "2.61005902290344"      "1.05575203895569"     
## [1029] "-9.30862331390381"     "-1.91534197330475"    
## [1031] "1.89728605747223"      "-1.496297955513"      
## [1033] "-2.06171202659607"     "-1.78191494941711"    
## [1035] "9.33734512329102"      "-3.41764211654663"    
## [1037] "-3.23487401008606"     "-0.528763473033905"   
## [1039] "1.55215096473694"      "7.97111511230469"     
## [1041] "-2.30906009674072"     "-0.54978621006012"    
## [1043] "1.57619798183441"      "-3.09972310066223"    
## [1045] "1.47070300579071"      "0.252915799617767"    
## [1047] "-1.53851401805878"     "1.80838394165039"     
## [1049] "10.6210699081421"      "10.6844596862793"     
## [1051] "4.88420104980469"      "7.02868604660034"     
## [1053] "3.43369102478027"      "6.46443605422974"     
## [1055] "5.58955097198486"      "5.34061193466187"     
## [1057] "-2.29353594779968"     "-5.69586801528931"    
## [1059] "6.89556503295898"      "6.59678602218628"     
## [1061] "1.31138002872467"      "5.11844921112061"     
## [1063] "0.888914108276367"     "0.39388981461525"     
## [1065] "1.2785929441452"       "1.84348595142365"     
## [1067] "-0.776953876018524"    "1.47523295879364"     
## [1069] "-2.42659497261047"     "1.1508150100708"      
## [1071] "-5.40798091888428"     "-7.02225017547607"    
## [1073] "1.16740500926971"      "1.46750497817993"     
## [1075] "2.46668910980225"      "-6.91153001785278"    
## [1077] "-1.3878790140152"      "0.0990376994013786"   
## [1079] "3.8381199836731"       "2.39254403114319"     
## [1081] "1.11750495433807"      "2.9004340171814"      
## [1083] "0.3260557949543"       "-5.87516689300537"    
## [1085] "2.07992601394653"      "1.82716202735901"     
## [1087] "-7.92679882049561"     NA                     
## [1089] NA                      NA                     
## [1091] NA                      NA                     
## [1093] NA                      "-0.935894191265106"   
## [1095] "-1.35573899745941"     "-0.82549387216568"    
## [1097] NA                      "0.623181283473969"    
## [1099] "5.77184200286865"      "0.532129883766174"    
## [1101] "-5.25788497924805"     "0.287483304738998"    
## [1103] "0.628739416599274"     "6.20793104171753"     
## [1105] NA                      NA                     
## [1107] NA                      NA                     
## [1109] "2.88234901428223"      "1.93653094768524"     
## [1111] "-7.03674602508545"     "5.72625303268433"     
## [1113] NA                      "6.51728105545044"     
## [1115] "1.52995800971985"      "1.10252594947815"     
## [1117] "-0.161750495433807"    "7.87900304794312"     
## [1119] "0.699913799762726"     "0.522710084915161"    
## [1121] "0.0978450030088425"    "7.60976696014404"     
## [1123] "1.73334205150604"      "4.7028489112854"      
## [1125] "2.99185490608215"      "4.17947721481323"     
## [1127] "5.05726289749146"      "0.605839014053345"    
## [1129] "2.49776196479797"      "2.07287096977234"     
## [1131] "9.78007411956787"      "5.10148906707764"     
## [1133] "-2.14197206497192"     "-2.60536909103394"    
## [1135] "5.11299610137939"      "2.79615688323975"     
## [1137] "-0.441256791353226"    "-3.78765511512756"    
## [1139] "2.80039691925049"      "-8.84302139282227"    
## [1141] "8.2991247177124"       "1.09704899787903"     
## [1143] "-3.37820410728455"     "1.23007905483246"     
## [1145] "3.27983808517456"      "0.294197112321854"    
## [1147] "1.43515205383301"      "1.79889094829559"     
## [1149] "-2.80882596969604"     "0.0398952998220921"   
## [1151] "-7.17973899841309"     "6.1057767868042"      
## [1153] "5.3435001373291"       "4.5598521232605"      
## [1155] "4.34096002578735"      "4.32642602920532"     
## [1157] "3.52266693115234"      "8.3519458770752"      
## [1159] "7.52584218978882"      "4.96914482116699"     
## [1161] NA                      NA                     
## [1163] NA                      NA                     
## [1165] NA                      "-0.624012172222137"   
## [1167] "-15.1129999160767"     "-13.5715303421021"    
## [1169] NA                      NA                     
## [1171] NA                      NA                     
## [1173] NA                      "0.873853385448456"    
## [1175] "-8.63786506652832"     "-13.221830368042"     
## [1177] NA                      NA                     
## [1179] NA                      NA                     
## [1181] "3.66172099113464"      "0.773128926753998"    
## [1183] "1.72529900074005"      "1.79751801490784"     
## [1185] "3.73024606704712"      "2.29303407669067"     
## [1187] "5.84377908706665"      "5.83600807189941"     
## [1189] "0.339262694120407"     "-3.81345391273499"    
## [1191] "-0.409815192222595"    "3.06485795974731"     
## [1193] "2.56393003463745"      "6.26123094558716"     
## [1195] "4.31523084640503"      "3.70955491065979"     
## [1197] "1.31122398376465"      "-0.507994472980499"   
## [1199] "3.28708410263062"      "2.9241418838501"      
## [1201] "1.66259396076202"      "2.22832202911377"     
## [1203] "4.32515621185303"      "-1.00848805904388"    
## [1205] "2.39248991012573"      "2.56683707237244"     
## [1207] "4.2938551902771"       "2.41875600814819"     
## [1209] NA                      NA                     
## [1211] NA                      NA                     
## [1213] NA                      NA                     
## [1215] NA                      NA                     
## [1217] NA                      NA                     
## [1219] NA                      NA                     
## [1221] NA                      "0.623758494853973"    
## [1223] "-0.355357885360718"    "0.441580295562744"    
## [1225] NA                      NA                     
## [1227] NA                      NA                     
## [1229] "-1.2060170173645"      "1.94807302951813"     
## [1231] "2.48286008834839"      "4.70688390731812"     
## [1233] NA                      NA                     
## [1235] NA                      NA                     
## [1237] NA                      "2.74115204811096"     
## [1239] "-9.84831523895264"     "-11.3817701339722"    
## [1241] "0.881250083446503"     "-0.000787900004070252"
## [1243] "3.22519898414612"      "4.11518001556396"     
## [1245] "-5.53957176208496"     "4.26492500305176"     
## [1247] "2.83315110206604"      "3.36162209510803"     
## [1249] NA                      NA                     
## [1251] NA                      NA                     
## [1253] NA                      "3.23582291603088"     
## [1255] "-5.1761908531189"      "-2.3223340511322"     
## [1257] NA                      NA                     
## [1259] NA                      "4.79625797271729"     
## [1261] "4.37442493438721"      "6.106116771698"       
## [1263] "2.49204301834106"      "2.46636199951172"     
## [1265] "-0.177173301577568"    "0.979534327983856"    
## [1267] "1.16609704494476"      "-3.48333191871643"    
## [1269] "-3.4360020160675"      "-0.631627976894379"   
## [1271] "3.06852006912231"      "-0.184321492910385"   
## [1273] NA                      "1.96435594558716"     
## [1275] "-2.5895140171051"      "4.94218015670776"     
## [1277] "-1.52824103832245"     "5.54130792617798"     
## [1279] NA                      NA                     
## [1281] NA                      NA                     
## [1283] NA                      NA                     
## [1285] "1.75197803974152"      "2.27361488342285"     
## [1287] "4.78369808197021"      "7.08965587615967"     
## [1289] NA                      NA                     
## [1291] NA                      "-5.28605318069458"    
## [1293] "3.42228198051453"      "-1.9953099489212"     
## [1295] "2.57933902740479"      "-1.89432299137115"    
## [1297] NA                      NA                     
## [1299] NA                      NA                     
## [1301] NA                      NA                     
## [1303] NA                      "-3.67827391624451"    
## [1305] NA                      NA                     
## [1307] NA                      "-2.03723788261414"    
## [1309] "0.952617824077606"     "1.75709497928619"     
## [1311] "-1.29141294956207"     "1.41490995883942"     
## [1313] NA                      NA                     
## [1315] NA                      NA                     
## [1317] NA                      NA                     
## [1319] "-1.12690103054047"     "3.63846898078918"     
## [1321] NA                      NA                     
## [1323] NA                      NA                     
## [1325] NA                      NA                     
## [1327] NA                      "8.68245029449463"     
## [1329] "3.21515107154846"      "2.46655511856079"     
## [1331] "-0.0681848973035812"   "3.45825099945068"     
## [1333] "-3.33301496505737"     "-0.0720150023698807"  
## [1335] "-2.58043003082275"     "1.1786949634552"      
## [1337] "1.75756800174713"      "0.974066615104675"    
## [1339] "-4.30820512771606"     "-2.99745011329651"    
## [1341] "-1.31399595737457"     "-1.59732902050018"    
## [1343] "-12.6932697296143"     "-5.57616281509399"    
## [1345] "-2.11640691757202"     "0.426189690828323"    
## [1347] "-1.7027759552002"      "-1.63803195953369"    
## [1349] "-3.82258296012878"     "-0.78723818063736"    
## [1351] "-1.78421998023987"     "-2.87209391593933"    
## [1353] "2.70010900497437"      "6.97800922393799"     
## [1355] "-3.4215259552002"      "3.41039490699768"     
## [1357] "-1.45409405231476"     "0.448615908622742"    
## [1359] "-1.4605530500412"      "3.58385396003723"
```

**Oppgave:** Opprett tre nye variabler i datasettet ditt ved å omkode klassen til tre valgfrier variabler, velg også navn selv. Bruk `mutate()`.

### Omkoding med ifelse()

Den funksjonen jeg bruker mest til omkoding, er `ifelse()`. Syntaksen til denne funksjonen kan forklares som følger:


```r
data$nyvar <- ifelse(test = my_data$my.variabel=="some logical condition",
       yes  = "what to return if 'some condition' is TRUE",
       no   = "what to return if 'some condition' is FALSE")
```

**Oppgave:** Opprett en ny variabel som får verdien 1 dersom de har positiv verdi på variabelen policy, og negativ verdi på variabelen policy2 - hvor mange slike observasjoner finnes? Hint: Her kan du bruke `&` for å binde sammen to logiske tester. Du kan også bruke `ifelse()` inne i `mutate()` - jeg viser et eksempel under.


### Endre datatstruktur ved hjelp av aggregering:

Tenk deg at vi ønsket å opprette en ny variabel, `relative_neighborhood_growth`, som viser differansen mellom et lands vekst i en periode, og gjennomsnittsveksten til alle land i samme region over hele tidsperioden. Dette høres kanskje fryktelig komplisert ut, og mangler en god teoretisk begrunnelse. Vi kan imidlertid finne informasjonen vi er på jakt etter ganske enkelt ved hjelp av funksjonene `group_by()` og `summarise()`. Først må vi imidlertid opprette en region-variabel - fordi informasjon om hvilken region et land tilhører er spredt ut over tre variabler - `elrssa`, `elrcentam` og `elreasia`. La oss bruke `ifelse()` og `mutate()` til dette:



```r
aid <- aid %>% # Forteller at vi skal jobbe med aid-datasettet
       mutate(region = ifelse(elrssa == 1, "Sub-Saharan Africa",
                               ifelse(elrcentam == 1, "Central America",
                               ifelse(elreasia == 1, "East Asia", "Other"))))
# Her nøster jeg ifelse-funksjoner inne i hverandre, ved å skrive en ifelse() funksjon som det som skal gjøres med observasjoner som får FALSE på at de ligger i Afrika sør for Sahara, osv. La oss sjekke omkodingen med en tabell
table(aid$region)
```

```
## 
##    Central America          East Asia              Other 
##                 56                 64                856 
## Sub-Saharan Africa 
##                384
```

```r
table(aid$elrssa) # ser at det er like mange land - kunne gjort det samme for resten av kategoriene
```

```
## 
##   0   1 
## 976 384
```
La oss se hvordan `group_by()` og `summarise()` fungerer:


```r
aid %>%
   group_by(region) %>% # grupperer observasjoner basert på verdi på region-variabelen. Alle observasjoner med lik verdi (uavh. av tidsperiode) blir gruppert sammen.
   summarise(neigh_growth = mean(elrgdpg, na.rm = T)) # regner gjennomsnitt for økonomisk vekst innad i hver gruppe - for hele tidsperioden data dekker sett under ett
```

```
## # A tibble: 4 x 2
##   region             neigh_growth
##   <chr>                     <dbl>
## 1 Central America           1.08 
## 2 East Asia                 5.10 
## 3 Other                     1.33 
## 4 Sub-Saharan Africa        0.717
```

```r
# Samme kode, men lagrer som et objekt - vi får et nytt datasett der vi har endret observasjonene - nå er det regioner som er observasjoner
agg_aid <- aid %>%
group_by(region) %>%
summarise(neigh_growth = mean(elrgdpg, na.rm = T))

# Litt annen kode - aggregerer til datasett der observasjonene er regions-perioder
agg_aid <- aid %>%
group_by(region, period) %>%
summarise(region_growth = mean(elrgdpg, na.rm = T))

# Endelig versjon - legger til en variabel som teller hvor mange land som finnes i hver gruppe:

agg_aid <- aid %>%
group_by(region) %>%
summarise(region_growth = mean(elrgdpg, na.rm = T),
          n_region = n()) # teller antall observasjoner i gruppene med n()
```

Nå har vi informasjonen vi trenger - men vi har ikke lagt den til det opprinnelige datasettet som en variabel. Dette kan vi gjøre ved hjelp av en `join` funksjon som slår sammen informasjon fra to datasett. Mer om `join` i senere seminar, og [her](https://r4ds.had.co.nz/relational-data.html).


```r
aid <- aid %>% left_join(agg_aid)
```

```
## Joining, by = "region"
```

```r
# left_join er en av flere join funksjoner. Siden begge datasett har en variabel som heter region, brukes denne til å matche de to datasettene. All informasjon i agg_aid legges til aid

# Ser på resultatet:
table(aid$region_growth, aid$region)
```

```
##                   
##                    Central America East Asia Other Sub-Saharan Africa
##   0.71703294443541               0         0     0                384
##   1.07525226560288              56         0     0                  0
##   1.33109037684893               0         0   856                  0
##   5.09593167688165               0        64     0                  0
```

```r
table(aid$n_region, aid$region)
```

```
##      
##       Central America East Asia Other Sub-Saharan Africa
##   56               56         0     0                  0
##   64                0        64     0                  0
##   384               0         0     0                384
##   856               0         0   856                  0
```

Disse formene for omkoding og opprettelse av nye variabler kan fort være aktuelle for hjemmeoppgaven.

## Utforsking av data og deskriptiv statistikk <a name="deskriptiv"></a>

Disse funksjonene fungerer gir unviariat statistikk for kontinuerlige variabler:


```r
min(aid$elrgdpg, na.rm = TRUE)  # minimumsverdi, na.rm = T spesifiserer at missing skal droppes i beregning.
```

```
## [1] -43.64145
```

```r
max(aid$elrgdpg, na.rm = TRUE)  # maksimumsverdi
```

```
## [1] 56.08551
```

```r
mean(aid$elrgdpg, na.rm = TRUE) # gjennomsnitt
```

```
## [1] 1.330477
```

```r
median(aid$elrgdpg, na.rm =T )  # median
```

```
## [1] 1.662594
```

```r
sd(aid$elrgdpg, na.rm = T)      # standardavvik
```

```
## [1] 5.397031
```

```r
var(aid$elrgdpg, na.rm = T)     # varians
```

```
## [1] 29.12795
```

```r
#install.packages("moments")
library(moments)
skewness(aid$elrgdpg) # skjevhet - fra moments
```

```
## [1] NA
```

```r
kurtosis(aid$elrgdpg) # kurtose - fra moments
```

```
## [1] NA
```

```r
summary(aid$elrgdpg) # forskjellig deskriptiv staatistikk for en variabel
```

```
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max.     NA's 
## -43.6414  -0.8739   1.6626   1.3305   3.8164  56.0855      369
```

```r
summary(aid)            # deskriptiv statistikk for alle variabler i datasettet
```

```
##    country              period      periodstart     periodend   
##  Length:1360        Min.   :1.00   Min.   :1966   Min.   :1969  
##  Class :character   1st Qu.:2.75   1st Qu.:1973   1st Qu.:1976  
##  Mode  :character   Median :4.50   Median :1980   Median :1983  
##                     Mean   :4.50   Mean   :1980   Mean   :1983  
##                     3rd Qu.:6.25   3rd Qu.:1987   3rd Qu.:1990  
##                     Max.   :8.00   Max.   :1994   Max.   :1997  
##                                                                 
##      code               bdgdpg            elrgdpg             bdgdp      
##  Length:1360        Min.   :-56.4871   Min.   :-43.6414   Min.   :  294  
##  Class :character   1st Qu.: -0.9493   1st Qu.: -0.8739   1st Qu.:  885  
##  Mode  :character   Median :  1.6893   Median :  1.6626   Median : 1712  
##                     Mean   :  1.1635   Mean   :  1.3305   Mean   : 2500  
##                     3rd Qu.:  4.0273   3rd Qu.:  3.8164   3rd Qu.: 3320  
##                     Max.   : 62.8700   Max.   : 56.0855   Max.   :24322  
##                     NA's   :471        NA's   :369        NA's   :633    
##      elrgdp           bdbb             elrbb             bdinfl       
##  Min.   :  270   Min.   :-0.5775   Min.   :-0.4503   Min.   :-0.1667  
##  1st Qu.:  899   1st Qu.:-0.0603   1st Qu.:-0.0556   1st Qu.: 0.0454  
##  Median : 1780   Median :-0.0284   Median :-0.0284   Median : 0.0938  
##  Mean   : 2622   Mean   :-0.0385   Mean   :-0.0361   Mean   : 0.1770  
##  3rd Qu.: 3431   3rd Qu.:-0.0073   3rd Qu.:-0.0083   3rd Qu.: 0.1566  
##  Max.   :24322   Max.   : 0.3951   Max.   : 0.4776   Max.   : 3.8784  
##  NA's   :471     NA's   :764       NA's   :655       NA's   :660      
##     elrinfl            bdsacw          elrsacw         bdethnf      
##  Min.   :-0.0633   Min.   :0.0000   Min.   :0.000   Min.   :0.0000  
##  1st Qu.: 0.0489   1st Qu.:0.0000   1st Qu.:0.000   1st Qu.:0.1600  
##  Median : 0.0959   Median :0.0000   Median :0.000   Median :0.5500  
##  Mean   : 0.2055   Mean   :0.2105   Mean   :0.267   Mean   :0.4725  
##  3rd Qu.: 0.1723   3rd Qu.:0.0000   3rd Qu.:0.750   3rd Qu.:0.7225  
##  Max.   : 3.8784   Max.   :1.0000   Max.   :1.000   Max.   :0.9300  
##  NA's   :569       NA's   :758      NA's   :611     NA's   :952     
##     elrethnf         bdassas           elrassas          bdicrge     
##  Min.   :0.0000   Min.   : 0.0000   Min.   : 0.0000   Min.   :2.271  
##  1st Qu.:0.1675   1st Qu.: 0.0000   1st Qu.: 0.0000   1st Qu.:3.603  
##  Median :0.5350   Median : 0.0000   Median : 0.0000   Median :4.553  
##  Mean   :0.4694   Mean   : 0.3172   Mean   : 0.2157   Mean   :4.706  
##  3rd Qu.:0.7225   3rd Qu.: 0.2500   3rd Qu.: 0.0000   3rd Qu.:5.578  
##  Max.   :0.9300   Max.   :11.5000   Max.   :11.5000   Max.   :8.560  
##  NA's   :656      NA's   :936       NA's   :297       NA's   :976    
##     elricrge         bdm21             elrm21            bdssa       
##  Min.   :1.580   Min.   :  6.855   Min.   :  2.716   Min.   :0.0000  
##  1st Qu.:3.082   1st Qu.: 19.848   1st Qu.: 17.091   1st Qu.:0.0000  
##  Median :4.700   Median : 26.035   Median : 24.025   Median :0.0000  
##  Mean   :4.687   Mean   : 30.834   Mean   : 30.714   Mean   :0.1867  
##  3rd Qu.:5.900   3rd Qu.: 36.555   3rd Qu.: 36.800   3rd Qu.:0.0000  
##  Max.   :9.600   Max.   :159.364   Max.   :167.482   Max.   :1.0000  
##  NA's   :528     NA's   :950       NA's   :587       NA's   :310     
##      elrssa          bddn1900        elrdn1900           bdaid        
##  Min.   :0.0000   Min.   :0.0000   Min.   :-1.0000   Min.   :-0.0080  
##  1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:-1.0000   1st Qu.: 0.2733  
##  Median :0.0000   Median :0.0000   Median : 0.0000   Median : 1.3247  
##  Mean   :0.2824   Mean   :0.2467   Mean   :-0.3455   Mean   : 2.5963  
##  3rd Qu.:1.0000   3rd Qu.:0.0000   3rd Qu.: 0.0000   3rd Qu.: 3.6661  
##  Max.   :1.0000   Max.   :1.0000   Max.   : 0.0000   Max.   :24.8543  
##                   NA's   :310      NA's   :480       NA's   :748      
##      elraid             bdlpop         elrlpop         bdeasia       
##  Min.   :-12.7330   Min.   :12.08   Min.   :10.17   Min.   :0.00000  
##  1st Qu.:  0.1785   1st Qu.:14.95   1st Qu.:14.03   1st Qu.:0.00000  
##  Median :  0.9166   Median :15.85   Median :15.31   Median :0.00000  
##  Mean   :  1.9607   Mean   :15.91   Mean   :15.13   Mean   :0.04667  
##  3rd Qu.:  2.8420   3rd Qu.:16.95   3rd Qu.:16.40   3rd Qu.:0.00000  
##  Max.   : 18.9440   Max.   :20.59   Max.   :20.91   Max.   :1.00000  
##  NA's   :629        NA's   :928     NA's   :92      NA's   :310      
##     elreasia          bdegypt          elregypt           bdcentam     
##  Min.   :0.00000   Min.   :0.0000   Min.   :0.000000   Min.   :0.0000  
##  1st Qu.:0.00000   1st Qu.:0.0000   1st Qu.:0.000000   1st Qu.:0.0000  
##  Median :0.00000   Median :0.0000   Median :0.000000   Median :0.0000  
##  Mean   :0.04706   Mean   :0.0116   Mean   :0.005882   Mean   :0.0833  
##  3rd Qu.:0.00000   3rd Qu.:0.0000   3rd Qu.:0.000000   3rd Qu.:0.0000  
##  Max.   :1.00000   Max.   :1.0000   Max.   :1.000000   Max.   :1.0000  
##                    NA's   :928                         NA's   :928     
##    elrcentam           bdfrz           elrfrz           bdarms1       
##  Min.   :0.00000   Min.   :0.000   Min.   :0.00000   Min.   :  0.000  
##  1st Qu.:0.00000   1st Qu.:0.000   1st Qu.:0.00000   1st Qu.:  0.325  
##  Median :0.00000   Median :0.000   Median :0.00000   Median :  1.350  
##  Mean   :0.04118   Mean   :0.125   Mean   :0.07647   Mean   :  4.921  
##  3rd Qu.:0.00000   3rd Qu.:0.000   3rd Qu.:0.00000   3rd Qu.:  4.250  
##  Max.   :1.00000   Max.   :1.000   Max.   :1.00000   Max.   :116.350  
##                    NA's   :928                       NA's   :935      
##     elrarms1       originalcountries    bddatap           bddatao        
##  Min.   :-0.2984   Min.   :0.0000    Min.   :-4.5035   Min.   :0.000000  
##  1st Qu.: 0.0032   1st Qu.:0.0000    1st Qu.: 0.6747   1st Qu.:0.000000  
##  Median : 0.0160   Median :0.0000    Median : 0.9944   Median :0.000000  
##  Mean   : 0.0668   Mean   :0.3294    Mean   : 1.2596   Mean   :0.003677  
##  3rd Qu.: 0.0513   3rd Qu.:1.0000    3rd Qu.: 1.6105   3rd Qu.:0.000000  
##  Max.   : 2.4612   Max.   :1.0000    Max.   : 4.5245   Max.   :1.000000  
##  NA's   :526                         NA's   :944                         
##  elrdatabdcos7093bdvarsp elrdatabdcos7093bdvarso elrdatabdcos7097bdvarsp
##  Min.   :-5.074          Min.   :0.0000          Min.   :-5.136         
##  1st Qu.: 0.904          1st Qu.:0.0000          1st Qu.: 1.012         
##  Median : 1.084          Median :0.0000          Median : 1.241         
##  Mean   : 1.570          Mean   :0.0219          Mean   : 1.491         
##  3rd Qu.: 3.221          3rd Qu.:0.0000          3rd Qu.: 2.648         
##  Max.   : 3.841          Max.   :1.0000          Max.   : 3.594         
##  NA's   :873             NA's   :1086            NA's   :873            
##  elrdatabdcos7097bdvarso elrdata7093bdvarsp elrdata7093bdvarso
##  Min.   :0.0000          Min.   :-5.048     Min.   :0.00      
##  1st Qu.:0.0000          1st Qu.: 0.852     1st Qu.:0.00      
##  Median :0.0000          Median : 1.135     Median :0.00      
##  Mean   :0.0373          Mean   : 1.494     Mean   :0.03      
##  3rd Qu.:0.0000          3rd Qu.: 2.867     3rd Qu.:0.00      
##  Max.   :1.0000          Max.   : 4.072     Max.   :1.00      
##  NA's   :1038            NA's   :873        NA's   :1060      
##  elrdata7097bdvarsp elrdata7097bdvarso     policy           policy2       
##  Min.   :-5.3453    Min.   :0.0000     Min.   :-0.0895   Min.   :-0.0949  
##  1st Qu.: 0.9723    1st Qu.:0.0000     1st Qu.: 0.0552   1st Qu.:-0.0006  
##  Median : 1.2896    Median :0.0000     Median : 0.2116   Median : 0.0000  
##  Mean   : 1.4182    Mean   :0.0309     Mean   : 0.5163   Mean   :-0.0018  
##  3rd Qu.: 2.3485    3rd Qu.:0.0000     3rd Qu.: 1.0320   3rd Qu.: 0.0000  
##  Max.   : 3.7832    Max.   :1.0000     Max.   : 3.3147   Max.   : 0.0139  
##  NA's   :873        NA's   :1004       NA's   :873       NA's   :873      
##     region          region_growth      n_region    
##  Length:1360        Min.   :0.717   Min.   : 56.0  
##  Class :character   1st Qu.:0.717   1st Qu.:384.0  
##  Mode  :character   Median :1.331   Median :856.0  
##                     Mean   :1.324   Mean   :652.5  
##                     3rd Qu.:1.331   3rd Qu.:856.0  
##                     Max.   :5.096   Max.   :856.0  
## 
```

For bivariat eller multivariat deskriptiv statistikk, ser vi gjerne på korrelasjon (pearsons R). Med funksjonen `cor()` kan vi få bivariat korrelasjon mellom to variabler, eller lage bivariate korrelasjoner mellom alle numeriske variabler i datasettet vårt:


```r
cor(aid$elrgdpg, aid$elraid, use = "pairwise.complete.obs") # argumentet use bestemmer missing-håndtering
```

```
## [1] -0.09172658
```

```r
aid         # sjekker hvilke variabler som er numeriske, str(aid hvis du ikke har en tibble)
```

```
## # A tibble: 1,360 x 57
##    country period periodstart periodend code  bdgdpg elrgdpg bdgdp elrgdp
##    <chr>    <dbl>       <dbl>     <dbl> <chr>  <dbl>   <dbl> <dbl>  <dbl>
##  1 AFG          1        1966      1969 AFG1      NA -0.0131    NA     NA
##  2 AFG          2        1970      1973 AFG2      NA -0.550     NA     NA
##  3 AFG          3        1974      1977 AFG3      NA  2.24      NA     NA
##  4 AFG          4        1978      1981 AFG4      NA -1.09      NA     NA
##  5 AFG          5        1982      1985 AFG5      NA  0.804     NA     NA
##  6 AFG          6        1986      1989 AFG6      NA NA         NA     NA
##  7 AFG          7        1990      1993 AFG7      NA NA         NA     NA
##  8 AFG          8        1994      1997 AFG8      NA NA         NA     NA
##  9 AGO          1        1966      1969 AGO1      NA NA       1066   1066
## 10 AGO          2        1970      1973 AGO2      NA NA       1165   1165
## # ... with 1,350 more rows, and 48 more variables: bdbb <dbl>,
## #   elrbb <dbl>, bdinfl <dbl>, elrinfl <dbl>, bdsacw <dbl>, elrsacw <dbl>,
## #   bdethnf <dbl>, elrethnf <dbl>, bdassas <dbl>, elrassas <dbl>,
## #   bdicrge <dbl>, elricrge <dbl>, bdm21 <dbl>, elrm21 <dbl>, bdssa <dbl>,
## #   elrssa <dbl>, bddn1900 <dbl>, elrdn1900 <dbl>, bdaid <dbl>,
## #   elraid <dbl>, bdlpop <dbl>, elrlpop <dbl>, bdeasia <dbl>,
## #   elreasia <dbl>, bdegypt <dbl>, elregypt <dbl>, bdcentam <dbl>,
## #   elrcentam <dbl>, bdfrz <dbl>, elrfrz <dbl>, bdarms1 <dbl>,
## #   elrarms1 <dbl>, originalcountries <dbl>, bddatap <dbl>, bddatao <dbl>,
## #   elrdatabdcos7093bdvarsp <dbl>, elrdatabdcos7093bdvarso <dbl>,
## #   elrdatabdcos7097bdvarsp <dbl>, elrdatabdcos7097bdvarso <dbl>,
## #   elrdata7093bdvarsp <dbl>, elrdata7093bdvarso <dbl>,
## #   elrdata7097bdvarsp <dbl>, elrdata7097bdvarso <dbl>, policy <dbl>,
## #   policy2 <dbl>, region <chr>, region_growth <dbl>, n_region <int>
```

```r
aid %>%
select(1:13) %>%
head() # velger de substansielle numeriske variablene i datasettet
```

```
## # A tibble: 6 x 13
##   country period periodstart periodend code  bdgdpg elrgdpg bdgdp elrgdp
##   <chr>    <dbl>       <dbl>     <dbl> <chr>  <dbl>   <dbl> <dbl>  <dbl>
## 1 AFG          1        1966      1969 AFG1      NA -0.0131    NA     NA
## 2 AFG          2        1970      1973 AFG2      NA -0.550     NA     NA
## 3 AFG          3        1974      1977 AFG3      NA  2.24      NA     NA
## 4 AFG          4        1978      1981 AFG4      NA -1.09      NA     NA
## 5 AFG          5        1982      1985 AFG5      NA  0.804     NA     NA
## 6 AFG          6        1986      1989 AFG6      NA NA         NA     NA
## # ... with 4 more variables: bdbb <dbl>, elrbb <dbl>, bdinfl <dbl>,
## #   elrinfl <dbl>
```

```r
aid %>%
select(6:13) %>%
cor(, use = "pairwise.complete.obs")  # korrelasjonsmatrise basert på numeriske variabler
```

```
##                bdgdpg      elrgdpg        bdgdp        elrgdp        bdbb
## bdgdpg   1.0000000000  0.945978221 -0.044538487  0.0001539001  0.05196675
## elrgdpg  0.9459782214  1.000000000  0.004423129  0.0188800071  0.09323997
## bdgdp   -0.0445384873  0.004423129  1.000000000  1.0000000000  0.20930475
## elrgdp   0.0001539001  0.018880007  1.000000000  1.0000000000  0.19978944
## bdbb     0.0519667519  0.093239975  0.209304751  0.1997894430  1.00000000
## elrbb    0.0451870871  0.084099280  0.195031938  0.1982491736  0.82348412
## bdinfl  -0.3190177401 -0.304478935  0.021410578  0.0255177880 -0.17885826
## elrinfl -0.3597406832 -0.326107615  0.030734035 -0.0095472030 -0.20026225
##               elrbb      bdinfl      elrinfl
## bdgdpg   0.04518709 -0.31901774 -0.359740683
## elrgdpg  0.08409928 -0.30447893 -0.326107615
## bdgdp    0.19503194  0.02141058  0.030734035
## elrgdp   0.19824917  0.02551779 -0.009547203
## bdbb     0.82348412 -0.17885826 -0.200262255
## elrbb    1.00000000 -0.16782050 -0.170226117
## bdinfl  -0.16782050  1.00000000  0.994029552
## elrinfl -0.17022612  0.99402955  1.000000000
```

```r
# Sjekk hva use = argumentet styrer i hjelpefilen
```


En av variablene i datasettet vårt, `aid$country`, er ikke kontinuerlig. Ved å ta `str(aid)`, ser vi at denne variabelen er kodet som en faktor. Dette innebærer at den vil behandles som en nominalnivå-variabel i statistisk analyse. For kategoriske variabler, er tabeller nyttig:


```r
table(aid$country)      # frekvenstabell
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
prop.table(table(aid$country)) # prosentfordeling basert på frekvenstabell
```

```
## 
##         AFG         AGO         ALB         ARE         ARG         ARM 
## 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 
##         ASM         ATG         AZE         BDI         BEN         BFA 
## 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 
##         BGD         BGR         BHR         BHS         BIH         BLR 
## 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 
##         BLZ         BOL         BRA         BRB         BRN         BTN 
## 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 
##         BWA         CAF         CHL         CHN         CIV         CMR 
## 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 
##         COG         COK         COL         COM         CPV         CRI 
## 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 
##         CSK         CUB         CZE         DJI         DMA         DOM 
## 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 
##         DZA         ECU         EGY         ERI         EST         ETH 
## 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 
##         FJI         FSM         GAB         GEO         GHA         GIN 
## 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 
##         GLP         GMB         GNB         GNQ         GRD         GTM 
## 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 
##         GUY         HKG         HND         HRV         HTI         HUN 
## 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 
##         IDN         IMY         IND         IRN         IRQ         JAM 
## 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 
##         JOR         KAZ         KEN         KGZ         KHM         KIR 
## 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 
##         KNA         KOR         KWT         LAO         LBN         LBR 
## 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 
##         LBY         LCA         LKA         LSO         LTU         LVA 
## 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 
##         MAC         MAR         MDA         MDG         MDV         MEX 
## 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 
##         MHL         MKD         MLI         MLT         MMR         MNG 
## 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 
##         MOZ         MRT         MUS         MWI         MYS         MYT 
## 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 
##         NAM         NER         NGA         NIC         NPL         NRU 
## 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 
##         OMN         PAK         PAN         PER         PHL         PLW 
## 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 
##         PNG         POL         PRI         PRK         PRY         ROM 
## 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 
##         RUS         RWA         SAU         SDN         SEN         SGP 
## 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 
##         SLB         SLE         SLV         SOM         STP         SUR 
## 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 
##         SVK         SWZ         SYC         SYR         TCD         TGO 
## 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 
##         THA         TJK         TKM         TON         TTO         TUN 
## 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 
##         TUR         TWN         TZA         UGA         UKR         URY 
## 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 
##         UZB         VCT         VEN         VIR         VNM         VUT 
## 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 
##         WBG         WSM         YEM         YUG         ZAF         ZAR 
## 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 0.005882353 
##         ZMB         ZWE 
## 0.005882353 0.005882353
```

Vi kan også lage tabeller med flere variabler. Under viser jeg hvordan du lager en tabell fordelingen av observasjoner som har høyere vekst enn medianveksten i utvalget, ved hjelp av en logisk test:

```r
table(aid$elrgdpg>median(aid$elrgdpg,na.rm=T))
```

```
## 
## FALSE  TRUE 
##   496   495
```

```r
table(aid$elrgdpg>median(aid$elrgdpg,na.rm=T), aid$country)
```

```
##        
##         AFG AGO ALB ARE ARG ARM ASM ATG AZE BDI BEN BFA BGD BGR BHR BHS
##   FALSE   4   4   3   6   5   1   0   0   3   5   6   6   4   2   4   5
##   TRUE    1   1   2   0   3   1   0   5   0   3   2   2   4   3   1   3
##        
##         BIH BLR BLZ BOL BRA BRB BRN BTN BWA CAF CHL CHN CIV CMR COG COK
##   FALSE   0   2   2   5   3   3   5   0   0   7   3   1   4   5   4   0
##   TRUE    1   1   6   3   5   5   1   5   8   1   5   7   4   3   4   0
##        
##         COL COM CPV CRI CSK CUB CZE DJI DMA DOM DZA ECU EGY ERI EST ETH
##   FALSE   1   4   1   3   0   0   1   3   0   2   3   5   4   1   2   2
##   TRUE    7   1   3   5   0   1   1   0   0   6   5   3   4   1   3   2
##        
##         FJI FSM GAB GEO GHA GIN GLP GMB GNB GNQ GRD GTM GUY HKG HND HRV
##   FALSE   4   2   4   3   7   2   0   7   6   1   1   5   4   0   5   1
##   TRUE    4   1   4   5   1   1   0   1   1   2   4   3   4   8   3   1
##        
##         HTI HUN IDN IMY IND IRN IRQ JAM JOR KAZ KEN KGZ KHM KIR KNA KOR
##   FALSE   7   1   0   0   2   3   5   4   4   2   4   2   0   5   0   0
##   TRUE    1   7   8   0   6   3   2   4   2   0   4   1   3   2   5   8
##        
##         KWT LAO LBN LBR LBY LCA LKA LSO LTU LVA MAC MAR MDA MDG MDV MEX
##   FALSE   6   1   1   5   4   2   2   2   2   1   1   3   3   7   0   3
##   TRUE    2   3   2   1   2   3   6   6   1   7   3   5   2   1   4   5
##        
##         MHL MKD MLI MLT MMR MNG MOZ MRT MUS MWI MYS MYT NAM NER NGA NIC
##   FALSE   0   2   6   0   3   1   2   8   2   3   0   0   4   8   5   7
##   TRUE    0   0   2   8   5   3   3   0   6   5   8   0   1   0   3   1
##        
##         NPL NRU OMN PAK PAN PER PHL PLW PNG POL PRI PRK PRY ROM RUS RWA
##   FALSE   3   0   5   2   4   6   2   0   5   1   2   0   4   2   2   5
##   TRUE    5   0   3   6   4   2   6   0   3   1   6   0   4   4   6   3
##        
##         SAU SDN SEN SGP SLB SLE SLV SOM STP SUR SVK SWZ SYC SYR TCD TGO
##   FALSE   4   6   7   0   5   7   5   4   3   5   1   5   2   2   6   5
##   TRUE    4   2   1   8   3   1   3   3   0   2   3   2   6   6   2   3
##        
##         THA TJK TKM TON TTO TUN TUR TWN TZA UGA UKR URY UZB VCT VEN VIR
##   FALSE   0   3   3   1   3   2   2   0   3   1   2   3   2   0   7   2
##   TRUE    8   0   0   3   5   6   6   0   0   3   1   5   1   5   1   3
##        
##         VNM VUT WBG WSM YEM YUG ZAF ZAR ZMB ZWE
##   FALSE   0   3   1   4   1   0   5   7   8   4
##   TRUE    4   2   0   1   1   1   3   1   0   4
```

De fleste land har vekst både over og under medianen. Dersom det hadde vært svært lite variasjon i veksten til land, ville kontrollvariabler for land kunne ha fjernet effekten av de fleste variabler - vi ville ikke hatt veldig godt datagrunnlag for å si så mye om effekten av bistand i samspill med policy (jeg sier ikke dermed nødvendigvis at dataene er gode generelt).


## Plotte-funksjonen `ggplot` <a name="ggplot"></a>


Hadley Wickham fra R studio skriver mange veldig gode tilleggspakker til R (i tillegg til gratis innføringsbøker på nett), blant annet pakken `ggplot2` (det kan være forvirrende at pakken heter `ggplot2`, mens funksjonen heter `ggplot()`). Jeg foretrekker å lage plot med `ggplot()` funksjonen fra ggplot2 over `plot()` fra *base* R. Grunnen til dette er først og fremst fordi jeg liker syntaksen bedre, og at jeg har brukt `ggplot()` mest, det er ingenting galt med `plot()`. Dersom jeg  bare vil ha et svært enkelt scatterplot bruker jeg ofte `plot()`. Med det sagt, her er de nødvendige elementene man må spesifisere i syntaksen til `ggplot()`:


```r
ggplot(data = my_data) +
  geom_point(aes(x = x-axis_var_name, y = y-axis_var_name, col=my.var3)))
```

Vi starter med å fortelle ggplot hvilket datasett vi bruker. Deretter bruker vi en `geom_...()`-funksjon, her `geom_point()` (det er en lang rekke alternativer), for å fortelle hvordan vi vil plotte data. Her har vi valgt å plotte data som punkter, dvs. lage et scatterplot. Vi må også spesifisere hvilke variabler fra datasettet vi vil plotte, etter `aes()` for aesthetics. Vi må minst velge å plotte en akse, som regel vil vi plotte minst to akser. Vi kan også velge å legge til argumentet `col` for å visualisere enda en variabel. Dette argumentet gir ulike farger til observasjonen avhengig av verdien de har på variabelen vi spesifiserte. Det finnes også alternative måter å visualisere mer enn to variabler, som f.eks. `size = my.var3`, eller `shape = my.var3`.

Vi legger til nye argumer til plottet vårt med `+`. Etter at vi har spesifisert datasett, geom og aesthetics må vi ikke legge til flere argumenter, men det er mulig å legge til flere elementer (som en regresjonslinje) eller finjustere plottet i det uendelige (f.eks. angi fargekoder for alle farger i plottet manuelt). Man får imidlertid som regel et godt resultat med et par linjer kode. Vi skal se raskt på 3 `geom()`

1. `geom_histogram` - histogram (et godt alternativ kan være å bruke `geom_bar()`)
2. `geom_boxplot()` - box-whiskers plot
3. `geom_point()`   - scatterplot


```r
library(ggplot2)
ggplot(aid) + geom_histogram(aes(x = elrgdpg), bins = 50) # lager histogram
```

Med et boxplot får du raskt oversikt over fordelingen til variabler innenfor ulike grupper.



```r
ggplot(aid) + geom_boxplot(aes(x = as_factor(region), y = elraid))
```

**Oppgave:** Lag boxplot som viser fordelingen til variablene `policy` og `elrgpdg` innenfor hver region.

Her viser jeg fordelingen til vekst (`elrgdpg`) opp mot bistand (`elraid`) og makroøkonomisk politikk (`policy`) ved hjelp av et spredningsplot (scatterplot)


```r
ggplot(aid) + geom_point(aes(x = elraid, y = elrgdpg, col = policy))
```

```
## Warning: Removed 669 rows containing missing values (geom_point).
```

![](Seminar1_files/figure-html/unnamed-chunk-28-1.png)<!-- -->





Her er et overlesset eksempel på et scatterplot (poenget er å illustrere muligheter, ikke å lage et pent plot):


```r
library(ggplot2)
ggplot(aid) +
  geom_point(aes(x=aid, y=elrgdpg, col=policy, shape=as_factor(sub_saharan_africa))) +
  geom_smooth(aes(x=aid, y=elrgdpg), method="lm") +  # merk: geom_smooth gir bivariat regresjon
  ggtitle("Visualization of relationship between aid and growth to showcase ggplot") +
  xlab("aid") +
  ylab("growth") +
  theme_minimal()
```

![](../pics/sem1gg3.png)<!-- -->


**Oppgave:** Forsøk å legge til `facet_wrap(~sub_saharan_africa)`, hva gjør dette argumentet? Hvordan kan det være nyttig for å plotte samspill? Forsøk å fjerne ett og ett argument i plottet over for å se hva argumentene gjør.

Dersom du lager et plot du er fornøyd med, kan du lagre det med `ggsave()`, som lagrer ditt siste ggplot.

```r
ggsave("testplot.png", width = 8, height = 5) # lagrer ditt siste ggplot i det formatet du vil på working directory
```
Mulighetene er endeløse, jeg har bare vist dere noen få muligheter her. Ved hjelp av [cheatsheet til ggplot2](https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf) og [annen dokumentasjon](http://zevross.com/blog/2014/08/04/beautiful-plotting-in-r-a-ggplot2-cheatsheet-3/) som dere kan google dere frem til, burde dere finne metoder for å lage akkurat det plottet dere ønsker.


## Takk for i dag!
