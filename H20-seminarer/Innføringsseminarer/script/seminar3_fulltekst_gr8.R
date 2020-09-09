#####################
##### SEMINAR 3 #####
#####################

# Hva bør dere vite hvor dere finner informasjon om nå?
# 1. Laste inn data (funksjon er avhengig av datatypen - se suffiks på fil (.dta, .csv, . Rdata, .sav))
# data <- read_csv("filbane/filnavn.csv" eller "lenke til data på github") (fra tidyversen-pakken)
# data <- read_dta("filbane/filnavn.dta") (fra haven-pakken)
# data <- read_sav("filbane/filnavn.dta") (fra haven-pakken)
# load("filbane/filnavn.Rdata")
# Lagre script og sette working directory
# Er du usikker her så anbefaler jeg å lese kapittel 4 i Lær deg R

# 2. Lage nye datasett med underutvalg av observasjoner eller variabler 
# Her er det nyttig med indeksering eller filter() og select() fra tidyverse

# 3. Gjøre regneoperasjoner og hente ut deskriptiv informasjon
# Se oppsummering seminar 1 for oversikt over funksjoner og regneoperasjoner
# F.eks. mean(), se() o.l. 
# HUSK na.rm = TRUE dersom variabelen har missing-verdier

# 4. Omkode variabler ved hjelp av regneoperasjoner og ifelse
# Se seminar 1 og 2
# HUSK:
# datasett$nyvariabel <- funksjon/regneoperasjon e.l. 
# eller
# datasett <- datasett %>% 
# mutate(nyvariabel1 = funksjon/regneoperasjon e.l., 
#        nyvariabel2 = funksjon/regneoperasjon e.l.)

# 5. Hvordan plotte deskriptiv informasjon 
# Se seminar 2 og ggplot 

# 6. Hvordan kjøre en OLS-modell 
# Se seminar 2 og 3

# Oppgavene i dag: litt friere og ikke like tydelig fasit. Bruk gjerne muligheten
# til å prøve deg på omkodinger, plotting osv. 

# Laster inn pakker jeg skal bruke
# Husk å kjør install.packages("pakkenavn") først om ikke du har gjort det allerede 
library(tidyverse)
library(stargazer)
# install.packages("car")
library(car)
# install.packages("moments")
library(moments)

# Laster inn data
load("H20-seminarer/Innføringsseminarer/data/aid.RData")

# Gjør de nødvendige omkodingene som dere gjorde i oppgaven
aid <- aid %>% 
  mutate(log_gdp_pr_capita = log(gdp_pr_capita),
         period_fac = as.factor(period),
         region = ifelse(fast_growing_east_asia == 1, "East Asia",
                         ifelse(sub_saharan_africa == 1, "Sub-Saharan Africa", 
                                "Other")),
         region = factor(region, 
                         levels = c("Other", "Sub-Saharan Africa", "East Asia")))

# Kjører modellen og bevarer informasjon om missing med na.action = "na.exclude"
m5 <- lm(data = aid, 
         gdp_growth ~ log_gdp_pr_capita + ethnic_frac*assasinations + 
           institutional_quality + m2_gdp_lagged + region + policy*aid +
           period_fac, 
         na.action = "na.exclude")

# Printer resultatene i en tabell
stargazer::stargazer(m5, type = "text")


### PLOTTER EFFEKTER ###
# Steg 1: Kjør modellen


# En variabel
# Steg 2: Lag et fiktivt datasett datasettet
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

# Steg 3: legg predikerte verdier til i det fiktive datasettet
# Bruker predict
predict <- predict(m5, newdata = snitt_data, 
                   se.fit = TRUE)


# Steg 4 + 5: Legger predikerte verdier og konfidensintervaller inn i snitt_data
snitt_data <- snitt_data %>% 
  mutate(fit.fit = predict$fit,             # Henter ut predikterte verdier
         se = predict$se.fit,               # Henter ut standardfeil
         fit.lwr = fit.fit - 1.96*se,       # Beregner nedre grense for KI
         fit.upr = fit.fit + 1.96*se)       # Beregner øvre grense for KI  

# (Steg 6: Plotter)
class(snitt_data$fit.fit)

library(ggplot2)
ggplot(snitt_data, aes(x = institutional_quality, y = snitt_data$fit.fit)) + 
  geom_line() +                                                   
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
predict <- predict(m5, newdata = snitt_data_sam, se = TRUE)

snitt_data_sam <- snitt_data_sam  %>% 
  mutate(fit.fit = predict$fit,             # Henter ut predikterte verdier
         se = predict$se.fit,               # Henter ut standardfeil
         fit.lwr = fit.fit - 1.96*se,       # Beregner nedre grense for KI
         fit.upr = fit.fit + 1.96*se)       # Beregner øvre grense for KI 

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
# Dette kan du ikke sjekke i R

## 2. Lineær sammenheng 
# geom_smooth + geom_point
ggplot(aid) + 
  geom_point(aes(y = gdp_growth, x = policy)) +
  geom_smooth(aes(y = gdp_growth, x = policy), 
              se = FALSE) +
  theme_bw()


# car::ceresPlot
# Kjører modellen uten samspill for å illustrere ceresplot()
model5_usam <- lm(gdp_growth ~ log_gdp_pr_capita + ethnic_frac + assasinations + 
                    institutional_quality + m2_gdp_lagged + region + policy + aid +
                    period_fac,
                  data = aid, na.action = "na.exclude")

stargazer(model5_usam, type = "text")

# installerer og laster inn pakken
ceresPlot(model5_usam, "aid")
ceresPlot(model5_usam, "policy")

## 3. Uavhengighet/ingen autokorrelasjon
# kjør modell med na.omit

# Kjører modellen på ny uten å bevare missingverdier
m5b <- lm(gdp_growth ~ log_gdp_pr_capita + ethnic_frac * assasinations + 
            institutional_quality + m2_gdp_lagged + region + policy * aid +
            period_fac,
          data = aid, na.action = "na.omit")
# Her blir det problemer om vi bevarer na med na.exclude. 

durbinWatsonTest(m5b)

## 4. Normalfordelte residualer
# ggplot med rstandard(m5) og y = ..density..
# stat_function(fun = dnorm)
ggplot() +
  geom_histogram(aes(x = rstandard(m5),
                     y = ..density..)) + 
  stat_function(fun = dnorm, 
                color = "goldenrod2")

qqPlot(m5)

# Sjekker skjevhet og kurtose til restleddene
kurtosis(m5$residuals)
# Ganske spiss 

skewness(m5$residuals)
 # ser ok ut (-1 - 1)


## 5. Homoskedastiske residualer
# residualPlot()
residualPlot(m5)

## 6. Ingen perfekt multikolineraitet
# vif()
vif(m5)

## 7. Uteliggere og innflytelsesrike observasjoner
# influenceIndexPlot(id = list(n=3))
influenceIndexPlot(m5,
                   id = list(n=3))

# Bruker indeksering til å se nærmere på noen av observasjonene
aid[c(39,86), ]

aid %>% 
  filter(row_number() %in% c(39,86))

## 8. Variabler med manglende informasjon "missing"
# table()
aid$reg_miss <- aid %>%
  select(gdp_growth, aid, policy) %>%
  complete.cases()

# Lager variabel som viser hvilke observasjoner som forsvinner i regresjon med de sentrale variablene
# gdp_growth, aid og policy - fin å bruke i plot for å få et inntrykk av hva slags informasjon du mister ved å legge til flere kontrollvariabler.
table(aid$reg_miss) # 47 observasjoner har missing på en eller flere av de tre variablene

# korrelasjonsmatriser
# Kjører en modell med litt færre variabler
m1 <- lm(gdp_growth ~ aid*policy + as.factor(period) + ethnic_frac*assasinations, data = aid )
summary(m1) # output viser at 48 observasjoner fjernes pga. missing

# Lager matrise med aid, select og cor(, pairwise)
# Siden as.factor(period) lager en dummvariabel for alle perioder unntatt periode 1, må vi gjøre dette for å inkludere denne variabelen i korrelasjonsmatrisen (inkluder gjerne også periode 1 i matrise):

aid$period2 <- ifelse(aid$period==2, 1, 0)
aid$period3 <- ifelse(aid$period==3, 1, 0)
aid$period4 <- ifelse(aid$period==4, 1, 0)
aid$period5 <- ifelse(aid$period==5, 1, 0)
aid$period6 <- ifelse(aid$period==6, 1, 0)
aid$period7 <- ifelse(aid$period==7, 1, 0)
aid$period8 <- ifelse(aid$period==8, 1, 0)

aid %>% 
  select(gdp_growth,aid,policy, ethnic_frac,assasinations,period2,period3,period4,period5,period6,period7) %>%
  cor(, use = "pairwise.complete.obs")

# sammenligne med cor(, complete)

# Alternativet "complete.obs" fjerner alle observasjoner som har missing på en av variablene som inngår, mao. det samme som regresjonsanalysen.
aid %>% 
  select(gdp_growth,aid,policy, ethnic_frac,assasinations,period2,period3,period4,period5,period6,period7) %>%
  cor(, use = "complete.obs")


# kjører glm() med regmiss som uavhengig var
miss_mod <- glm(reg_miss ~ aid*policy + as.factor(period), data = aid)
summary(miss_mod) # ingen store forskjeller

# I denne modellen ønsker du ikke signifikante uavhengige variabler

###############################
##### SLÅ SAMMEN DATASETT #####
###############################

# Last inn equality
equality <- read_csv("https://raw.githubusercontent.com/liserodland/stv4020aR/master/H20-seminarer/Innf%C3%B8ringsseminarer/data/Vdem_10_redusert.csv")
# Eller last ned Rdata-filen fra githubd


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

agg_equality <- equality %>%
  group_by(country_text_id, period) %>%
  summarise(avg_eq = mean(v2pepwrsoc, na.rm = TRUE)) %>% # regner ut gjennomsnittet for perioden
  mutate(period_num = as.numeric(period))

table(agg_equality$period, agg_equality$period_num)

agg_equality

# husk: ?left_join for å forstå funksjonen
aid2 <- left_join(aid, agg_equality,
                  by = c("country" = "country_text_id", "period" = "period_num")) # Spesifiserer nøkkelvariablene
# Sjekker missing:
table(is.na(aid2$avg_eq))
# 6 missing pga observasjonen som mangler

summary(aid2$avg_eq)

