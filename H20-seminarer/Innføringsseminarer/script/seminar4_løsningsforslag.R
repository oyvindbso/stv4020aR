######################################
##### SEMINAR 4: LØSNINGSFORSLAG #####
######################################

## OPPGAVE 1
library(tidyverse)
beer <- read_csv("https://raw.githubusercontent.com/liserodland/stv4020aR/master/H20-seminarer/Innf%C3%B8ringsseminarer/data/beer.csv") 


## OPPGAVE 2
beer


## OPPGAVE 3
library(ggplot2)

ggplot(beer, aes(x = beertax, y = mrall)) +
  geom_point() +
  theme_minimal()


## OPPGAVE 4
beer2 <- beer %>% 
  select(year, mrall, beertax, vmiles, unrate, perinc)

beer.cor <- cor(beer2, use = "pairwise")

cor.test(beer2$beertax, beer2$mrall)


## OPPGAVE 5
# Lager datasett ved hjelp av tidyverse
beer1982 <- beer %>% 
  filter(year == 1982) # Beholder bare de observasjonene med år lik 1982

mean(beer1982$beertax, na.rm = TRUE)
# 0.53

mean(beer1982$mrall, na.rm = TRUE)
# 2.09

beer1988 <- beer %>% 
  filter(year == 1988) # beholder bare de observasjonene med år lik 1988

mean(beer1988$beertax, na.rm = TRUE)
# 0.48

mean(beer1988$mrall, na.rm = TRUE)
# 2.07


## OPPGAVE 6
# Kjører en OLS-modell ved hjelp av lm(). avhengig variabel kommer før ~ og 
# uavhengige variabler kommer etter. 
m1 <- lm(data = beer, 
         mrall ~ beertax + vmiles + unrate + perinc, na.action = "na.exclude")

stargazer::stargazer(m1, type = "text")


## OPPGAVE 7
beer <- beer %>% 
  mutate(state_fac = as.factor(state)) # Omkoder state til en faktor

# Lager boxplot
ggplot(beer) +
  geom_boxplot(aes(x = state_fac, y = mrall))

# Lager spredningsdiagram
ggplot(beer) +
  geom_point(aes(x = beertax, y = mrall)) +
  facet_wrap(~state_fac)

# Plottet viser at det er lite variasjon i beer tax innad i stater
# (prikkene er spredd lite utover x-aksen)

## OPPGAVE 8
# Kjører en OLS modell
m2 <- lm(data = beer, 
         mrall ~ beertax + vmiles + unrate + perinc + state_fac, na.action = "na.exclude")

stargazer::stargazer(m2, type = "text",
                     omit = c("state_fac")) # Her printer jeg ikke state fixed effects i tabellen pga. lengden


## OPPGAVE 9
# Lager ny variabel som tar verdien 1 dersom comserd har verdien "yes" og 0 ellers. 
beer <- beer %>% 
  mutate(comserd_d = ifelse(comserd == "yes", 1, 0))

# Sjekker at omkodingen ble riktig
table(beer$comserd, beer$comserd_d, useNA = "always")


## OPPGAVE 10
# Kjører en binomisk logistisk regresjon
# velger family = binomial(link = "logit) for å spesifisere at det er det jeg skal i glm
m3 <- glm(data = beer, 
          comserd_d ~ unrate + perinc + mrall + mlda,
          family = binomial(link = "logit"),
          na.action = "na.exclude")

# Lager tabell
stargazer::stargazer(m3, type = "text")

# Koeffisienten er signifikant  på 1 prosentsnivå og positiv. En skalaenhets økning i dødsfall øker sannsynligheten for at staten har obligatorisk samfunnstraff om en fyllekjører.
# Husk at det her er snakk om korrelasjon, men ikke nødvendigvis kausalitet (ikke til prøven nødvendigvis, men sånn generelt)


## OPPGAVE 11
# Finner gjennomsnittet: 
mean(beer$beertax, na.rm = TRUE)
# 0.52 er gjennomsnittet

median(beer$beertax, na.rm = TRUE)
# Median er 0.35
