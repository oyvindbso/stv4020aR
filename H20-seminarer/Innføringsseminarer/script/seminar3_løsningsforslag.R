#####################################
##### SEMINAR 3 LØSNINGSFORSLAG #####
#####################################

library(tidyverse)
aid <- read_csv("https://raw.githubusercontent.com/liserodland/stv4020aR/master/H20-seminarer/Innf%C3%B8ringsseminarer/data/aid.csv")

## OPPGAVE 1: Variabler: `aid`, `policy`, `period`. 
# Spredningsplot:

# Med col og shape
ggplot(aid) +
  geom_point(aes(x = aid, 
                 y = gdp_growth, 
                 shape = as.factor(period),  # Bruker as.factor her fordi periode er registrert som numeris
                 col = policy)) +
  theme_minimal()

#OBS! Du kan bare lese av aid og gdp_growth på aksene. Periode og policy
# må du lese av på fargeskala og formoversikt til høyre


# Med col og facet_wrap
ggplot(aid) +
  geom_point(aes(x = aid, y = gdp_growth, col = policy)) +
  facet_wrap(~as.factor(period))
  theme_minimal()

## OPPGAVE 2: aid, economic open, budget_balance, inflation
# Med korrelasjonsmatrise
# For å kunne lage en korrelasjonsmatrise med flere variabler så krever
# R at du oppretter et objekt som inneholder de variablene du ønsker
# Dette skyldes at en ikke kan beregne korrelasjon på ikke-numeriske variabler
# se ?cor for mer informasjon

## MED TIDYVERSE  
# Med pairwise observations
corr.matrise.pair <- aid %>%  # Sier at jeg vil ta utgangspunkt i aid når jeg lager det nye objektet 
  select(gdp_growth, aid, economic_open, budget_balance, inflation) %>%  # Velger ut de variablene jeg vil ha med
  cor(, use = "pairwise") # Kjører funksjonen cor. Lar være å spesifisere noen variabler fordi jeg ønsker å ta med alle
# Printer matrisen i konsoll
corr.matrise.pair  

# Med complete observations (dvs. observasjonen må en verdi på alle variablene i matrisen for å bli tatt med)
corr.matrise.comp <- aid %>% # Sier at jeg vil ta utgangspunkt i aid når jeg lager det nye objektet 
  select(gdp_growth, aid, economic_open, budget_balance, inflation) %>% # Velger ut de variablene jeg vil ha med
  cor(, use = "complete") # Kjører funksjonen cor. Lar være å spesifisere noen variabler fordi jeg ønsker å ta med alle
corr.matrise.comp  

# Med base R: 
# Lager et datasett med de variablene du ønsker 

korr.data <- aid[, c("gdp_growth", "aid", "economic_open", 
                     "budget_balance", "inflation")]

# Kjører funksjonen cor med complete observations på det nye datasettet
cor(korr.data,
    use = "complete")


# REGRESJON  
# Vanlig regresjon
m1 <- lm(data = aid, 
         gdp_growth ~ aid + policy + as.factor(period), na.action = "na.exclude")

# Med andregradsledd (husk å ta med aid og aid^2 her)
m2 <- lm(data = aid, 
         gdp_growth ~ aid + I(aid^2) + policy + as.factor(period), na.action = "na.exclude")

# Med en omkodet policy variabel som har verdien 1 om verdie på policy
# er større enn gjennomsnittsverdien og 0 hvis ikke.
# Lager først en ny variabel
aid <- aid %>% 
  mutate(policy_mean = ifelse(policy > mean(policy, na.rm = TRUE), 1, 0))

# Kjører modellen
m3 <- lm(data = aid, 
         gdp_growth ~ aid + policy_mean + as.factor(period),
         na.action = "na.exclude")

# Presenterer resultatet i en tabell
stargazer::stargazer(m1, m2, m3, type = "text")

## EKSEMPLER PÅ KONTROLL AV FORUTSETNINGER 
# Se oppsummeringsarket fra seminar 3 for mer
# Sjekker linearitet på gdp_growth og policy: 
ggplot(aid) + 
  geom_point(aes(y = gdp_growth, x = policy)) +
  geom_smooth(aes(y = gdp_growth, x = policy), 
              se = FALSE) +
  theme_bw()

# Sjekker linearitet på gdp_growth og aid
ggplot(aid) + 
  geom_point(aes(y = gdp_growth, x = aid)) +
  geom_smooth(aes(y = gdp_growth, x = aid), se = FALSE) +
  theme_bw()

# Sjekker fordelingen til restleddene til modell 1
ggplot() +
  geom_histogram(aes(x = rstandard(m1),
                     y = ..density..)) + # Plotter fordelingen til standardavvikene
  stat_function(fun = dnorm, 
                color = "goldenrod2") 

# Sjekker fordelingen til restleddene til modell 2
ggplot() +
  geom_histogram(aes(x = rstandard(m2),
                     y = ..density..)) + # Plotter fordelingen til standardavvikene
  stat_function(fun = dnorm, 
                color = "goldenrod2") 


## PLOTTER RESULTATER FRA REGRESJONEN
# 2. Lager plotdata
plotdata <- data.frame(aid = seq(min(aid$aid, na.rm = TRUE),
                                 max(aid$aid, na.rm = TRUE), 1),
                       policy = mean(aid$policy, na.rm = TRUE),
                       period = "3")

# 3. predikerer verdier
pred <- predict(m1, plotdata, se = TRUE)

# 4. Legger predikerte verdier og standardfeil inn i plotdata
plotdata$pred  <- pred$fit
plotdata$se <- pred$se.fit

# 5. Regner ut KI
plotdata$ki.hoy <- plotdata$pred + 1.96*plotdata$se
plotdata$ki.lav <- plotdata$pred - 1.96*plotdata$se

# 6. Plotter
ggplot(plotdata, aes(x = aid, y = pred)) +
  geom_line() +
  geom_ribbon(aes(ymin = ki.lav, ymax = ki.hoy), alpha = 0.2)

## Med andregradsledd
# 3. Predikerer verdier
pred2 <- predict(m2, plotdata, se = TRUE)

# 4. Legger predikerte verdier og standardfeil inn i plotdata
plotdata$pred2  <- pred2$fit
plotdata$se2 <- pred2$se.fit

# 5. Regner ut KI
plotdata$ki.hoy2 <- plotdata$pred2 + 1.96*plotdata$se2
plotdata$ki.lav2 <- plotdata$pred2 - 1.96*plotdata$se2

# 6. Plotter
ggplot(plotdata, aes(x = aid, y = pred2)) +
  geom_line() +
  geom_ribbon(aes(ymin = ki.lav2, ymax = ki.hoy2), alpha = 0.2)

# Se seminarintroduksjonsdokumentet for flere tester o.l. 
