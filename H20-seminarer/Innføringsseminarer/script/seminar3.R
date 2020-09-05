library(tidyverse)

# Laster inn data
load("../data/aid.RData")

# Gjør de nødvendige omkodingene som dere gjorde i oppgaven
aid <- aid %>% 
  mutate(log_gdp_pr_capita = log(gdp_pr_capita),
         period_fac = as.factor(period),
         region = ifelse(fast_growing_east_asia == 1, "East Asia",
                         ifelse(sub_saharan_africa == 1, "Sub-Saharan Africa", "Other")),
         region = factor(region, levels = c("Other", "Sub-Saharan Africa", "East Asia")))

# Kjører modellen og bevarer informasjon om missing med na.action = "na.exclude"
m5 <- lm(data = aid, 
         gdp_growth ~ log_gdp_pr_capita + ethnic_frac*assasinations + 
           institutional_quality + m2_gdp_lagged + region + policy*aid +
           period_fac, 
         na.action = "na.exclude")

# Printer resultatene i en tabell
stargazer::stargazer(m5, type = "text")


### PLOTTER EFFEKTER ###
# En variabel
# Lager datasettet
snitt_data <- data.frame(log_gdp_pr_capita = mean(aid$log_gdp_pr_capita, na.rm = TRUE),
                         ethnic_frac = mean(aid$ethnic_frac, na.rm = TRUE),
                         assasinations = mean(aid$assasinations, na.rm = TRUE),
                         institutional_quality = c(seq(min(aid$institutional_quality, na.rm = TRUE),
                                                       max(aid$institutional_quality, na.rm =TRUE), by = 0.5)),
                         m2_gdp_lagged = mean(aid$m2_gdp_lagged, na.rm = TRUE),
                         region = "Other",
                         policy = mean(aid$policy, na.rm = TRUE),
                         aid = mean(aid$aid, na.rm = TRUE),
                         period_fac = "4")

# Bruker predict
predict(m5, newdata = snitt_data, se = TRUE)

# Legger predikerte verdier inn i snitt_data
snitt_data <- cbind(snitt_data, predict(m5, newdata = snitt_data, se = TRUE, interval = "confidence"))
snitt_data

ggplot(snitt_data, aes(x = institutional_quality, y = fit.fit)) + # Setter institusjonell kvalitet på x-aksen og predikert verdi på y-aksen
  geom_line() +                                                   # Sier at jeg vil ha et linjediagram
  scale_y_continuous(breaks = seq(-12, 12, 2)) +                  # Bestemmer verdier og mellomrom på y-aksen
  geom_ribbon(aes(ymin = fit.lwr, ymax = fit.upr, color = NULL), alpha = .2) + # Legger til konfidensintervall på plottet
  labs(x = "Kvalitet på institusjoner", y = "Forventet GDP vekst", color = "Policy", fill = "Policy") # Setter tittel på akser og plot


### PLOTTER SAMSPILL ###
# Lager plot data
snitt_data_sam <- data.frame(log_gdp_pr_capita = mean(aid$log_gdp_pr_capita, na.rm = TRUE),
                             ethnic_frac = mean(aid$ethnic_frac, na.rm = TRUE),
                             assasinations = mean(aid$assasinations, na.rm = TRUE),
                             institutional_quality = mean(aid$institutional_quality, na.rm = TRUE),
                             m2_gdp_lagged = mean(aid$m2_gdp_lagged, na.rm = TRUE),
                             region = "Other",
                             policy = c(rep(-1, 9), rep(0, 9), rep(1, 9)),
                             aid = rep(0:8, 3),
                             period_fac = "4")

# Predikerer verdier (løser likningen for modellen)
predict(m5, newdata = snitt_data_sam, se = TRUE)

# Lagrer predikerte verdier i plot datasettet
snitt_data_sam <- cbind(snitt_data_sam, predict(m5, newdata = snitt_data_sam, se = TRUE, interval = "confidence"))
snitt_data_sam

# Plotter
ggplot(snitt_data_sam, aes(x = aid, y = fit.fit, 
                           group = factor(policy), 
                           color = factor(policy), 
                           fill = factor(policy))) +
  geom_line() +
  scale_y_continuous(breaks = seq(-12, 12, 2)) +
  geom_ribbon(aes(ymin = fit.lwr, ymax = fit.upr, color = NULL), alpha = .2) +
  labs(x = "Bistandsnivå", y = "Forventet GDP vekst", color = "Policy", fill = "Policy")


### FORUTSETNINGER

## 1. Ingen utelatt variabelskjevhet


## 2. Lineær sammenheng 
# geom_smooth + geom_point

# car::ceresPlot


## 3. Uavhengighet/ingen autokorrelasjon
# kjør modell med na.omit
# car::durbinWatsonTest(model5)


## 4. Normalfordelte residualer
# ggplot med rstandard(m5) og y = ..density..
# stat_function(fun = dnorm)

# car::qqPlot()

# moments::kurtosis()
# moments::skewness()


## 5. Homoskedastiske residualer
# residualPlot()


## 6. Ingen perfekt multikolineraitet
# car::vif()


## 7. Uteliggere og innflytelsesrike observasjoner
# influenceIndexPlot(id = list(n=3))

# Bruker indeksering til å se nærmere på variabelen


## 8. Variabler med manglende informasjon "missing"
# table()

# Lag missing variabel med select og complete.cases()

# korrelasjonsmatriser
# kjører redusert modell og lager periodedummies
# Lager matrise med aid, select og cor(, pairwise)
# sammenligne med cor(, complete)

# kjører glm() med regmiss som uavhengig var


# Slå sammen datasett
# Last inn equality
equality <- read_csv("https://raw.githubusercontent.com/liserodland/stv4020aR/master/H20-seminarer/Innf%C3%B8ringsseminarer/data/Vdem_10_redusert.csv")

# Oppretter periode-variabel i V-dem datasettet, slik at jeg er klar til å merge. Verdiene til period-variabelen går fra 1-8, jeg vil gi de samme periodene (datasettet inneholder imidlertid bare data for periode 2-7). Her bruker jeg et en egenskap ved `as.numeric` på en faktor som ofte fører til feil i kode for å gjøre dette raskt:
table(aid$periodstart, aid$period)
table(aid$periodend, aid$period)
# Det kommer ikke tydelig frem her, men datasettet gikk opprinnelig fra 1966-1998
# Dersom jeg bruker 1966, 1970, 1974, 1978, 1982, 1986, 1990 og 1994 som kuttpunkt,
# bør jeg få de samme gruppene i V-dem-datasettet som i aid

periodcutpoints <-  unique(c(aid$periodstart)) # henter ut ovennevnt årtsall med unique()
# Her buker jeg funksjonen cut(), jeg kunne også brukt ifelse(), men cut() er raskere her.
equality$period <- cut(equality$year, periodcutpoints)
table(equality$year, equality$period)
# Tabell viser at jeg må justere periodcutpoints for å få rett

periodcutpoints <- periodcutpoints - 1
table(periodcutpoints)

periodcutpoints <- c(1965, periodcutpoints, 1997) # legger til to kuttpunkt for å få med periode 1 og 8

# Forsøker på nytt:
equality$period <- cut(equality$year, periodcutpoints)
table(equality$year,equality$period)
equality$period <- as.numeric(as_factor(equality$period))

table(equality$year,equality$period)
# Ser fint ut

# Aggregerer på land og periode
# gjør periode numerisk for å kunne merge 


# Bruker left_join


# sjekker missing