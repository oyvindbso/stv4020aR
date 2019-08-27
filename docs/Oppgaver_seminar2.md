---
title: "Oppgaver seminar 2"
author: "Erlend Langørgen"
date: "27 august 2019"
output:
  html_document:
    keep_md: yes
---



## Forberedelse:

Start med å kjøre koden i løsningsforslaget til oppgavene fra seminar 1, på slutten av dokumentet til dagens seminar. Dersom du skrev din egen løsning, bruk denne. Du skal jobbe med utgangspunkt i datasettet `aid2` fra løsningsforslaget, eller tilsvarende.

Dagens oppgaver er designet for å trene forståelsen din av regresjon, og bruker mye plotting til dette formålet.

## Instruksjoner:

I oppgavene under får du oppgitt sett av variabler. I hver regresjon, bruker du `aid2$elrgdpg` som avhengig variabel, og variablene du får oppgitt som uavhengige variabler.

* For hver oppgave med 4 variabler eller mindre, lag et spredningsplot der du visualiserer alle variablene som nevnes, samt `aid2$elrgdpg` som du setter på y-aksen. Dersom det er mer enn 4 variabler, lag en korrelasjonsmatrise mellom variablene i oppgaven samt `aid2$elrdgpg`. 
* For hver oppgave, kjør minst to forskjellige regresjonsspesifikasjoner, der den ene er lineær, mens den andre inneholder samspill og/eller høyeregradspolynomer/matematiske transformasjoner. Du står også fritt til å forsøke forskjellige omkodinger

Tips: I tillegg til argumentet `col =`, kan du bruke `shape = `, `alpha =`, m.m. Du kan også bruke `facet_wrap()` med en eller flere variabler (velg variabler med et begrenset antall verdier - dersom du vil bruke denne strategien når du bare har kontinuerlige variabler, bruk `cut()` til å lage en ny variabel som deler en kontinuerlig var. i kategorier)

## Oppgaver:

1. Variabler: `elraid`, `policy`, `period`. 
2. Variabler: `elraid`, `elrsacw`, `elrbb`, `elrinfl` - Merk at de tre siste variablene ble brukt til å opprette `policy`- variablene.
3. Variabler: `elraid`, `policy`, `region`, `c_years` (eller en ekvivalent variabel som angir antall konfliktår i ett land i en periode).
4. Variabler: `elraid`, `period`, `region`, `policy`, `c_years`
5. Variabler: `elraid`, `period`, `region`, `policy`, `c_years`, `elrgdpg` (ta gjerne `log()`), `elricrge`, `elrassas`. Bruk argumentet `use = "complete.obs"` i korrelasjonsmatrisen - dette kaster ut de samme observasjonene som kastes ut av regresjonsanalysen din pga. missing.

## Ekstraoppgave (ingen fasit):
Tenk metodekritisk gjennom løsningsforslaget til oppgavene fra seminar 1 - hvordan kan det forbedres? Jeg har tatt mange snarveier, og ikke gått inn i en del viktige metodologiske spørsmål. 

