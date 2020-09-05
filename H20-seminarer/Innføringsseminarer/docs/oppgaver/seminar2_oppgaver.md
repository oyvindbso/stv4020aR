Oppgaver seminar 2
================

1.  Last ned de fire datasettene i mappen “aid” på github. Dette skal vi
    gjøre for å lære å laste inn ulike typer data. Lagre datasettene i
    ditt working directory eller i prosjektmappen. Last inn de ulike
    dataformatene. Tips: bruk `rm(objektnavn)` mellom hver innlastning
    for å slette det lagrede objektet.

2.  Datasettene du lastet inn nå er mer bearbeidet enn det vi brukte i
    seminaret, bl.a. finnes allerede variabelen policy der. Kjør modell
    (5) på s. 856 i Burnside and Dollar (2000) uten å bearbeide data noe
    mer. Husk å lagre modellen som et objekt.

3.  Som du ser blir ikke resultatene de samme. For å replisere
    artikkelen må du gjøre noen flere justeringer:

<!-- end list -->

  - Logtransformer variabelen gdp\_pr\_capita (Tips: husk å lagre den
    nye variabelen i datasettet ved hjelp av `data$`)
  - Kontroller for variabelen periode (Tips: i datasettet er variabelen
    numerisk. Blir det riktig?)
  - Sett område-dummiene (`sub_saharan_africa` og
    `fast_growing_east_asia`) til riktig målenivå (Tips: se hva vi
    gjorde når vi lagde region-variabelen i seminar 2)

<!-- end list -->

4.  Kjør modellen på ny, denne gangen med faste effekter for periode.
    Husk å lagre modellen som et objekt.

5.  Sammenlign resultatene fra de to modellene i en tabell. Last den inn
    i word, latex eller ditt foretrukne tekstredigeringsprogram.

6.  Lag et plot som viser sammenhengen mellom gdp\_pr\_capita (BNP per
    innbygger) og den logtransformerte varianten av variabelen. Hvordan
    påvirker logtransformasjone betydningen av en enhets økning i
    gdp\_pr\_capita? Tips: bruk `geom_point()` om du bruker funksjonen
    `ggplot()`.
