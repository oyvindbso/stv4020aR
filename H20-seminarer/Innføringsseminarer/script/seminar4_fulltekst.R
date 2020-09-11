#####################
##### SEMINAR 4 #####
#####################

## HVA MÅ DU KUNNE TIL PRØVEN? ##
# 1. Laste inn data (i det minste Rdata og/eller .csv)
# 2. Lagre script (du skal levere et script)
# 3. Lage nye datasett med underutvalg av observasjoner eller variabler
# 4. Gjøre regneoperasjoner
# 5. Hent ut deskriptiv statistiskk om variabler ved hjelp av funksjoner 
###  og tabeller (noen eksempler (ikke uttømmende): mean(), is.na() o.l.)
# 6. Omkode variabler ved hjelp av regneoperasjoner, logiske tester og ifelse
# 7. Hvordan plotte deskriptiv informasjon (spredningsplot, box-plot o.l.)
# 8. Lage korrelasjonsmatriser
# 9. Estimere en OLS-modell og identifisere koeffisienter og signifikansnivå
# 10. Estimere en binomisk logistisk modell og identifisere koeffisienter og
####  signifikansnivå
# 11. Presentere resultatet av en regresjonsanalyse i en tabell i R (trenger
####  ikke å kunne lagre i word e.l.)
 
# Klarer dere dagens oppgaver så er dere godt rusta :) 

# Noen tips på veien: 
# - Husk å laste inn de nødvendige pakkene ved hjelp av library(). Gjør
### det først i scriptet så er du ferdig med det. 
# - Om en kodesnutt ikke vil kjøre så prøv 1) laste inn nødvendige pakker
### igjen. 2) Kjør all koden før kodesnutten på ny. 3) Google! 
# - Om du ikke vet hvilken funksjon du skal bruke for å løse en oppgave så
### slå opp i materiale eller søk på nett.
# - Dere har god tid, men begynn tidlig og lever tidlig. 

library(tidyverse)

aid <- read_csv("https://raw.githubusercontent.com/liserodland/stv4020aR/master/H20-seminarer/Innf%C3%B8ringsseminarer/data/aid.csv")

# Lager en dikotom variabel som kan være avhengig variabel
# Lager ny dikotom variabel
aid <- aid %>% 
  mutate(gdp_growth_d = ifelse(gdp_growth <= 0, 0, 1))

# Sjekker missing ved hjelp av en tabell
table(is.na(aid$gdp_growth_d), 
      is.na(aid$gdp_growth))

# Kjører en binomisk logistisk modell ved hjelp av glm
# Det er ganske likt på lm, men i glm må vi også spesifisere family
m1 <- glm(gdp_growth_d ~ aid + policy + as.factor(period), data = aid, 
          family = binomial(link = "logit"),
          na.action = "na.exclude")
summary(m1)

# Laster inn stargazer for å kunne lage pene tabeller
library(stargazer)

# Viser resultatene i en tabell
stargazer(m1, type = "text")

# Regne ut predikerte sannsynligheter for hånd
# Her henter jeg ut koeffisientene fra modellobjektet ved hjelp av indeksering
# og setter inn verdien på uavhengig variabel inn i likningen. Alt som begynner
# med m1$coefficients er koeffisienter fra modellobjektet: 
exp(m1$coefficients["(Intercept)"] + 
      m1$coefficients["as.factor(period)4"]*1 + 
      m1$coefficients["aid"]*(-3) + 
      m1$coefficients["policy"]*median(aid$policy, na.rm = TRUE))/
  (1 + exp(m1$coefficients["(Intercept)"] + 
             m1$coefficients["as.factor(period)4"]*1 + 
             m1$coefficients["aid"]*(-3) + 
             m1$coefficients["policy"]*median(aid$policy, na.rm = TRUE)))

### PLOTTE EFFEKTER ###
# Plotte logits
# Trinn 1: kjøre modellen
# Trinn 2: Vi lager et datasett med plotdata der vi lar aid variere
plotdata <- data.frame(aid = seq(min(aid$aid, na.rm = TRUE), 
                                 max(aid$aid, na.rm = TRUE), 1),
                       policy = mean(aid$policy, na.rm = TRUE),
                       period = "4")

# Trinn 3: Bruker først predict til å predikere logits
preds <- predict(m1, 
                 se.fit = TRUE,
                 newdata = plotdata,
                 type = "link") # Dette gir oss logits


# Trinn 4: Lagrer predikert verdi og standardfeil i plotdata
plotdata$fit <- preds$fit
plotdata$se <- preds$se.fit

# Eksempel på plot uten konfidensintervall:
ggplot(plotdata) + 
  geom_line(aes(x = aid, y = fit))

# Trinn 5: Regner ut 95 % konfidensintervaller
plotdata <- plotdata %>% 
  mutate(ki.lav = fit - 1.96*se,
         ki.hoy = fit + 1.96*se)

# Trinn 6: Legger konfidensintervaller til i plottet
ggplot(plotdata) + 
  geom_line(aes(x = aid, y = fit)) + 
  geom_line(aes(x = aid, y = ki.lav), linetype = "dotted") + 
  geom_line(aes(x = aid, y = ki.hoy), linetype = "dotted") +
  theme_minimal()


## Plotter sannsynligheter: 
# Snarvei for å plotte sannsynlighet:
# Brukt i Lær deg R, men kan gi konfidensintervaller som går utenfor referanseområdet
# Her gjenbruker vi trinn 1 og 2 fra tidligere og går rett på trinn 3
# Trinn 3: Bruker predict med type = response for å få sannsynligheter
preds <- predict(m1, 
                 se.fit = TRUE,
                 newdata = plotdata,
                 type = "response") # Velger respons for å få sannsynlighet

# Trinn 4: Lagrer informasjon om predikerte verdier og standardfeil fra predict i plotdata
plotdata$fit.prob <- preds$fit
plotdata$se.prob <- preds$se.fit

# Trinn 5: Lager 95 % konfidensintervaller
plotdata <- plotdata %>% 
  mutate(ki.lav.prob = fit.prob - (1.96*se.prob),
         ki.hoy.prob = fit.prob + (1.96*se.prob))


# Trinn 6: Plotter med konfidensintervaller
ggplot(plotdata) + 
  geom_line(aes(x = aid, y = fit.prob)) + 
  geom_line(aes(x = aid, y = ki.lav.prob), linetype = "dotted") + 
  geom_line(aes(x = aid, y = ki.hoy.prob), linetype = "dotted") +
  theme_minimal() +
  scale_y_continuous(limits = c(0:1))

# Hva er det som skurrer med med grense på KI her?:
summary(plotdata$ki.lav.prob)
summary(plotdata$ki.hoy.prob)

## Alternativ metode for utregning av predikerte sannsynligheter:
# Her gjenbruker vi trinn 1 - 4 fra når vi predikerte logits og går rett på trinn 5
# Trinn 5: regner om sannsynligheter fra logits-prediksjonene og lagrer i plotdata
plotdata$ki.lav.prob2  <- exp(plotdata$fit - 1.96*plotdata$se)/(1 + exp(plotdata$fit - 1.96*plotdata$se))
plotdata$ki.hoy.prob2 <- exp(plotdata$fit + 1.96*plotdata$se)/(1 + exp(plotdata$fit + 1.96*plotdata$se))
plotdata$fit.prob2 <- exp(plotdata$fit)/(1+ exp(plotdata$fit))

# Trinn 6: plotter
ggplot(plotdata) + 
  geom_line(aes(x = aid, y = fit.prob2)) + 
  geom_line(aes(x = aid, y = ki.lav.prob2), linetype = "dotted") + 
  geom_line(aes(x = aid, y = ki.hoy.prob2), linetype = "dotted") +
  theme_minimal() +
  scale_y_continuous(limits = c(0:1))

# Vi bruker summary til å sjekke konfidensintervallene
summary(plotdata$ki.lav.prob2)
summary(plotdata$ki.hoy.prob2)

# NB! Legg merke til at den predikerte verdien fortsatt er den samme. Her bruker
# jeg table() og en logisk test til å teste dette og alle er like. 
table(plotdata$fit.prob == plotdata$fit.prob2)


### FORVENTET VERDI VS FAKTISK VERDI
# Henter ut residualer og lagrer dem i datasettet
aid$resid <- residuals(m1)
# Henter ut predikerte sannsynligheter og lagrer dem i datasettet
aid$predict <- predict(m1, type = "response")

# Bestter hvor grensen for positivt utfall skal gå
kuttpunkt <- mean(aid$gdp_growth_d, na.rm = TRUE)
kuttpunkt
# I nullmodellen predikerer vi 62 prosent riktig om vi gjetter at alle land har vekst

# Lager en variabel der de med predikert sannsynlighet høyere enn kuttpunktet får verdien 1
aid$growth.pred <- as.numeric(aid$predict>kuttpunkt)

# Bruker en logisk test til å sjekke om predikert verdi er lik faktisk verdi
aid$riktig <- aid$growth.pred == aid$gdp_growth_d
mean(aid$riktig, na.rm = TRUE)

krysstabell <- table(aid$growth.pred, aid$gdp_growth_d)
krysstabell
prop.table(krysstabell, margin = 2)
