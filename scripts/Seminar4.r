#########################################
########  Seminar 4, fasit:    ##########
########  Logistisk regresjon  ##########
#########################################

### Oppvarmings-oppgave i plenum: ###

library(tidyverse)

# Les hjelpefil, hva må vi spesifisere for å kjøre en logistisk regresjon? Forklar til sidemannen.
# 
# Last inn datasettet aid2.csv, du finner data på github/via canvas - kall det for aid2. Lagre i en mappe, sett working directory, 
# og last inn datasettet i R med read_csv(). Merk at dette datasettet er det som vi lagde i oppgavene til seminar 1,





# Opprett en ny variabel elrgdpg_d, slik at observasjoner vekst mindre eller lik 0, og andre observasjoner får verdien 1.
# Kjør deretter følgende logistiske regresjon:
m1 <- glm(elrgdpg_d ~ elraid*policy + as.factor(period) + elrlpop + elrassas*elrethnf, data = aid2, family = binomial(lin = "logit"))
summary(m1)

# Diskuter raskt med sidemannen hva slags informasjon du får fra regresjons-output
 
# For å regne om til predikert sannsynlighet for hånd, bruker vi følgende formel: 
# exp(b0 + b1X1 + b2X2 + ... + bnXn)/(1 + exp(b0 + b1X1 + b2X2 + ... + bnXn)) , der b0 er konstantledd.

# Regn ut den predikerte sannsynligheten for positiv vekst for et land med elraid lik -3 i periode 8, 
# med resterende variabler satt til sin medianverdi (ikke legg inn koeffisienter for andre perioder enn periode 8!).

# Regn ut den predikerte sannsynligheten for positiv vekst for et land med elraid lik 3 i periode 8, 
# med resterende variabler satt til sin medianverdi (ikke legg inn koeffisienter for andre perioder enn periode 8!).

# Jeg har satt opp noe dere kan copy-paste under til hjelp, men dere må sørge for at formelen blir riktig selv:
  
exp(-4.046138 + -0.102802*(-3) + 1.654813*median(aid2$policy, na.rm =T) + 
      0.008147*median(aid2$policy, na.rm =T)*(-3) +  -0.770560*1 + 0.381205*median(aid2$elrlpop, na.rm =T) + 
      -0.216738*median(aid2$elrassas, na.rm = T) + -0.449168*median(aid2$elrethnf, na.rm =T) + 
      0.490778*median(aid2$elrassas, na.rm = T)*median(aid2$elrethnf, na.rm =T))
# Er effekten av elraid substansiell?


## Fasit:

#install.packages("tidyverse")
library(tidyverse)

# Laster inn datasettet
aid2 <- read_csv("https://raw.githubusercontent.com/langoergen/stv4020aR/master/data/aid2.csv")

# Denne koden skal fungere dersom du lagret datasett i working directory: 

full <- read_csv("aid2")

aid2$elrgdpg_d <- ifelse(aid2$elrgdpg <= 0, 0, 1)
table(aid2$elrgdpg, aid2$elrgdpg_d)

# Kjører logistisk regresjon
m1 <- glm(elrgdpg_d ~ elraid*policy + as.factor(period) + elrlpop + elrassas*elrethnf, data = aid2, family = binomial(lin = "logit"))
summary(m1)

# Elraid = -3
exp(-1.13311 + -0.17075 *(-3) + 1.654813*median(aid2$policy, na.rm =T) +  0.01071*1 + 
      0.19744*median(aid2$elrlpop, na.rm =T) + -0.22117*median(aid2$elrassas, na.rm = T) + 
      -0.47635*median(aid2$elrethnf, na.rm =T) + 0.06744*median(aid2$policy, na.rm =T)*(-3) +
      0.42297*median(aid2$elrassas, na.rm = T)*median(aid2$elrethnf, na.rm =T))/(1 + exp(-1.13311 + -0.17075 *(-3) + 1.654813*median(aid2$policy, na.rm =T) +  0.01071*1 + 
                                                                                           0.19744*median(aid2$elrlpop, na.rm =T) + -0.22117*median(aid2$elrassas, na.rm = T) + 
                                                                                           -0.47635*median(aid2$elrethnf, na.rm =T) + 0.06744*median(aid2$policy, na.rm =T)*(-3) +
                                                                                           0.42297*median(aid2$elrassas, na.rm = T)*median(aid2$elrethnf, na.rm =T)))

# Elraid = 3
exp(-1.13311 + -0.17075 *(3) + 1.654813*median(aid2$policy, na.rm =T) +  0.01071*1 + 
      0.19744*median(aid2$elrlpop, na.rm =T) + -0.22117*median(aid2$elrassas, na.rm = T) + 
      -0.47635*median(aid2$elrethnf, na.rm =T) + 0.06744*median(aid2$policy, na.rm =T)*(3) +
      0.42297*median(aid2$elrassas, na.rm = T)*median(aid2$elrethnf, na.rm =T))/(1 + exp(-1.13311 + -0.17075 *(3) + 1.654813*median(aid2$policy, na.rm =T) +  0.01071*1 + 
                                                                                           0.19744*median(aid2$elrlpop, na.rm =T) + -0.22117*median(aid2$elrassas, na.rm = T) + 
                                                                                           -0.47635*median(aid2$elrethnf, na.rm =T) + 0.06744*median(aid2$policy, na.rm =T)*(3) +
                                                                                           0.42297*median(aid2$elrassas, na.rm = T)*median(aid2$elrethnf, na.rm =T)))




### Forutsetning og modellvurdering - logistisk regresjon ###
# Mange av metodene for diagnostikk som vi har sett på i dag fungerer også for logistisk regresjon. 
# Funksjonene ceresplot(), dfbetas(), influenceIndexPlot() m.m. fungerer også for logistisk regresjon. 
# Husk forøvrig på at forutsetninger om homoskedastiske, normalfordelte restledd ikke gjelder logistisk regresjon. 

library(car)

# Innflytelsesrike observasjoner/uteliggere
influenceIndexPlot(m1)
dfbetasPlots(m1)

# Ceresplot fungerer ikke på modellen dersom vi legger inn samspill, estimerer på nytt uten samspill
# for å demonstrere
m1b <-  glm(elrgdpg_d ~ elraid + policy + as.factor(period) + elrlpop + elrassas + elrethnf, data = aid2, family = binomial(lin = "logit"))
summary(m1b)
ceresPlots(m1b)



# I tillegg viser jeg noen flere sentrale måter å vurdere modeller på under:
#   
# Tomme celler vil føre til at modellen ikke lar seg estimere, 
# eller at du ikke får estimert standardfeil/ekstremt høye standardfeil, og er således greit å oppdage. 
# Tabeller eller spredningsplot mellom variabler fra regresjonen kan brukes til å undersøke nærmere.
# 
# Vi kan gjøre nøstede likelihood-ratio tester med anova():


gm0 <- glm(as.factor(am) ~ hp, data = mtcars, family = binomial(link = "logit"))
gm1 <- glm(as.factor(am) ~ hp + qsec, data = mtcars, family = binomial(link = "logit"))
anova(gm0, gm1, test = "LRT") # Sjekk de forskjellige alternativene til test med ?anova.glm

#install.packages("pscl")
library(pscl)

pR2(gm1) # sjekk ?pR2 - under Value i hjelpefil er output forklart.
?pR2
# Vi kan gjøre hosmer-lemeshow med hoslem.test() fra pakken ResourceSelection
# Husk: I tillegg til formell diagnostikk, må du aldri glemme generelle validitets/metode-vurderinger.

#install.packages("ResourceSelection")
library(ResourceSelection)
?hoslem.test

# Trenger datasett uten missing på variablene som inngår i regresjonen 

reg_data <- aid2 %>%
  drop_na(elraid, policy, elrgdpg_d, period, elrlpop, elrassas, elrethnf)

# Observert (x = ) mot predikert verdi (y = )
hoslem.test(x = reg_data$elrgdpg_d, y = m1$fitted.values, g = 10)

### Forventet verdi vs. faktisk verdi ###
m1 <- lm(mpg ~ wt + hp, data = mtcars)
m1s <- summary(m1)
names(m1s) # residualer for alle observasjoner gis automatisk i model summary-objekter.

m1s$residuals # residualer for alle observasjonene

# Med cbind(), kan du legge residualene til det opprinnelige datasettet, 
# og deretter plotte faktiske verdier på avhengig variabel mot residualene:
mtcars2 <- (cbind(mtcars, m1s$residuals))
names(mtcars2)
library(ggplot2)
ggplot(mtcars2, aes(x = m1$residuals, y = mpg)) + geom_point()


# install.packages("plotROC")
library(plotROC)

# Kjører regresjonsmodell
m2 <- glm(am ~ vs + hp, data = mtcars, family = binomial())
summary(m2)
m2res <- predict(m2, type = "response") # henter ut predikerte sannsynligheter for observasjonene i datasettet vi brukte til å estimere modellen.

mtcars2 <- cbind(mtcars, m2res)

# Basic ROC:
(basicplot <- ggplot(mtcars2, aes(d = am, m = m2res)) + geom_roc(labelround = 2))

# Pyntet ROC med AUC.
basicplot + 
  style_roc(ylab = "Sensivity (True positive fraction)") +
  theme(axis.text = element_text(colour = "blue")) +
  annotate("text", x = .75, y = .25, 
           label = paste("AUC =", round(calc_auc(basicplot)$AUC, 2))) +
  scale_x_continuous("1 - Specificity", breaks = seq(0, 1, by = .1))


### Logistisk regresjonsplotting ###
#install.packages("ggpubr")
library(ggpubr)

gm1 <- glm(am ~ hp + qsec, data = mtcars, family = binomial(link = "logit"))
summary(gm1)

#' setter inn koeffisienter fra modell over for minimumsverdi og maksimumsverdi til horsepower (hp), 
#' setter qsec til medianverdi: 
#' maks:
exp(38.77277 + -0.04468*max(mtcars$hp) + -1.84289*median(mtcars$qsec))/(1 + exp(38.77277 + -0.04468*max(mtcars$hp) + -1.84289*median(mtcars$qsec)))
#' min:
exp(38.77277 + -0.04468*min(mtcars$hp) + -1.84289*median(mtcars$qsec))/(1 + exp(38.77277 + -0.04468*min(mtcars$hp) + -1.84289*median(mtcars$qsec)))

## Sannsynlighetstolkning igjennom plot:
rm(mtcars)

## Trinn 1: Kjører  logistisk regresjonsmodell
gm1 <- glm(as.factor(am) ~ hp + qsec, data = mtcars, family = binomial(link = "logit"))
## Trinn 2: Lager datasett med den uavh. var hp og kontrollvariabelen qsec. Jeg er interessert i effekten av hp, og lar denne variabelen variere i datasettet jeg lager. Jeg velger medianverdien til qsec.
data_for_prediction <- tibble(hp   = seq(min(mtcars$hp),
                                         max(mtcars$hp), .1),
                              qsec = median(mtcars$qsec))

## Trinn 3: Lager nytt datasett med predikerte verdier for avhengig variabel, og standardfeil (i logit):
predicted_data <- predict(gm1, newdata = data_for_prediction,  type = "link",  
                          se=TRUE)

## Trinn 4: Kombinerer data fra trinn 2 og 3: 
plot_data <- cbind(predicted_data, data_for_prediction)

## Trinn 5: Kalkulerer konfidensintervall med standardfeil fra trinn 3 og legger til plot_data fra trinn 4. Her lager jeg 95% CI med vanlige standardfeil. Regner om fra logit til predikerte sannsynligheter.
plot_data$low  <- exp(plot_data$fit - 1.96*plot_data$se)/(1 + exp(plot_data$fit - 1.96*plot_data$se))
plot_data$high <- exp(plot_data$fit + 1.96*plot_data$se)/(1 + exp(plot_data$fit + 1.96*plot_data$se))
plot_data$fit <- exp(plot_data$fit)/(1+ exp(plot_data$fit))

## Trinn 6: Plot
#install.packages("ggthemes")
library(ggthemes)
p <- ggplot(mtcars, aes(x = hp, y = am)) +
  geom_rangeframe() +
  ggtitle("Cars")  + 
  theme_tufte() + 
  ylab("Predicted probabilities for automatic") +
  xlab("Weight") + 
  geom_point() +
  geom_ribbon(data=plot_data, aes(y=fit, ymin=low, ymax=high), alpha=.2) +
  geom_line(data=plot_data, aes(y=fit))
p

#'Når du plotter effekten av logistisk regresjon er det lurt å gjøre en rask test av at alt er gått 
#'rett ved å sjekke at alle verdier på 
plot_data$low 
#' og
plot_data$high 
#' ligger mellom 0 og 1.

