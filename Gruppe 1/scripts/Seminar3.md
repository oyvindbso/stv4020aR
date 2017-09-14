# Seminar 3 - Lineær og logistisk regresjon
Erlend Langørgen  
13 september 2017  



## Dagens seminar:
* Første time:
 1) Kort gjennomgang av lineær regresjon med `lm()`, inkludert:
  + samspill
  + plot
 2) Oppgaver i lineær regresjon, jobb i grupper
* Andre time:
 1) Kort gjennomgang av logistisk regresjon med `glm()`, inkludert:
  + samspill
  + Beregne sannsynligheter
  + plot
 2) Oppgaver i logistisk regresjon, jobb i grupper

I dag fokuserer vi på det R-tekniske ved å gjøre regresjonsanalyse, og substansiell tolkning av analysene. For å gjøre substansiell tolkning på best mulig vis, skal jeg lære dere [å plotte regresjon](https://github.com/martigso/stv4020aR/blob/master/Gruppe%201/docs/Regresjonsplot.md). Vi skal også snakke om visualisering av data i modeller, fordi: 

**Når vi gjør dataanalyse må vi forstå data! Visualiser, gjør deskriptiv statistikk og les kodebok**. I statsvitenskap har vi ofte data som ikke er helt ideelle. Kanskje er variablene våre upresise, eller kanskje vi forsøker å studere en bestemt egenskap som kjennetegner vestlige demokratier, f.eks., helsevesen men mangler data til å skille effekten av denne variabelen fra andre kjennetegn ved vestlige demokratier. For å bli flinke til å analysere data, må dere forstå informasjonen dere har i datasettet deres, før dere gjør analysen. **Visualisering, deskriptiv statistikk og kodebok er fantastiske, uunværlige hjelpemidler**. 

I neste seminar skal vi gå gjennom mer formell diagnostikk for OLS og logistisk regresjon, som dere kan gjøre etter analysen for å teste modeller. Hensikten med denne organiseringen, er å tydeliggjøre likhetene mellom lineær og logistisk regresjon.



## Plan for resten av seminarene:
* Komme oss gjennom alle analyseformer, samt verktøy for diagnostikk
* Statistikk vs. R-teknisk fokus - avhengig av deres preferanser 
* Jeg vil ikke stresse gjennom seminarene, dette kan bety at vi ikke rekker å gå gjennom alt i timen. Dermed må dere se gjennom undervisningsmateriale jeg legger ut på egenhånd. Jeg kommer til å holde av tid i siste seminar til å gå gjennom ting vi ikke har fått tid til å gå grundig gjennom. Dess bedre forberedt dere stiller på metode og R, dess mer rekker vi i seminarene. Videre kommer både jeg og Martin til å være tilgjengelig på slack, og i R-veiledningstimene senere i høst.
* Jeg kommer til å legge ut en del ekstra undervisningsmateriell, som ikke vil være pensum til prøven, men som vil kunne være ekstremt nyttig.

I dag skal dere få gjøre oppgaver i lineær og logistisk regresjon.
Jeg satser på å snakke så lite som mulig, men still meg gjerne spørsmål!


## Lineær regresjon
I R bruker vi `lm()` funksjonen for å kjøre lineær regresjon. Vi må spesifisere to argumenter: 
1. Regresjonsformelen, som vi spesifiserer med `avh.var ~ uavh.var1 + uavh.var2`. Samspill spesifiserer i regresjonsformelen spesifiserer vi med `*`, som i `avh.var ~ uavh.var1*uavh.var2`. Andregradsledd og polynomer av høyere grad spesifiseres med `I(uavh.var^2)`, som i `avh.var ~ uavh.var1 + I(uavh.var1^2) + I(uavh.var1^3)`.
2. Data, som vi spesifiserer med `data = mitt_datasett`.

Vi pleier å opprette objekter av modeller. Bruk `class()`, `names()` og `str()` for å lære mer om modellobjektene deres. Se også på hjelpefilene for regresjonsanalyse, med `?lm`.

Som jeg nevnte, skal vi gjøre regresjonsdianostikk i neste seminar, dermed blir det naturlig å snakker mer om forutsetninger for regresjon i neste seminar, men jeg nevner likevel forutsetningene her. Jeg vil også at dere skal tenke på utelatte variabler, da dette er en forutsetning som vi ikke kan teste.

Forutsetninger:
1. Ingen utelatte variabler som er en årsak til uavh. og avh. variabel.

Tolkning:
Substansiell tolkning av lineær regresjonsanalyse er stort sett ganske greit, siden avhengig variabel stort sett er substansielt meningsfull, og siden vi får oppgitt effekten til en uavhengig variabel i endring i enheter i avhengig variabel. Det er for eksempel ganske klart at en variabel som øker et lands BNP med 200 kroner har en svak effekt, mens en variabel som øker BNP med 5 000 000 000 har en ganske sterk substansiell effekt. I noen tilfeller kan det være vanskeligere, da bør vi se på variasjon i avhengig og uavhengig variabel og tenke oss godt om. Vi kan også standardisere vår uavhengige variabel for å se på prosentvis endring (sett inn Field referanse).

For å forstå regresjonsanalysen vår bedre er det fint å plotte regresjonslinjen og usikkerheten, dette er særlig nyttig ved samspill (legg inn mtcars eksempel).

## Logistisk regresjon

Teori: Vi gjør basically det samme som med OLS, vi bruker en matematisk metode for å finne den linjen som beskriver sammenhengen vi spesifiserer mellom uavhengig og avhengig variabel best. På grunn av at den avhengige variabelen er dikotom, må den imidlertid transformeres for at regresjonen vår skal fungere. Dette er tankegangen bak logistisk regresjon, og beslektede metoder som probit.

Konsekvenser i praksis:

* Den største praktiske forskjellen er at substansiell tolkning blir vanskeligere. OLS gir oss en rett linje (eller polynom) som beskriver en sammenheng i substansielt meningsfulle enheter, som f.eks. antall kroner til kommunene over statsbudsjett som en funksjon av hvor venstre/høyre-vridd regjeringen er. Logistisk regresjon gir oss en rett linje (eller polynom) på logits skalaen, som vi ikke kan tolke substansielt uten videre. Odds-ratio er heller ikke uten videre lett å forstå. Dersom alle var supersmarte matematikere, ville det vært mulig å se på logits, og regne om til sannsynlighet i hodet, for å deretter visualisere sammenhengen mellom uavhengige variabler og sannsynlighet for utfall grafisk. Dessverre er vi ikke så smarte, formen på sammenhengen er ikke-lineær, og sterkt avhengig av verdiene til kontrollvariabler. Derfor anbefaler jeg plotting av regresjonslinjen til logistisk regresjon på det aller sterkeste, da dette gjør substansiell tolkning av logistisk regresjon **mye** lettere. 

* I R må vi huske å bytte `lm()` med `glm()` og spesifisere alternativet `family = binomial`. De resterende argumentene er like.

Les hjelpefil, hva må vi spesifisere for å kjøre en logistisk regresjon?

Forutsetninger:

Forutsetninger:
1. Ingen utelatte variabler som er en årsak til uavh. og avh. variabel.

Tolkning:
Substansiell tolkning av logistisk regresjonsanalyse er stort sett ganske greit, siden avhengig variabel stort sett er substansielt meningsfull, og siden vi får oppgitt effekten til en uavhengig variabel i endring i enheter i avhengig variabel. Det er for eksempel ganske klart at en variabel som øker et lands BNP med 200 kroner har en svak effekt, mens en variabel som øker BNP med 5 000 000 000 har en ganske sterk substansiell effekt. I noen tilfeller kan det være vanskeligere, da bør vi se på variasjon i avhengig og uavhengig variabel og tenke oss godt om. Vi kan også standardisere vår uavhengige variabel for å se på prosentvis endring.




