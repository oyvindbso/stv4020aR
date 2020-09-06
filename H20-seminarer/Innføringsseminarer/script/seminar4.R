
# Laster inn aid data
library(tidyverse)
aid <- read_csv("https://raw.githubusercontent.com/liserodland/stv4020aR/master/H20-seminarer/Innf%C3%B8ringsseminarer/data/aid.csv")


# Lager en dikotom vekstvariabel (1 = vekst)


# Sjekker missing ved hjelp av en tabell


# Kjører en binomisk logistisk regresjon
# f.eks. gdp_growth_d ~ aid + policy + period

# summary

# stargazer

# Hva kan vi lese ut av denne? 


# Regn ut sannsynlighet for hånd ved hjelp av indeksering: 
# `exp(b0 + b1X1 + b2X2 + ... + bnXn)/(1 + exp(b0 + b1X1 + b2X2 + ... + bnXn))` 


## Plotte effekter

# LOGITS
# Trinn 2: Lag plotdata


# Trinn 3: prediker logits
# Type = c("link")


# Trinn 4: Lagerer predikert verdi og standardfeil i plotdata


# Trinn 5: Regner ut ki
# fit + 1.96*se


# Trinn 6: Plotter
# x = aid, y = fit
# 3*geom_line

# Noe sketchy?
# Kjør summary() på KI 


# SANNSYNLIGHETER
# Trinn 3: predikerer sannsynligheter
# Type = c("response")


# Trinn 4: lagrer predikert verdi og standardfeil i plotdata


# Trinn 5: Regner ut KI 


# Trinn 6: Plotter


# ALT. METODE FOR SANNSYNLIGHETER
# Trinn 5: regner om sannsynligheter fra logits-prediksjonene og lagrer i plotdata
plotdata$ki.lav.prob2  <- exp(plotdata$fit - 1.96*plotdata$se)/(1 + exp(plotdata$fit - 1.96*plotdata$se))
plotdata$ki.hoy.prob2 <- exp(plotdata$fit + 1.96*plotdata$se)/(1 + exp(plotdata$fit + 1.96*plotdata$se))
plotdata$fit.prob2 <- exp(plotdata$fit)/(1+ exp(plotdata$fit))


# Trinn 6: plotter 



## Sammenligne faktiske og predikerte verdier: 
# Lagrer residualer (resid()) og predikerte verdier (type = "response) i aid

# Lagre kuttpunkt lik gjennomsnitt til avhengig variabel

# Lager variabel growht.pred > kuttpunkt, 1, 0

# Bergen aid$riktig med logisk test (faktisk == pred) og tar gjenomsnitt

# Bruker indeksering for å sjekke om modellen er bedre til å predikere 1 eller 0
# mean(aid[aid$riktig == 1,]$riktig)


## PLotter ROC
#install.packages("plotROC")
library(plotROC)

# Basic ROC:
basicplot <- ggplot(aid, aes(d = gdp_growth_d, m = predict)) + geom_roc(labelround = 2) 

# Pyntet ROC med AUC.
basicplot + 
  style_roc(ylab = "Sensivity (True positive fraction)") +
  theme(axis.text = element_text(colour = "blue")) +
  annotate("text", x = .75, y = .25, 
           label = paste("AUC =", round(calc_auc(basicplot)$AUC, 2))) +
  scale_x_continuous("1 - Specificity", breaks = seq(0, 1, by = .1))


# Kontroll av forutsetninger

# Likelihood ratio test med anova()
# Lager et datasett med variablene vi trenger og uten NA
aid.complete <- aid %>% 
  select(gdp_growth_d, aid, policy, period) %>%  # Velger variablene vi skal bruker
  na.omit()                                      # Beholder bare observasjoner uten NA

gm0 <- glm(gdp_growth_d ~ aid, data = aid.complete, 
           family = binomial(link = "logit"))
gm1 <- glm(gdp_growth_d ~ aid + policy + as.factor(period), data = aid.complete, 
           family = binomial(link = "logit"))
anova(gm0, gm1, test = "LRT") 


## HL TEST
#install.packages("ResourceSelection")
library(ResourceSelection)

# Sjekker nullmodellen
hoslem.test(gm0$y, gm0$fitted.values)

# Sjekker den alternative modellen vår
hoslem.test(gm1$y, gm1$fitted.values)



## PSEUDO R2
# install.packages("pscl")
library(pscl)
pR2(gm0)
pR2(gm1)
