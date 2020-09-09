#####################################
##### SEMINAR 3 LØSNINGSFORSLAG #####
#####################################

library(tidyverse)
aid <- read_csv("https://raw.githubusercontent.com/liserodland/stv4020aR/master/H20-seminarer/Innf%C3%B8ringsseminarer/data/aid.csv")

## OPPGAVE 1: Variabler: `aid`, `policy`, `period`. 
# Spredningsplot:

ggplot(aid) +
  geom_point(aes(x = aid, y = policy, col = as.factor(period))) +
  theme_minimal()

# Vanlig regresjon
m1 <- lm(data = aid, 
         gdp_growth ~ aid + policy + as.factor(period), na.action = "na.exclude")

# Med andregradsledd (husk å ta med aid og aid^2 her)
m2 <- lm(data = aid, 
         gdp_growth ~ aid + I(aid^2) + policy + as.factor(period), na.action = "na.exclude")

# Presenterer resultatet i en tabell
stargazer::stargazer(m1, m2, type = "text")

# Sjekker linearitet: 
ggplot(aid) + 
  geom_point(aes(y = gdp_growth, x = policy)) +
  geom_smooth(aes(y = gdp_growth, x = policy), 
              se = FALSE) +
  theme_bw()


ggplot(aid) + 
  geom_point(aes(y = gdp_growth, x = aid)) +
  geom_smooth(aes(y = gdp_growth, x = I(aid)), 
              se = FALSE) +
  theme_bw()

# Sjekker fordelingen til restleddene
ggplot() +
  geom_histogram(aes(x = rstandard(m1),
                     y = ..density..)) + # Plotter fordelingen til standardavvikene
  stat_function(fun = dnorm, 
                color = "goldenrod2") 


ggplot() +
  geom_histogram(aes(x = rstandard(m2),
                     y = ..density..)) + # Plotter fordelingen til standardavvikene
  stat_function(fun = dnorm, 
                color = "goldenrod2") 


# Plotter resultater
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