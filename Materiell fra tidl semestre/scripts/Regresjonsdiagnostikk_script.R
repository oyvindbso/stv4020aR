########################################################
########## Seminar 3: regresjonsdiagnostikk ############
########################################################

#### Forberedelser ####

## pakker til seminaret
#install.packages("nnet")
#install.packages("car")
#install.packages("stargazer")
#install.packages("plm")
#install.packages("lmtest")
#install.packages("tidyverse")

library(nnet)
library(car)
library(stargazer)
library(plm)
library(tidyverse)
library(lmtest)

## Data som brukes ligger i github-mappen for data.
aid <- read_csv("https://raw.githubusercontent.com/langoergen/stv4020aR/master/data/aid.csv")

str(aid)





aid <- aid %>% # Forteller at vi skal jobbe med aid-datasettet
  mutate(region = ifelse(elrssa == 1, "Sub-Saharan Africa",
                         ifelse(elrcentam == 1, "Central America",
                                ifelse(elreasia == 1, "East Asia", "Other"))))

table(aid$country)

table(complete.cases(aid)) 
# sjekker hvor mange observasjoner som har missing på en eller flere variabler i mine_data, TRUE betyr at det ikke er missing 
aid$policy <- aid$elrinfl + aid$elrsacw + aid$elrbb
table(is.na(aid$policy)) 



## Lager datasett uten missing på variabler som skal inngå i regresjon
reg_data <- aid %>% 
  drop_na(elrgdpg, elraid, policy, country, period,  elrethnf,   
            elrassas, elricrge, elrm21)
# Lager nytt datasett med observasjoner som faktisk brukes i regresjon. 
# drop_na() fjerner alle observasjoner som har missing på en av variablene du skriver inn.




table(complete.cases(aid)) 
# sjekker hvor mange observasjoner som har missing på en eller flere variabler i mine_data, TRUE betyr at det ikke er missing 


# sjekker hvor mange observasjoner som har missing på en variabel

aid$reg_miss <- aid %>%
  select(elrgdpg, elraid, policy) %>%
  complete.cases()
# Lager variabel som viser hvilke observasjoner som forsvinner i regresjon med de sentrale variablene
# elrgdpg, elraid og policy - fin å bruke i plot for å få et inntrykk av hva slags informasjon du mister ved å legge til flere kontrollvariabler.
table(aid$reg_miss) # Mange observasjoner har missing på en eller flere av de tre variablene







## Burnside and Dollar reported regression:
m5 <- lm(elrgdpg ~     # økonomisk vekst, prosent av BNP
           elrgdp +    # BNP
           elrethnf*   # Ethnic fractionalization index
           elrassas +  # Political assasinations
           elricrge +  # Institutional quality (political institutions)
           elrm21 +    # Verdien av våpenimport, relativt til verdien av all annen import
           region +    # region
           policy*     # Makroøkonomisk politikk
           elraid,     # Bistand, prosent av BNP
           data = aid)
summary(m5)



## The actual regression they run, include period and log of elrgdp
aid$elrgdp_log <- log(aid$elrgdp)

m6 <- lm(elrgdpg ~ elrgdp_log + elrethnf*elrassas + 
           elricrge + elrm21 +
            region + policy*elraid + 
           as.factor(period),
         data = aid)
summary(m6)

## Model without interaction for running ceresplot:
m6b <- lm(elrgdpg ~ elrgdp_log + elrethnf + elrassas + 
            elricrge + elrm21 +
             region + policy + elraid + 
            as.factor(period),
          data = aid)

## Linearity:
ceresPlots(m6b, term = "policy") ## Ikke lineært
ceresPlots(m6b, term = "aid") ## lineært

## Independent errors:
?plm
m6_plm <- plm(elrgdpg ~ elrgdp_log + elrethnf*elrassas + 
                  elricrge + elrm21 +
                   region + policy*aid,
                  index = "period",
                 model = "within",
                data = aid) # bytter ut lm med plm for å kunne kjøre pdwtest()
# Merk at modellene er helt like.

plm::pdwtest(m6_plm) # Ikke autokorrelasjon når vi har faste effekter på periode.
durbinWatsonTest(m6) ## Fungerer ikke på paneldata, bare tidsserier


m6_plm_b <- plm(elrgdpg ~ elrgdp_log + elrethnf*elrassas + 
                elricrge + elrm21 +
                 region + policy*elraid,
              index = c("country", "period"),
              model = "pooling",
              data = aid)
pdwtest(m6_plm_b) # Nesten signifikant forskjellig fra 2 når vi ikke bruker faste effekter.

## Normally distributed errors:
qqPlot(m6) ## Stort sett ganske bra, litt dårlig i utkantene (fat-tails).


## Homoskedasticity:
spreadLevelPlot(m6) ## Heteroskedastisitet
ncvTest(m6) ## Formell test.

### Multikolinearitet:
vif(m6) ## Ikke store problemer
names(aid)

aid %>% 
  select(elrgdpg, 
           elraid, 
           policy, 
           elrgdp_log,   
           elrethnf, 
           elrassas,
           elricrge,  
           elrm21) %>%
  cor(, use = "pairwise.complete.obs") ## Kan også brukes til å se på korrelasjon

### Inflytelsesrike observasjoner og uteliggere:
influenceIndexPlot(m6, id.n=5)

## Henter ut interessante observasjoner:

## Hack fordi rownames ikke går fra 1 til 286
aid$obs_nr <- as.numeric(rownames(aid)) 


slice(.data = aid, 403)
slice(.data = aid, 476)



aid2 <- slice(aid, -403) # Ved å sette - foran 403, forteller vi slice at vi vil kaste ut observasjonen

summary(m6c <- lm(elrgdpg ~ elrgdp_log + elrethnf*elrassas + 
                    elricrge + elrm21 +
                     region + policy*elraid + 
                    as.factor(period),
                  data = aid2))

aid3 <- slice(aid, -476)
summary(m6d <- lm(elrgdpg ~ elrgdp_log + elrethnf*elrassas + 
                    elricrge + elrm21 +
                     region + policy*elraid + 
                    as.factor(period),
                  data = aid3))

aid4 <- slice(aid2, -476)
summary(m6e <- lm(elrgdpg ~ elrgdp_log + elrethnf*elrassas + 
                    elricrge + elrm21 +
                     region + policy*elraid + 
                    as.factor(period),
                  data = aid4))
stargazer(m6, m6c, m6d, m6e, type="text")


## Lager variabel til multinomisk:
summary(aid$elrgdpg)
aid$gdp_g_categories <- ifelse(aid$elrgdpg<0, 1, NA)
aid$gdp_g_categories <- ifelse(aid$elrgdpg>=0 & aid$elrgdpg< 1, 2, aid$gdp_g_categories)
aid$gdp_g_categories <- ifelse(aid$elrgdpg>=1 & aid$elrgdpg<3, 3, aid$gdp_g_categories)
aid$gdp_g_categories <- ifelse(aid$elrgdpg>=3, 4, aid$gdp_g_categories)

table(aid$gdp_g_categories) #test


## Kjører regresjon
m7 <- multinom(gdp_g_categories ~ elrgdp_log + 
           elricrge + elrm21 +
            region + policy + elraid, data= aid,
         Hess = T, na.action="na.exclude")
stargazer(m7, type="text")
summary(m7)
