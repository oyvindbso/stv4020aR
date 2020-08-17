# Første R-Seminar
Erlend Langørgen  
28 august 2017  





## Introduksjon til R for 4020 A

Velkommen til innføring i R!

**Mål for i dag:**

1. Få R og Rstudio til å virke på egen PC.
2. Gå frem i passelig tempo
3. Forstå hvordan R-studio er satt opp.
4. Forstå grunnleggende konsepter i R: indeksering, objekter, funksjoner m.m.
5. Lage noen fine figurer
6. Intro til hjelpefiler

Format: jeg går raskt gjennom et tema, dere løser småoppgaver etterpå.

Notasjon: alt som er skrevet som `"dette"` er R-kode.



## Er det noen som ikke har lastet ned R og Rstudio?

Dersom du ikke har gjennomført [installasjonsguiden](https://github.com/martigso/stv4020aR/blob/master/Gruppe%201/scripts/for_R_introduksjon.md), ta en titt på den nå. 

Dersom du har gjennomført installasjonsguiden, uten å ha fått Rstudio til å virke, rekk opp en hånd.


## Min første R-kode, console og script

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


**Oppgave:** Skriv kode i scriptet ditt for å teste om `"R"` er forskjellig fra `"SPSS"` ved hjelp av logiske utsagn (to fremgangsmåter er mulig). Sjekk deretter om `3` er større eller lik den naturlige logaritmen av `20`. Avslutt med å teste om `36*36` og `144*9` er lik `1296`.
 

```r
## Din løsning i script!
```



## Objekter 

Objekter er grunnleggende byggesteiner i R. Vi kan lagre ulike typer informasjon, som regresjonskoeffisienter, tekst og tall i objekter. Vi kan også lage objekter som representerer en enkelt verdi. Vi lager objekter ved hjelp av `<-` :


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

Vi kan også gi navn til objekter med `=`. Jeg oppfordrer dere imidlertid instendig til å alltid bruke `<-` for å gi navn til objekter, **alle** følger denne konvensjonen. 


En enda viktigere konvensjon er objektnavn. Feilskriving av objektnavn er en av de største kildene til frustrasjon og feil i R. Hold derfor navn korte, forståelige og enkle. Unngå gjerne store bokstaver, samt ikke-engelske bokstaver. Du kan lese flere gode råd [her](https://google.github.io/styleguide/Rguide.xml).


### Variabler

Det er mulig å opprette mange forskjellige objekttyper i R. Over laget vi objekter som representerte en enkelt tallverdi. Vi kan også lage objekter som inneholder flere verdier. Den enkleste objekttypen med flere verdier, er vektorer. I R kan en vektor defineres som en ordnet liste av verdier, dvs. at man lagrer verdier i en bestemt rekkefølge. Tenk på vektorer som variabler. Det finnes flere måter å lage vektorer på:


```r
## Ved å bruke parenteser rundt denne koden oppretter jeg objektet samtidig som jeg printer
## innholdet i objektet i console.
(x <- 1:5)  # med : teller vi på heltall mellom de to tallene
```

```
## [1] 1 2 3 4 5
```

```r
(y <- c(1, 2, 4, gull, 5))  # med c() kan vi kombinere ulike tall/informasjon i den rekkefølgen vi vil. Vi kan også kombinere verdier fra objekter som 'gull'
```

```
## [1] 1 2 4 3 5
```
Legg merke til at vi nå har overskrevet de tidligere verdiene til x og y, uten at R gir oss noen advarsel. Dette illustrerer viktigheten av å gi navn på en lur måte.  

Vi kan også bruke `c()` til å lage vektorer med forskjellige typer innhold, som tekst. 

```r
z <- c(1, 2, "tre", "fire", 5)
```

Vi kan utføre matematiske operasjoner på vektorer som bare består av tall. Her er noen eksempler:

```r
x * y
```

```
## [1]  1  4 12 12 25
```

```r
x + y
```

```
## [1]  2  4  7  7 10
```

```r
x * 2
```

```
## [1]  2  4  6  8 10
```
Dette fungerer naturlig nok ikke på vektorer som inneholder andre typer verdier enn tall. Forsøk `x*z` for å kontrollere. En vektor som bare består av en type verdier (f.eks, bare tall), kalles **atomic vector**. En vektor som består av forskjellige typer verdier (f.eks. både tall og tekst) kalles **list**.

**Oppgave:** Lag en vektor `w`, bestående av heltall fra 6 til 2 i synkende rekkefølge. Bruk deretter matematiske operasjoner på variabelen for å få den til å bli lik variabelen `a`, gitt ved `a <- 1:5`. Test om du har fått det til ved å printe verdiene til variablene, samt en logisk test. Snakk med naboen. Hint: `*` og `+`



### Ulike typer vektorer i R - grov inndeling:    

------------------------------------------------------------

atomic vector | List
------------- | -------------
numeric       | Blanding
integer       | 
character     | 
factor        | 
logical       |


En hyppig årsak til at kode ikke fungerer, er at en vektor/variable ikke er i det formatet vi forventet. Dette fører ofte til uønskede resultater. Tabellen over gir en oversikt over variabeltypene vi skal jobbe med. Atomci vector har kun verdier av en type, mens lister kan ha flere typer verdier, samt bestå av flere variabler.

Hvilket format tror dere x, y og z har? Vi kan sjekke med funksjonen `class`. 

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

Oppgave:

Opprett vektoren karaktersnitt, bestående av verdiene `6`, `5` og `4`. Transformer deretter variabelen til `factor` med `as.factor()`. Sjekk at transformasjonen virket med `class()`. Hva skjer dersom du forsøker å transformere variabelen direkte tilbake til tallverdier med `as.numeric()` (inspiser verdiene)? Diskuter med sidemannen, og se om du klarer å løse eventuelle problemer ved ytterligere transformasjoner av klasse.



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

## Datasett 
Dersom man har en rekke variabler (vektorer), kan man lage datasett. I dette seminaret fokuserer vi heretter på datasett, som utgjør klassen "data.frame". Siden det stort sett er datasett som brukes til statistisk analyse, er det denne objekt-klassen vi skal jobbe mest med i seminarene. 

Dere kan tenke på datasett som et sett av vektorer limt sammen i kolonner, der hver rad er en observasjon (for eksempel masterstudented i statsvitenskap ved UiO). Vi kan lage vårt eget datasett av en samling vektorer på følgende måte:

```r
test_data <- data.frame(x = c(rep(1, 5), rep(0, 5)), y = seq(2, 20, 2), z = rnorm(10), w = "tekst", 
    q = c(1, 2))
```

Legg merke til at de tre første vektorene har en lengde på 10, mens de to siste har en lengde på henholdsvis 1 og 2. R fyller inn verdier basert på strukturen til disse variablene slik at de kan slåes sammen med de lengre variablene. Som regel fungerer R slik at du må spesifisere nøyaktig det du vil ha for å få output, men noen ganger tolker R den gale koden din i beste mening, og gir deg output du egentlig ikke ønsker. Hva skjer dersom vi forsøker å inkludere variabelen `s = c(1,2,3)`? Diskuter med naboene dine om hva som foregår.


Kjør følgende kode for å laste inn deres første 'ordentlige' datasett i R:

```r
beer <- read.csv("https://raw.githubusercontent.com/martigso/stv4020aR/master/Gruppe%201/data/beer.csv")
```

Her bruker vi funksjonen `read.csv()` for å laste inn en klassisk excel-fil fra en url (nettside). Funksjonen ville også fungert om vi erstattet urlen med en filsti på pcen. Det finnes andre funksjoner for å laste inn alle mulige typer filer, vi skal lære mer om dette i senere seminar.

Her er noen nyttige funksjoner for å lære mer om datasett:

```r
class(beer)  # Er dette faktisk en data.frame, eller et annet type objekt?
```

```
## [1] "data.frame"
```

```r
colnames(beer)  # denne funksjonen forteller deg kolonnenavn i datasettet.
```

```
##  [1] "state"   "year"    "mrall"   "beertax" "mlda"    "jaild"   "comserd"
##  [8] "vmiles"  "unrate"  "perinc"
```

```r
head(beer, 5)  # denne funksjonen viser deg de første observasjonene i datasettet.
```

```
##   state year   mrall  beertax  mlda jaild comserd   vmiles unrate   perinc
## 1     1 1982 2.12836 1.539379 19.00    no      no 7.233887   14.4 10544.15
## 2     1 1983 2.34848 1.788991 19.00    no      no 7.836348   13.7 10732.80
## 3     1 1984 2.33643 1.714286 19.00    no      no 8.262990   11.1 11108.79
## 4     1 1985 2.19348 1.652542 19.67    no      no 8.726917    8.9 11332.63
## 5     1 1986 2.66914 1.609907 21.00    no      no 8.952854    9.8 11661.51
```

```r
tail(beer, 5)  # denne funksjonen viser deg de siste observasjonene i datasettet.
```

```
##     state year   mrall    beertax mlda jaild comserd    vmiles unrate
## 332    56 1984 3.06043 0.04945055 19.0   yes      no  9.994155    6.3
## 333    56 1985 2.98625 0.04766949 19.0   yes      no 10.611011    7.1
## 334    56 1986 3.31361 0.04643963 19.0   yes      no 10.619331    9.0
## 335    56 1987 2.63265 0.04500000 19.0   yes      no 10.953050    8.6
## 336    56 1988 3.23591 0.04331088 19.5   yes      no 11.812115    6.3
##       perinc
## 332 13456.04
## 333 13595.34
## 334 13126.93
## 335 12719.00
## 336 13098.17
```

```r
str(beer)  # denne funksjonen beskriver strukturen til et objekt.
```

```
## 'data.frame':	336 obs. of  10 variables:
##  $ state  : int  1 1 1 1 1 1 1 4 4 4 ...
##  $ year   : int  1982 1983 1984 1985 1986 1987 1988 1982 1983 1984 ...
##  $ mrall  : num  2.13 2.35 2.34 2.19 2.67 ...
##  $ beertax: num  1.54 1.79 1.71 1.65 1.61 ...
##  $ mlda   : num  19 19 19 19.7 21 ...
##  $ jaild  : Factor w/ 2 levels "no","yes": 1 1 1 1 1 1 1 2 2 2 ...
##  $ comserd: Factor w/ 2 levels "no","yes": 1 1 1 1 1 1 1 2 2 2 ...
##  $ vmiles : num  7.23 7.84 8.26 8.73 8.95 ...
##  $ unrate : num  14.4 13.7 11.1 8.9 9.8 ...
##  $ perinc : num  10544 10733 11109 11333 11662 ...
```
Dere kan også åpne datasettet ved å trykke på `View` i toppmenyen, skriv evt. `View(my_data)`, men ikke lagre denne kommandoen i scriptet ditt som en hovedregel.



  
### Indeksering
Indeksering lar oss spesifisere et eller flere elementer i et objekt. For å indeksere et objekt skriver vi enten 

1. `objektnavn$x`
2. `objektnavn[x]`
3. `objektnavn[[x]]`

der `x` spesifiserer hvilke del av et objekt vi er interessert i. Disse metodene fungerer generelt, men virker litt forskjellig (forskjellene avhenger delvis av objekttype). I tillegg finnes det en rekke funksjoner som kan være til hjelp ved noen typer indeksering, jeg kommer til å bruke funksjoner fra pakken `dplyr`. Dersom du får problemer med indeksering finner du mer informasjon om indekseringsmetodene [her](https://cran.r-project.org/doc/manuals/r-release/R-lang.html#Indexing). Lister kan for eksempel være litt utfordrende å jobbe med, men [her](http://r4ds.had.co.nz/lists.html) er en god forklaring av hvordan det fungerer. Generelt kan vi bruke funksjonen `str()` til å lære om hvordan et objekt er strukturert, og hvordan det kan indekseres.

Vi skal i hovedsak indeksere variabler og datasett. Jeg skal derfor vise dere noen effektive måter å gjøre dette på:

For vektorer/variabler, skal vi bruke `[]` som utgangspunkt for å indeksere oss frem til verdier/elementer fra et objekt som vi er interessert i. Inne i `[]` kan vi sette ulike funksjoner for å nærmere angi hvilke elementer vi vil hente ut fra et objekt. 

```r
y[4]  # Tallet i '[]', her 4, refererer til 4. element i objektet, ikke tallet 4.
```

```
## [1] 3
```

```r
z[3:4]  # Vi kan bruke : til å velge flere elementer
```

```
## [1] "tre"  "fire"
```

```r
y[c(1, 2, 3, 4)]  # Vi kan også bruke c() til å velge flere elementer
```

```
## [1] 1 2 4 3
```

```r
y[which(y >= 3)]  # which() er en funksjon vi kan bruke til å sette logiske tester inn i [], dette kan være svært nyttig, særlig i store datasett, for å se på observasjoner med spesielle kombinasjoner av variabelverdier
```

```
## [1] 4 3 5
```

Indekseringen av z og y over returnerte nye vektorer. Vi kan dermed bruke indeksering til å opprette nye vektorer. Ved hjelp av funksjonen `c()` kan vi lage en ny versjon av y, der vi endrer på rekkefølgen i vektoren:

```r
x == y  # Vi kan bruke == til å sammenligne verdiene i to vektorer som er like lange
```

```
## [1]  TRUE  TRUE FALSE FALSE  TRUE
```

```r
y <- y[c(1, 2, 4, 3, 5)]
x == y  # Vi ser at y nå er endret, slik at alle verdiene i x og y er like
```

```
## [1] TRUE TRUE TRUE TRUE TRUE
```

For datasett bruker vi `$` til å indeksere enkeltvariabler, mens vi bruker `[]` eller funksjonen `select()` fra pakken `dplyr` til å velge flere variabler samtidig:


Prinsippene for indeksering av vektorer er overførbare til datasett og andre objekttyper, med noen modifikasjoner. I datasett har vi en dimensjon mer enn i en vektor, så for å velge en spesifikk verdi fra et datasett, må vi indeksere i to trinn. I datasett bruker vi `$` for å velge en variabel/vektor. 

```r
beer$mrall
```

```
##   [1] 2.12836 2.34848 2.33643 2.19348 2.66914 2.71859 2.49391 2.49914
##   [9] 2.26738 2.82878 2.80201 3.07106 2.76728 2.70565 2.38405 2.39570
##  [17] 2.23785 2.26367 2.54323 2.67588 2.54697 1.86194 1.80672 1.94611
##  [25] 1.88128 1.94548 1.98966 1.90365 2.17448 2.05144 1.90596 1.79201
##  [33] 1.84630 1.79308 1.50560 1.64695 1.39490 1.48653 1.41147 1.40933
##  [41] 1.39832 1.49706 2.03333 1.81518 2.11726 1.67203 2.14850 2.26708
##  [49] 2.42424 2.53197 2.49768 2.54661 2.49164 2.42004 2.36131 2.49534
##  [57] 2.17484 2.26060 2.41356 2.27744 2.50820 2.56991 2.60643 2.61759
##  [65] 2.66194 2.42242 2.53731 2.57485 2.62525 2.56231 1.43840 1.32800
##  [73] 1.34265 1.32987 1.38170 1.43326 1.58171 1.75269 1.85605 1.68427
##  [81] 1.77123 1.88624 1.90743 1.98164 1.65119 1.76997 1.44678 1.64355
##  [89] 1.54737 1.73253 1.96542 2.06811 1.69345 2.09016 1.98367 2.03335
##  [97] 1.98304 1.93587 2.22523 2.09478 2.02688 1.91090 2.16049 2.26456
## [105] 2.24846 2.48916 2.10088 2.15423 2.07766 2.07157 1.85384 2.09846
## [113] 1.46127 1.95633 2.00692 1.76976 1.82594 1.95451 2.11618 1.49778
## [121] 1.52523 1.47850 1.65984 1.75745 1.79493 1.69191 1.14669 1.12903
## [129] 1.14867 1.27448 1.28900 1.17677 1.23111 1.52682 1.45129 1.69022
## [137] 1.70004 1.75621 1.73587 1.84416 1.38156 1.33896 1.39803 1.45004
## [145] 1.35533 1.24823 1.42094 2.84379 2.76810 2.61355 2.53349 2.93826
## [153] 2.88000 2.75573 1.80089 1.83558 1.93361 1.85126 2.22946 2.04586
## [161] 2.14550 3.15528 3.50490 2.89186 2.69976 2.71726 2.89246 2.45963
## [169] 1.64151 1.59774 1.77570 1.47572 1.81477 1.86324 1.62921 3.18907
## [177] 2.82051 2.71538 2.76709 2.40951 2.60179 2.71347 1.82489 1.99166
## [185] 1.96319 1.91383 1.67478 1.69347 1.52995 1.42799 1.24799 1.22655
## [193] 1.27480 1.36262 1.33342 1.36122 4.21784 3.78745 3.48527 3.68966
## [201] 3.37390 3.78667 3.23159 1.22932 1.17444 1.16082 1.12804 1.19247
## [209] 1.30884 1.25914 2.16589 2.03061 2.35161 2.36930 2.60148 2.46998
## [217] 2.42410 2.20238 1.70338 1.45560 1.31387 1.47275 1.50298 1.55922
## [225] 1.49155 1.47327 1.53259 1.53202 1.55657 1.64318 1.62414 3.26215
## [233] 2.56116 2.40785 2.25386 2.11434 1.82457 1.95558 1.94080 2.06767
## [241] 2.13752 2.08039 2.29090 2.27606 2.44669 1.53127 1.44731 1.45285
## [249] 1.49414 1.59240 1.66471 1.60903 1.10063 1.04603 0.82121 1.12603
## [257] 1.27179 1.14604 1.25881 2.26286 2.59055 2.77408 2.84135 3.13221
## [265] 3.17080 2.97983 2.13256 2.50358 2.02837 1.83616 1.89266 1.88999
## [273] 2.06171 2.26152 2.21156 2.31697 2.31205 2.56250 2.57055 2.58631
## [281] 2.74034 2.41717 2.43238 2.24679 2.13734 1.94234 2.01473 1.89345
## [289] 1.77429 1.94085 1.84195 1.88101 1.76190 1.75740 2.05769 1.79048
## [297] 2.15094 2.14953 2.01479 2.17153 2.31598 1.60503 1.62080 1.79737
## [305] 1.71048 1.94305 1.72934 1.78055 1.74848 1.62137 1.71534 1.68746
## [313] 1.57517 1.71882 1.67384 2.29475 2.16505 2.24500 2.16942 2.29525
## [321] 2.48287 2.45203 1.62242 1.52728 1.72617 1.55812 1.56178 1.65800
## [329] 1.66220 3.94118 3.35271 3.06043 2.98625 3.31361 2.63265 3.23591
```

```r
beer$mrall[5]
```

```
## [1] 2.66914
```
Dersom vi ønsker å opprette en ny variabel i datasettet vårt, må vi indeksere på samme måte:

```r
beer$mrall_cent <- beer$mrall - mean(beer$mrall)  # sentrert versjon av variabelen
str(beer)
```

```
## 'data.frame':	336 obs. of  11 variables:
##  $ state     : int  1 1 1 1 1 1 1 4 4 4 ...
##  $ year      : int  1982 1983 1984 1985 1986 1987 1988 1982 1983 1984 ...
##  $ mrall     : num  2.13 2.35 2.34 2.19 2.67 ...
##  $ beertax   : num  1.54 1.79 1.71 1.65 1.61 ...
##  $ mlda      : num  19 19 19 19.7 21 ...
##  $ jaild     : Factor w/ 2 levels "no","yes": 1 1 1 1 1 1 1 2 2 2 ...
##  $ comserd   : Factor w/ 2 levels "no","yes": 1 1 1 1 1 1 1 2 2 2 ...
##  $ vmiles    : num  7.23 7.84 8.26 8.73 8.95 ...
##  $ unrate    : num  14.4 13.7 11.1 8.9 9.8 ...
##  $ perinc    : num  10544 10733 11109 11333 11662 ...
##  $ mrall_cent: num  0.0879 0.308 0.296 0.153 0.6287 ...
```
Legg merke til at `str` forteller oss også hva slags klasse variablene i datasettet vårt har.

**Oppgave:** Hvordan kan vi velge observasjoner med verdi på variabelen mrall som er høyere enn 3? Bruk en logisk test og `which()`



Vi kan også velge variabler med klammeparentes, `[]`. Husk på at datasett har to dimensjoner, den første dimensjonen er definert som `rows` mens den andre er definert som `columns`. For å velge et element fra columns, den andre dimensjonen, skriver vi `[ , x]`, der x referer til et eller flere element.
For å velge et element fra rows, den første dimensjonen, skriver vi `[x, ]`, der x referer til et eller flere element

```r
dim(beer)  # my_data har 32 rows (observasjoner) og 11 columns (variabler).
```

```
## [1] 336  11
```

```r
beer[, 3]
```

```
##   [1] 2.12836 2.34848 2.33643 2.19348 2.66914 2.71859 2.49391 2.49914
##   [9] 2.26738 2.82878 2.80201 3.07106 2.76728 2.70565 2.38405 2.39570
##  [17] 2.23785 2.26367 2.54323 2.67588 2.54697 1.86194 1.80672 1.94611
##  [25] 1.88128 1.94548 1.98966 1.90365 2.17448 2.05144 1.90596 1.79201
##  [33] 1.84630 1.79308 1.50560 1.64695 1.39490 1.48653 1.41147 1.40933
##  [41] 1.39832 1.49706 2.03333 1.81518 2.11726 1.67203 2.14850 2.26708
##  [49] 2.42424 2.53197 2.49768 2.54661 2.49164 2.42004 2.36131 2.49534
##  [57] 2.17484 2.26060 2.41356 2.27744 2.50820 2.56991 2.60643 2.61759
##  [65] 2.66194 2.42242 2.53731 2.57485 2.62525 2.56231 1.43840 1.32800
##  [73] 1.34265 1.32987 1.38170 1.43326 1.58171 1.75269 1.85605 1.68427
##  [81] 1.77123 1.88624 1.90743 1.98164 1.65119 1.76997 1.44678 1.64355
##  [89] 1.54737 1.73253 1.96542 2.06811 1.69345 2.09016 1.98367 2.03335
##  [97] 1.98304 1.93587 2.22523 2.09478 2.02688 1.91090 2.16049 2.26456
## [105] 2.24846 2.48916 2.10088 2.15423 2.07766 2.07157 1.85384 2.09846
## [113] 1.46127 1.95633 2.00692 1.76976 1.82594 1.95451 2.11618 1.49778
## [121] 1.52523 1.47850 1.65984 1.75745 1.79493 1.69191 1.14669 1.12903
## [129] 1.14867 1.27448 1.28900 1.17677 1.23111 1.52682 1.45129 1.69022
## [137] 1.70004 1.75621 1.73587 1.84416 1.38156 1.33896 1.39803 1.45004
## [145] 1.35533 1.24823 1.42094 2.84379 2.76810 2.61355 2.53349 2.93826
## [153] 2.88000 2.75573 1.80089 1.83558 1.93361 1.85126 2.22946 2.04586
## [161] 2.14550 3.15528 3.50490 2.89186 2.69976 2.71726 2.89246 2.45963
## [169] 1.64151 1.59774 1.77570 1.47572 1.81477 1.86324 1.62921 3.18907
## [177] 2.82051 2.71538 2.76709 2.40951 2.60179 2.71347 1.82489 1.99166
## [185] 1.96319 1.91383 1.67478 1.69347 1.52995 1.42799 1.24799 1.22655
## [193] 1.27480 1.36262 1.33342 1.36122 4.21784 3.78745 3.48527 3.68966
## [201] 3.37390 3.78667 3.23159 1.22932 1.17444 1.16082 1.12804 1.19247
## [209] 1.30884 1.25914 2.16589 2.03061 2.35161 2.36930 2.60148 2.46998
## [217] 2.42410 2.20238 1.70338 1.45560 1.31387 1.47275 1.50298 1.55922
## [225] 1.49155 1.47327 1.53259 1.53202 1.55657 1.64318 1.62414 3.26215
## [233] 2.56116 2.40785 2.25386 2.11434 1.82457 1.95558 1.94080 2.06767
## [241] 2.13752 2.08039 2.29090 2.27606 2.44669 1.53127 1.44731 1.45285
## [249] 1.49414 1.59240 1.66471 1.60903 1.10063 1.04603 0.82121 1.12603
## [257] 1.27179 1.14604 1.25881 2.26286 2.59055 2.77408 2.84135 3.13221
## [265] 3.17080 2.97983 2.13256 2.50358 2.02837 1.83616 1.89266 1.88999
## [273] 2.06171 2.26152 2.21156 2.31697 2.31205 2.56250 2.57055 2.58631
## [281] 2.74034 2.41717 2.43238 2.24679 2.13734 1.94234 2.01473 1.89345
## [289] 1.77429 1.94085 1.84195 1.88101 1.76190 1.75740 2.05769 1.79048
## [297] 2.15094 2.14953 2.01479 2.17153 2.31598 1.60503 1.62080 1.79737
## [305] 1.71048 1.94305 1.72934 1.78055 1.74848 1.62137 1.71534 1.68746
## [313] 1.57517 1.71882 1.67384 2.29475 2.16505 2.24500 2.16942 2.29525
## [321] 2.48287 2.45203 1.62242 1.52728 1.72617 1.55812 1.56178 1.65800
## [329] 1.66220 3.94118 3.35271 3.06043 2.98625 3.31361 2.63265 3.23591
```

```r
beer[1, ]
```

```
##   state year   mrall  beertax mlda jaild comserd   vmiles unrate   perinc
## 1     1 1982 2.12836 1.539379   19    no      no 7.233887   14.4 10544.15
##   mrall_cent
## 1 0.08791628
```

```r
beer[, 3][15]
```

```
## [1] 2.38405
```

```r
head(beer[, c(1, 3, 4)])  # kode for å få raskt inntrykk av variabler vi er interessert i
```

```
##   state   mrall  beertax
## 1     1 2.12836 1.539379
## 2     1 2.34848 1.788991
## 3     1 2.33643 1.714286
## 4     1 2.19348 1.652542
## 5     1 2.66914 1.609907
## 6     1 2.71859 1.560000
```
Denne typen indeksering er nyttig dersom vi raskt vil velge mange variabler/observasjoner, men den gjør koden vår mindre forståelig. Derfor bruker vi `$` til å velge variabler/navngitte elementer i et objekt.


Et godt alternativ, som jeg kommer til å bruke mye i seminarene, er å kombinere funksjonene `select()` og `filter()` fra pakken `dplyr`. Pakker er eksterne samlinger av funksjoner man kan laste ned på pcen sin med `install.packages()`, og deretter tilgjengeliggjøre i den nåværende R-sesjonen med `library`. Med `select()` velger du variabler, mens `filter()` lar deg filtrere observasjoner med logiske tester. Her viser jeg `dplyr` løsningen på oppgaven over:


```r
#install.packages("dplyr") # Denne trenger du bare kjøre dersom dplyr ikke er installert allerede
library(dplyr) # denne må du kjøre hver gang
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
# Man kan spesifisere datasett på egen linje før man bruker select og filter - gir ryddig kode
beer %>%                     # i dplyr brukes %>% til å binde sammen linjer med kode
     filter(mrall >3)           # samme filtrering som over, alle variabler
```

```
## Warning: package 'bindrcpp' was built under R version 3.4.4
```

```
##    state year   mrall    beertax mlda jaild comserd    vmiles unrate
## 1      4 1986 3.07106 0.37151703 21.0   yes     yes  8.129008    6.9
## 2     30 1982 3.15528 0.34644747 19.0   yes      no  8.284474    8.6
## 3     30 1983 3.50490 0.33293921 19.0   yes      no  8.800240    8.8
## 4     32 1982 3.18907 0.16109785 21.0    no      no  7.304109   10.1
## 5     35 1982 4.21784 0.24164678 21.0    no      no  8.662289    9.2
## 6     35 1983 3.78745 0.34833717 21.0    no      no  8.329537   10.1
## 7     35 1984 3.48527 0.44505495 21.0    no      no  8.718084    7.5
## 8     35 1985 3.68966 0.42902541 21.0    no      no  9.151046    8.8
## 9     35 1986 3.37390 0.41795665 21.0    no      no  9.596345    9.2
## 10    35 1987 3.78667 0.40500000 21.0    no      no 10.077343    8.9
## 11    35 1988 3.23159 0.38979790 21.0    no      no 10.141354    7.8
## 12    40 1982 3.26215 0.86634845 21.0    no      no  9.288461    5.7
## 13    45 1986 3.13221 1.78328180 21.0   yes     yes  8.414968    6.2
## 14    45 1987 3.17080 1.72800004 21.0   yes     yes  8.824518    5.6
## 15    56 1982 3.94118 0.05369928 19.0   yes      no 10.354911    5.8
## 16    56 1983 3.35271 0.05160551 19.0   yes      no  9.804255    8.4
## 17    56 1984 3.06043 0.04945055 19.0   yes      no  9.994155    6.3
## 18    56 1986 3.31361 0.04643963 19.0   yes      no 10.619331    9.0
## 19    56 1988 3.23591 0.04331088 19.5   yes      no 11.812115    6.3
##      perinc mrall_cent
## 1  14107.33   1.030616
## 2  12033.41   1.114836
## 3  11954.13   1.464456
## 4  14914.08   1.148626
## 5  11347.25   2.177396
## 6  11288.99   1.747006
## 7  11539.56   1.444826
## 8  11861.23   1.649216
## 9  11825.59   1.333456
## 10 11898.00   1.746226
## 11 12019.25   1.191146
## 12 13552.51   1.221706
## 13 11674.92   1.091766
## 14 12027.00   1.130356
## 15 14600.24   1.900736
## 16 13574.54   1.312266
## 17 13456.04   1.019986
## 18 13126.93   1.273166
## 19 13098.17   1.195466
```

```r
beer %>%        
  select(mrall, beertax) %>% # her velger jeg to variabler med select 
     filter(mrall >3)
```

```
##      mrall    beertax
## 1  3.07106 0.37151703
## 2  3.15528 0.34644747
## 3  3.50490 0.33293921
## 4  3.18907 0.16109785
## 5  4.21784 0.24164678
## 6  3.78745 0.34833717
## 7  3.48527 0.44505495
## 8  3.68966 0.42902541
## 9  3.37390 0.41795665
## 10 3.78667 0.40500000
## 11 3.23159 0.38979790
## 12 3.26215 0.86634845
## 13 3.13221 1.78328180
## 14 3.17080 1.72800004
## 15 3.94118 0.05369928
## 16 3.35271 0.05160551
## 17 3.06043 0.04945055
## 18 3.31361 0.04643963
## 19 3.23591 0.04331088
```


Dersom dere vil vite hvordan dere skal indeksere et R-objekt, kan dere bruke `str`

```r
(a <- list(a1 = list(1, 2), a2 = c(3, 4)))
```

```
## $a1
## $a1[[1]]
## [1] 1
## 
## $a1[[2]]
## [1] 2
## 
## 
## $a2
## [1] 3 4
```

```r
str(a)
```

```
## List of 2
##  $ a1:List of 2
##   ..$ : num 1
##   ..$ : num 2
##  $ a2: num [1:2] 3 4
```
`str` gir dere en oppskrift på hvordan dere kan gå frem for å velge ulike elementer av R-objekt, se på `$` i koden over, og følgende indeksering:

```r
a$a1[1]
```

```
## [[1]]
## [1] 1
```

```r
a[[1]][2]
```

```
## [[1]]
## [1] 2
```
Nå som vi har sett hvordan datasettet vårt er bygd opp, og lært hvordan vi kan velge variabler fra datasettet kan vi begynne med statistisk analyse. 

Indeksering og logiske tester er essensielt. Derfor får dere en oppgave til. Nå står dere fritt til å velge mellom `dplyr` og andre metoder.

**Oppgave:** velg variablene `state`, `year`, `mrall` og `beertax`. Filtrer slik at observasjonene fra to stater printes i Console, ved hjelp av en logisk test. Diskuter med naboen: hvordan ser sammenhengen mellom `mrall` og `beertax` ut i dine to stater?  


### Funksjoner 1 - oppbygging og deskriptiv statistikk

Dersom vi ønsker å gjøre noe i r, får vi som regel en funksjon til å gjøre jobben for oss. En funksjon er en kodesnutt hvor vi leverer input noe og får ut noe annet etter at funksjonen har omarbeidet input. Hoveddelen av det vi skal gjøre i disse seminarene, er å lære massevis av funksjoner og hvordan man bruker dem. Funksjoner gjør enkle ting, som å finne gjennomsnitt. De kan også gjøre avanserte ting, som å hente ut tekst fra tusenvis av nettsider.

Alle funksjoner har samme struktur:

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
Veldig ofte vil input til en funksjon være et objekt. 



Her er noen nyttige funksjoner for deskriptiv statistikk:


```r
mean(beer$mrall, na.rm = TRUE)  # gjennomsnitt
```

```
## [1] 2.040444
```

```r
# Jeg fjerner missing med na.rm = TRUE, fungerer for de fleste funksjonene under.
median(beer$mrall)  # median
```

```
## [1] 1.955955
```

```r
min(beer$mrall)  # minimumsverdi
```

```
## [1] 0.82121
```

```r
max(beer$mrall)  # maksimumsverdi
```

```
## [1] 4.21784
```

```r
summary(beer$mrall)  # alt over + 1. og 3. kvartil
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##  0.8212  1.6237  1.9560  2.0404  2.4179  4.2178
```

```r
summary(beer)  # kan også brukes på hele datasettet 
```

```
##      state            year          mrall           beertax       
##  Min.   : 1.00   Min.   :1982   Min.   :0.8212   Min.   :0.04331  
##  1st Qu.:18.75   1st Qu.:1983   1st Qu.:1.6237   1st Qu.:0.20885  
##  Median :30.50   Median :1985   Median :1.9560   Median :0.35259  
##  Mean   :30.19   Mean   :1985   Mean   :2.0404   Mean   :0.51326  
##  3rd Qu.:42.50   3rd Qu.:1987   3rd Qu.:2.4179   3rd Qu.:0.65157  
##  Max.   :56.00   Max.   :1988   Max.   :4.2178   Max.   :2.72076  
##       mlda       jaild     comserd       vmiles           unrate      
##  Min.   :18.00   no :242   no :274   Min.   : 4.576   Min.   : 2.400  
##  1st Qu.:20.00   yes: 94   yes: 62   1st Qu.: 7.183   1st Qu.: 5.475  
##  Median :21.00                       Median : 7.796   Median : 7.000  
##  Mean   :20.46                       Mean   : 7.891   Mean   : 7.347  
##  3rd Qu.:21.00                       3rd Qu.: 8.504   3rd Qu.: 8.900  
##  Max.   :21.00                       Max.   :26.148   Max.   :18.000  
##      perinc        mrall_cent      
##  Min.   : 9514   Min.   :-1.21923  
##  1st Qu.:12086   1st Qu.:-0.41673  
##  Median :13763   Median :-0.08449  
##  Mean   :13880   Mean   : 0.00000  
##  3rd Qu.:15175   3rd Qu.: 0.37744  
##  Max.   :22193   Max.   : 2.17740
```

```r
sd(beer$mrall)  # standardavvik
```

```
## [1] 0.5701938
```

```r
var(beer$mrall)  # varians
```

```
## [1] 0.3251209
```

```r
# install.packages('moments') # kjør dersom du ikke har pakken installert på pcen
library(moments)  # laster inn pakke med funksjonene under
skewness(beer$mrall)  # skjevhet
```

```
## [1] 0.7336646
```

```r
kurtosis(beer$mrall)  # kurtose
```

```
## [1] 3.622448
```

```r
table(beer$jaild)  # lager frekvenstabell - fin for ikke numeriske variabler
```

```
## 
##  no yes 
## 242  94
```

```r
prop.table(table(beer$jaild))  # lag proposjoner av frekvenstabell med prop.table, se ?prop.table for detaljer
```

```
## 
##        no       yes 
## 0.7202381 0.2797619
```


**Oppgave:** Åpne hjelpefilen til funksjonen `quantile()`. Les argumentene og `details`, og forsøk å reprodusere kvartilene vi fikk gjennom `summary()` funksjonen (du får forskjellig avrunding). Hva er skillet mellom de to midterste kvartilene?

## Funksjoner 2

Funksjoner er helt sentralt i R. De over 10 000 pakkene som finnes til R inneholder som regel funksjoner. Derfor kan et google-søk ofte finne en funksjon som passer til akkurat ditt formål. Ofte er det imidlertid minst like effektivt å skrive sin egen funksjon. Dersom du skal gjenta en operasjon mange ganger, kan en funksjon ofte gjøre dette mer effektivt enn copy-paste. Du kan også redusere sjansen for feil. Videre kan funksjoner brukes til å oppskalere dataforberedelsene og dataanalysen din - i stedet for å velge en analysemetode/operasjonalisering, kan du skrive en funksjon som tester 1000 operasjonaliseringer og analyser. Dette kan være svært nyttig. Derfor skal vi nå skrive vår første funksjon, og se en måte vi kan oppskalere.


```r
beer$mrall - mean(beer$mrall)  # kan vi skrive en funksjon for sentreringen vi gjør her?
```

```
##   [1]  0.087916284  0.308036266  0.295986262  0.153036250  0.628696158
##   [6]  0.678146185  0.453466361  0.458696319  0.226936260  0.788336198
##  [11]  0.761566204  1.030616273  0.726836312  0.665206331  0.343606240
##  [16]  0.355256212  0.197406204  0.223226249  0.502786294  0.635436314
##  [21]  0.506526136 -0.178503818 -0.233723825 -0.094333794 -0.159163741
##  [26] -0.094963747 -0.050783841 -0.136793809  0.134036251  0.010996169
##  [31] -0.134483838 -0.248433775 -0.194143780 -0.247363772 -0.534843842
##  [36] -0.393493814 -0.645543754 -0.553913836 -0.628973779 -0.631113784
##  [41] -0.642123763 -0.543383779 -0.007113835 -0.225263779  0.076816228
##  [46] -0.368413733  0.108056280  0.226636199  0.383796156  0.491526313
##  [51]  0.457236180  0.506166122  0.451196262  0.379596182  0.320866253
##  [56]  0.454896232  0.134396265  0.220156231  0.373116214  0.236996290
##  [61]  0.467756341  0.529466357  0.565986135  0.577146289  0.621496162
##  [66]  0.381976148  0.496866284  0.534406150  0.584806127  0.521866183
##  [71] -0.602043714 -0.712443710 -0.697793715 -0.710573789 -0.658743796
##  [76] -0.607183741 -0.458733833 -0.287753777 -0.184393851 -0.356173827
##  [81] -0.269213764 -0.154203721 -0.133013804 -0.058803838 -0.389253822
##  [86] -0.270473814 -0.593663848 -0.396893723 -0.493073734 -0.307913709
##  [91] -0.075023839  0.027666261 -0.346993751  0.049716197 -0.056773846
##  [96] -0.007093753 -0.057403798 -0.104573832  0.184786201  0.054336284
## [101] -0.013563825 -0.129543754  0.120046185  0.224116244  0.208016150
## [106]  0.448716324  0.060436156  0.113786242  0.037216247  0.031126270
## [111] -0.186603851  0.058016172 -0.579173778 -0.084113839 -0.033523814
## [116] -0.270683798 -0.214503801 -0.085933847  0.075736185 -0.542663751
## [121] -0.515213745 -0.561943729 -0.380603727 -0.282993846 -0.245513787
## [126] -0.348533780 -0.893753808 -0.911413794 -0.891773801 -0.765963763
## [131] -0.751443716 -0.863673762 -0.809333709 -0.513623803 -0.589153773
## [136] -0.350223839 -0.340403771 -0.284233814 -0.304573754 -0.196283785
## [141] -0.658883786 -0.701483790 -0.642413783 -0.590403782 -0.685113758
## [146] -0.792213817 -0.619503829  0.803346207  0.727656167  0.573106096
## [151]  0.493046115  0.897816077  0.839556320  0.715286166 -0.239553759
## [156] -0.204863740 -0.106833744 -0.189183760  0.189016151  0.005416238
## [161]  0.105056257  1.114836356  1.464456305  0.851416131  0.659316298
## [166]  0.676816140  0.852016252  0.419186123 -0.398933756 -0.442703735
## [171] -0.264743852 -0.564723727 -0.225673852 -0.177203750 -0.411233763
## [176]  1.148626194  0.780066344  0.674936324  0.726646264  0.369066271
## [181]  0.561346111  0.673026240 -0.215553722 -0.048783826 -0.077253775
## [186] -0.126613726 -0.365663713 -0.346973815 -0.510493832 -0.612453717
## [191] -0.792453778 -0.813893843 -0.765643766 -0.677823831 -0.707023850
## [196] -0.679223725  2.177396251  1.747006187  1.444826354  1.649216152
## [201]  1.333456181  1.746226204  1.191146308 -0.811123740 -0.866003815
## [206] -0.879623752 -0.912403760 -0.847973773 -0.731603781 -0.781303810
## [211]  0.125446255 -0.009833733  0.311166237  0.328856273  0.561036155
## [216]  0.429536318  0.383656167  0.161936201 -0.337063815 -0.584843787
## [221] -0.726573766 -0.567693772 -0.537463769 -0.481223818 -0.548893717
## [226] -0.567173833 -0.507853823 -0.508423822 -0.483873722 -0.397263779
## [231] -0.416303795  1.221706203  0.520716291  0.367406188  0.213416221
## [236]  0.073896241 -0.215873719 -0.084863845 -0.099643788  0.027226212
## [241]  0.097076278  0.039946186  0.250456229  0.235616186  0.406246269
## [246] -0.509173827 -0.593133722 -0.587593808 -0.546303767 -0.448043851
## [251] -0.375733783 -0.431413777 -0.939813748 -0.994413771 -1.219233803
## [256] -0.914413816 -0.768653830 -0.894403769 -0.781633847  0.222416289
## [261]  0.550106212  0.733636131  0.800906142  1.091766331  1.130356264
## [266]  0.939386242  0.092116257  0.463136108 -0.012073709 -0.204283846
## [271] -0.147783852 -0.150453838  0.021266184  0.221076203  0.171116277
## [276]  0.276526276  0.271606274  0.522056231  0.530106350  0.545866075
## [281]  0.699896351  0.376726253  0.391936206  0.206346173  0.096896271
## [286] -0.098103759 -0.025713802 -0.146993829 -0.266153787 -0.099593730
## [291] -0.198493784 -0.159433824 -0.278543724 -0.283043759  0.017246217
## [296] -0.249963763  0.110496200  0.109086264 -0.025653848  0.131086286
## [301]  0.275536164 -0.435413807 -0.419643751 -0.243073722 -0.329963790
## [306] -0.097393771 -0.311103780 -0.259893844 -0.291963792 -0.419073753
## [311] -0.325103741 -0.352983756 -0.465273755 -0.321623796 -0.366603766
## [316]  0.254306229  0.124606173  0.204556287  0.128976259  0.254806233
## [321]  0.442426113  0.411586240 -0.418023832 -0.513163817 -0.314273769
## [326] -0.482323798 -0.478663845 -0.382443817 -0.378243843  1.900736112
## [331]  1.312266264  1.019986099  0.945806256  1.273166141  0.592206358
## [336]  1.195466190
```

```r
center <- function(min_data_var) {
    # denne linjen definerer input i funksjonen, den skal alltid ha samme form
    
    centered <- min_data_var - mean(min_data_var, na.rm = T)  # denne linjen/innmat angir hva som skal gjøres med input
    
    return(centered)  # denne linjen angir hvilken output vi vil har, det er andre funksjoner som kan stå på denne linjen i stedet
}

center(beer$mrall) == (beer$mrall - mean(beer$mrall))  # vi har nå generalisert den første linjen
```

```
##   [1] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
##  [15] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
##  [29] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
##  [43] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
##  [57] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
##  [71] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
##  [85] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
##  [99] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
## [113] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
## [127] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
## [141] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
## [155] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
## [169] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
## [183] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
## [197] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
## [211] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
## [225] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
## [239] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
## [253] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
## [267] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
## [281] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
## [295] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
## [309] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
## [323] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
```

Oppskalering: Funksjonen `apply()` kjører en funksjon på alle rader, eller alle kolonner i et datasett.


```r
apply(beer[, c(3:5, 8:10)], MARGIN = 2, FUN = center)
```

```
##               mrall     beertax       mlda       vmiles      unrate
##   [1,]  0.087916284  1.02612349 -1.4556250 -0.656866411  7.05327341
##   [2,]  0.308036266  1.27573475 -1.4556250 -0.054405962  6.35327360
##   [3,]  0.295986262  1.20102963 -1.4556250  0.372236616  3.75327418
##   [4,]  0.153036250  1.13928637 -0.7856249  0.836163374  1.55327341
##   [5,]  0.628696158  1.09665105  0.5443750  1.062099897  2.45327399
##   [6,]  0.678146185  1.04674396  0.5443750  1.275548139  0.45327399
##   [7,]  0.453466361  0.98818764  0.5443750  1.783569624 -0.14672640
##   [8,]  0.458696319 -0.29845884 -1.4556250 -1.080596880  2.55327341
##   [9,]  0.226936260 -0.30683395 -1.4556250 -1.303258990  1.75327418
##  [10,]  0.788336198 -0.21655268 -1.4556250 -1.180783404 -2.34672620
##  [11,]  0.761566204 -0.13190004  0.5443750 -1.119490923 -0.84672620
##  [12,]  1.030616273 -0.14173895  0.5443750  0.238254194 -0.44672611
##  [13,]  0.726836312 -0.15325597  0.5443750  1.479900678 -1.14672640
##  [14,]  0.665206331 -0.16676897  0.5443750  1.924967085 -1.04672601
##  [15,]  0.343606240  0.13710204  0.5443750 -0.682253130  2.45327399
##  [16,]  0.355256212  0.16220275  0.5443750 -0.714836626  2.75327418
##  [17,]  0.197406204  0.08564511  0.5443750 -0.805933794  1.55327341
##  [18,]  0.223226249  0.06407455  0.5443750 -0.636835650  1.35327360
##  [19,]  0.502786294  0.04917952  0.5443750 -0.421754595  1.35327360
##  [20,]  0.635436314  0.03174403  0.5443750 -0.224923052  0.75327418
##  [21,]  0.506526136  0.01128688  0.5443750  0.133871870  0.35327360
##  [22,] -0.178503818 -0.40585741  0.5443750 -1.032076861  2.55327341
##  [23,] -0.233723825 -0.41004497  0.5443750 -0.674462115  2.35327360
##  [24,] -0.094333794 -0.41435488  0.5443750 -0.271577837  0.45327399
##  [25,] -0.159163741 -0.41791700  0.5443750 -0.016686724 -0.14672640
##  [26,] -0.094963747 -0.42037673  0.5443750  0.144156538 -0.64672640
##  [27,] -0.050783841 -0.42325598  0.5443750  0.289879682 -1.54672601
##  [28,] -0.136793809 -0.42663423  0.5443750  0.641236616 -2.04672601
##  [29,]  0.134036251 -0.29845884  0.5443750 -0.147911822  0.35327360
##  [30,]  0.010996169 -0.30683395  0.5443750 -0.234690630 -0.74672630
##  [31,] -0.134483838 -0.31545378  0.5443750 -0.182901079 -1.74672630
##  [32,] -0.248433775 -0.32257801  0.5443750  0.201455854 -1.44672611
##  [33,] -0.194143780 -0.32749747  0.5443750  0.240620893  0.05327389
##  [34,] -0.247363772 -0.33325598  0.5443750  0.291274214  0.35327360
##  [35,] -0.534843842 -0.34001248  0.5443750  0.490014936 -0.94672611
##  [36,] -0.393493814 -0.28891231 -1.9556250 -1.450699908 -0.44672611
##  [37,] -0.645543754 -0.27969290 -1.2056250 -1.320710650 -1.34672620
##  [38,] -0.553913836 -0.26524499 -0.4556250 -1.210560747 -2.74672630
##  [39,] -0.628973779 -0.27417758 -0.1256251 -0.911538775 -2.44672611
##  [40,] -0.631113784 -0.28034575  0.5443750 -0.229008990 -3.54672625
##  [41,] -0.642123763 -0.28756598  0.5443750  0.447780561 -4.04672625
##  [42,] -0.543383779 -0.29603750  0.5443750  0.170481733 -4.34672620
##  [43,] -0.007113835 -0.34022497 -0.4556250 -0.239099810  1.15327380
##  [44,] -0.225263779 -0.34697159 -0.4556250  0.171946089  0.75327418
##  [45,]  0.076816228 -0.35391533  0.5443750  0.477308881 -1.14672640
##  [46,] -0.368413733 -0.35965429  0.5443750  0.734671186 -2.04672601
##  [47,]  0.108056280 -0.36361718  0.5443750  1.155063764 -3.04672601
##  [48,]  0.226636199 -0.36825599  0.5443750  1.559553999 -4.14672616
##  [49,]  0.383796156 -0.37369873  0.5443750  1.812266889 -4.14672616
##  [50,]  0.491526313  0.56072971 -1.4556250 -0.303623736  0.85327360
##  [51,]  0.457236180  0.65715679 -1.4556250 -0.286499224  1.25327418
##  [52,]  0.506166122  0.67355725 -1.4556250 -0.155448931 -1.04672601
##  [53,]  0.451196262  0.63081190 -0.4556250 -0.143442583 -1.34672620
##  [54,]  0.379596182  0.60129520  0.5443750 -0.121997759 -1.64672640
##  [55,]  0.320866253  0.56674406  0.5443750 -0.102423052 -2.04672601
##  [56,]  0.454896232  0.52620503  0.5443750  0.647476850 -2.34672620
##  [57,]  0.134396265  2.20750770 -1.4556250  0.732690717  0.45327399
##  [58,]  0.220156231  2.10142288 -1.4556250  0.627836225  0.15327380
##  [59,]  0.373116214  1.99223837 -1.4556250  0.751160444 -1.34672620
##  [60,]  0.236996290  1.90199813 -1.2056250  1.097353803 -0.84672620
##  [61,]  0.467756341  1.83968505 -0.2056250  1.454013960 -1.44672611
##  [62,]  0.529466357  1.76674399  0.5443750  1.799527631 -1.84672620
##  [63,]  0.565986135  1.68116173  0.5443750  1.926641889 -1.54672601
##  [64,]  0.577146289 -0.11051133 -1.4556250  0.142998335  2.45327399
##  [65,]  0.621496162 -0.12621468 -1.4556250  0.496887983  2.45327399
##  [66,]  0.381976148 -0.14237687 -1.4556250 -0.114985552 -0.14672640
##  [67,]  0.496866284 -0.15573478 -1.4556250 -0.219121783  0.55327389
##  [68,]  0.534406150 -0.16495878 -1.4556250  0.008447065  1.35327360
##  [69,]  0.584806127 -0.17575598  0.0443750  0.244514936  0.65327380
##  [70,]  0.521866183 -0.18842441  0.5443750  0.211928510 -1.54672601
##  [71,] -0.602043714 -0.32471183  0.5443750 -2.194218951  3.95327399
##  [72,] -0.712443710 -0.33206332  0.5443750 -2.027885454  4.05327341
##  [73,] -0.697793715 -0.33962961  0.5443750 -1.823225298  1.75327418
##  [74,] -0.710573789 -0.34588310  0.5443750 -1.749077349  1.65327380
##  [75,] -0.658743796 -0.35020128  0.5443750 -1.544976275  0.75327418
##  [76,] -0.607183741 -0.35525598  0.5443750 -1.349907427  0.05327389
##  [77,] -0.458733833 -0.36118668  0.5443750 -1.133140826 -0.54672601
##  [78,] -0.287753777 -0.20412353  0.5443750 -0.740836138  4.55327341
##  [79,] -0.184393851 -0.21617687  0.5443750 -0.613247271  3.75327418
##  [80,] -0.356173827 -0.22858235  0.5443750 -0.411866411  1.25327418
##  [81,] -0.269213764 -0.23883545  0.5443750 -0.474500689  0.55327389
##  [82,] -0.154203721 -0.24591544  0.5443750 -0.176431353 -0.64672640
##  [83,] -0.133013804 -0.25420299  0.5443750  0.086462202 -0.94672611
##  [84,] -0.058803838 -0.26392683  0.5443750  1.310822553 -2.04672601
##  [85,] -0.389253822 -0.13736099 -1.4556250 -1.237490435  1.15327380
##  [86,] -0.270473814 -0.15201744 -1.4556250 -1.120446001  0.75327418
##  [87,] -0.593663848 -0.16710213 -1.4556250 -0.830123247 -0.34672620
##  [88,] -0.396893723 -0.17956954 -1.4556250 -0.889716021  0.65327380
##  [89,] -0.493073734 -0.13012904 -0.4556250 -0.697763384 -0.34672620
##  [90,] -0.307913709 -0.08575597  0.5443750 -0.548496294 -1.84672620
##  [91,] -0.075023839 -0.02832910  0.5443750 -0.160690142 -2.84672620
##  [92,]  0.027666261 -0.02924642  0.5443750 -0.557684283 -1.04672601
##  [93,] -0.346993751 -0.04811835  0.5443750 -0.411142779 -1.24672630
##  [94,]  0.049716197 -0.06754169  0.5443750 -0.219865923 -2.14672640
##  [95,] -0.056773846 -0.08359495  0.5443750 -0.023420122 -2.34672620
##  [96,] -0.007093753 -0.09468013  0.5443750  0.209299604 -1.94672611
##  [97,] -0.057403798 -0.10765597  0.5443750  0.413377241 -2.44672611
##  [98,] -0.104573832 -0.12288061  0.5443750  0.590601850 -2.54672601
##  [99,]  0.184786201 -0.29726553  0.5443750 -0.953287798  3.25327418
## [100,]  0.054336284 -0.30568719  0.5443750 -0.696611040  4.35327360
## [101,] -0.013563825 -0.31435490  0.5443750 -0.377050494  1.95327399
## [102,] -0.129543754 -0.32151870  0.5443750 -0.236418169  2.15327380
## [103,]  0.120046185 -0.32646549  0.5443750 -0.031133013  1.95327399
## [104,]  0.224116244 -0.33225599  0.5443750  0.244490522  1.45327399
## [105,]  0.208016150 -0.33905003  0.5443750  0.591681928  0.55327389
## [106,]  0.448716324  0.35309246 -2.4556250 -1.752954790  2.95327399
## [107,]  0.060436156  0.31931284 -2.4556250 -1.682011919  4.45327399
## [108,]  0.113786242  0.28454623 -2.4556250 -0.809815142  2.65327380
## [109,]  0.037216247  0.25581184 -2.4556250 -0.444875201  4.15327380
## [110,]  0.031126270  0.23597005 -2.4556250 -0.782067583  5.75327418
## [111,] -0.186603851  0.21274403  0.0443750 -1.031546099  4.65327380
## [112,]  0.058016172  0.18549284  0.5443750 -0.022776568  3.55327341
## [113,] -0.579173778  0.29223332 -0.4556250 -1.157467974  1.25327418
## [114,] -0.084113839  0.26082662 -0.4556250 -0.970236529  1.65327380
## [115,] -0.033523814  0.22850224 -0.4556250  0.193154585 -1.24672630
## [116,] -0.270683798  0.20178643  0.0443750  0.079180464 -1.94672611
## [117,] -0.214503801  0.23655102  0.5443750  0.659594038 -2.04672601
## [118,] -0.085933847  0.27424404  0.5443750  1.179182905 -2.94672611
## [119,]  0.075736185  0.24468437  0.5443750  1.570645796 -3.54672625
## [120,] -0.542663751 -0.27220586  0.5443750 -1.122659869  1.05327341
## [121,] -0.515213745 -0.28160460  0.5443750 -0.771928423 -0.44672611
## [122,] -0.561943729 -0.29127796  0.5443750 -0.601265337 -1.94672611
## [123,] -0.380603727 -0.29927292  0.5443750 -0.300343951 -2.74672630
## [124,] -0.282993846 -0.30479364  0.5443750 -0.064049029 -2.84672620
## [125,] -0.245513787 -0.31125598  0.5443750  0.156221479 -3.14672640
## [126,] -0.348533780 -0.31883827  0.5443750  0.222192182 -2.84672620
## [127,] -0.893753808 -0.22685981 -0.4556250 -1.510702837  0.55327389
## [128,] -0.911413794 -0.23802662 -0.4556250 -1.380013872 -0.44672611
## [129,] -0.891773801 -0.24951974 -0.4556250 -1.244162798 -2.54672601
## [130,] -0.765963763 -0.25901869  0.0443750 -1.072457232 -3.44672611
## [131,] -0.751443716 -0.26557797  0.5443750 -0.862789263 -3.54672625
## [132,] -0.863673762 -0.27325599  0.5443750 -0.665317583 -4.14672616
## [133,] -0.809333709 -0.28226465  0.5443750 -0.532280962 -4.04672625
## [134,] -0.513623803  0.03239796  0.5443750 -1.178010454  8.15327380
## [135,] -0.589153773  0.01112244  0.5443750 -1.169425494  6.85327360
## [136,] -0.350223839 -0.01077470  0.5443750 -0.883682818  3.85327360
## [137,] -0.340403771 -0.02887252  0.5443750 -0.474177447  2.55327341
## [138,] -0.284233814 -0.04136953  0.5443750 -0.061230181  1.45327399
## [139,] -0.304573754 -0.05599800  0.5443750  0.338161421  0.85327360
## [140,] -0.196283785 -0.07316166  0.5443750  0.539892866  0.25327370
## [141,] -0.658883786 -0.16719395 -1.4556250 -0.831489947  0.45327399
## [142,] -0.701483790 -0.18068719 -1.4556250 -0.396678911  0.85327360
## [143,] -0.642413783 -0.19457468 -1.4556250 -0.245787310 -1.04672601
## [144,] -0.590403782 -0.20605260 -1.4556250 -0.094880572 -1.34672620
## [145,] -0.685113758 -0.21397838 -0.7856249  0.162422651 -2.04672601
## [146,] -0.792213817 -0.19700599  0.5443750  0.391605756 -1.94672611
## [147,] -0.619503829 -0.19227427  0.5443750  0.571501264 -3.34672620
## [148,]  0.803346207  0.63268682  0.5443750 -1.211352740  3.65327380
## [149,]  0.727656167  0.58800551  0.5443750 -0.998765337  5.25327418
## [150,]  0.573106096  0.54201874  0.5443750 -0.792213579  3.45327399
## [151,]  0.493046115  0.56337544  0.5443750 -0.569656939  2.95327399
## [152,]  0.897816077  0.55213103  0.5443750 -0.401429888  4.35327360
## [153,]  0.839556320  0.44704404  0.5443750 -0.205801470  2.85327360
## [154,]  0.715286166  0.41099814  0.5443750  0.522619428  1.05327341
## [155,] -0.239553759 -0.16664380  0.5443750 -0.807994829  1.85327360
## [156,] -0.204863740 -0.18015850  0.5443750 -0.527679888  2.55327341
## [157,] -0.106833744 -0.19406807  0.5443750 -0.185307818 -0.14672640
## [158,] -0.189183760 -0.20556423  0.5443750 -0.079271197 -0.94672611
## [159,]  0.189016151 -0.21350262  0.5443750  0.271163374 -1.24672630
## [160,]  0.005416238 -0.22279498  0.5443750  0.609951460 -1.04672601
## [161,]  0.105056257 -0.23369774  0.5443750  0.973293256 -1.64672640
## [162,]  1.114836356 -0.16680852 -1.4556250  0.393720014  1.25327418
## [163,]  1.464456305 -0.18031678 -1.4556250  0.909486616  1.45327399
## [164,]  0.851416131 -0.19421974 -1.4556250  1.083732710  0.05327389
## [165,]  0.659316298 -0.19417760 -1.4556250  1.276324506  0.35327360
## [166,]  0.676816140 -0.19117445 -1.4556250  1.684527631  0.75327418
## [167,]  0.852016252 -0.18945599 -0.1256251  2.089470014  0.05327389
## [168,]  0.419186123 -0.19034550  0.5443750  2.218573530 -0.54672601
## [169,] -0.398933756 -0.13736099 -0.4556250 -0.698926958 -1.24672630
## [170,] -0.442703735 -0.15201744 -0.4556250 -0.663955767 -1.64672640
## [171,] -0.264743852 -0.16710213 -0.4556250 18.257517866 -2.94672611
## [172,] -0.564723727 -0.14381743  0.5443750 -0.385129107 -1.84672620
## [173,] -0.225673852 -0.04885972  0.5443750 -0.022787310 -2.34672620
## [174,] -0.177203750 -0.04638100  0.5443750  0.321931928 -2.44672611
## [175,] -0.411233763 -0.01518092  0.5443750  0.478142866 -3.74672630
## [176,]  1.148626194 -0.35215813  0.5443750 -0.586644732  2.75327418
## [177,]  0.780066344 -0.31328465  0.5443750 -0.229668658  2.45327399
## [178,]  0.674936324 -0.29072851  0.5443750  0.104895796  0.45327399
## [179,]  0.726646264 -0.29874328  0.5443750  0.192568159  0.65327380
## [180,]  0.369066271 -0.30427766  0.5443750  0.362594038 -1.34672620
## [181,]  0.561346111 -0.31075598  0.5443750  0.446890913 -1.04672601
## [182,]  0.673026240 -0.31835704  0.5443750  0.637701460 -2.14672640
## [183,] -0.215553722 -0.02996242 -0.4556250 -0.537396197  0.05327389
## [184,] -0.048783826  0.05440459 -0.4556250 -0.402737994 -1.94672611
## [185,] -0.077253775  0.22850224 -0.4556250 -0.432676470 -3.04672601
## [186,] -0.126613726  0.20178643 -0.4556250 -0.337637896 -3.44672611
## [187,] -0.365663713  0.18333843  0.0443750  0.242640913 -4.54672625
## [188,] -0.346973815  0.16174403  0.5443750  0.781893842 -4.84672620
## [189,] -0.510493832  0.13640717  0.5443750  0.871434858 -4.94672611
## [190,] -0.612453717 -0.42375717 -1.4556250 -0.918770220  1.65327380
## [191,] -0.792453778 -0.42724681  0.5443750 -0.898661822  0.45327399
## [192,] -0.813893843 -0.43083840  0.5443750 -0.931612505 -1.14672640
## [193,] -0.765643766 -0.43380683  0.5443750 -0.867716509 -1.64672640
## [194,] -0.677823831 -0.43585660  0.5443750 -0.665851763 -2.34672620
## [195,] -0.707023850 -0.43825598  0.5443750 -0.451886431 -3.34672620
## [196,] -0.679223725 -0.44107119  0.5443750 -0.291881548 -3.54672625
## [197,]  2.177396251 -0.27160920  0.5443750  0.771535444  1.85327360
## [198,]  1.747006187 -0.16491881  0.5443750  0.438783491  2.75327418
## [199,]  1.444826354 -0.06820104  0.5443750  0.827330366  0.15327380
## [200,]  1.649216152 -0.08423057  0.5443750  1.260292280  1.45327399
## [201,]  1.333456181 -0.09529933  0.5443750  1.705591108  1.85327360
## [202,]  1.746226204 -0.10825598  0.5443750  2.186589155  1.55327341
## [203,]  1.191146308 -0.12345809  0.5443750  2.250599897  0.45327399
## [204,] -0.811123740 -0.39392424 -1.4556250 -3.314407915  1.25327418
## [205,] -0.866003815 -0.38040048 -1.4556250 -3.153242388  1.25327418
## [206,] -0.879623752 -0.37725599 -1.4556250 -2.973159380 -0.14672640
## [207,] -0.912403760 -0.38215429 -1.2956252 -2.800628130 -0.84672620
## [208,] -0.847973773 -0.38553669  0.5443750 -2.593758990 -1.04672601
## [209,] -0.731603781 -0.38949598  0.5443750 -2.392727740 -2.44672611
## [210,] -0.781303810 -0.39414145  0.5443750 -2.100831744 -3.14672640
## [211,]  0.125446255  0.91872498  0.5443750 -0.726528033  1.65327380
## [212,] -0.009833733  0.86289081  0.5443750 -0.479520708  1.55327341
## [213,]  0.311166237  0.80542538  0.5443750 -0.076596880 -0.64672640
## [214,]  0.328856273  0.75793049  0.5443750  0.090526167 -1.94672611
## [215,]  0.561036155  0.72513410  0.5443750  0.364167280 -2.04672601
## [216,]  0.429536318  0.68674406  0.5443750  0.623192671 -2.84672620
## [217,]  0.383656167  0.64170071  0.5443750  1.038656538 -3.74672630
## [218,]  0.161936201 -0.08366171  0.5443750 -0.075280962 -1.44672611
## [219,] -0.337063815 -0.10041192  0.5443750 -0.015557818 -1.74672630
## [220,] -0.584843787 -0.11765158  0.5443750 -0.063992388 -2.24672630
## [221,] -0.726573766 -0.13190004  0.5443750 -0.026511431 -1.44672611
## [222,] -0.567693772 -0.14173895  0.5443750  0.259444624 -1.04672601
## [223,] -0.537463769 -0.15325597  0.5443750  0.563137006 -2.14672640
## [224,] -0.481223818 -0.16676897  0.5443750  0.752422163 -2.54672601
## [225,] -0.548893717 -0.08366171  0.5443750 -1.231126665  5.15327380
## [226,] -0.567173833 -0.10041192  0.5443750 -1.072550005  4.85327360
## [227,] -0.507853823 -0.11765158  0.5443750 -0.917282915  2.05327341
## [228,] -0.508423822 -0.13190004  0.5443750 -0.859005083  1.55327341
## [229,] -0.483873722 -0.14173895  0.5443750 -0.693779986  0.75327418
## [230,] -0.397263779 -0.15325597  0.5443750 -0.550505572 -0.34672620
## [231,] -0.416303795 -0.16676897  0.5443750 -0.337535845 -1.34672620
## [232,]  1.221706203  0.35309246  0.5443750  1.397707319 -1.64672640
## [233,]  0.520716291  0.31931284  0.5443750  1.038574506  1.65327380
## [234,]  0.367406188  0.43413410  0.5443750  1.469045210 -0.34672620
## [235,]  0.213416221  0.44807878  0.5443750  1.555161421 -0.24672630
## [236,]  0.073896241  0.42327657  0.5443750  1.605324506  0.85327360
## [237,] -0.215873719  0.39424404  0.5443750  1.768770796  0.05327389
## [238,] -0.084863845  0.36018005  0.5443750  2.099360639 -0.64672640
## [239,] -0.099643788 -0.28806505  0.5443750 -0.628115435  4.15327380
## [240,]  0.027226212 -0.29684542  0.5443750 -0.162555376  3.45327399
## [241,]  0.097076278 -0.30588235  0.5443750 -0.064515337  2.05327341
## [242,]  0.039946186 -0.31335132  0.5443750  0.095115522  1.45327399
## [243,]  0.250456229 -0.31850882  0.5443750  0.397567671  1.15327380
## [244,]  0.235616186 -0.32454598  0.5443750  0.674574506 -1.14672640
## [245,]  0.406246269 -0.33162941  0.5443750  1.218016889 -1.54672601
## [246,] -0.509173827 -0.22685981  0.5443750 -1.887485064  3.55327341
## [247,] -0.593133722 -0.23802662  0.5443750 -1.810369341  4.45327399
## [248,] -0.587593808 -0.24951974  0.5443750 -1.640470415  1.75327418
## [249,] -0.546303767 -0.25901869  0.5443750 -1.527117388  0.65327380
## [250,] -0.448043851 -0.26557797  0.5443750 -1.414629595 -0.54672601
## [251,] -0.375733783 -0.27325599  0.5443750 -1.303461626 -1.64672640
## [252,] -0.431413777 -0.28226465  0.5443750 -1.121495318 -2.24672630
## [253,] -0.939813748 -0.33903164 -0.4556250 -1.697875201  2.85327360
## [254,] -0.994413771 -0.34582479 -0.4556250 -1.599928911  0.95327399
## [255,] -1.219233803 -0.35281643  0.0443750 -2.381370318 -2.04672601
## [256,] -0.914413816 -0.35859497  0.5443750 -1.875274615 -2.44672611
## [257,] -0.768653830 -0.36258519  0.5443750 -1.826161333 -3.34672620
## [258,] -0.894403769 -0.36725599  0.5443750 -1.802542681 -3.54672625
## [259,] -0.781633847 -0.37273626  0.5443750 -1.996502154 -4.24672630
## [260,]  0.222416289  1.54879650  0.5443750 -0.382398150  3.45327399
## [261,]  0.550106212  1.46839544  0.5443750 -0.224383501  2.65327380
## [262,]  0.733636131  1.38564512  0.5443750 -0.025510454 -0.24672630
## [263,]  0.800906142  1.31725249  0.5443750  0.079665815 -0.54672601
## [264,]  1.091766331  1.27002582  0.5443750  0.524214155 -1.14672640
## [265,]  1.130356264  1.21474406  0.5443750  0.933763960 -1.74672630
## [266,]  0.939386242  1.14988169  0.5443750  1.261705366 -2.84672620
## [267,]  0.092116257  0.20512113  0.5443750  1.274931928 -1.84672620
## [268,]  0.463136108  0.17711100  0.5443750  1.146454389 -1.94672611
## [269,] -0.012073709  0.14828250  0.5443750  1.188684858 -3.04672601
## [270,] -0.204283846  0.12445590  0.5443750  0.975074506 -2.24672630
## [271,] -0.147783852  0.10800305  0.5443750  0.927063764 -2.64672640
## [272,] -0.150453838  0.09599701  0.5443750  0.866669233 -3.14672640
## [273,]  0.021266184  0.08010879  0.5443750  1.413589155 -3.44672611
## [274,]  0.221076203 -0.17516172 -1.4556250 -0.432453326  4.45327399
## [275,]  0.171116277 -0.18834430 -1.4556250 -0.157544146  4.15327380
## [276,]  0.276526276 -0.20191205 -0.7856249 -0.162653521  1.25327418
## [277,]  0.271606274 -0.21312571  0.5443750 -0.276737994  0.65327380
## [278,]  0.522056231 -0.22086901  0.5443750  0.274246381  0.65327380
## [279,]  0.530106350 -0.22993299  0.5443750  0.786089155 -0.74672630
## [280,]  0.545866075 -0.24056783  0.5443750  1.137428999 -1.54672601
## [281,]  0.699896351 -0.08008176 -1.4556250  0.254033979 -0.44672611
## [282,]  0.376726253 -0.09697157 -1.4556250  0.447818647  0.65327380
## [283,]  0.391936206 -0.09440982 -1.4556250  0.673375288 -1.44672611
## [284,]  0.206346173 -0.05181530 -1.4556250  0.860792280 -0.34672620
## [285,]  0.096896271 -0.06372038 -0.7856249  0.930942671  1.55327341
## [286,] -0.098103759 -0.07765597  0.5443750  1.114294233  1.05327341
## [287,] -0.025713802 -0.09400669  0.5443750  1.399568647 -0.04672601
## [288,] -0.146993829 -0.15641588  0.5443750 -0.878570513  0.45327399
## [289,] -0.266153787  0.11599860  0.5443750 -0.855662798  1.85327360
## [290,] -0.099593730  0.36409238  0.5443750 -0.705911822 -0.84672620
## [291,] -0.198493784  0.33249292  0.5443750 -0.573409380 -1.44672611
## [292,] -0.159433824  0.31067279  0.5443750 -0.464070025 -1.34672620
## [293,] -0.278543724  0.28513101  0.5443750 -0.343750201 -0.94672611
## [294,] -0.283043759  0.25516269  0.5443750 -0.042808794 -2.44672611
## [295,]  0.017246217  0.19825950 -2.4556250 -0.211916216 -0.44672611
## [296,] -0.249963763  0.17051694 -2.4556250  0.015929975 -0.44672611
## [297,]  0.110496200  0.14196381 -2.4556250  0.416780561 -2.14672640
## [298,]  0.109086264  0.11836478 -2.4556250  0.871851850 -2.54672601
## [299,] -0.025653848  0.10206911 -0.9556250  1.100015913 -2.64672640
## [300,]  0.131086286  0.08299401  0.5443750  1.304490522 -3.74672630
## [301,]  0.275536164  0.06061313  0.5443750  2.078732710 -4.54672625
## [302,] -0.435413807  0.24569389  0.5443750 -0.342922564  0.35327360
## [303,] -0.419643751  0.21610180  0.5443750 -0.281628130 -1.24672630
## [304,] -0.243073722  0.18564507  0.5443750  0.009690229 -2.34672620
## [305,] -0.329963790  0.16047278  0.5443750  0.508825483 -1.74672630
## [306,] -0.097393771  0.14309075  0.5443750  0.975663374 -2.34672620
## [307,] -0.311103780  0.12274399  0.5443750  1.396869428 -3.14672640
## [308,] -0.259893844  0.09887102  0.5443750  1.660874311 -3.44672611
## [309,] -0.291963792 -0.28149703  0.5443750 -0.584071001  4.75327418
## [310,] -0.419073753 -0.28169750  0.5443750  0.505062788  3.85327360
## [311,] -0.325103741 -0.29136696  0.5443750 -0.015825396  2.15327380
## [312,] -0.352983756 -0.29935874  0.5443750 -0.094189654  0.75327418
## [313,] -0.465273755 -0.30487724  0.5443750  0.275930952  0.85327360
## [314,] -0.321623796 -0.31133698  0.5443750  0.597572553  0.25327370
## [315,] -0.366603766 -0.31891623  0.5443750  1.105168256 -1.14672640
## [316,]  0.254306229 -0.03689203 -2.4556250 -2.316040728  6.55327341
## [317,]  0.124606173 -0.05546585 -1.9556250 -1.932536333 10.65327380
## [318,]  0.204556287 -0.07458237 -1.4556250 -1.396142779  7.65327380
## [319,]  0.128976259 -0.09038207 -1.4556250 -1.349435747  5.65327380
## [320,]  0.254806233 -0.10129210 -0.7856249 -1.003438677  4.45327399
## [321,]  0.442426113 -0.11406300  0.5443750 -0.646677447  3.45327399
## [322,]  0.411586240 -0.12904713  0.5443750 -0.489887408  2.55327341
## [323,] -0.418023832 -0.34022497 -2.4556250 -0.980930376  3.35327360
## [324,] -0.513163817 -0.34697159 -2.4556250 -0.706007525  3.05327341
## [325,] -0.314273769 -0.35391533 -1.9556250 -0.463812701 -0.04672601
## [326,] -0.482323798 -0.35965429 -1.4556250 -0.209264361 -0.14672640
## [327,] -0.478663845 -0.36361718 -0.7856249  0.145618452 -0.34672620
## [328,] -0.382443817 -0.36825599  0.5443750  0.471224897 -1.24672630
## [329,] -0.378243843 -0.37369873  0.5443750  0.854436811 -3.04672601
## [330,]  1.900736112 -0.45955670 -1.4556250  2.464157514 -1.54672601
## [331,]  1.312266264 -0.46165048 -1.4556250  1.913501264  1.05327341
## [332,]  1.019986099 -0.46380543 -1.4556250  2.103401655 -1.04672601
## [333,]  0.945806256 -0.46558649 -1.4556250  2.720257124 -0.24672630
## [334,]  1.273166141 -0.46681635 -1.4556250  2.728577436  1.65327380
## [335,]  0.592206358 -0.46825598 -1.4556250  3.062296186  1.25327418
## [336,]  1.195466190 -0.46994511 -0.9556250  3.921361616 -1.04672601
##              perinc
##   [1,] -3336.032189
##   [2,] -3147.386681
##   [3,] -2771.393517
##   [4,] -2547.557579
##   [5,] -2218.677697
##   [6,] -1936.184533
##   [7,] -1511.560509
##   [8,] -1571.115197
##   [9,] -1186.376915
##  [10,]  -614.250939
##  [11,]  -153.489220
##  [12,]   227.142616
##  [13,]   360.815467
##  [14,]   527.900428
##  [15,] -3612.881798
##  [16,] -3446.698204
##  [17,] -2963.701134
##  [18,] -2730.820275
##  [19,] -2480.803673
##  [20,] -2343.184533
##  [21,] -2119.837853
##  [22,]  1916.951210
##  [23,]  2089.999061
##  [24,]  2709.924842
##  [25,]  3104.985389
##  [26,]  3475.852577
##  [27,]  3965.815467
##  [28,]  4168.901405
##  [29,]  1202.154335
##  [30,]  1251.696327
##  [31,]  1606.628944
##  [32,]  1689.730507
##  [33,]  1735.914100
##  [34,]  1724.815467
##  [35,]  1964.858436
##  [36,]  3375.184608
##  [37,]  3864.081092
##  [38,]  4880.254921
##  [39,]  5432.315467
##  [40,]  6272.549842
##  [41,]  7311.815467
##  [42,]  8313.270546
##  [43,]   383.539100
##  [44,]   619.815467
##  [45,]  1045.089882
##  [46,]  1528.713905
##  [47,]  1942.312538
##  [48,]  2526.815467
##  [49,]  3117.889686
##  [50,]  -377.797814
##  [51,]    44.126991
##  [52,]   427.507850
##  [53,]   880.408241
##  [54,]  1221.982460
##  [55,]  1703.815467
##  [56,]  2099.603553
##  [57,] -2105.721642
##  [58,] -1642.798790
##  [59,]  -923.041954
##  [60,]  -515.777306
##  [61,]    11.456092
##  [62,]   425.815467
##  [63,]   807.014686
##  [64,] -2801.425743
##  [65,] -2533.854454
##  [66,] -2493.371056
##  [67,] -2420.438439
##  [68,] -2338.388634
##  [69,] -2021.184533
##  [70,] -1690.579064
##  [71,]   863.251991
##  [72,]   865.228553
##  [73,]  1509.925819
##  [74,]  1722.569374
##  [75,]  2108.463905
##  [76,]  2536.815467
##  [77,]  3035.118202
##  [78,] -1597.368126
##  [79,] -1515.505822
##  [80,]  -871.393517
##  [81,]  -719.167931
##  [82,]  -298.141564
##  [83,]    56.815467
##  [84,]   483.626991
##  [85,]  -911.210900
##  [86,] -1306.790001
##  [87,]  -676.887658
##  [88,]  -528.489220
##  [89,]   -68.006798
##  [90,]   403.815467
##  [91,]   231.460975
##  [92,]   214.087928
##  [93,]    37.247108
##  [94,]   428.606483
##  [95,]   751.170936
##  [96,]  1097.111366
##  [97,]  1271.815467
##  [98,]  1287.284217
##  [99,] -2808.585900
## [100,] -2966.193322
## [101,] -2438.426720
## [102,] -2474.463829
## [103,] -2277.500939
## [104,] -1872.184533
## [105,] -1539.472618
## [106,] -1666.581017
## [107,] -1885.918908
## [108,] -1862.602501
## [109,] -1907.726525
## [110,] -2277.500939
## [111,] -2365.184533
## [112,] -2049.578087
## [113,] -2437.463829
## [114,] -2084.313439
## [115,] -1608.755822
## [116,] -1271.074181
## [117,]  -588.130822
## [118,]   103.815467
## [119,]   658.794960
## [120,]  1317.906288
## [121,]  1764.310585
## [122,]  2433.001991
## [123,]  3041.424842
## [124,]  3595.563514
## [125,]  4286.815467
## [126,]  4875.348671
## [127,]  1335.805702
## [128,]  1921.420936
## [129,]  2854.979530
## [130,]  3391.001014
## [131,]  4265.327186
## [132,]  5169.815467
## [133,]  6154.463905
## [134,]  -633.167931
## [135,]  -273.533165
## [136,]   437.397499
## [137,]   950.324257
## [138,]  1398.453163
## [139,]  1537.815467
## [140,]  2050.517616
## [141,]   -98.561486
## [142,]   -39.587853
## [143,]   853.881874
## [144,]  1102.866249
## [145,]  1584.211952
## [146,]  2029.815467
## [147,]  2167.938514
## [148,] -4326.485314
## [149,] -4366.422814
## [150,] -4087.876915
## [151,] -4082.514611
## [152,] -3883.280236
## [153,] -3577.184533
## [154,] -3181.435509
## [155,]  -911.210900
## [156,]  -693.257775
## [157,]  -152.711876
## [158,]   153.713905
## [159,]   488.236366
## [160,]   767.815467
## [161,]   991.807655
## [162,] -1846.771447
## [163,] -1926.055626
## [164,] -1973.590783
## [165,] -2210.693322
## [166,] -1803.817345
## [167,] -1589.184533
## [168,] -1497.123986
## [169,]  -688.060509
## [170,]  -960.459923
## [171,]  -339.525353
## [172,]  -145.014611
## [173,]    90.919960
## [174,]   419.815467
## [175,]   339.256874
## [176,]  1033.896522
## [177,]   983.347694
## [178,]  1334.101600
## [179,]  1684.433632
## [180,]  2096.080116
## [181,]  2531.815467
## [182,]  2973.520546
## [183,]   -46.055626
## [184,]   782.659217
## [185,]  1571.463905
## [186,]  2400.536171
## [187,]  3251.911171
## [188,]  4025.815467
## [189,]  4824.338905
## [190,]  2785.686561
## [191,]  3395.043983
## [192,]  4185.749061
## [193,]  4781.891639
## [194,]  5540.868202
## [195,]  6432.815467
## [196,]  7288.247108
## [197,] -2532.929650
## [198,] -2591.193322
## [199,] -2340.623986
## [200,] -2018.956017
## [201,] -2054.590783
## [202,] -1982.184533
## [203,] -1860.935509
## [204,]  1278.526405
## [205,]  1693.209999
## [206,]  2454.980507
## [207,]  2828.501014
## [208,]  3445.924842
## [209,]  4124.815467
## [210,]  4700.180702
## [211,] -2801.425743
## [212,] -2424.909142
## [213,] -1791.173790
## [214,] -1526.371056
## [215,] -1041.174767
## [216,]  -555.184533
## [217,]  -113.100548
## [218,] -1326.485314
## [219,] -1490.276329
## [220,] -1190.074181
## [221,] -1219.167931
## [222,] -1062.846642
## [223,]  -909.184533
## [224,] -1528.884728
## [225,]  -840.804650
## [226,]  -643.946251
## [227,]   -95.569298
## [228,]   112.400428
## [229,]   399.485389
## [230,]   717.815467
## [231,]  1072.654335
## [232,]  -327.678673
## [233,] -1095.781212
## [234,]  -998.866173
## [235,]  -975.523400
## [236,] -1223.837853
## [237,] -1273.184533
## [238,] -1057.278283
## [239,] -1253.693322
## [240,]  -954.725548
## [241,]  -634.030236
## [242,]  -504.124962
## [243,]  -231.061486
## [244,]   138.815467
## [245,]   446.090858
## [246,]  -228.632775
## [247,]  -173.762658
## [248,]   107.727577
## [249,]   476.806678
## [250,]   832.921913
## [251,]  1319.815467
## [252,]  1743.492225
## [253,]  -553.215783
## [254,]  -121.010704
## [255,]   431.903358
## [256,]   715.154335
## [257,]  1229.207069
## [258,]  1752.815467
## [259,]  2377.755897
## [260,] -3486.389611
## [261,] -3186.376915
## [262,] -2719.745079
## [263,] -2510.481408
## [264,] -2205.261681
## [265,] -1853.184533
## [266,] -1439.375939
## [267,] -2556.795861
## [268,] -2788.441368
## [269,] -2218.646447
## [270,] -2195.862267
## [271,] -1704.746056
## [272,] -1335.184533
## [273,] -1603.956993
## [274,] -2892.118126
## [275,] -2696.698204
## [276,] -2175.789025
## [277,] -1960.693322
## [278,] -1508.667931
## [279,] -1004.184533
## [280,]  -527.922814
## [281,]    62.536171
## [282,]  -187.524376
## [283,]   159.376014
## [284,]   389.942421
## [285,]    70.280311
## [286,]     8.815467
## [287,]   158.314491
## [288,] -3091.401329
## [289,] -3100.368126
## [290,] -2759.305626
## [291,] -2595.226525
## [292,] -2540.659142
## [293,] -2491.184533
## [294,] -2144.862267
## [295,] -1815.745079
## [296,] -1693.257775
## [297,] -1199.964806
## [298,]  -767.896447
## [299,]  -139.214806
## [300,]   444.815467
## [301,]   847.438514
## [302,]    -1.903283
## [303,]   419.126991
## [304,]  1026.409217
## [305,]  1442.908241
## [306,]  2035.192421
## [307,]  2605.815467
## [308,]  3131.364296
## [309,]   462.297889
## [310,]   654.218788
## [311,]   878.057655
## [312,]  1029.773475
## [313,]  1495.459999
## [314,]  1749.815467
## [315,]  1974.483436
## [316,] -3131.974572
## [317,] -3428.349572
## [318,] -3238.426720
## [319,] -3210.693322
## [320,] -2991.639611
## [321,] -2888.184533
## [322,] -2585.670861
## [323,]  -666.581017
## [324,]  -588.900353
## [325,]   -61.502892
## [326,]    72.145546
## [327,]   471.724647
## [328,]   839.815467
## [329,]  1061.105507
## [330,]   720.053749
## [331,]  -305.643517
## [332,]  -424.140587
## [333,]  -284.845665
## [334,]  -753.249962
## [335,] -1161.184533
## [336,]  -782.013634
```

```r
# arg 1: velger et par numeriske variabler fra datasett, siden center ikke virker på factor
# arg 2: angir om operasjonen skal utføres på rader (1) eller kolonner (2), arg 3: angir
# funksjonen som skal anvendes
```


**Oppgave:**

Lag en funksjon som først snur skalaretningen til en numerisk variabel. Test først på variabelen `state` i datasettet `beer`. Deretter anvender du funksjonen på alle numeriske variabler i `beer` ved hjelp av `apply`

## Plot-funksjoner

Vi skal stort sett bruke funksjonen `ggplot()` fra pakken `ggplot2` til å lage plot. I tillegg til denne funksjonen kommer jeg noen ganger til å bruke funksjonen `plot()`. Jeg synes imidlertid det er lettere å bruke `ggplot()`, syntaksen ligner på databehandling med `dplyr()`, men i stedet for å bruke `%>%` bruker vi `+` for å binde sammen funksjoner.


```r
# install.packages('ggplot2') # Kjør dersom ggplot2 ikke er installert
library(ggplot2)
```

Histogram:


```r
ggplot(beer, aes(mrall)) + geom_histogram(bins = 50)
```

![](Introduksjon_files/figure-html/unnamed-chunk-28-1.png)<!-- -->

Scatterplot:


```r
ggplot(beer, aes(x = beertax, y = mrall, col = jaild)) + geom_point()
```

![](Introduksjon_files/figure-html/unnamed-chunk-29-1.png)<!-- -->

Scatterplot med regresjonslinje

```r
ggplot(beer, aes(x = beertax, y = mrall)) + geom_point() + geom_smooth(method = "lm")
```

![](Introduksjon_files/figure-html/unnamed-chunk-30-1.png)<!-- -->

Scatterplot for hvert år separat: 


```r
ggplot(beer, aes(x = beertax, y = mrall, col = jaild)) + geom_point() + facet_wrap(~year)
```

![](Introduksjon_files/figure-html/unnamed-chunk-31-1.png)<!-- -->

## Teaser:


```r
m1 <- lm(mrall ~ beertax + jaild, data = beer)
summary(m1)  # høyere skatt fører til flere dødsfall i trafikken per 10000 innbygger. Kan det være rett????
```

```
## 
## Call:
## lm(formula = mrall ~ beertax + jaild, data = beer)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -0.98309 -0.37706 -0.07491  0.29783  2.38288 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  1.74372    0.04561  38.230  < 2e-16 ***
## beertax      0.37758    0.05935   6.362 6.58e-10 ***
## jaildyes     0.36791    0.06308   5.832 1.30e-08 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.5187 on 333 degrees of freedom
## Multiple R-squared:  0.1774,	Adjusted R-squared:  0.1724 
## F-statistic:  35.9 on 2 and 333 DF,  p-value: 7.591e-15
```

`lm()` er funksjonen for lineær regresjon i R. Dere har fått et brukbart fundament for å forstå hva som kan være galt med denne regresjonen, men dere kommer trolig til å forstå enda bedre etter forelesningen om paneldata senere i høst.

**Oppgave:** Utforsk grunnlaget for regresjonen over ved hjelp av plot + nye kontrollvariabler.



