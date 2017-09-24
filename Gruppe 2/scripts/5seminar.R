#' 
#' ## Laste inn data
#' Vi fortsetter der vi slapp sist! Altså med European Social Survey data (Norge subsett).
#' 
## ----lasterda------------------------------------------------------------
load("./data/ess_norge.rda")

#' 
#' 
#' ## Variabler
#' 
#' Tabellen under viser en kort variabelbeskrivelse. Jeg har lagt inn labels i selve datasettet og det skal vi jobbe med i første del denne gangen.
#' 
#' | Variabel            | Målenivå        | Beskrivelse                                             |
#' |---------------------|-----------------|---------------------------------------------------------|
#' | idno                | Forholdstall    | ID indikator for hver enhet                             |
#' | party_vote          | Nominal         | Parti stemt på forrige Stortingsvalg                    |
#' | party_vote_short    | Nominal         | Forkortet navn på parti stemt på forrige Stortingsvalg  |
#' | gender              | Dikotom         | Kjønn                                                   |
#' | year_born           | Forholdstall    | År født                                                 |
#' | income_feel         | Ordinal         | Hvordan føler du din økonomiske situasjon er for tiden? |
#' | income_decile       | Ordinal         | Husholningens inntekt i desiler                         |
#' | trust_parl          | Ordinal         | Hvor mye stoler du på det nasjonale parlamentet?        |
#' | trust_legalsys      | Ordinal         | Hvor mye stoler du på rettsvesenet?                     |
#' | trust_police        | Ordinal         | Hvor mye stoler du på politiet?                         |
#' | trust_politicians   | Ordinal         | Hvor mye stoler du på politikere?                       |
#' | trust_polparties    | Ordinal         | Hvor mye stoler du på politiske partier?                |
#' | trust_eurparl       | Ordinal         | Hvor mye stoler du på det europeiske parlamentet?       |
#' | trust_unitednations | Ordinal         | Hvor mye stoler du på FN?                               |
#' 
#' 
#' 
#' # Fikse problemer vi fant sist
#' 
#' Vi kjørte en multinomisk logistisk modell sist, som viste seg å ha flere mangler:
#' 1. Små partier er problematiske (liten N)
#' 2. Vi mangler noen kontrollvariabler (kanskje man systematisk stemmer med venstre som ung f.eks, samtidig som alder påvirker hvor mye man stoler på politikere).
#' 3. Kanskje AV er ordinal?
#' 
#' ## Eliminere små partier
#' 
#' Vi fjernet først de minste partiene. Noen ganger kan det være lurt å heller slå sammen kategoriene (ref forelesningen til Solveig). 
#' 
## ----subsetLargParties---------------------------------------------------
larger_parties <- ess_nor[which(ess_nor$party_vote_short != "RØDT" &
                                  ess_nor$party_vote_short != "KYST" & 
                                  ess_nor$party_vote_short != "MDG" & 
                                  is.na(ess_nor$party_vote_short) == FALSE), ]
table(larger_parties$party_vote_short, useNA = "always")

#' 
#' ## Fikse kontrollvariabler
#' Videre har vi noen kontrollvariabler vi vil inkludere i regresjonen. Men disse må vi "pynte" litt på først.
#' 
#' Vi skal kontrollere for fire ting: inntekt, hvor fornøyd respondenten er med økonomien sin, kjønn og alder. Tanken med alle er den samme: de er bakenforliggende variabler (for tillit til politikere), og de kan tenkes å påvirke både vår avhenige og uavhengige variabel (*backdoor path*).
#' 
#' 
#' ### To inntektsvariabler
#' 
#' Når vi subsetter blir labels på variablene fjernet av en eller annen grunn...så vi må kopiere dem over til det nye datasettet med pakken **labelled** og funksjonen **copy_labels** først. Deretter kan vi sjekke hvilke verdier vi ikke vil ha med videre fra de forskjellige variablene.
#' 
## ----incomeCode----------------------------------------------------------
library(labelled)

larger_parties$income_feel <- copy_labels(ess_nor$income_feel, 
                                          larger_parties$income_feel)
attr(larger_parties$income_feel, "labels")

larger_parties$income_feel2 <- ifelse(larger_parties$income_feel > 4, NA, 
                                      larger_parties$income_feel)

table(larger_parties$income_feel2, larger_parties$income_feel, useNA = "always")

larger_parties$income_decile <- copy_labels(ess_nor$income_decile,
                                            larger_parties$income_decile)
attr(larger_parties$income_decile, "labels")

larger_parties$income_decile2 <- ifelse(larger_parties$income_decile > 10, NA, 
                                        larger_parties$income_decile)

table(larger_parties$income_decile2, larger_parties$income_decile, useNA = "always")


#' 
#' ### Kjønn og alder
#' Kjønn ser ut til å være kodet på en fornuftig måte, så her trenger vi ikke gjøre noe. Alder kan vi regne ut med å trekke fødselsår fra året surveyen ble utført (2014). Så sentrerer vi variabelen til median.
#' 
## ----genderageCode-------------------------------------------------------
table(larger_parties$gender) # Ca like mange, så referansekategori er ikke viktig

larger_parties$age <- 2014 - larger_parties$year_born
larger_parties$age_sen <- larger_parties$age - median(larger_parties$age) # ingen har NA
summary(larger_parties$age_sen)

#' 
#' ## Multinomisk med kontroller
#' Da er det bare å plugge inn variablene i en regresjon. Vi fortsetter med pakken **nnet** og funksjonen `multinom()`.
#' 
## ----multivariatMultinom-------------------------------------------------
library(nnet)
party_reg2 <- multinom(party_vote_short ~ trust_politicians + income_decile2 + 
                         income_feel2 + age_sen + gender,
                       data = larger_parties, Hess = TRUE, na.action = "na.exclude")

summary(party_reg2)

confint(party_reg2)

#' 
#' 
#' ## Plotte effekter
#' 
#' Ofte foretrekker jeg å supplere en regresjonstabell/koeffisientplot med å vise effekten av Xen man fokuserer på i oppgaven/paperet mer substansielt. En måte å gjøre dette på er, som vi var litt innom i bivariat regresjon sist, å lage et *test set* man regner ut regresjonsligningen på. Funksjonen `predict()` er ekstremt kraftig her; den funger på så og si alle regresjonsfunksjoner! 
#' 
#' Det første vi gjør er å konstruere et hypotetisk datasett (test set), der vi lar vår *X in focus* variere fra minimum til maksimumsverdi. Alle de andre variablene vi har som Xer i regresjonen setter vi til snitt/median for kontinuerlige variabler og til en troverdig kategori på de kategoriske variablene:
#' 
#' Når vi holder på med multinomisk regresjon 
#' 
## ----testSet-------------------------------------------------------------
test_set2 <- data.frame(trust_politicians = 0:10,
                        income_decile2 = median(larger_parties$income_decile2, na.rm = TRUE),
                        income_feel2 = median(larger_parties$income_feel2, na.rm = TRUE),
                        age_sen = 0,
                        gender = "female")

#' 
#' Når vi har opprettet dette objektet kan vi binde sammen kolonnene av test settet vår og predikerte verdier på test settet. Mer spesifikt bruker vi regresjonsobjektet vårt (alle beta og Xer) og regner ut ligningen gitt at data ser ut som test settet vårt (*newdata*-argumentet sier altså at vi skal løse ligningen for vårt hypotetiske datasett). Legg også merke til argumentet *type*, som med multinomisk regresjon enten kan gi partiet med høyest sannsynlighet for hver rad (dette er *default*), eller sannsynlighet for hver rad å havne i hvert parti.
#' 
## ----predikerteSannsynligheter-------------------------------------------
test_set2 <- cbind(test_set2, predict(party_reg2, newdata = test_set2, type = "probs"))
head(test_set2)

#' 
#' Vi gjør også et siste lille triks før vi plotter ut effekten av *trust_politicians*. `ggplot()` (og veldig mange andre funksjoner i R) liker nemlig best data i **long** heller enn **wide format**. Pakken **reshape2** kan hjelpe oss med denne konverteringen, og er generelt en pakke som brukes veldig mye.
#' 
#' Her "smelter" vi ned data slik at vi får en egen kolonne for parti (heller enn en kolonne per parti). 
## ----smelteData----------------------------------------------------------
library(reshape2)
test_set2 <- melt(test_set2, measure.vars = c("A", "FRP", "H", "KRF", "SP", "SV", "V"))


#' 
#' Til slutt kan vi bruke `ggplot()` som vi ellers ville gjort. Da får vi et veldig godt bilde av hvordan variabelen vår oppfører seg i regresjonen. Vi ser også at Solveig var smartere enn meg når hun slo sammen til tre kategorier...
#' 
## ----plotEffektenDaVelJegVilSeResultatet---------------------------------
library(ggplot2)

ggplot(test_set2, aes(x = trust_politicians, y = value, color = variable)) + 
  geom_line() +
  theme_minimal() +
  scale_color_manual(values = c("darkred", "darkblue", "blue", "yellow4",
                                "darkgreen", "red2", "green")) +
  labs(x = "Tillit til politikere", y = "Forventet verdi på Y", color = "Parti")


#' 
#' Husk at alt bortsett fra *trust_politicians* er konstant her; *all else equal*!
#' 
#' # Men hva med flernivå!?
#' La oss kikke på vår *trust_politicians* som avhengig variabel i en komparativ sammenheng. Jeg har juksa litt, og fiksa alle variablene på forhånd. Helt identisk med det vi har gjort over. Her vil vi kjapt på forskjellene mellom det som kalles *fixed effects* og flernivåanalyse.
#' 
#' ## Laste inn ESS med alle land
#' Vi starter med å laste inn datasettet ESS, nå med alle land som er inkludert (15 stk).
#' 
## ----essAll--------------------------------------------------------------
rm(list = ls())
load("./data/ess.rda")

table(ess$country)

#' 
#' 
#' 
#' ## Flernivå vs. fixed effects
#' *Fixed effects* er en samlebetegnelse for å kontrollere bort varians som kan åpne *backdoor paths* i regresjonen vår på en enkel måte: vi bare plugger inn dummyset for, i akkurat denne sammenhengen, land. Har man paneldata vil du også lage fixed effects for år (eller periode etc). Legg merke til at R squared ofte blir høy når vi gjør dette.
#' 
## ----FE------------------------------------------------------------------
fe <- lm(trust_politicians ~ gender + age + income_decile + factor(income_feel) + factor(country), 
         data = ess)
summary(fe)

#' Husk også:
#' 
#' | *income_feel* beskrivelse             | Verdi |
#' |---------------------------------------|-------|
#' | Living comfortably on present income  | 1     |
#' | Coping on present income              | 2     |
#' | Difficult on present income           | 3     |
#' | Very difficult on present income      | 4     |
#' 
#' 
#' Ganske tydelig her at det er forskjeller mellom de forskjellige landene. La oss prøve oss på en veldig enkel flernivå her. Vi skal komme tilbake til det neste gang også.
#' 
#' De fleste behov innenfor flernivåanalyse kan tilfredsstilles med pakken **lme4**. OLS flernivå kan kjøres med funksjonen `lmer()`. Syntaksen for denne funksjonen er også veldig lik alle andre regresjonsanalyser, med ett viktig unntak. Legg merke til leddet `(1|country)` under: her sier vi at vi har hierarkisk struktur i data, der *country* er nivå 2 enheter. Dette er altså bare en *random intercept* modell.
#' 
## ----flernivå------------------------------------------------------------
library(lme4)
trust_polit <- lmer(trust_politicians ~ age + gender + income_feel + income_decile + (1|country),
                    data = ess)
summary(trust_polit)

#' 
#' Andre spesifikasjoner:
## ----flernivå2-----------------------------------------------------------
# lmer(AV ~ 1 + (1 | Gruppe_nivå2), data = data) 
      # = random intercept only

# lmer(AV ~ UV_nivå1 + (1 | Gruppe_nivå2), data = data) 
      # = ranomd intercept plus fixed effect

# lmer(AV ~ UV_nivå1 + (UV_nivå1 | Gruppe_nivå2), data = data) 
      # = random intercept, random slope

# lmer(AV ~ UV_nivå1 + UV_nivå2 + (1 + UV_nivå1 | Gruppe_nivå2), data = data) 
      # = random intercept, individual and group predictor

# lmer(AV ~ UV_nivå1 * UV_nivå2 + (1 + UV_nivå1 | Gruppe_nivå2), data = data) 
      # = random intercept, cross-level interaction

library(lme4)

trust_polit2 <- lmer(trust_politicians ~ age + gender + income_feel + income_decile + 
                       (income_feel|country),
                    data = ess) # random intercept, random slope
summary(trust_polit2)

#' 
#' 
#' Vi kan så hente ut random effekter og konstantledd for alle land med funksjonen `coef()`/`ranef()`, plotte konstantleddene med `dotplot()` fra pakken lattice, etc. 
#' 
## ----trekkeUtLmerTing----------------------------------------------------
coef(trust_polit2)
ranef(trust_polit2)

lattice::dotplot(ranef(trust_polit2, condVar = TRUE))


#' 
## ----ikketenkpådenne, eval=FALSE, echo=FALSE-----------------------------
## knitr::purl("./docs/seminar5.Rmd", output = "./scripts/5seminar.R", documentation = 2)
## 

