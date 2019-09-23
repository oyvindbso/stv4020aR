#################################
#### Flernivåanalyse - script ###
#################################

#### Forberedelser ####

### Pakker:
#install.packages("lme4")
#install.packages("stargazer")
library(tidyverse)
library(lme4) # for flernivå
library(stargazer) # for regresjonstabeller

#### Konstruksjon av data til dagens seminar ####
### Laster inn noe data fra European Social Survey - samme data som i faktoranalyse-scriptet
load("ess.rda")

### Jeg bruker dette som en anledning til å repetere aggregering

### Konstruksjon av aggregerte variabler (makronivå-variabler/nivå-2 variabler til flernivå) med dplyr (aggregering) 

ess2 <- ess%>%   ## Forteller at jeg skal jobbe med ess datasettet
  group_by(country) %>% ## Forteller at ess skal grupperes etter land
  summarise(lvl2_legalsys = mean(trust_legalsys, na.rm=T), ## Forteller at jeg vil ha nye variabler, lvl2_..
            lvl2_politicians = mean(trust_politicians, na.rm=T)) ## som skal opprettes ved å finne gjennomsnitt innenfor gruppene jeg har delt data i
ess2

### Legger den nye variabelen inn i datasettet med merge, legg merke at jeg laget et nytt datasett
ess <- left_join(ess, ess2, by="country")
summary(ess$lvl2_legalsys)

rm(ess2) # fjerner ess2, da det har spilt sin rolle

### Ferdigstiller datasett 
str(ess) # Sjekker at alt er som det skal være
ess <- ess %>%
  select(trust_police, age, gender, income_decile, lvl2_legalsys, lvl2_politicians, country) %>%
  drop_na()
save(ess, file="ess.RData") # Lagrer data som ess.Rdata i current working directory
table(is.na(ess))

### Time 1: Flernivå ####

## Flernivå med kun random intercept:
names(ess)
fm1 <- lmer(trust_police ~ (1|country), data=ess)
summary(fm1)
ranef(fm1)

### Flernivå med uavh. var på mikronivå, fixed effects, random intercept:
fm2 <- lmer(trust_police ~ (1|country) + income_decile, data=ess)
summary(fm2)
ranef(fm2)

### Flernivå med uavh. var på mikronivå, random slopes:
fm3 <- lmer(trust_police ~ income_decile + (income_decile|country), data=ess)
summary(fm3)
ranef(fm3)

### Flernivå med uavh. var på mikronivå med random effects, og uavhengig variabel på makronivå
fm4 <- lmer(trust_police ~ income_decile + (income_decile|country) + lvl2_legalsys, data=ess)
summary(fm4)
ranef(fm4)

### Flernivå med uavh. var på mikronivå med random effects, kryssnivåsamspill, og uavhengig variabel på makronivå:
fm5 <- lmer(trust_police ~ income_decile*lvl2_legalsys + (income_decile|country), data=ess)
summary(fm5)
ranef(fm5)

## Compare models:
stargazer(fm1, fm2, fm3, fm4, fm5, type="text") # Gives AIC/BIC
anova(fm3, fm2) # Log likelood/deviance based test
anova(fm4, fm3)
anova(fm5, fm4)


## intra-class correlation:
summary(fm1)
0.6473/(0.6473 + 4.8832)