Oppgaver seminar 4
================

## Introduksjon

Datasettet «beer» består av 336 observasjoner og 10 variabler.
Observasjonene er av amerikanske stater i tidsperioden 1982-1988. Det er
ikke missing-data.

## Variablene

| Variabel |                   Beskrivelse                    |
| -------- | :----------------------------------------------: |
| state    |                  state ID code                   |
| year     |                       year                       |
| mrall    |     traffic fatality rate (deaths per 10000)     |
| beertax  |         tax on case of beer (percentage)         |
| mlda     |            minimum legal drinking age            |
| jaild    |   mandatory jail sentence after drunk-driving?   |
| comserd  | mandatory community service after drunk-driving? |
| vmiles   |             average miles per driver             |
| unrate   |                unemployment rate                 |
| perinc   |            per capita personal income            |

## Oppgaver

1.  Importer datasettet beer.csv eller beer.Rdata fra \[data-mappen på
    github\]
    (<https://github.com/liserodland/stv4020aR/tree/master/H20-seminarer/Innf%C3%B8ringsseminarer/data>)
    som et objekt i R-Studio. Du skal bruke dette datasettet i alle
    oppgavene.

2.  Hvilken klasse har variablene i datasettet? Vis hvordan du finner ut
    av dette med kode.

3.  Lag et spredningsplot (scatter-plot) med skatt på øl på x-aksen, og
    dødsrate i trafikken per 10000 innbygger på y-aksen. Tegn deretter
    en lineær regresjonslinje oppå plottet.

4.  Lag et nytt datasett basert på beer, bestående av variablene year,
    mrall, beertax, vmiles, unrate og perinc. Lag en korrelasjonsmatrise
    med utgangspunkt i det nye datasettet. Gjør deretter en
    signifikanstest av sammenhengen mellom beertax og mrall. Hva
    indikerer korrelasjonen mellom disse to variablene?

5.  Opprett et nytt datasett med alle observasjoner fra år 1982 i det
    opprinnelige datasettet, og et datasett med alle observasjoner fra
    år 1988 i det opprinnelige datasettet. Hva er gjennomsnittlig skatt
    på øl og gjennomsnittlig dødsrate per 10000 innbygger i de to
    datasettene? Oppgi gjennomsnittene i en kommentar.

6.  Kjør en lineær regresjon med mrall som avhengig variabel og beertax,
    vmiles, unrate og perinc som uavhengige variabler. Lagre modellen
    som et objekt. Indikerer modellen at skatt på øl reduserer dødsfall
    i trafikken? Tolk effekten substansielt.

7.  Opprett en ny variabel i datasettet ditt, state\_fac, ved å omkode
    variabelen state til en factor. Lag deretter et boxplot med
    state\_fac på x-aksen og mrall på y-aksen. Vil du si det er store
    variasjoner i dødsrate mellom statene (du kan trykke på Zoom over
    plottet for å se tydelig)? Lag deretter det samme plottet som i
    oppgave 3, men legg til argumentet facet\_wrap(\~state\_fac). Hva
    leser du fra dette plottet?

8.  Kjør en lineær regresjon med mrall som avhengig variabel og beertax,
    vmiles, unrate og perinc og state\_fac som uavhengige variabler.
    Lagre modellen som et objekt. Indikerer modellen at skatt på øl
    reduserer dødsfall i trafikken? Tolk effekten substansielt. (P.S.:
    ved å legge til variabelen state\_fac spesifiserer vi en modell med
    det som kalles fixed effects).

9.  Lag en ny variabel comserd\_d som tar verdien:

<!-- end list -->

  - 1 dersom comserd har verdien “yes”

  - 0 dersom comserd har verdien “no”

Sjekk ved hjelp av en tabell at det ble riktig.

10. Kjør en binomisk logistisk regresjon med comserd\_d som avhengig
    variabel og unrate, perinc, mrall og mlda som uavhengige variabler.
    Hva kan si om effekten av antall trafikkdødsfall?
