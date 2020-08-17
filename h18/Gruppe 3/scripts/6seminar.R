#' ---
#' title: "Seminar 6"
#' author: "Martin Søyland"
#' output:
#'   pdf_document: default
#'   html_document: html_notebook
#' header-includes: \usepackage{setspace}\onehalfspacing
#' urlcolor: cyan
#' ---
#' 
## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, tidy.opts = list(width.cutoff = 80), tidy = FALSE)
knitr::opts_knit$set(root.dir = "../")

#' 
#' ## Laste inn data
#' Vi fortsetter der vi slapp sist! Altså med European Social Survey data.
#' 
## ----essAll--------------------------------------------------------------
rm(list = ls())
load(file = url("https://github.com/martigso/stv4020aR/raw/master/Gruppe%203/data/ess.rda"))

library(psych)     # Viktig pakke for ting rundt faktoranalyse
library(lme4)      # Flernivåanalyse
library(ggplot2)   # Plotting
library(stargazer) # Regresjonstabeller

#' 
#' # Faktoranalyse
#' 
#' Skal ikke skrive så mye om den substansielle tolkningen av faktoranalyse, Christophersen er mye ryddigere på dette. Så les pensum!
#' 
#' La oss tenke oss at våre tillitsvariabler **sammen** måler et (eller flere) underliggende konsep -- for eksemple politisk tillit. Det første vi vil gjøre er å bare sjekke korrelasjonen mellom disse variablene. Jeg bruker `cor.plot()` for å visualisere kjapt hvordan korrelasjonsmatrisen ser ut. Vi kunne brukt `ggplot()` også her, men det tar litt lenger tid (når dere skriver oppgaver: pass på å gjøre figurer/tabeller finere enn dette).
#' 
## ----trustVars-----------------------------------------------------------

korrel <- cor(ess[, c("trust_parl", "trust_legalsys", "trust_police", 
                      "trust_politicians", "trust_polparties", "trust_eurparl",
                      "trust_unitednations")], use = "complete.obs")
korrel
cor.plot(korrel, numbers = TRUE)

KMO(korrel)

bartlett.test(formula = ~., ess[, c("trust_parl", "trust_legalsys", "trust_police", 
                          "trust_politicians", "trust_polparties", 
                          "trust_eurparl", "trust_unitednations")])




# Et triks når det er et mønster i variablene vi skal ha:
# cor(ess[, c(names(ess)[which(grepl("trust_", names(ess)))])], use = "complete.obs")


#' 
#' Korrelasjonene er altså ganske høye mellom alle variablene -- de laveste er rundt 0.40. La oss kjøre på med faktoranalysene. Vi gjør først en prinsipal komponentanalyse. Denne er *eksplorerende*, i at vi ikke bestemmer på forhånd hvor mange faktorer variablene deler seg inn i. Funksjonen vi bruker er `princomp()`, som kan spesifiseres på flere måter. Jeg har lagt opp en formel som sier at vi skal bruke alle variablene i `data`-argumentet (ess) -- her trekker jeg (som i korrelasjonene over) ut bare *trust*-variablene. Jeg tar også vare på scores.
#' 
#' Ladningene vist under, viser ikke veldig sterke mønster (for meg hvertfall). Legg merke til at denne type faktoranalyse går fra 1 faktor til antall variabler du putter inn (her 7). 
#' 
#' Ser vi på screeplotet derimot, er det tydelig at èn faktor forklarer mye. Likevel kan vi ikke ignorere faktor 2 og 3 heller. Hvordan kan det ha seg?
#' 
## ----principalComponents-------------------------------------------------

trust_prin <- princomp(~., ess[, c("trust_parl", "trust_legalsys", "trust_police", 
                                     "trust_politicians", "trust_polparties", 
                                     "trust_eurparl", "trust_unitednations")],
                       scores = TRUE)

loadings(trust_prin)

screeplot(trust_prin, type = "lines")


#' 
#' La oss kjøre en faktoranalyse der vi setter antall faktorer til 3. Vi kan ha en ganske tydelig, men uhøytidelig, teoretisk antagelse om hvorfor våre variabler deler seg i tre faktorer: en faktor handler om nasjonal politikk (parlament, politiske partier, politikere), en handler om rettsvesen (rettssystem,politi) og en handler om internasjonale institusjoner (EU, FN). Her bruker vi funksjonen `factanal()` som er satt opp ganske likt som `princomp()`. Forskjellen er at vi setter akkurat hvor mange faktorer vi skal ha i analysen (3). 
#' 
## ----factoranalyse-------------------------------------------------------

trust_factor <- factanal(~., 3, ess[, c("trust_parl", "trust_legalsys", "trust_police", 
                        "trust_politicians", "trust_polparties", 
                        "trust_eurparl", "trust_unitednations")])

loadings(trust_factor)

print(loadings(trust_factor), cutoff = .5)


#' Her er alle ladninger lavere enn 0.5 sjult. Vi ser at den teoretiske antagelsen vår ser ganske rimelig ut. Magi!
#' 
#' Nedefor er to eksempler på rotasjon. Dette kan dere bruke om dere skulle trenge det til oppgaven
#' 
## ----rotasjon------------------------------------------------------------
varimax(loadings(trust_factor), normalize = TRUE)
promax(loadings(trust_factor))


#' 
#' Det siste som da gjenstår, er å lage våre tre faktorer om til en additiv indeks -- det er også mulig å vekte faktorene forskjellig. Her summerer vi rett fram veridene for variablene på hver faktor og deler på antall variabler.
#' 
## ----lageIndekser--------------------------------------------------------

ess$political_trust <- (ess$trust_parl + ess$trust_politicians + ess$trust_polparties) / 3
ess$legal_trust <- (ess$trust_legalsys + ess$trust_police) / 2
ess$international_trust <- (ess$trust_unitednations + ess$trust_eurparl) / 2

summary(ess[, c("political_trust", "legal_trust", "international_trust")])


#' 
## ----plotIndekses--------------------------------------------------------

# is.na(ess$gender[100:120])
# is.na(ess$gender[100:120]) == FALSE

plot_data <- ess[which(is.na(ess$gender) == FALSE), ]

ggplot(plot_data, aes(x = gender, y = as.numeric(political_trust))) + 
  geom_boxplot() +
  facet_wrap(~ country) +
  theme_minimal() +
  labs(y = "Politisk tillit", x = "Kjønn") +
  theme(strip.background = element_rect(color = "black"))


#' 
#' 
#' # Litt mer flernivåanalyse
#' 
#' I denne seksjonen går vi tilbake til litt flernivåanalyse. Her bruker vi en av våre konstruerte indekser: *political_trust*. Jeg lager et eget datasett der jeg fjerner enhetene som har NA på en eller flere av variablene vi skal bruke, og drar ut bare variablene vi skal bruke. Dette er hovedsakelig fordi det er en enkel måte å teste model fit på med sekvensiell analyse.
#' 
#' Først estimerer jeg en null-modell, med bare random intercept mellom land. Deretter legger jeg inn variablene sekvensielt.
#' 
## ----flernivå------------------------------------------------------------


reg_data <- na.omit(ess[, c("political_trust", "income_feel", "income_decile",
                            "gender", "age", "country")])

# reg_data <- ess[which(is.na(ess$political_trust) == FALSE &
#                         is.na(ess$income_feel) == FALSE &
#                         ...)]

trust_polit0 <-lmer(political_trust ~ (1|country),
                    data = reg_data)
summary(trust_polit0)

# ICC
1.377 / (1.377 + 3.743)

trust_polit1 <- lmer(political_trust ~ income_feel + (1|country),
                    data = reg_data)
summary(trust_polit1)

fixef(trust_polit1)
ranef(trust_polit1)
coef(trust_polit1)

trust_polit2 <- lmer(political_trust ~ income_feel + income_decile + (1|country),
                    data = reg_data)

trust_polit3 <- lmer(political_trust ~ income_feel + income_decile + age + gender + 
                       (1|country),
                    data = reg_data)

trust_polit4 <- lmer(political_trust ~ income_feel + income_decile + age + gender + 
                       (gender|country),
                    data = reg_data)

summary(trust_polit4)

library(lattice)

dotplot(coef(trust_polit4))
# To mål på model-fit, som straffer at vi legger inn flere variabler
# AIC(trust_polit0, trust_polit1, trust_polit2, trust_polit3, trust_polit4)
# BIC(trust_polit0, trust_polit1, trust_polit2, trust_polit3, trust_polit4)


#' 
#' 
#' 
## ----tabell,results='asis',echo=FALSE------------------------------------

stargazer(trust_polit0, trust_polit1, trust_polit2, trust_polit3, trust_polit4, header = FALSE)
# Nevn hvorfor det er viktig å se på regresjonen i R! Siste modell her gir ingen indikasjon om at vi har brukt random slope på gender.

#' 
#' 
#' Vi kan så hente ut random effekter og konstantledd for alle land med funksjonen `ranef()`, fixed effekter med `fixef()` og summen av disse med `coef()`. Videre kan vi plotte random effekter med `dotplot()` fra pakken lattice, etc. 
#' 
## ----trekkeUtLmerTing----------------------------------------------------
fixef(trust_polit4)
ranef(trust_polit4)
coef(trust_polit4)

lattice::dotplot(ranef(trust_polit4, condVar = TRUE))

#' 
## ----ikketenkpådenne, eval=FALSE, echo=FALSE-----------------------------
## knitr::purl("./docs/seminar6.Rmd", output = "./scripts/6seminar.R", documentation = 2)
## 

