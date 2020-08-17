#' ---
#' title: "Seminar 1"
#' author: "Martin Søyland"
#' output:
#'   pdf_document: default
#'   html_document: html_notebook
#' header-includes: \usepackage{setspace}\onehalfspacing
#' urlcolor: cyan
#' editor_options: 
#'   chunk_output_type: console
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
#' | ~~fr. 24. aug.~~  | ~~10:15–12:00~~ | ~~Seminar i databehandling R 2~~  | ~~ES PC-stue 351~~  |
#' | ti. 11. sep.      | 10:15–12:00	    | Seminar i databehandling R 2      | ES PC-stue 351	    |
#' | fr. 14. sep.      | 10:15–12:00	    | Seminar i databehandling R 2      | HE PC-rom 235       |
#' | ti. 18. sep.      | 10:15–12:00	    | Seminar i databehandling R 2      | ES PC-stue 351	    |
#' | ma. 24. sep.      | 10:15–12:00	    | Seminar i databehandling R 2      | ES PC-stue 351	    |
#' | ti. 2. okt.       | 10:15–12:00	    | Seminar i databehandling R 2      | ES PC-stue 351	    |
#' | ti. 9. okt.       | 10:15–12:00     | Obligatorisk kvalifiseringsprøve  | ES PC-stue 351	    |
#' | ti. 23. okt.      | 14:15–16:00     | Utsatt kvalifiseringsprøve        | ES PC-stue 351	    |
#' 
#' 
#' [Semestersidene](www.uio.no/studier/emner/sv/statsvitenskap/STV4020A/index.html).
#' 
#' ### Egen datamaskin
#' I selve seminarene har dere valget mellom å bruke maskinene som står i seminarrommet via deres UiO-bruker (R er forhåndsinstallert på alle maskinene) eller dere kan bruke egen bærbar PC/Mac. Hvis dere bruker egen maskin forventer jeg at dere har installert både R og RStudio før det første seminaret. 
#' 
#' ### Slack
#' Erlend har satt opp et Slack-team (slack.com) som dere kan bruke gjennom seminarrekka. Hensikten med dette er å tilrettelegge for en platform der dere kan sette frem problemer dere støter på med R (eller med oppgaver til teori-seminarene og spørsmål angående forelesningene) med hverandre, samarbeide om å løse disse, og at spørsmål bare jeg kan svare på blir åpne for alle. Slack er også et verktøy som blir mye brukt i både arbeidsliv og forskning, så det kan være god verdi i å få kjennskap til hvordan det fungerer.
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
#' For de som starter helt fra scratch med R vil jeg anbefale å gå gjennom [materiellet fra STV1020](https://github.com/martigso/stv1020R). Dessuten kan dere gå tilbake til Erlends første seminar for å friske opp i basics.
#' 
#' I dette dokumentet skal vi repetere noe av det mest grunnleggende med R, laste inn data, endre på variabler og kjøre OLS-regresjon. Det første man må gjøre er å installere [R](http://cran.uib.no/) og [Rstudio](https://www.rstudio.com/products/rstudio/download/#download) (den siste er valgfri, men sterkt anbefalt). Du skal da få opp et vidu som ser ut som dette:
#' 
## ----echo = FALSE--------------------------------------------------------
knitr::include_graphics("../pics/RStudio.png")

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
#' 
## ----Objekter------------------------------------------------------------
Tiern <- 1:10

Tiern

Tiern * Tiern

Tiern[4] 

ABC <- c("A", "B", "C")

ABC[2]
ABC[c(3,1,2)]

which(ABC == "A")

ABC[which(ABC == "A")]


#' 
#' ## Working directory og paths
#' De fleste av dere kommer til å jobbe med data som ligger lokalt på datamaskinen deres. Det er derfor viktig at vi skjønner hvordan mappestrukturen på dataen er bygget opp (dette varier mellom mac/windows/linux). Hele tiden når vi skal "snakke" med filer i R, er det viktig å vite hvor i mappestrukturen R mener at vi befinner oss. Koden under får R til å vise oss hvor R jobber fra:
## ----wd------------------------------------------------------------------
getwd() # get working directory

#' 
#' Vi kan også endre dette (her er det viktig å skille mellom mac/windows/linux):
#' 
## ----setwd, eval=FALSE---------------------------------------------------
## # Mac/Linux:
## # setwd("~/R/der/du/vil/jobbe/fra")
## 
## # Windows
## # setwd("C:/Users/Navn/R/der/du/vil/jobbe/fra")

#' 
#' Etter dette kan du sjekke hvilke filer og mapper som ligger i mappen du jobber fra -- da jobber vi med relative paths:
## ----ls------------------------------------------------------------------
list.files()

# En mappe under:
list.files("../")

# En mappe under, og i mappen scripts
list.files("../scripts")


#' 
#' Det kan være lurt å sette seg inn i jobbe med prosjekter (den blå kuben helt øverst til høyre i R-studio), men vi får dessverre ikke tid å gå gjennom det her.
#' 
#' ## Datasett
#' Det vi jobber mest med er to-dimensjonale dataset: variabler er kolonner, enheter er rader og hver celle er en verdi. Nedenfor laster vi inn et datasett vi kan jobbe med videre dette seminaret. Data er passasjerer fra Titanic og variabler på om de overlevde, klasse, pris, osv. Dere kan enten laste ned data ved å skrive inn nettaddressen under i nettleseren og legge denne filen i mappen dere jobber fra:
#' 
## ----Titanic2, eval=FALSE------------------------------------------------
## # setwd("~/Der/du/vil/jobbe/fra")
## 
## passengers <- read.csv("titanic.csv")
## 

#' 
#' Eller dere kan laste den direkte inn i R via linken:
## ----Titanic-------------------------------------------------------------

passengers <- read.csv("https://folk.uio.no/martigso/stv4020/titanic.csv")

#' 
#' La oss se på noen helt basic funksjoner vi kan bruke på datasettet:
## ----dataset_basic, eval=TRUE--------------------------------------------
class(passengers)
head(passengers)
tail(passengers)
colnames(passengers)

#' 
## ----View, eval = FALSE--------------------------------------------------
## View(passengers) # Denne gir et vindu med data i.

#' 
#' Allerede nå er det kommet mange **funksjoner** vi bruker. Funksjoner er en slags "sort-boks" vi sender informasjon til, for så å få ut det funksjonen er definert til å gi oss, gitt data vi putter inn. Funksjonen *head()* for eksempel er definert til å vise de første enhetene i en vektor, dataset, matrise eller tabell. Det er veldig nyttig å se på hjelpefilene til funksjonene man bruker:
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
#' Noen ganger trenger vil å håndere data som er **missing** (variabler vi ikke har informa
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
median(passengers$Age, na.rm = TRUE)
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
## ----korrelasjon_missing, results='hold'---------------------------------
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
#' \newpage
#' 
## ----regplot-------------------------------------------------------------

# install.packages("ggplot")
library(ggplot2)
theme_set(theme_bw())
ggplot(passengers, aes(x = Age, y = Survived)) +
  geom_smooth(method = "lm")

#' 
#' Kan dere tenke dere noen variabler som vi burde inkludere i denne regresjonen?
#' 
#' \newpage
#' 
## ----regplot2------------------------------------------------------------

ggplot(passengers, aes(x = Age, y = Survived, color = Sex)) +
  geom_smooth(method = "lm") + 
  geom_point()

#' 
#' \newpage
#' 
#' Bonus for \LaTeX elskere:
## ----stargazer,results='asis'--------------------------------------------
# install.packages("stargazer")
library(stargazer)
stargazer(pass_reg, star.cutoffs = c(.05, .01, .001), ci = TRUE)

#' 
## ----ikketenkpådenne, eval=FALSE, echo=FALSE-----------------------------
## knitr::purl("./docs/seminar1.Rmd", output = "./scripts/1seminar.R", documentation = 2)
## 

#' 
