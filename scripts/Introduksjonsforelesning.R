############################################
### Introduksjonsforelesning R  ############
### Erlend Langørgen            ############
### 16.08.2019                  ############
############################################

## Velkommen!
## La oss starte med å kjøre litt kode som oppvarming:


"Hello world!"


# R kan brukes som en kalkulator


1 + 1  # addisjon
2 - 3  # subtraksjon
4/2  # divisjon
2 * 2  # multiplikasjon
2^3  # potens
exp(2)  # eksponentiering
log(2)  # logaritme (default er naturlig logaritme)
2 * (4 - 2)/(4 - 2)  # parentesregler fungerer som i vanlig algebra: den innerste parentesen regnes ut først
# kommentarere i R skrives forøvrig etter #



### Logiske tester

#R kan evaluere logiske utsagn, og bedømme om de er `TRUE` eller `FALSE`:


1 == 2  # tester om 1 er lik 2
2 == 2  # tester om 2 er lik 2
"Statsvitenskap" == "statsvitenskap"  # Logiske tester kan også brukes på tekst
"statsvitenskap" == "statsvitenskap"  # R er imidlertid sensitivt til store og små bokstaver.
1 <= 2  # tester om 1 er mindre enn eller lik 2
1 >= 2  # tester om 1 er større eller lik 2
1 != 2  # tester om 1 er ulik 2
1 == 2 | 1 == 1  # tester om en av de to påstandene 1 er lik 2 eller 1 er lik 1 er sanne
1 == 2 & 1 == 1  # tester om begge de to påstandene 1 er lik 2 og 1 er lik 1 er sanne.



#Oversikt over logiske operatorer i dokumentet til forelesningen

#Logiske operatorer er viktig å forstå i R. Dersom vi vil gjøre endringer i et datasett, 
#bruker vi som regel en logisk test.


#**Oppgave 1:** Skriv kode i scriptet ditt for å teste om `"R"` er forskjellig fra `"SPSS"` ved hjelp av logiske utsagn
# (to fremgangsmåter er mulig!). Sjekk deretter om `3` er større eller lik den naturlige logaritmen av `20`.

## Din løsning i script!


## Pakker:

# Gir oss tilgang på ekstra funksjoner m.m. - slik utviklere deler koden sin med andre.

# Syntaks:
#install.packages("pakkenavn") # laster ned filene pakken består av fra nett til PC - må bare gjøres en gang
#library(pakkenavn) # tilgjengeliggjør pakke i R sesjon, må gjøres hver gang du vil bruke kode fra pakken i en ny R sesjon.


# Vi skal for det meste bruke pakker fra tidyverse - du kan installere alle pakkene herfra på følgende måte:


install.packages("tidyverse") 
library(tidyverse)


## Objekter


#**Oppgave 2:** Forklar kort til sidemannen/kvinnen hva et objekt er.

x <- 3  # lager objektet x
y <- 6  # lager objektet y
z <- x + y  # man kan lage objekter fra andre objekter

# Vi kan også gi andre navn til objekter:
gull <- 3
solv <- 1
bronse <- 1
medaljer <- gull + solv + bronse
medaljer


### Variabler/vektorer


## Ved å bruke parenteser rundt denne koden oppretter jeg objektet samtidig som jeg printer
## innholdet i objektet i console.
(x <- 1:3)  # med : teller vi på heltall mellom de to tallene





(y <- c(1:2, gull))  # med c() kan vi kombinere ulike tall/informasjon i den rekkefølgen vi vil. 
# Vi kan også kombinere verdier fra objekter som 'gull'
x==y # Et eksempel på at det ofte er flere veier til samme resultat i R


# Vi kan også bruke `c()` til å lage vektorer med forskjellige typer innhold, som tekst.

sunn_mat <- c("fisk", "potet", "gronnsak")

#**Oppgave 3:** Bind sammen informasjonen i objektene x og sunn_mat til en vektor. Hint: du kan bruke `c()`

# Jeg har skrevet et lite tillegg om variabler, vektorer og forskjellige objekttyper på slutten av dokumentet til forelesningen,
# som jeg anbefaler at du titter gjennom på egenhånd før første seminar.


## Datasett

# Oppretter datasett som objekter


sunn_middag <- tibble(sunn_mat, x)
sunn_middag
test_data <- tibble(x = c(rep(1, 5), rep(0, 5)), y = seq(2, 20, 2), z = rnorm(10), w = "tekst",
                    q = rep(c(1, 2), 5))


#Kjør følgende kode for å laste inn deres første 'ordentlige' datasett i R:


aid <- read_csv("https://raw.githubusercontent.com/langoergen/stv4020aR/master/data/aid.csv")


## Funksjoner 1 - Hva er en funksjon?


#Funksjoner har heldigvis stort sett alltid samme struktur:

#funksjonsnavn(argument1 = , argument2 = , ... argumentK =)

#funksjonsnavn = NAVNET PÅ FUNKSJONEN
#argument = "INSTILLINGER" TIL FUNKSJONEN.
# Disse linjene er ikke gyldig R-kode, men linjene viser den generelle syntaksen til funksjoner i R


#Hjelpesiden til en funksjon finner man ved å kjøre `?funksjonsnavn`.
#Der finner man argumentene til en funksjon, og standardinnstillingene for funksjonen.

#**Merk:** Dersom man skriver argumenter i den rekkefølgen de står i hjelpefilen, 
# trenger man ikke skrive inn argumentnavn. Dersom man ikke følger rekkefølgen i hjelpefilen,
# må man spesifisere argumentnavn.

#**Oppgave 4:** Snakk med naboen din - identifiser minst 2 funksjoner vi har brukt så langt. 
# Åpne hjelpesiden for en av disse funksjonene. Hint: Let etter `funksjonsnavn()`

#Her er noen nyttige funksjoner for å lære mer om datasett:
class(aid)  # Er dette faktisk en data.frame, eller et annet type objekt? Les mer om class i siste del av dokumentet til forelesningen.
names(aid)  # denne funksjonen forteller deg navn du kan referere til i et objekt, mer om dette straks. For datasett er det variabelnavn
head(aid, 5)  # denne funksjonen viser deg de første observasjonene i datasettet.
str(aid) # Denne funksjonen viser deg strukturen til et objekt - du får masse nyttig informasjon om innhold.

#Dere kan også åpne datasettet ved å dobbeltklikke på det i Environment, skriv evt. `View(my_data)`, 
#men ikke lagre denne kommandoen i scriptet ditt som en hovedregel - det er bare irriterende.




#### Indeksering #####
                                                                                                                                                                                                                    

## Vi skal i hovedsak indeksere datasett, variabler og observasjoner på følgende måter i seminarene:
## Flere fremgangsmåter er mulig - velg selv dersom du ikke liker det du ser under (se dokumentet for mer).

aid$country # Velg en variabel fra et datasett med $

aid$country[1:5] # Velg observasjon 1:5 på variabelen country

select(.data = aid, country, period, periodstart, periodend) # Velg flere variabler samtidig

select(.data = aid, 1:4) # Velg flere variabler samtidig basert på posisjon

filter(.data = aid, country == "AFG") # Velg observasjonser basert på verdi på en eller flere variabler spesifisert gjennom en logisk test

slice(aid, 1:5) # Velg rader basert på posisjon i datasettet


aid %>% # datasettargument, R forstår at vi på de neste linjene referer til observasjoner og variabler fra "aid"
select(country, periodstart, periodend, elraid, elrgdpg) %>% # binder sammen funksjoner fra dplyr med %>%
filter(country == "KEN") # Dermed kan vi velge på både variabler og verdiene til observasjoner samtidig

# **Oppgave 5:** Hvordan kan vi velge observasjoner som har positiv verdi både på variabelen elrgdpg (vekst i BNP) og
# variabelen elraid (økonomisk bistand)? Hint: logisk test + filter().
# Dersom du synes dette var greit, kan du kombinere denne filtreringen med å velge de fem første variablene i datasettet.

#### Funksjoner 2 - deskriptiv statistikk og grafikk ####

# Nå er vi klare til å kombinere vår forståelse av indeksering og funksjoner for å utforske datasettet `aid` 
# med deskriptiv statistikk og grafikk!

#### Deskriptiv statistikk.


# Enkle funksjoner som kan brukes til å lære mer om hvordan variabler er fordelt (i hovedsak univariat statistikk):

median(aid$elrgdpg, na.rm = TRUE) # median
sd(aid$elrgdpg, na.rm = TRUE) # standardavvik
quantile(aid$elrgdpg, na.rm = T) # kvantiler, na.rm = TRUE/ na.rm = T betyr at observasjoner med missing-verdier på variabelen kastes ut.
summary(aid$elrgdpg) # diverse deskriptiv statistikk
summary(aid) # Kan også brukes på hele datasettet
table(aid$country) # fint for å se på tabeller som ikke er numeriske.
prop.table(table(aid$country)) # Prosentfordeling med prop.table()
table(aid$country, aid$period) # kan ta flere variabler - legg til enda flere ved hjelp av et ekstra komma og indeksering med $

# Dersom du trenger en funksjon for å gjennomføre en statistisk operasjon eller noe annet, prøv google eller søk med `??mulig_funkskjonsnavn` i R.
                                                                                                          

# **Oppgave 6:** Finn funksjonene for gjennomsnitt, minimumsverdi og maksimumsverid. Åpne hjelpesiden for en av 
# funksjonene, og anvend den på `aid$elrgdpg`.

# Dere finner flere funksjoner for univariat deskriptiv statistikk i pakken `moments`, f.eks. kurtose - `kurtosis()`
# og skjevhet `skewness()`. Syntaks er som for `median()`




### Grafikk med ggplot() ####

# Plot er en ypperlig måte å forstå data og for å skaffe seg en visuell forståelse av hvordan statistiske metoder
# fungerer. Bruk plot hyppig. Vi kommer i hovedsak til å bruke funksjonen ggplot() fra ggplot2 pakken(med i tidyverse).

# install.packages('ggplot2') # Kjør dersom ggplot2 ikke er installert
library(ggplot2) # bør allerede være lastet inn med library(tidyverse)


# Histogram:
ggplot(aid, aes(elrgdpg)) + geom_histogram(bins = 50)

# Kontinuerlig fordeling:
ggplot(aid, aes(elrgdpg)) + geom_density()

# Scatterplot:
ggplot(aid) + geom_point(aes(x = period, y = elrgdpg, col = elraid)) # Viser økonomisk utvikling over tid, 
#punktene fargelegges basert på økonomisk bistand landene fikk i perioden

# Scatterplot med regresjonslinje
ggplot(aid) + geom_point(aes(x = period, y = elrgdpg, col = elraid)) + geom_smooth(aes(x = period, y = elrgdpg), method = "lm") 
# method = "lm" angir lineær regresjon (OLS)

# Scatterplot med flere delplot:
ggplot(aid) + geom_point(aes(x = period, y = elrgdpg, col = elraid)) + facet_wrap(~elrssa) 
# separate paneler land i Afrika Sør for Sahara, og land i andre regioner

#### Funksjoner 3 - skriv din egen funksjon! ####


# Dette er ikke nødvendig for å lykkes med hjemmeoppgaven, men gir deg økt forståelse av funksjoner. 
# Dersom du mestrer å skrive egne funksjoner, vil R bli et mer effektivt redskap. 
# Les mer i del 3 av R for Data Science hvis du vil - dette er bare en smakebit.



#La oss forsøke å sentrere en variabel:
aid$elrgdpg - mean(aid$elrgdpg, na.rm = T)  # kan vi skrive en funksjon for sentreringen vi gjør her?

#  Svaret er ja:
center <- function(min_data_var) { # denne linjen definerer input i funksjonen, den skal alltid ha samme form
centered <- min_data_var - mean(min_data_var, na.rm = T)  # denne linjen/innmat angir hva som skal gjøres med input
return(centered)  # denne linjen angir hvilken output vi vil har, det er andre funksjoner som kan stå på denne linjen i stedet
}
center(aid$elrgdpg) == (aid$elrgdpg - mean(aid$elrgdpg, na.rm = T))  # vi har nå generalisert den første linjen

# arg 1: velger et par numeriske variabler fra datasett, siden center ikke virker på factor
# arg 2: angir om operasjonen skal utføres på rader (1) eller kolonner (2), arg 3: angir
# funksjonen som skal anvendes


# **Bonus-oppgave 1: (vanskelig!)** Lag en funksjon som først snur skalaretningen til en numerisk variabel. 
# Test først på variabelen `elraid` i datasettet `aid`. Deretter anvender du funksjonen på alle numeriske variabler
# i `aid` ved hjelp av `apply()` funksjonen.
# Hint: skriv først funksjonen og test den. Lag deretter ett nytt datasett som bare inneholder tall-variabler
# med `select`. Se deretter på hjelpefilen til `apply()` - du skal spesifisere tre argumenter,
# og et av argumentene skal ha verdien `2`.





#### Et lite tillegg om variabler/vektorer og klasser ####





# La oss opprette x, y og z på nytt:
x <- 1:5
y <- c(1,2,3,4,5)
z <- c(1,2,"tre","fire",5)
# Vi kan utføre matematiske operasjoner på vektorer som bare består av tall. Dette er nyttig for omkoding/opprettelse av variabler. Her er noen eksempler:
x * y
aid$elraid*aid$elrgdpg
x + y
aid$elraid + aid$elrgdpg
x * 2
aid$elraid*2

#Dette fungerer naturlig nok ikke på vektorer som inneholder andre typer verdier enn tall. 
#Forsøk selv for å kontrollere. 


# **Bonus-oppgave 2:** Lag en vektor `w`, bestående av heltall fra 6 til 2 i synkende rekkefølge.
# Bruk deretter matematiske operasjoner på variabelen for å få den til å bli lik variabelen `a`, gitt ved `a <- 1:5`.
# Test om du har fått det til ved å printe verdiene til variablene, samt en logisk test. Hint: `*` og `+`


#Hvilket format tror du x, y og z har? Vi kan sjekke med funksjonen class() eller med str().
class(x)
class(y)
class(z)
class(list(1:5))
class(aid)
class(aid$elraid)


# Vi kan endre på  klasser med funksjoner som as.character, as.numeric m.m.
class(as.character(x))
class(as.list(y))
class(as.numeric(z))
as.numeric(z)
class(unlist(list(1:5)))

#  **Bonus-Oppgave 3:**  Opprett vektoren karaktersnitt, bestående av verdiene `6`, `5` og `4`. 
# Transformer deretter variabelen til `factor` med `as.factor()`. Sjekk at transformasjonen virket med `class()`. 
# Hva skjer dersom du forsøker å transformere variabelen direkte tilbake til tallverdier med `as.numeric()` 
# (inspiser verdiene)? Se om du klarer å løse eventuelle problemer ved ytterligere transformasjoner av klasse. 
# Hint: `as.character()`
