# Oppgaver til seminar 2
Erlend Langørgen  
September 13, 2018  



## Praktisk informasjon:

Den første delen av oppgavene er ment å trene basisferdighetene dine i R. Oppgavene blir progressivt vanskeligere, og vil etterhvert kreve at du har forstått emnene i [introduksjonen](https://github.com/martigso/stv4020aR/blob/master/Gruppe%201/for_seminaret/Introduksjon_seminar_2.md) til dagens seminar.

Den andre delen av oppgaven vil fokusere mer på å bruke R som et hjelpemiddel til å tenke metodologisk rundt statistiske analyser. Jeg forventer ikke at dere kommer helt hit.

Vi vil bruke [den sammenslåtte versjonen](https://github.com/martigso/stv4020aR/raw/master/Gruppe%201/data/bd_full.Rdata) av datasettene til Easterly (2003) og Burnside og Dollar (2000) til nesten alle oppgavene.



## Del 1 

Easterly (2003) utvidet datasettet til Burnside og Dollar (2000) med ekstra variabler. Variabler som begynner med `elr` er de utvidede variablene, mens variabler som begynner med `bd` er Burnside og Dollar sine originale variabler. I de neste par oppgavene, skal dere sammenligne de to datakildene.

### Oppgave 1:
Importer datasettet full_bd.Rdata (https://github.com/martigso/stv4020aR/raw/master/Gruppe%201/data/bd_full.Rdata).
Finn ut hvor mange variabler av klassene `factor` og `character` det er i datasettet ved hjelp av en enkelt funksjon.


### Oppgave 2:

Indekser deg frem til maksimums og minimumsverdier av `elraid`, `bdaid` (bistandsvariabler), `elrgdpg` og `bdgdpg` (øk. vekst). Ta deretter `summary()` av de samme variablene. Er det store forskjeller i data?

### Oppgave 3:

Lag en factor-variabel med `ifelse` for de ulike regionene, med utgangspunkt i variablene `elreasia` (East Asia), `elrcentam` (Central America) og `elrssa` (Sub saharan Africa). Observasjoner som ikke er i disse kategoriene, setter du til `Other`. Lap deretter et scatterplot med `elraid` på x-aksen og `elrgdpg` på y-aksen. Fargelegg først punktene i plottet ut fra verdi på variabelen originalcountries. Etter at du har gjort dette, deler du plottet i fire, med utgangspunkt i verdien  på region-variabelen du har opprettet.

### Oppgave 4:

Opprett variabelen elrpolicy, ved å legge sammen `(-1)*elrinfl`, `elrbb` og `elrsacw`. 

Lag deretter to nye datasett, et bestående av land i Sub-Saharan Africa, og et bestående av de andre landene. Du kan bruke `filter()` fra dplyr, eller indeksering med `full[,]` til dette.

Kjør til slutt følgende regresjonsmodeller i begge datasettene (fyll inn data-argument):

1. `summary(lm(elrgdpg ~ elraid*elrpolicy + as.factor(period) + elrlpop + elrassas*elrethnf , data = ))`
2. `summary(lm(gdp_growth ~ aid*policy + as.factor(period) + bdlpop + bdassas*bdethnf , data = ))`

Er det store forskjeller?

### Oppgave 5

Opprett et nytt datasett ved å aggregere datasettet `full` på land, og beregn gjennomsnittsvekst for hvert land med utgangspunkt i `elrgdpg` (husk `na.rm()`). Opprett variabelen `growth_group` i det aggregerte datasettet (etter ferdig aggregering), der du deler dataene i fem grupper, ut fra følgende cut-off:

"Extremely low growth" - mindre enn `-6`
"Low Growth" - mindre enn `0`, større eller lik `-6`
"medium growth" - større eller lik `0`, mindre enn `2`
"High Growth" - større eller lik `2`, mindre enn `6`
"Extremely high growth" - større eller lik `6`

Merge så det aggregerte datasettet med full, med utgangpunkt i landnavn-variabler.  Avslutt med å aggregere data ut fra verdi på `growth_group`, og inkluder gjennomsnittsverdier for `bdaid`, `elraid`, `elrpolicy` og `bdpolicy` i det aggregerte datasettet (husk `na.rm=T`). Er det store forskjeller?

### Oppgave 6 
Denne oppgaven er vanskelig, hopp gjerne videre om du vil!

Lag et ggplot som visualiserer sammenhengen mellom vekst, policy og økonomisk utvikling i et enkelt land i et scatterplot, med følgende kode:

ggplot(filter(full, country == "MEX"), aes(x = elraid, y = elrgdpg, col = elrpolicy)) + geom_line()

Forsøk så å lage en funksjon med utgangspunkt i plottet med et argument, `"land"`, som lar deg produsere tilsvarende plot for ethvert enkeltland du kjenner forkortelsen til i datasettet.

## Del 2

### Oppgave 7

Det kan tenkes at giverland gir mest til land som vokser mye. Med andre ord: vekst kan påvirke bistand. Burnside og Dollar (2000) diskuterer slike muligheter i sin artikkel. Hvis dette er tilfellet, kan vi for eksempel teste om vekst i forrige periode påvirker bistand man får i denne perioden. For å sjekke dette, kan vi "lagge" vekst med `lag()` fra dplyr. Opprett en ny variabel `elrgdpg_lag` ved å lagge `elrgdpg`. Kjør deretter en regresjon med `elraid` som avhengig variabel, og `elrpolicy`, `elrgdpg_lag` og `elrlpop` som uavhengige variabler. Gir regresjonen grunn til å mistenke en slik sammenheng? Er det grunn til å mistenke at det er en slik sammenheng i noen av regionene? Sjekk ved å legge inn samspill mellom region og `elrgdpg_lag`.

### Oppgave 8

Funksjonen `complete.cases()` gjør en logisk test av om en observasjon har missing på en eller flere variabler.
Funksjonen kan brukes sammen med indeksering, til å sjekke hvilke observasjoner som droppes fra regresjonsanalyse 1 i oppgave 4 pga. missing på kontrollvariabler. Opprett en dummyvariabel som får verdien 1 for observasjoner som droppes pga. missing på en eller flere kontrollvariabler, og lag deretter et boxplot der du grupperer `elrgdpg` ut fra verdi på den nye dummy-variabelen.
