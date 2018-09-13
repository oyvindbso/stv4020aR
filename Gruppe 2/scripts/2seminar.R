#' ---
#' title: "Seminar 2"
#' author: "Martin Søyland"
#' output:
#'   pdf_document: default
#'   html_document: html_notebook
#' header-includes: \usepackage{setspace}\onehalfspacing
#' urlcolor: cyan
#' editor_options: 
#'   chunk_output_type: console
#' ---
#' 
## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, tidy.opts = list(width.cutoff = 90), tidy = TRUE)


#' # Disposisjon
#' 1. Repetisjon
#' 2. Korrelasjon
#' 3. Bivariat OLS
#' 4. Multipel OLS
#' 5. Samspill og andregradsledd
#' 6. Logistisk regresjon
#' 
#' Fokus: Regresjon og tolkning + litt visualisering!
#' 
#' ## Datasett
#' Sååå, samme datasett som sist. Husk at du må `setwd()` hver gang du åpner R (med mindre du bruker prosjekt). Data er passasjerer fra Titanic og variabler på om de overlevde, klasse, pris, osv. Dere kan enten laste ned data ved å skrive inn nettaddressen under i nettleseren og legge denne filen i mappen dere jobber fra:
#' 
## ----Titanic2, eval=FALSE------------------------------------------------
## setwd("~/Der/du/vil/jobbe/fra")
## 
## passengers <- read.csv("titanic.csv", stringsAsFactors = FALSE)
## 

#' 
#' Jeg laster bare direkte inn fra linken. Legg merke til argumentet `stringsAsFactors = FALSE`. Dette står som default til `TRUE`. Argumentet konverterer alle variabler (kolonner) til klassen `factor()`, som er tilnærmet det samme som ordinalt målenivå -- det vil vi ikke! Hvorfor vil vi ikke? Fordi vi vil ha lavest målenivå og heller sette det opp om vi finner ut at det gir mening, gitt data og det vi skal gjøre.
#' 
## ----Titanic-------------------------------------------------------------
passengers <- read.csv("https://folk.uio.no/martigso/stv4020/titanic.csv",
                       stringsAsFactors = FALSE)

# passengers <- read.csv("./data/titanic.csv", stringsAsFactors = FALSE)

class(passengers$Name)

#' 
#' ## Litt omkoding
#' 
#' Vi skal, som forrige gang, sentrere variabelen `Age`
#' 
## ----omkoding------------------------------------------------------------
median(passengers$Age, na.rm = TRUE)
passengers$age_cent <- passengers$Age - median(passengers$Age, na.rm = TRUE)

#' 
#' Dette er en veldig god anledning til å se litt på **pakker**. R har nemlig et helt insane stort *open source* bibliotek med brukerlagede pakker alle har lov å bruke. Vi installerer en pakke med funksjonen `install.packages()` (husk å ha pakkenavnet i hermetegn her). Det er faktisk ikke nok å bare installer pakken, vi må også pakke den opp. Det gjør vi med `library()`. Pakken vil da være lastet *inn* til du avslutter R-sessionen du har åpen. Såååå, "ggplot2" er en pakke for å lage grafikk, som vi kommer til å bruke mye (R har også en innebygd grafikk-fuksjon: `plot()`).
#' 
#' Nedenfor sjekker jeg om omkodingen vi gjorde er riktig. Syns dere det ser sånn ut?
#' 
## ----sjekkeomkoding------------------------------------------------------
rm(list = ls())
library(ggplot2)

#install.packages("ggplot2")

ggplot(passengers, aes(x = Age, y = age_cent)) +
  geom_point()


#' 
#' Vi kan også gjøre grafikken mye finere, men denne figuren vil ikke bli brukt i et evt paper. Så det er greit at den er litt quick and dirty. Kommer tilbake til det senere.
#' 
#' ## Korrelasjon
#' La oss også sjekke korrelasjonen mellom flere av variablene våre. Her bruker vi funksjonen `cor()` for bare korrelasjonsestimater.
#' 
#' Som dere husker fra forrige gang, må vi håndtere missingverdier. Men med korrelasjon er det, som dere vet, forskjellige måter å håndere missing på: pairwise og listwise exclusion. Dette er ikke viktig med korrelasjon mellom bare to variabler, men med flere variabler er det viktig:
#' 
## ----korrelasjon_missing, results='hold'---------------------------------
# data[rader, kolonner]
passengers[ , c("age_cent", "Survived", "Fare")]

cor(passengers[, c("age_cent", "Survived", "Fare")], use = "complete.obs")

cor(passengers[, c("age_cent", "Survived", "Fare")], use = "pairwise.complete.obs")


#' 
#' 
#' ## Multivariat OLS
#' Forrige gang kjørte vi en bivariat regresjon med `Survived` som avhengig variabel og `age_cent` som uavhengig variabel:
#' 
## ----ols-----------------------------------------------------------------
pass_reg <- lm(Survived ~ age_cent, data = passengers)
summary(pass_reg)

#' 
#' Vi ble likevel enige om at dette kanskje ikke var den beste spesifikasjonen av regresjonen, hvis vi undersøke hva som gjorde at passasjerene overlevde.
#' 
#' "Women and children":
## ----ols2----------------------------------------------------------------
# pass_reg2 <- lm(passengers$Survived ~ passengers$age_cent + passengers$Sex)
pass_reg2 <- lm(Survived ~ age_cent + Sex, data = passengers)
summary(pass_reg2)

#' 
#' 
#' Og noen personer er viktiger enn andre...:
## ----ols3----------------------------------------------------------------
pass_reg3 <- lm(Survived ~ age_cent + Sex + factor(Pclass), data = passengers)
summary(pass_reg3)

plot(pass_reg3)
hist(resid(pass_reg3))

0.972139 + (-0.005460 * 40) + (-0.479456 * 1) + (-0.406618 * 1)

#' 
#' 
#' Så kan man tenke seg at man prioriterte både de yngste og de elste i livbåter, fordi personer mellom har større sannsynlighet for å overleve uten livbåt (dog kanskje ikke så veldig stor absolutt sannsynlighet likevel). Dette kan vi teste med et andregradsledd. For å lage andregradsledd er det to alternativer, her er ett: (det andre er å bruke funksjonen `poly()`)
#' 
#' ## Andregradsledd (polynomer)
## ----polynom, tidy=FALSE-------------------------------------------------

passengers$age_cent_andregrad <- passengers$age_cent^2

andregrads_reg <- lm(Survived ~ age_cent + age_cent_andregrad + Sex + factor(Pclass),
                     data = passengers)

# andregrads_reg <- lm(Survived ~ poly(age_cent, 2, raw = TRUE) + Sex + factor(Pclass),
#                      data = passengers[which(is.na(passengers$age_cent) == FALSE), ])

summary(andregrads_reg)
# plot(andregrads_reg)
# termplot(andregrads_reg, se = TRUE, terms = 1)

#' 
#' ## Logistisk regresjon
#' Logistisk regresjon er veldig likt i oppbygning. Det er i familien **general linearized models** (`glm()`). Det viktige her er argumentet `family = "binomial"`, som spesifiserer at vi snakker om en binær avhengig variabel -- kan også skrive `binomial(link = "logit")`. 
#' 
## ----logit, tidy=FALSE---------------------------------------------------

pass_logit <- glm(Survived ~ age_cent + Sex + factor(Pclass),
                  data = passengers, family = "binomial",
                  na.action = "na.exclude")
resid(pass_logit)
summary(pass_logit)


#' 
#' ### Tolkning av logit-regresjon
#' Tolkning av logit-estimater, utover retning, er gankse vanskelig. Heldigvis kan vi regne ut sannsynligheter basert på disse estimatene. Her bruker vi estimatene fra regresjonen til å regne fra logit til sannsynligheter manuelt:
#' 
## ----logitomregning, tidy=FALSE------------------------------------------

# Konstantleddet (kvinne, 28 år, 1 klasse)
exp(2.741425) / (1 + exp(2.741425))

# Alder (1 enhets økning)
exp(2.741425 + (-0.036985 * 1)) / (1 + exp(2.741425 + (-0.036985 * 1)))

# Alder (10 enhets økning)
exp(2.741425 + (-0.036985 * -10)) / (1 + exp(2.741425 + (-0.036985 * -10)))

# Mann, 38 år, 3 klasse
exp(2.741425 + (-0.036985 * 10) + (-2.522781 * 1) + (-2.580625 * 1)) / 
  (1 + exp(2.741425 + (-0.036985 * 10) + (-2.522781 * 1) + (-2.580625 * 1)))


exp(2.741425 + (-0.036985 * 10) + (-2.522781 * 1)) / 
  (1 + exp(2.741425 + (-0.036985 * 10) + (-2.522781 * 1)))

# table(passengers$Pclass)

#' 
#' Dette kan også gjøres automatisk. Her med in sample prediksjon:
## ----predict_logit, tidy=FALSE, results='hide'---------------------------

# Logits
predict(pass_logit)

# Sannsynlighet
predict(pass_logit, type = "response")
passengers[891, c("Survived", "age_cent", "Sex", "Pclass")]

# Sannsynlighet, med standardfeil
predict(pass_logit, type = "response", se = TRUE)


#' 
#' 
#' Der er også mange måter å sjekke om denne prediksjonen er god; her er ett forslag:
#' 
## ----plotpred, tidy=FALSE------------------------------------------------

passengers$pred <- predict(pass_logit, type = "response")

ggplot(passengers, aes(x = pred, color = factor(Survived), fill = factor(Survived))) +
  geom_density(alpha = .25) +
  theme_bw() +
  scale_colour_manual(values = c("blue", "darkred")) +
  scale_fill_manual(values = c("blue", "darkred")) +
  labs(x = "Predikert sannsynlighet", y = "Tetthet", color = "Overlevde", fill = "Overlevde") +
  theme(legend.position = "top",
        panel.grid = element_blank())


ggplot(passengers, aes(x = Age, y = Fare)) +
  geom_point() +
  geom_smooth(method = "lm")
#' 
#' 
#' 
#' ## Neste gang:
#' - Mer wrangling
#' - Samspill
#' - Diagnostisering
#' - Plotte effekter med multipel regresjon
#' - Ønsker?
#' 
#' \newpage
#' 
#' ## Bonus for \LaTeX -elskere:
## ----stargazer,results='asis',tidy=FALSE---------------------------------
# install.packages("stargazer")
library(stargazer)
stargazer(pass_reg, pass_reg2, pass_reg3, pass_logit,
          star.cutoffs = c(.05, .01, .001),
          column.sep.width = ".01cm",
          no.space = FALSE,
          covariate.labels = c("Alder (sentrert)", "Kjønn (mann)",
                               "Klasse (2)", "Klasse (3)", "Konstantledd"),
          keep.stat = c("n", "rsq", "adj.rsq", "ll"))

#' 
#' 
#' 
#' 
#' 
#' 
#' 
## ----ikketenkpådenne, eval=FALSE, echo=FALSE-----------------------------
## knitr::purl("./docs/seminar2.Rmd", output = "./scripts/2seminar.R", documentation = 2)
## 

#' 
