####################################################
##### Første R Seminar : en første dataanalyse #####
####################################################

#### Fra introduksjonsforelesningen: Indeksering ####

#### Indeksering #####

# Data fra introforelesning:
aid <-  read_csv("https://raw.githubusercontent.com/langoergen/stv4020aR/master/data/aid.csv")


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

aid %>% # datasettargument, R forstår at vi på de neste linjene referer til observasjoner og variabler fra "aid"
  select(country, periodstart, periodend, elraid, elrgdpg) %>% # binder sammen funksjoner fra dplyr med %>%
  filter(country %in% c("KEN", "ETH", "MOZ", "AGO", "RWA")) # %in% lar oss velge alle verdier fra en vektor

# **Oppgave 5:** Hvordan kan vi velge observasjoner som har positiv verdi både på variabelen elrgdpg (vekst i BNP) og
# variabelen elraid (økonomisk bistand)? Hint: logisk test + filter().
# Dersom du synes dette var greit, kan du kombinere denne filtreringen med å velge de fem første variablene i datasettet.


## Dagens seminar: En første dataanalyse med R.

#I dagens seminar skal vi øve på å forberede og utforske data. Dette er som regel første del av enhver dataanalyse - også hjemmeoppgaven.
#Vi skal også øve på å forstå hjelpefiler til funksjoner.

#### Innhold: #####

# 1. Kort om funksjoner og hjelpefiler
# 2. Forberede og Manipulere data
# 3. Utforsking av data og deskriptiv statistikk
# 4. Plotte-funksjonen ggplot
        
        
## Kort om  funksjoner og hjelpefiler 
        
#En grunnleggende byggestein i R er funksjoner. En funksjon tar i mot verdi(er), 
#gjerne lagret i form av et R-objekt, utfører operasjoner basert på input, 
#og produserer nye verdier. En typisk R-funksjon har følgende *syntaks*:
          
# aFunction(x = "R-objekt", arg = "alternativ for funksjonens oppførsel")
# Merk: dette er ikke en faktisk funksjon i R. Funksjoner kan også ha andre syntakser.

# Funksjoner som c(), log(), summary(), str() og read_csv() er eksempler på funksjoner.
# Dersom vi vil lære mer om en funksjon, kan vi spørre R om hjelp med ?. Kjør ?c() og ?log()
        
# Dersom vi er på jakt etter en funksjon til et spesielt formål, kan vi bruke ?? (eller google).
# Si at vi har lyst til å lage en sekvens av tall, som med : (som teller på heltall), men bare inkludere partall. 
# La oss se om vi kan finne en funksjon til å gjøre dette med følgende kode: ??sequence
        
# Søket med ?? tyder på at funksjonen seq() kan gjøre jobben.
# La oss åpne hjelpefilen til seq() ved hjelp av ?seq()
?seq()        
# **Oppgave:** Bruk to minutter på å lese hjelpefilen, 
# og skriv ned hva du tror de to linjene med kode kommer til å gjøre:
# Når du har skrevet ned et svar, kjør koden og sjekk.
          
seq(from = 2, to = 20, by =2)
seq(from = 20, to = 2, by = -2)

#Dersom en funksjon produserer output av en type som fungerer som input i en annen funksjon,
# kan vi plassere funksjoner inne i andre funksjoner:

c(seq(20 ,2 , -2), rep(1, 2), seq(2, 20, 2))


##### Pakker ####
#install.packages("tidyverse")
library(tidyverse)
install.packages("moments") # dersom pakken allerede er installert trenger du ikke kjøre denne, klikk på packages i viduet nede til høyre for å sjekke, eller se om neste linje med kode kjører uten problemer.
library(moments)

#### Laste inn data - read_funksjoner() ####
        
#### Vi skal starte med å laste inn data som et objekt i R. 
# Funksjoner for å laste inn ulike datatyper har stort sett ganske lik syntaks 
# Det kan være små variasjoner og ulike tilleggalternativ. 
# Dette finner du raskt ut av i hjelpefilen!

#Syntaks:        

# datasett <- read_filtype("filnavn.filtype")
#read_csv("filnavn.csv") # for .csv, sjekk også read.table
# load("filnavn") - filer i R-format - oppretter automatisk objekt.

library(haven)
# Syntaks: Fra haven-pakken - dette skal vi se på i senere seminar
#read_spss("filnavn.sav")  # for .sav-filer fra spss
#read_dta("filnavn.dta") # for .dta-filer fra stata

# Laster inn data fra en url (nettside) - samme datasett som i introforelesning
aid <-  read_csv("https://raw.githubusercontent.com/langoergen/stv4020aR/master/data/aid.csv")



#**Legg merke til:** eksterne filer, som uinstallerte pakker og datasett som ikke er lastet
#inn som objekter, må alltid skrives i " " når vi refererer til dem. 
#Informasjon som er lagret internt, som nedlastede pakker og opprettede objekter, 
#refererer vi ikke til med " "
        
        
        
##### Forberede og manipulere data ####

#Datamanipulasjon og dataforberedelser handler om å stille seg selv følgende spørsmål:
          
#          1. Hva slags data ønsker jeg?
#          2. Hva slags data har jeg?
#          3. Hva må jeg gjøre for å omarbeide de dataene jeg har til dataene jeg ønsker meg?
          
#  Når du har svart på disse spørsmålene, har du laget en plan med et sett av oppgaver, datamanipuleringer du vet at du må gjøre - disse skal vi lære å løse i R. Dersom du ikke har en slik plan, blir datamanipulering vanskeligere. Tenk gjennom disse spørsmålene (særlig spm. 1 og 2) allerede før du åpner R, med utgangspunkt i teori, og det du vet om dataene dine fra kodebok eller artikklene du repliserer. Vi skal imidlertid lære hvordan R også kan være til stor hjelp for å lage arbeidsplanen din - også for å svare på spm. 1 og 2. Dersom du blir flink på koder for å manipulere data, blir denne planleggingsprosessen både lettere og mer kreativ fordi du ser flere muligheter.
        
        
# I dagens seminar, skal vi jobbe med utgangspunkt i følgende hypotese:  
#bistand fører til økonomisk vekst, men bare dersom de fører en god makroøkonomisk politikk.
#Datasettet aid som vi brukte i introduksjonsforelesningen, og som vi lastet inn i sted, 
#ble brukt i en forskningsartikkel - "Aid, policies and growth" (Burnside og Dollar, 2000) - for å teste denne hypotesen. 
# Disse dataene har observasjoner av en rekke land over flere tidsperioder. 
#Dersom dere hadde lest denne artikkelen og kodeboken på nett - slik vi har gjort for dere -
#ville dere også visst at vi har data som blant annet inneholder:
          
# * Økonomisk vekst i prosent av BNP - variabelen elrgdpg
# * Økonomisk bistand som prosentandel av landets BNP - variabelen elraid
# * Tre variabler som ble brukt til å opprette en indeks for makroøkonomisk politikk - elrsacw (øk. åpenhet), elrbb (budsjettbalanse) og elrinfl (inflasjon).
# * En rekke potensielle kontrollvariabler
        
# Dersom vi har lyst til å kjøre den samme testen av hypotesen som det Burnside og Dollar
#gjorde - dette bør man alltid gjøre som første del av en replikasjon - er vi nødt til å
#opprette en indeks-variabel, som kombinerer de tre variablene som omhandler
#makroøkonomisk politikk. Dermed inneholder i hvert fall planen vår denne arbeidsoppgaven.
        
#### Sjekke strukturen til data ####
        
# Nå som vi har laget en tentativ plan for hva som må gjøre, og lastet inn et datasett, 
#er det tid for å skaffe seg en enda bedre forståelse av hva slags data vi har ved hjelp av R. Husk at du i tillegg til å bruke R, **alltid** bør se på kodeboken/beskrivelsen av data i artikkelen du repliserer i denne fasen av analysen din. R og kodebok komplementerer hverandre.
        
# For å skaffe deg en forståelse av datasettet ditt i R, vil du som regel stille spørsmål av
# følgende type:
          
# 1. Hva er observasjonene i datasettet? Ønsker jeg å omarbeide informasjonen slik at jeg får andre typer enheter?
# 2. Hva heter variablene mine?
# 3. Hva slags klasse har variablene mine? Hva slags informasjon inneholder variablene mine?
# 4. Er det mange observasjoner som har manglende informasjon på noen av variablene jeg er 
# interessert i?
          
# Spørsmål 1-3. bør du kunne svare på delvis ut fra kodeboken. 
#Spørsmål 4. kan ofte bare besvares ved hjelp av et statistikkprogram som R. 
#Uansett er det nyttig å bruke følgende koder i R for å svare på disse spørsmålene. 
# Under viser jeg hvordan:
          
#  1. Hva er enhetene i datasettet? Ønsker jeg å omarbeide informasjonen slik at jeg får andre enheter?
          
#**Klikk** på datasettet i Environment - da åpnes det i et nytt vindu. 
#Legg merke til at koden View(aid) blir evaluert i Console. Les informasjonen 
          
str(aid)
aid # Printer samme informasjon som str() gjør for en data.frame hvis det er en tibble
head(aid, 10) # første 10 observasjoner
tail(aid, 10) # siste 10 observasjoner
sample_n(aid, 20) # Velg 20 observasjoner tilfeldig

        
# 2. Hva heter variablene mine?

names(aid)

# 3. Hva slags klasse har variablene mine? Hva slags informasjon inneholder variablene mine?
          
#Disse funksjonene er fine for å få en rask oversikt over data
        
str(aid) # gir deg klasse for alle variabler samt noe informasjon om verdier
class(aid) # klasse aid datasettet
class(aid$elrgdpg) # gir deg klasse for en variabel
table(aid$country, aid$period) # Fungerer bra for å se nærmere på verdiene til variabler som ikke er kontinuerlige (numeriske). Her får vi (ikke helt) tilfeldigvis også en oversikt over enhetene i datasettet.

        
# Disse funksjonene for univariat statistikke er fine for å få en forståelse av fordelingen
# til kontinuerlige variabler vi er særlig interessert i.

min(aid$elrgdpg, na.rm = TRUE)  # minimumsverdi, na.rm = T spesifiserer at missing skal droppes i beregning.
max(aid$elrgdpg, na.rm = TRUE)  # maksimumsverdi
mean(aid$elrgdpg, na.rm = TRUE) # gjennomsnitt
median(aid$elrgdpg, na.rm =T )  # median
sd(aid$elrgdpg, na.rm = T)      # standardavvik
var(aid$elrgdpg, na.rm = T)     # varians
quantile(aid$elrgdpg, na.rm = T)
        
#install.packages("moments")
library(moments)
skewness(aid$elrgdpg) # skjevhet - fra moments
kurtosis(aid$elrgdpg) # kurtose - fra moments
        
summary(aid$elrgdpg) # forskjellig deskriptiv statistikk for en variabel
summary(aid)            # deskriptiv statistikk for alle variabler i datasettet

        
# 4. Er det mange observasjoner som har manglende informasjon på noen av variablene jeg er
# interessert i?

table(complete.cases(aid)) # tester hvor mange rader som ikke har missing
table(is.na(aid$elrgdpg)) # tester hvor mange observasjoner som har missing på variabelen aid$elrgdpg
aid %>%
  complete(country, period) # Tester alle mulige teoretiske kombinasjoner av verdier for variablene vi setter inn - ta utgangspunkt i variabler som definerer forskjellen på observasjonene. Dersom vi for eksempel har spurt et panel av førstegangsvelgere hva de har tenkt å stemme i mange runder, skiller vi med utgangspunkt i individ og spørsmålsrunde.

# mer om missing senere - merk at koden over gjør logiske tester!        
        
        
        
#### Noen omkodingsfunksjoner: ####
        
        
# Etter at vi har kartlagt datastrukturen og hvilke variabler vi har,
# er det på tide å svare på følgende spørsmål en gang til: 
# Hvilke endringer i data er det nødvendig å gjøre?
          
# Ofte vil en del av svaret være at det er nødvendig å omkode en eller flere variabler. 
#Omkoding av variabler betyr at vi tar informasjon som finnes i en eller flere variabler 
#og omarbeider denne informasjonen, slik at vi får en ny variabel.
#Dersom du synes dette høres ut som om noe du kan bruke en funksjon til, tenker du rett. 
#Før vi gjennomgår noen funksjoner som er nyttig til å omkode variabler, skal dere få et godt
#råd. Ikke gjør en omkoding som overskriver variabler som allerede finnes,
#opprett alltid nye variabler, ellers kan det bli veldig kjedelig å gjøre feil
#(særlig dersom du har den eneste kopien av rådata-filen til masteroppgaven din).
        
        
#Den generelle syntaksen vi skal bruke for å omkode variabler er som følger:
          
#data$ny_var <- funksjon(data$gammel_var)
# Vi anvender en funksjon som omarbeider informasjonen i en gammel variabel i datasettet vårt,
#og legger den til datasettet vårt med et nytt navn

# oppretter policy-indeks variabel, som hos Burnside og Dollar 2000
aid$policy <- aid$elrinfl + aid$elrbb + aid$elrsacw

        
#I tidyverse og dplyr pakken bruker man som regel mutate() funksjonen sammen med andre funksjoner for å opprette nye variabler. 
#Ved hjelp av mutate() kan du gjøre mange omkodinger i slengen - 
#dette gir mer ryddig kode.
        
aid %>% # Spesifiserer at vi skal jobbe med datasettet aid - R vil da lete etter variabler vi referer til her, slik at vi slipper aid$var
          mutate(policy = elrsacw + elrinfl + elrbb) # lager variabelen policy ved å summere budsjettbalanse, inflasjon og en indeks for øk. åpenhet
        
        
        
aid <- aid %>% # samme kode som over, men nå overskriver jeg data slik at variabelen legges til - gjør dette etter at du har testet at koden fungerte
      mutate(policy = elrsacw + elrinfl + elrbb,
                 policy2 = elrsacw*elrinfl*elrbb)
# Her lager jeg to versjoner av policyindeksen - en additiv og en multiplikativ indeks. Hva er den teoretiske forskjellen?
# Dette er en ryddig måte å samle alle omkodinger på!

        
        
# Her brukte vi enkle matematiske operasjoner, + og * for å opprette nye variabler. 
#Andre nyttige matematiske funksjoner til omkoding er funksjoner som log(), exp() og sqrt(). 
#Mot slutten av dokumentet til introduksjonsforelesningen viste jeg sentrering -
#dvs. å sørge for at gjennomsnittet til en variabel blir 0. 

        
# Oppgave: Sentrer de to nye variablene policy og policy2. Det er lov å bruke alle hjelpemidler!
          
          
# En annen type enkel omkoding består i å endre klassen til en variabel.
 #Dette kan gjøres med utgangspunkt i to begrunnelser:
          
#  1. Endre målenivå til en variabel - variabler av klassene numeric og integer vil stort sett behandles som kontinuerlige variabler. Variabler av klassene factor vil derimot stort sett håndteres som nominal-nivå variabler i statistiske funksjoner (her er det noen ganger forskjell mellom funksjoner - se på hjelpefil dersom du er i tvil).
#  2. Endre klassen til en variabel for at en R-funksjon skal fungere på variabelen. Tenk gjennom konsekvensene for målenivå når du gjør dette.
        
# For å endre klassen til en variabel, bruk en funksjon av typen as.klassenavn(data$variabel) - her er noen eksempler på hvordan disse funksjonene brukes:
          
library(tidyverse)
as_factor(aid$period)
as.numeric(as_factor(aid$country)) # Denne fungerer bare hvis variabelen inneholder noe som kan leses som tall, legg merke til hva den gjør med faktor-variabler!
# Legg merke til . i as.numeric.
as.character(aid$elrgdpg)

        
#Oppgave: Opprett tre nye variabler i datasettet ditt ved å omkode klassen til tre valgfrier
# variabler, velg også navn selv. Bruk mutate().
        
#### Omkoding med ifelse() ####
        
#Den funksjonen jeg bruker mest til omkoding, er ifelse(). 
#Syntaksen til denne funksjonen kan forklares som følger:
          

#data$nyvar <- ifelse(test = my_data$my.variabel=="some logical condition",
#                             yes  = "what to return if 'some condition' is TRUE",
#                             no   = "what to return if 'some condition' is FALSE")

        
# Oppgave: Opprett en ny variabel som får verdien 1 dersom de har positiv verdi på variabelen
# policy, og negativ verdi på variabelen policy2 - hvor mange slike observasjoner finnes?
# Hint: Her kan du bruke & for å binde sammen to logiske tester. Du kan også bruke ifelse()
# inne i mutate() - jeg viser et eksempel under.
        
        
#### Endre datatstruktur ved hjelp av aggregering: ####
        
# Tenk deg at vi ønsket å opprette en ny variabel, neigh_growth,
# som viser differansen mellom et lands vekst i en periode, og gjennomsnittsveksten til alle
#land i samme region over hele tidsperioden. Dette høres kanskje fryktelig komplisert ut, og mangler en god teoretisk begrunnelse. Vi kan imidlertid finne informasjonen vi er på jakt etter ganske enkelt ved hjelp av funksjonene group_by() og summarise(). Først må vi imidlertid opprette en region-variabel - fordi informasjon om hvilken region et land tilhører er spredt ut over tre variabler - elrssa, elrcentam og elreasia. La oss bruke ifelse() og mutate() til dette:
          

aid <- aid %>% # Forteller at vi skal jobbe med aid-datasettet
    mutate(region = ifelse(elrssa == 1, "Sub-Saharan Africa",
                       ifelse(elrcentam == 1, "Central America",
                          ifelse(elreasia == 1, "East Asia", "Other"))))
# Her nøster jeg ifelse-funksjoner inne i hverandre, ved å skrive en ifelse() funksjon
# som det som skal gjøres med observasjoner som får FALSE på at de ligger i Afrika sør
# for Sahara, osv. La oss sjekke omkodingen med en tabell
table(aid$region, aid$elrssa) # ser bra ut
#kunne gjort det samme for resten av kategoriene

#La oss se hvordan group_by() og summarise() fungerer:
          

aid %>%
  group_by(region) %>% # grupperer observasjoner basert på verdi på region-variabelen. Alle observasjoner med lik verdi (uavh. av tidsperiode) blir gruppert sammen.
  summarise(neigh_growth = mean(elrgdpg, na.rm = T)) # regner gjennomsnitt for økonomisk vekst innad i hver gruppe - for hele tidsperioden data dekker sett under ett
        
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
        
# Nå har vi informasjonen vi trenger - men vi har ikke lagt den til det opprinnelige datasettet som en variabel.
# Dette kan vi gjøre ved hjelp av en join funksjon som slår sammen informasjon fra to datasett.
# Mer om join i senere seminar, og her: https://r4ds.had.co.nz/relational-data.html.
        

aid <- aid %>% left_join(agg_aid)
# left_join er en av flere join funksjoner. Siden begge datasett har en variabel som heter region, brukes denne til å matche de to datasettene. All informasjon i agg_aid legges til aid
        
# Ser på resultatet:
table(aid$region_growth, aid$region)
table(aid$n_region, aid$region)

        

        
#### Utforsking av data og deskriptiv statistikk ####
        
#Disse funksjonene fungerer gir unviariat statistikk for kontinuerlige variabler:
          

min(aid$elrgdpg, na.rm = TRUE)  # minimumsverdi, na.rm = T spesifiserer at missing skal droppes i beregning.
max(aid$elrgdpg, na.rm = TRUE)  # maksimumsverdi
mean(aid$elrgdpg, na.rm = TRUE) # gjennomsnitt
median(aid$elrgdpg, na.rm =T )  # median
sd(aid$elrgdpg, na.rm = T)      # standardavvik
var(aid$elrgdpg, na.rm = T)     # varians
        
#install.packages("moments")
library(moments)
skewness(aid$elrgdpg) # skjevhet - fra moments
kurtosis(aid$elrgdpg) # kurtose - fra moments
        
summary(aid$elrgdpg) # forskjellig deskriptiv staatistikk for en variabel
summary(aid)            # deskriptiv statistikk for alle variabler i datasettet
        
        
#For bivariat eller multivariat deskriptiv statistikk, ser vi gjerne på korrelasjon (pearsons R). 
#Med funksjonen cor() kan vi få bivariat korrelasjon mellom to variabler, 
# eller lage bivariate korrelasjoner mellom alle numeriske variabler i datasettet vårt:

cor(aid$elrgdpg, aid$elraid, use = "pairwise.complete.obs") # argumentet use bestemmer missing-håndtering
aid         # sjekker hvilke variabler som er numeriske, str(aid hvis du ikke har en tibble)
        
aid %>%
  select(1:13) %>%
  head() # velger de substansielle numeriske variablene i datasettet
        
aid %>%
  select(6:13) %>%
  cor(, use = "pairwise.complete.obs")  # korrelasjonsmatrise basert på numeriske variabler
        # Sjekk hva use = argumentet styrer i hjelpefilen

        
        
#To av variablene i datasettet vårt, aid$country og code, er ikke kontinuerlig.
#Ved å ta str(aid), ser vi at denne variabelen er kodet som en faktor.
#Dette innebærer at den vil behandles som en nominalnivå-variabel i statistisk analyse. 
#For kategoriske variabler, er tabeller nyttig:
          

table(aid$country)      # frekvenstabell
prop.table(table(aid$country)) # prosentfordeling basert på frekvenstabell

        
# Vi kan også lage tabeller med flere variabler. Under viser jeg hvordan du lager en tabell fordelingen av observasjoner som har høyere vekst enn medianveksten i utvalget, ved hjelp av en logisk test:

table(aid$elrgdpg>median(aid$elrgdpg,na.rm=T))
table(aid$elrgdpg>median(aid$elrgdpg,na.rm=T), aid$country)

        
# Oppgave: Lag et nytt datasett ved hjelp av group_by() og summarise(), 
# der du oppretter variabler som viser korrelasjon (Pearsons r) mellom elraid, og elrgdpg,
# elraid og policy og elrgdpg separat for hver region. Er det store forskjeller i korrelasjonene 
# mellom regionene? Lag deretter to nye variabler, good_policy og good_policy2,
# slik at observasjoner som har positive verdier på henholdsvis variablene
# policy og policy2 får verdien 1, mens andre observasjoner får verdien 0. 
# Bruk disse nye variablene som grupperingsvariabler, og lag et nytt datasett der du inkluderer
# en variabel som beregner korrelasjon mellom elraid og elrpolicy for hver gruppe.
        
        
#### Plotte-funksjonen ggplot ####
        
# syntaks:
#ggplot(data = my_data) +
#geom_point(aes(x = x-axis_var_name, y = y-axis_var_name, col=my.var3)))
      
#Vi legger til nye argumer til plottet vårt med +. Etter at vi har spesifisert datasett, 
#geom og aes (aesthetics) må vi ikke legge til flere argumenter, men det er mulig å legge til flere
#elementer (som en regresjonslinje) eller finjustere plottet i det uendelige 
#(f.eks. angi fargekoder for alle farger i plottet manuelt). 

# 4 geom_:
      
#      1. geom_histogram - histogram (et godt alternativ kan være å bruke geom_bar())
#      2. geom_boxplot() - box-whiskers plot
#      3. geom_line()    - linje, fin for tidsserier
#      4. geom_point()   - scatterplot
      
      
library(ggplot2)
ggplot(aid) + geom_histogram(aes(x = elrgdpg), bins = 50) # lager histogram
      
      

      
      
#Med et boxplot får du raskt oversikt over fordelingen til variabler innenfor ulike grupper.
      
      

ggplot(aid) + geom_boxplot(aes(x = as_factor(region), y = elraid))
      
# Oppgave: Lag boxplot som viser fordelingen til variablene policy og elrgpdg innenfor hver region.
      
      
# Med geom_line() kan vi plotte tidsserier:
        

ggplot(aid) + geom_line(aes(x = period, y = elrgdpg, col = country))
      

      
      
# Et problem med dette plottet, er at det blir vanskelig å se veksten til forskjellige land 
#klart, det er for mye informasjon. Dersom vi har lyst til å sammenligne et par land om 
#gangen, kan vi bruke %in% til å indeksere. Denne operatorene lar deg velge alt innholdet 
#i en vektor - f.eks. variabelnavn eller ulike verdier på en variabel. Her viser jeg hvordan
#du kan kombinere dplyr, %in% og ggplot() for å sammenligne et par land om gangen:
        
# Hvilke land finnes i Sub-Saharan Africa? Velger land kun herfra:
aid %>% filter(region == "Sub-Saharan Africa") %>%
  ggplot() + geom_line(aes(x = period, y = elrgdpg, col = country))
      
# Fortsatt litt mye informasjon til å være enkelt å lese - La oss sammenligne 5 land med %in%

# Velger land med %in%, fint for mindre sammenligninger
aid %>% filter(country %in% c("KEN", "ETH", "MOZ", "AGO", "RWA")) %>%
  ggplot() + geom_line(aes(x = period, y = elrgdpg, col = country))
      
      

      
      

      
      
# Her viser jeg fordelingen til vekst (elrgdpg) opp mot bistand (elraid) og makroøkonomisk politikk (policy) ved hjelp av et spredningsplot (scatterplot). Sammenlign gjerne med korrelasjonsmatrisen du lagde mellom disse tre variablene.
      
ggplot(aid) + geom_point(aes(x = elraid, y = elrgdpg, col = policy))
      
#Her er et overlesset eksempel på et scatterplot (poenget er å illustrere muligheter, ikke å lage et pent plot):

ggplot(aid) +
        geom_point(aes(x=elraid, y=elrgdpg, col=policy, shape=as_factor(region))) +
        geom_smooth(aes(x=elraid, y=elrgdpg), method="lm") +  # merk: geom_smooth gir bivariat regresjon
        ggtitle("Visualization of relationship between aid and growth to showcase ggplot") +
        xlab("aid") +
        ylab("growth") +
        theme_minimal()
      

      
      
      
      
# Oppgave: Forsøk å legge til facet_wrap(~region), hva gjør dette argumentet? 
# Hvordan kan det være nyttig for å plotte samspill? Forsøk å fjerne ett og ett argument 
# i plottet over for å se hva argumentene gjør.
      
# Dersom du lager et plot du er fornøyd med, kan du lagre det med ggsave(), 
# som lagrer ditt siste ggplot.

ggsave("testplot.png", width = 8, height = 5) # lagrer ditt siste ggplot i det formatet du vil på working directory
      
      ## Takk for i dag!
      