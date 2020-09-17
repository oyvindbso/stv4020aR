###############################################
##### FORDYPNINGSSEMINAR 3: FAKTORANALYSE #####
###############################################

## HUSK install.packages("pakkenavn") FØRST OM DU IKKE HAR BRUKT PAKKEN FØR ##
library(psych) # Nyttig for faktoranalyse
library(tidyverse) # Dataprepping e.l.
library(sjlabelled) # Undersøke labels
library(REdaS) # For å gjøre Bartletts test
library(FactoMineR) # Alternativ pakke for faktoranalyse
library(factoextra) # Litt mer intuitive varianter av. bla scree plot
library(GPArotation) # For rotasjon
library(ggcorrplot) # For korrelasjonsplot

## Start med samme data fra European Social Survey bare for norge (ess_no). 
## Last ned fra data-mappen på github, lagre data i prosjektmappen din (working directory)
# og kjør følgende kode:

load("H20-seminarer/Fordypningsseminarer/data/ess9no.Rdata")

# En hensikt med faktoranalyse kan være å redusere dimensjoner
dim(ess_no)
str(ess_no)
# Noe om dimensjoner?
# Exactly! Explaining data variation and handling correlation 
# efficiently are the two key reasons for conducting dimensionality 
# reduction!


# TRINN 1: Forberede dataene
# Deskriptiv statistikk
ess_no %>%
  summary()
# Hvilket målenivå er variablene på? Vi vil helst ha metriske og forholdstallsnivå
# Bør ha sju verdier (Christophersen s 97)
# Går variablene i samme retning?  Sjekk kodebok og evnt. labels 
summary(ess_no$trust_police)
get_labels(ess_no$trust_police)

# Har vi mye missing? Hva skal vi gjøre med det?
table(complete.cases(ess_no))
# Ser at 387 observasjoner har missing på en eller flere av
# variablene våre. Dette kan være lurt å diskutere i hjemmeoppgaven,
# spesielt dersom du velger å fjerne de med na ved hjelp av na.omit()

## Ser på korrelasjoner mellom tillits- og tilfredshetsvariabler
# Korrelasjonsmatrise (Pearsons R)
korrel <- ess_no %>%
  select(starts_with("trust")) %>%
  cor(, use = "complete.obs")
# OBS! use = "complete.obs" betyr at vi tar utgangspunkt i de 
# observasjonene som ikke har missing på noen av disse variablene

korrel
# Pearsons R -1 - 1

# Plotter korrelasjon:
cor.plot(korrel, numbers = TRUE)

# Alternativ metode ved hjelp av ggcorrplot som tar utgangspunkt
# i ggplot  fra pakken ggcorrplot
ggcorrplot(korrel, show.diag = FALSE, lab = TRUE,
           hc.order =  TRUE, type = "upper",
           ggtheme = theme_void())

### Keyser-Meyer-Olkin
# Måler i hvilken grad hver variabel i analysen kan predikeres
# uten målefeil av de andre variablene.
KMO(korrel) 
# Bør være minst 0.5 
# OVerall MSA = 0.84

### Bartletts signifikanstest
# Tester om korr.matrise er sign. forskjellig fra null:
bart_spher(korrel)
# H0: variables are not intercorrelated 
# Med p < 0.05 indikerer Bartletts signifikanstest at
# indikatorkorrelasjonene har tilfredsstillende styrke, 
# dvs. at korrelasjonsmatrisen er signifikant forskjellig fra 0. 
# Men denne kan bli signifikant selv uten tilfredsstillende KMO-verdier.

### TRINN 2: Kjører faktoranalyse
## Induktivt valg av faktorer: principal component
# I faktoranalyse så omfordeler vi faktorenes varians
# For å forklare all varians vil en trenge like mange
# faktorer som indikatorer og det er vi estimerer i denne modellen
trust_prin <- princomp(~.,    # Her skal vi ha en formel uten AVAR. Med "." sier vi at vi vil ta med alt i datasettet
                       ess_no %>%
                         select(starts_with("trust")),
                       scores = TRUE, na.action = "na.omit")


# Alternativ kode i pakken FactoMineR som gir et interessant plot: 
trust_prin_alt <- PCA(ess_no%>%
                        select(starts_with("trust")))
## OBS!! Merk dere advarselen her.. 
# Gå evnt. gjennom denne introen: 
# https://learn.datacamp.com/courses/dimensionality-reduction-in-r
# PCA graph of variables: 
# Her ser vi at dimensjon nr 2 skiller de som har høy verdi på
# satisfied fra de med lav verdi på tillit 

### Hvor mange faktorer skal vi ha?
## Kaisers kriterium: : De faktorene som har eigenvalue større
# enn 1, skal tas med
# Eigenvalues henger sammen med hvor stor andel forklart varians en faktor står for
# Legger til grunn standardiserte variabler som da vil ha total varians
# lik 1 * antall indikatorer. 
eigen <- eigen(korrel)
eigen

# Summen av alle eigen-verdiene er lik antall indikatorer:
sum(eigen$values)

# Kaises kriterium: Hver faktor bør forklare minst like mye som en enkeltstående indikator (>=1). 
eigen$values
#.. egentlig bare 1? 

## Med andel forklart varians
summary(trust_prin)
# Eller som plot:
fviz_screeplot(trust_prin,
               addlabels = TRUE) +
  theme_classic()
# Vil forklare 70 % så bør vi velge 2
# Vil vi forklare 60 % så bør vi velge 1

# Scree test
# Skal ta med faktorer frem til den unike variansen blir dominenerende, 
# dvs. eigenvalue flater ut
screeplot(trust_prin, type = "lines")
# Kanskje egentlig 1 i følge scree-plottet? 
fviz_screeplot(trust_prin,
               addlabels = TRUE,
               choice = "eigenvalue") +
  theme_classic()
# NB! Her plottes eigenvaluens varians
# (om jeg har forstått det riktig)

# A priori test: argumenter teoretisk

# For å se på hvilke faktorer de ulike indikatorene lader på:
loadings(trust_prin) # Hva forteller denne oss?
# Her ser vi at proporsjonell varians er delt likt mellom alle faktorene

## Vi velger antall faktorer, her 1, under 2, også 3.
trust_factor1 <- factanal(~., 1, ess_no %>%
                            select(starts_with("trust")))

names(trust_factor1)
print(loadings(trust_factor1), cutoff = .4)

trust_factor2 <- factanal(~., 2, ess_no %>%
                                    select(starts_with("trust")))


names(trust_factor2)
print(loadings(trust_factor2), cutoff = .4)
# Faktorladningene kan tolkes som standardiserte regresjonskoeffisienter
# 0.3-0.4: minimumsnivå for å kunne gjøre substansielle tolkninger
# >0.6-0.7: uttrykk for en god tilpasset faktorstruktur

trust_factor3 <- factanal(~., 3, ess_no %>%
                            select(starts_with("trust")))

print(loadings(trust_factor3), cutoff = .4)
 
## ROTASJON
# For å få "renere" faktorer
# Ortogonal
# For å tolke faktorene substansielt bør hver indiator lade
# sterkt på bare en faktor

# Ortogonal rotasjon (ikke korrelert)
varimax(loadings(trust_factor2), normalize = TRUE)
# Hver indikator lader enten høyt eller lavt på en faktor, 
# men kan lade høyt/lavt på flere faktorer

quartimax(loadings(trust_factor2), normalize = TRUE)
# Hver indikator lader høyt på bare en faktor, men kan lade
# moderat også på andre

# Oblique (korrelert)
oblimin(loadings(trust_factor2))
promax(loadings(trust_factor2))

# For å oversikt over rotasjonsmuligheter: 
?quartimax

## Opprette additive indekser - eksempel (her finnes det mange muligheter - se pensum/forelesning):
ess$political_trust <- (ess$trust_parl + ess$trust_politicians + ess$trust_polparties) / 3
ess$legal_trust <- (ess$trust_legalsys + ess$trust_police) / 2
ess$international_trust <- (ess$trust_unitednations + ess$trust_eurparl) / 2


## Opprette faktorindekser
trust_factor2score <- factanal(~., 2, ess_no %>%
                            select(starts_with("trust")),
                          scores = "regression", # Her kan vi velge mellom regression og Bartlett
                          na.action = "na.exclude")

loadings(trust_factor2score)

# Ser hva som er lagret i modellen:
names(trust_factor2score)

# Sjekker ut scores-elementet
trust_factor2score$scores

# Lagrer faktor-skår i data
# Husk na.action = "na.exclude" i modellen over.
ess_no$factor1_score <- trust_factor2score$scores[, 1]
ess_no$factor2_score <- trust_factor2score$scores[, 2]

summary(ess_no$factor1_score)
summary(ess_no$factor2_score)

cor(ess_no$trust_legal, ess_no$factor2_score, use = "complete") 
cor(ess_no$trust_polparties, ess_no$factor2_score, use = "complete")
