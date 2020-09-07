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
  geom_smooth(method = "lm") +
  theme_minimal()


## OPPGAVE 4
beer2 <- beer %>% 
  select(year, mrall, beertax, vmiles, unrate, perinc)

beer.cor <- cor(beer2, use = "pairwise")

cor.test(beer2$beertax, beer2$mrall)


## OPPGAVE 5
beer1982 <- beer %>% 
  filter(year == 1982)

mean(beer1982$beertax, na.rm = TRUE)
# 0.53

mean(beer1982$mrall, na.rm = TRUE)
# 2.09

beer1988 <- beer %>% 
  filter(year == 1988)

mean(beer1988$beertax, na.rm = TRUE)
# 0.48

mean(beer1988$mrall, na.rm = TRUE)
# 2.07


## OPPGAVE 6
m1 <- lm(data = beer, 
         mrall ~ beertax + vmiles + unrate + perinc, na.action = "na.exclude")

stargazer::stargazer(m1, type = "text")


## OPPGAVE 7
beer <- beer %>% 
  mutate(state_fac = as.factor(state))

ggplot(beer, aes(x = state_fac, y = mrall)) +
  geom_boxplot()

ggplot(beer, aes(x = beertax, y = mrall)) +
  geom_point() +
  geom_smooth(method = "lm") +
  theme_minimal() +
  facet_wrap(~state_fac)

# Plottet viser at det er lite variasjon i beer tax innad i stater

## OPPGAVE 8
m2 <- lm(data = beer, 
         mrall ~ beertax + vmiles + unrate + perinc + state_fac, na.action = "na.exclude")

stargazer::stargazer(m2, type = "text",
                     omit = c("state_fac")) # Her printer jeg ikke state fixed effects i tabellen pga. lengden


## OPPGAVE 9
beer <- beer %>% 
  mutate(comserd_d = ifelse(comserd == "yes", 1, 0))

table(beer$comserd, beer$comserd_d, useNA = "always")


## OPPGAVE 10
m3 <- glm(data = beer, 
          comserd_d ~ unrate + perinc + mrall + mlda,
          family = binomial(link = "logit"),
          na.action = "na.exclude")

stargazer::stargazer(m3, type = "text")

# Koeffisienten er signifikant  på 1 prosentsnivå og positiv. En skalaenhets økning i dødsfall øker sannsynligheten for at staten har obligatorisk samfunnstraff om en fyllekjører.

