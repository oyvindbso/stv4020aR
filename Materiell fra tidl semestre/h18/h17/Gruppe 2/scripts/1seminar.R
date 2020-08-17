#' ## R som kalkulator
#' 
#' R (og de fleste andre programmeringsspråk) er enkelt sagt veldig avanserte kalkulatorer:
## ----Plussminus----------------------------------------------------------

1 + 2  # Dette er linjen med kode jeg sender til console. 

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

(100.5:0.5)[23]

#' 
#' Den siste linjen viser indeksnummerene til flere av verdiene i rekken tall vi spør om: tall nummer 12 i rekken tall er 89.5. Hvor mange verdier er det totalt i denne rekken?
#' 
#' R er det vi kaller et objektorientert programeringsspråk: vi lager objekter og jobber med disse objektene. Objektene kan være forskjellige klasse/målenivå (heltall, desimaltall, tekst, rangert, osv)
## ----Objekter------------------------------------------------------------
Tiern <- 1:10

Tiern

Tiern * Tiern

Tiern[c(1, 10, 3)] 

tekst <- c("A", "B", "C") # SKRIV DETTE I DOKUMENTET 

tekst[2]
tekst[c(3, 1, 2)]


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
## setwd("~/R/der/du/vil/jobbe/fra")
## 
setwd("~/Dropbox/PhD/Undervisning/Seminarleder/STV4020/høst_2017/Gruppe 2/")


#' 
#' Etter dette kan du sjekke hvilke filer og mapper som ligger i mappen du jobber fra -- da jobber vi med relative paths:
## ----ls------------------------------------------------------------------
list.files("./docs")

# En mappe under:
list.files("../")

# En mappe under, og i mappen scripts
list.files("../Gruppe 1/scripts/")


#' 
#' Det kan være lurt å sette seg inn i jobbe med prosjekter (den blå kuben helt øverst til høyre i R-studio), men vi får dessverre ikke tid å gå gjennom det her.
#' 
#' ## Datasett
#' Det vi jobber mest med er to-dimensjonale dataset: variabler er kolonner, enheter er rader og hver celle er en verdi. Nedenfor laster vi inn et datasett vi kan jobbe med videre dette seminaret. Data er passasjerer fra Titanic og variabler på om de overlevde, klasse, pris, osv. Dere kan enten laste ned data ved å skrive inn nettaddressen under i nettleseren og legge denne filen i mappen dere jobber fra:
#' 
## ----Titanic2, eval=FALSE------------------------------------------------
## setwd("~/Der/du/vil/jobbe/fra")
## 
passengers <- read.csv("./data/titanic.csv")
## 

#' 
#' Eller dere kan laste den direkte inn i R via linken:
## ----Titanic-------------------------------------------------------------

passengers <- read.csv("https://folk.uio.no/martigso/stv4020/titanic.csv")

#' 
#' La oss se på noen helt basic funksjoner vi kan bruke på datasettet:
## ----dataset_basic, eval=FALSE-------------------------------------------
class(passengers)
head(passengers)
tail(passengers)
colnames(passengers)

#' 
## ----View, eval = FALSE--------------------------------------------------
View(passengers) # Denne gir et vindu med data i, men man kan også trykke i "Environment"

#' 
#' Allerede nå er det kommet mange **funksjoner** vi bruker. Funksjoner er en slags "sort-boks" vi sender informasjon til, for så å få ut det funksjonen er definert til å gi oss, gitt data vi putter inn. Funksjonen *head()* for eksempel er definert til å vise de første enhetene i en vektor, dataset, matrise eller tabell. Det er veldig nyttig å se på hjelpefilene til funksjonene man bruker:
#' 
## ----Hjelp, eval = FALSE, tidy = FALSE-----------------------------------
?head
## 

#' 
#' Da får vi opp bildet nedenfor i vinduet nede til høyre. Her har vi først en kort beskrivelse av hva funksjonen gjør, så hvordan den brukes. Disse lærer man seg å lese etter hvert som man jobber med hjelpefilene. Den viktigste seksjonen i starten er **Arguments**; her listes argumentene man kan gi til funksjonen og beskrivelse av hva disse skal være. Så funksjonen `head()` tar argumentene *x* og *n*, hvor den første er et objekt (f.eks et dataset) og den andre er et enkelt heltall/integer (f.eks 4) som gir antall elementer man skal vise med funksjonen. Legg merke til at *n* har 6 som default -- disse verdiene står i seksjonen **Usage**. Derfor fikk vi 6 linjer når vi skrev `head(passengers)` over, uten å spesifiser *n*. Det er også viktig å spesifisere argumentene riktig; hvis vi gjør det i rekkefølgen **Usage** viser, slipper vi å skrive `n = 4` for eksempel:
#' 
## ----Head_eks------------------------------------------------------------
head(passengers, 8)
head(n = 1, x = passengers)

#' 
#' Koden under vil gi en feilmelding fordi objektet *passengers* ikke er et enkelt heltall:
## ----Head_eks2, eval=FALSE-----------------------------------------------
head(1, passengers)

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
barplot(table(passengers$Pclass)) #Vi trenger ikke gå innom objektet
## 

#' 
#' Noen ganger trenger vil å håndere data som er **missing** (variabler vi ikke har informasjon om på noen/alle enheter). Enheter med missing tar verdien `NA` ("Not Available") i R. Kodelinjen nedenfor viser at vi ikke får sjekket gjennomsnitt på alder; vi kan ikke regne gjennomsnitt på rekker med tall som har `NA` i seg. Vi kartlegger derfor hvor mange missing vi har på aldervariabelen. `is.na()` sjekker for hver rad i datasettet om enheten har missing på aldersvariabelen og gir `TRUE` hvis den har det og `FALSE` hvis den ikke har det. `table()` teller opp disse to kategoriene. På den siste linjen sier vi at vi skal regne gjennomsnitt for alder ved å fjerne alle missing. Hvor mange enheter har missing på variabelen?
#' 
## ----missing-------------------------------------------------------------
mean(passengers$Age)


mean(passengers$Age, na.rm = TRUE)
?mean
#' 
#' ## Litt omkoding
#' 
#' Ofte er vi heller ikke fornøyd med hvordan data er strukturert. Her er en av hovedfordelene med R; vi kan gjøre så og si hva som helst for å få dataene i det formatet vi ønsker. La oss si at vi, for eksempel, har en hypotese om at eldre personer hadde mindre sannsynlighet for å overleve enn yngre personer. Som dere husker fra forelesning :) kan det være lurt å sentrere variabler som alder fordi vi sjelden har et naturlig nullpunkt, som igjen gjør at konstantleddet i en evt regresjon ikke gir substansiell mening. La oss derfor sentrere alder:
#' 
## ----omkoding------------------------------------------------------------
median(passengers$Age, na.rm = TRUE)
passengers$age_cent <- passengers$Age - median(passengers$Age, na.rm = TRUE)

table(passengers$age_cent, passengers$Age)

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
#' 
## ----regplot2------------------------------------------------------------
ggplot(passengers, aes(x = Age, y = Survived, color = Sex)) +
  geom_smooth(method = "lm") 

# Andre problemer, gitt denne ukens forelesningstematema?
ggplot(passengers, aes(x = Age, y = Survived, color = Sex)) +
  geom_smooth(method = "lm") + 
  geom_point()

#' 
#' 
#' Bonus for \LaTeX elskere:
## ----stargazer,results='asis'--------------------------------------------
# install.packages("stargazer")
library(stargazer)
stargazer(pass_reg, star.cutoffs = c(.05, .01, .001), ci = TRUE)
