---
title: "Oppgaver seminar 4"
author: "Erlend Langørgen"
date: "16 9 2019"
output: 
  html_document:
    keep_md: TRUE
---



## Variabelbeskrivelser: 

Datasettet er en omarbeidet versjon av spørreundersøkelsen European social survey, runde 7 (fra 2014). Jeg har hentet ut norske respondenter som oppgir at de ikke har innvandrerbakgrunn. 


**imwbcnt** -	Er det blitt verre eller bedre å bo i Norge på grunn av at folk kommer fra andre land for å bosette seg her? (0 – 10, 0 = verre, 10 = bedre)

**imwbcrm** - 	Er problemene med kriminalitet i Norge blitt verre eller bedre på grunn av folk som kommer fra andre land for å bosette seg her? (0 – 10, 0 = verre, 10 = bedre)

**imdetbs** - Tenk nå på folk som har kommet fra et annet land for å bosette seg i Norge, og som har en annen hudfarge eller etnisk tilhørighet enn de fleste i Norge. Hvor mye ville du hatt imot eller ikke hatt imot at en slik person ble satt til å være sjefen din? (0-10, 0 = Har slett ikke noe imot det, 10 = Har mye imot)

**imdetmr** - Tenk nå på folk som har kommet fra et annet land for å bosette seg i Norge, og som har en annen hudfarge eller etnisk tilhørighet enn de fleste i Norge. Hvor mye ville du hatt imot eller ikke hatt imot at en slik person giftet seg med en nær slektning av deg? (0-10, 0 = Har slett ikke noe imot det, 10 = Har mye imot)

**smegbli** - Tror du at mennesker med en bestemt hudfarge eller etnisk tilhørighet er født mindre intelligente enn andre? (1 = ja, 2 = nei)

**smegbhw** - Tror du at mennesker med en bestemt hudfarge eller etnisk tilhørighet er født mer hardtarbeidende enn andre? (1 = Ja, 2 = Nei)

**almuslv** -	I hvilken grad synes du at Norge bør tillate muslimer fra andre land å bosette seg i Norge? 1 = La mange bosette seg her, 2 = La noen bosette seg her, 3 = La enkelte bosette seg her, 4 = Ikke la noen bosette seg her 

**gndr** -	1 = mann, 2 = kvinne

**agea** -	alder

**edlvdno** - 	Hva er din høyest fullførte utdanning? (1 = lavest, alt over 8 = påbegynt universitet, 13 = doktorgrad)  

**trstplt** -	Se på dette kortet og fortell meg på en skala fra 0 - 10 hvor stor tillit du personlig har til politikere. 0 står for at du ikke har noen tillit til institusjonen i det hele tatt, mens 10 står for at du har full tillit til institusjonen. 

**lrscale** -	I politikken snakkes det iblant om venstresiden og høyresiden. Se på dette kortet, og plasser deg selv på en skala der 0 står for venstresiden og 10 står for høyresiden.



## Oppgaver:

### Oppgave 1: 
Last inn datasettet no_ess7.csv eller no_ess7.Rdata som et objekt. Du finner lenke til mappen med datasett gjennom seminar-modulen på canvas.

### Oppgave 2: 
Lag en tabell bestående av de to variablene smegbli og smegbhw. Hvor mange mener at mennesker av annen etnisitet/hudfarge er født mindre intelligente? Hvor mange mener at mennesker av annen etnisitet/hudfarge er født mindre hardtarbeidende? Hvor mange mener begge deler?

### Oppgave 3:
Lag en korrelasjonsmatrise mellom alle variablene i datasettet. Sett argumentet use = "complete.obs". Kommenter sammenhengen mellom variabelen lrscale og variablene smegbli, smegbhw og almuslv kort.

### Oppgave 4:
Lag to boxplot, et med smegbli på x-aksen og edlvdno på y-aksen, og et med smegbhw på x-aksen og edlvdno på y-aksen. Sørg for at variabelen som er på x-aksen håndteres som en faktor.

### Oppgave 5: 
Opprett en ny variabel, innvandring_samfunn ved å addere (plusse sammen) observasjonenes verdi på variablene imwbcnt og imwbcrm. Lav verdi på den nye variabelen betyr at man mener innvandring påvirker samfunnet negativt.  Lag derette et spredningsplot med agea på x-aksen, og innvandring_samfunn på y-aksen. Legg til en lineær regresjonslinje til plottet. Lag til slutt separate paneler i plottet basert på observasjonenes verdier på variabelen lrscale. Ser det ut som det er noen forskjell mellom hvordan alder påvirker syn på innvandringens samfunnseffekter mellom dem som er på høyre- og venstre-siden?

### Oppgave 6: 
Opprett to nye datasett, et bestående av dem som har verdi mindre eller lik 5 på variabelen trstpol, og et bestående av dem som har verdi større enn 5 på variabelen trstpol. Lag histogram for de følgende 2 variablene for hvert av de nye datasettene (altså 4 histogram totalt): imwbcrm, imwbcnt. Ser det ut som det er en sammenheng mellom politisk tillit og holdning til innvandring?

### Oppgave 7:
I denne oppgaven skal du kjøre tre lineære regresjonsmodeller. I alle modellene skal du bruke følgende uavhengige variabler: agea, gndr, edlvdno, trstplt, lrscale. I den første regresjonen bruker du almuslv som avhengig variabel. I den andre regresjonsmodellen bruker du smegbhw som avhengig variabel. I den tredje regresjonsmodellen bruker du imwbcrm som avhengig variabel. Er det store forskjeller i effektene til de uavhengige variablene i de tre modellene? Velg en eller to variabler og kommenter retning på effekt samt signifikans kort.


### Oppgave 8:

Opprett en ny variabel, hverdagsrasisme, ved å addere (plusse sammen) observasjonenes verdier på variablene imdetbs og imdetmr. Høy verdi på den nye variabelen kan muligens tolkes som større skepsis til å ha folk med annen etnisitet/hudfarge i viktige roller i hverdagslivet. Bruk den nye variabelen hverdagsrasisme som avhengig variabel i en lineær regresjon med gndr, edlvdno, trstplt og samspill mellom lrscale og agea. Hva blir den forventede effekten av et års økning i alder for en som er helt ytterst til høyre? Hva blir den forventede effekten av et års økning i alder for en som er helt ytterst til venstre? Kjør til slutt en vif-test for å sjekke multikolinearitet (du kan bruke vif() funksjonen fra pakken car til dette)

## Oppgave 9

Kjør to logistiske regresjoner. I den første regresjonen bruker du `smegbli` som avhengig variabel, i den andre bruker du `smegbhw` som avhengig variabel. I begge regresjonene bruker du `agea`, `gndr`, `lrscale`, `trstplt` og `edlvdno` (velg om du vil ha samspill/andregradsledd o.l. selv). Er det noen forskjeller i effektene til de uavhengige variablene? 

**Legg merke til:** Du må endre verdien på de to avhengige variablene slik at de har verdiene 0 og 1 i stedet for 1 og 2


### Oppgave 10:
Opprett en ny variabel, morkemann i datasettet ditt, som har verdien 1 for menn over 60 som også har verdi på trstpol mindre enn 4, og 0 for alle andre. Lag en tabell mellom morkemann og smegbhw. Lag også en tabell mellom morkemann og smegbli. Kommenter kort  

### Oppgave 11:
Opprett en ny variabel, «gammel», som har verdien 1 for dem som er over 60, 0 for alle andre. Opprett en ny variabel «universitet», som har verdien 1 for alle som har verdi på edlvdno større enn 8, 0 for alle andre. Opprett en ny variabel «ideologi», som har verdien «venstresiden» for alle med verdi lavere enn 4 på lrscale, «høyresiden» for alle med verdi større enn 7 på lrscale, og «sentrum» for alle andre (verdiene fra 5-7 på lrscale). Aggreger data på variablene universitet, gammel, ideologi og gndr. Når du aggregerer, opprett nye variabler som viser gjennomsnittsverdi for variablene samfunnsutvikling, hverdagsrasisme, smegbhw og almuslv. Er det stor variasjon i verdiene til variablene du har beregnet gruppegjennomsnitt for?


### Oppgave 12:

Plot de predikerte sannsynlighetene fra modellene i oppgave 9 som en funksjon av alder. Velg verdier på andre kontrollvariabler selv - er det store forskjeller i effekten til alder på de to variablene? 
