#' ---
#' title: "Seminar 1"
#' author: "Martin Søyland"
#' date: "`r format(Sys.time(), '%d %B, %Y')`"
#' output: pdf_document
#' urlcolor: cyan
#' ---
#' 
## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, tidy.opts = list(width.cutoff = 90), tidy = TRUE)


#' 
#' # Seminaropplegg
#' 
#' ## Seminarrekka
#' 
#' | Dato              | Tid             | Aktivitet                         | Sted                |
#' |-------------------|-----------------|-----------------------------------|---------------------|
#' | ma. 28. aug.      | 10:15–12:00     | Seminar i databehandling R 2      | ES PC-stue 351      |
#' | ma. 11. sep.      | 10:15–12:00	    | Seminar i databehandling R 2      | ES PC-stue 351	    |
#' | **to. 14. sep.**  | **08:15–10:00**	| **Seminar i databehandling R 2**  | **ES PC-stue 351**  |
#' | ma. 18. sep.      | 10:15–12:00	    | Seminar i databehandling R 2      | ES PC-stue 351	    |
#' | ma. 25. sep.      | 10:15–12:00	    | Seminar i databehandling R 2      | ES PC-stue 351	    |
#' | ma. 2. okt.       | 10:15–12:00	    | Seminar i databehandling R 2      | ES PC-stue 351	    |
#' | **ma. 9. okt.**   | **10:15–12:00** | **Obligatorisk prøve**            | **ES PC-stue 351**	|
#' 
#' ## Linker
#' - [Last ned R](http://cran.uib.no/)
#' - [Last ned Rstudio](https://www.rstudio.com/products/rstudio/download/#download)
#' - [R cheat sheet](https://s3.amazonaws.com/quandl-static-content/Documents/Quandl+-+R+Cheat+Sheet.pdf)
#' - [Stilguide for R](https://google.github.io/styleguide/Rguide.xml)
#' - [Mappestruktureringsforslag](https://nicercode.github.io/blog/2013-04-05-projects/)
#' - [Bruke prosjekter i R](https://support.rstudio.com/hc/en-us/articles/200526207-Using-Projects)
#' - [Guide til ggplot2](http://docs.ggplot2.org/current/)
#' - [Data fra Fivethirtyeight](https://github.com/fivethirtyeight/data)
#' - [Facebookgruppe for R](https://www.facebook.com/groups/427792970608618/)
#' 
#' 
#' # Grunnleggende (repetisjon fra STV1020)
#' For de som starter helt fra scratch med R vil jeg anbefale å gå gjennom [materiellet fra STV1020](https://github.com/martigso/stv1020R).
#' 
#' I dette dokumentet skal vi gå gjennom det mest grunnleggende med R. Det første man må gjøre er å installere [R](http://cran.uib.no/) og [Rstudio](https://www.rstudio.com/products/rstudio/download/#download) (den siste er valgfri, men sterkt anbefalt). Du skal da få opp et vidu som ser ut som dette:
#' 
## ----echo = FALSE--------------------------------------------------------
knitr::include_graphics("../pics/RStudio.png")

#' 
#' 
#' 
#' ## Script og konsoll
#' 
#' På bildet over viser tre vindu:
#' 
#' 1. Til venstre viser console. Dette er motoren til R; det er her vi får ut kodene vi skal kjøre.
#' 2. Oppe til høyre har vi Environment. Her kommer *objektene* vi lagrer
#' 3. Nede til høyre er filene i mappen vi jobber fra. Her er det også tabs for plot (figurer), pakker og hjelp
#' 
#' Men vi mangler ett vindu; vinduet der vi skriver inn koden har ikke kommet opp enda. For å få dette opp trykker vi på arket helt overst til venstre (under "File") og så på "R Script" fra rullegardinmenyen (eventuelt kan man bruke hurtigtasten Ctrl/Cmd + Shift + N). Vinduet som da dukker opp er det vi skal tilbringe mest tid i; det er her vi skriver den **reproduserbare** koden som R skal gjøre om til outputen vi vil ha. For å sende en linje med kode fra **script** til **console** kan vi bruke knappen *run* øverst til høyre i script-vinduet, eller bare trykke Ctrl / Cmd + Enter når markøren står på linjen vi vil sende. 
#' 
#' ## R som kalkulator
#' 
#' R (og de fleste andre programmeringsspråk) er enkelt sagt veldig avanserte kalkulatorer:
## ----Plussminus----------------------------------------------------------
1 + 2 # Dette er linjen med kode jeg sender til console. 
# Linjen over er det console gir meg som svar

3 * 4
10 / 2

4 * (10 / 1.5)

# De to neste linjene er sannhetsevalueringer; 
  # er det på venstresiden de samme som det på høyresiden av likhetstegnene?

2 * 2 == 4 

2 * 2 == 5



#' 
#' 
#' ## Indeksering, vektorer og objekter
#' Legg merke til at det kommer opp [1] før outputen vi forventer. Dette er R sin måte å vise til en verdis **indeks** i en rekke med tall. Alle linjene over har kun 1 verdi som svar. Men det er veldig sjelden vi opererer med bare 1 verdi om gangen; vi bruker da heller **vektorer** av verdier:
#' 
## ----Vektorer------------------------------------------------------------
1:10

2 * 1:10

1:10 / 1:10

100.5:0.5

#' 
#' Den siste linjen viser indeksnummerene til flere av verdiene i rekken tall vi spør om: tall nummer 12 i rekken tall er 89.5. Hvor mange verdier er det totalt i denne rekken?
#' 
#' R er det vi kaller et objektorientert programeringsspråk: vi lager objekter og jobber med disse objektene. Objektene kan være forskjellige klasse/målenivå (heltall, desimaltall, tekst, rangert, osv)
## ----Objekter------------------------------------------------------------
Tiern <- 1:10

Tiern

Tiern * Tiern

Tiern[4] 

ABC <- c("A", "B", "C")

ABC[2]
ABC[c(3,1,2)]


#' 
#' ## Datasett
#' Det vi jobber mest med er to-dimensjonale dataset: variabler er kolonner, enheter er rader og hver celle er en verdi. Nedenfor laster vi inn et datasett vi kan jobbe med videre dette seminaret. Data er passasjerer fra Titanic og variabler på om de overlevde, klasse, pris, osv.
#' 
## ----Titanic-------------------------------------------------------------
data_url <- "https://folk.uio.no/martigso/stv4020/titanic.csv"
passengers <- read.csv(data_url)

class(passengers)

head(passengers)
# tail(passengers)
colnames(passengers)

#' 
## ----View, eval = FALSE--------------------------------------------------
## View(passengers) # Denne gir et vindu med data i.

#' 
#' Allerede nå er det kommet mange **funksjone** vi bruker. Funksjoner er en slags "sort-boks" vi sender informasjon til, for så å få ut det funksjonen er definert til å gi oss, gitt data vi putter inn. Funksjonen *head()* for eksempel er definert til å vise de første enhetene i en vektor, dataset, matrise eller tabell. Det er veldig nyttig å se på hjelpefilene til funksjonene man bruker:
#' 
## ----Hjelp, eval = FALSE, tidy = FALSE-----------------------------------
## ?head
## 

#' 
#' Da får vi opp bildet nedenfor i vinduet nede til høyre. Her har vi først en kort beskrivelse av hva funksjonen gjør, så hvordan den brukes. Disse lærer man seg å lese etter hvert som man jobber med hjelpefilene. Den viktigste seksjonen i starten er **Arguments**; her listes argumentene man kan gi til funksjonen og beskrivelse av hva disse skal være. Så funksjonen `head()` tar argumentene *x* og *n*, hvor den første er et objekt (f.eks et dataset) og den andre er et enkelt heltall/integer (f.eks 4) som gir antall elementer man skal vise med funksjonen. Legg merke til at *n* har 6 som default -- disse verdiene står i seksjonen **Usage**. Derfor fikk vi 6 linjer når vi skrev `head(passengers)` over, uten å spesifiser *n*. Det er også viktig å spesifisere argumentene riktig; hvis vi gjør det i rekkefølgen **Usage** viser, slipper vi å skrive `n = 4` for eksempel:
#' 
## ----Head_eks------------------------------------------------------------
head(passengers, 1)
head(n = 1, x = passengers)

#' 
#' Koden under vil gi en feilmelding fordi objektet *passengers* ikke er et enkelt heltall:
## ----Head_eks2, eval=FALSE-----------------------------------------------
## head(1, passengers)

#' 
## ----echo = FALSE, fig.align='center'------------------------------------
knitr::include_graphics("../pics/head_man.png")

#' 
#' ## Jobbe med variabler i dataset
#' 
#' Det første å gjøre når man har et dataset man ikke kjenner godt er å få en oversikt over variablene det inneholder. Nedenfor vises summary for alle variablene i data, summary for bare alder, gjennomsnitt for om passasjeren overlevde, en tabell med antall passasjerer som tilhørte hver av de tre klassene på båten og et histogram over alder.
#' 
## ----data_desc-----------------------------------------------------------

summary(passengers)
summary(passengers$Age)

mean(passengers$Survived)

table(passengers$Pclass)

hist(passengers$Age)


#' 
#' 
#' Personlig liker jeg figurer bedre enn tabeller, så tabellen kan enkelt illustreres som dette:
#' 
## ----barplot-------------------------------------------------------------
klassetabell <- table(passengers$Pclass)
barplot(klassetabell)

#' 
## ----barplot2, eval=FALSE------------------------------------------------
## barplot(table(passengers$Pclass)) #Vi trenger ikke gå innom objektet
## 

#' 
#' Noen ganger trenger vil å håndere data som er **missing** (variabler vi ikke har informasjon om på noen/alle enheter). Enheter med missing tar verdien `NA` ("Not Available") i R. Kodelinjen nedenfor viser at vi ikke får sjekket gjennomsnitt på alder; vi kan ikke regne gjennomsnitt på rekker med tall som har `NA` i seg. Vi kartlegger derfor hvor mange missing vi har på aldervariabelen. `is.na()` sjekker for hver rad i datasettet om enheten har missing på aldersvariabelen og gir `TRUE` hvis den har det og `FALSE` hvis den ikke har det. `table()` teller opp disse to kategoriene. På den siste linjen sier vi at vi skal regne gjennomsnitt for alder ved å fjerne alle missing. Hvor mange enheter har missing på variabelen?
#' 
## ----missing-------------------------------------------------------------
mean(passengers$Age)

table(is.na(passengers$Age))

mean(passengers$Age, na.rm = TRUE)

#' 
#' ## Litt omkoding
#' 
#' Ofte er vi heller ikke fornøyd med hvordan data er strukturert. Her er en av hovedfordelene med R; vi kan gjøre så og si hva som helst for å få dataene i det formatet vi ønsker. La oss si at vi, for eksempel, har en hypotese om at eldre personer hadde mindre sannsynlighet for å overleve enn yngre personer. Som dere husker fra forelesning :) kan det være lurt å sentrere variabler som alder fordi vi sjelden har et naturlig nullpunkt, som igjen gjør at konstantleddet i en evt regresjon ikke gir substansiell mening. La oss derfor sentrere alder:
#' 
## ----omkoding------------------------------------------------------------
passengers$age_cent <- passengers$Age - median(passengers$Age, na.rm = TRUE)

table(passengers$age_cent[1:10], passengers$Age[1:10])

#' 
#' Over har jeg laget en ny variabel i datasettet *passengers* som heter *age_sent*. Den skal være sentrert til median: vi trekker fra medianen til aldervariabelen fra alle verdier på aldervariabelen. Legg også merke til at jeg validerer at det ble riktig med `table()`.
#' 
#' Først kan vi sjekke korrelasjonen mellom de to variablene våre. Her bruker vi funksjonen `cor()` for bare korrelasjonsestimat, og `cor.test()` for å se om estimatet er signifikant forskjellig fra null:
#' 
## ----korrelasjon---------------------------------------------------------
cor(passengers$age_cent, passengers$Survived)

cor(passengers$age_cent, passengers$Survived, use = "complete.obs")

cor.test(passengers$age_cent, passengers$Survived, use = "complete.obs")


#' 
#' Også her må vi håndtere missingverdier (ref første linje over). Men med korrelasjon er det, som dere vet, forskjellige måter å håndere missing på: pairwise og listwise exclusion. Dette er ikke viktig med korrelasjon mellom bare to variabler, men med flere variabler er det viktig:
#' 
## ------------------------------------------------------------------------
cor(passengers[, c("age_cent", "Survived", "Fare")], use = "complete.obs")
cor(passengers[, c("age_cent", "Survived", "Fare")], use = "pairwise.complete.obs")


#' 
#' 
#' Da gjenstår det bare å kjøre en linær regresjon (OLS) for å teste hypotesen. For dette bruker vi funksjonen `lm()`. Se på hjelpefilen om koden under gir mening.
#' 
#' 
## ----ols-----------------------------------------------------------------
pass_reg <- lm(Survived ~ age_cent, data = passengers)
summary(pass_reg)

#' 
#' Kan dere tenke dere noen variabler som er viktigere her?
#' 
#' 
