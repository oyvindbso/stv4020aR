load("../Gruppe 1/data/Seminar2.RData")

table(tillit$utdanning)
attributes(tillit$utdanning)
# 1. Vis hvordan du gjennomfører en regresjonsanalyse med tillit som
# avhengig variabel og sosial status som uavhengig. Hvor mange
# respondenter ligger til grunn for analysen? Tolk konstantleddet,
# variabel-koeffisienten og R2.
tillit_reg <- lm(tillit ~ rsosstat, data = tillit)
summary(tillit_reg) # Forventet tillit når sosial status er null, er 2.82
nobs(tillit_reg) # 1003 observasjoner ligger til grunn for analysen
summary(tillit_reg)$r.squared # vi forklarer under 4% av variasjonen i Y (R-squared)

# 2. Vis hvordan du får frem et spredningsdiagram for relasjonen
# mellom tillit og sosial status.

library(ggplot2)
theme_set(theme_bw())
ggplot(tillit, aes(x = rsosstat, y = tillit)) + geom_point() + geom_smooth(method = "lm")

# 3. Vis hvordan du gjennomfør en regresjonsanalyse med tillit som
# AV og med sosial status og UTD2 som UV og tolk resultatet.

tillit_reg2 <- lm(tillit ~ rsosstat + factor(utd2), data = tillit)
summary(tillit_reg2) 
# Forventet tillit med lav utdanning (utd2 = 0) og lav sosial status (sosstat = 0), er 2.907
# En enhets økning på sosial status, gir -0.07 forventet økning i tillit
# Går man fra lav til høy utdanning, endres forventet tillit med -0.322 

# 4. Vis hvordan du finner gjennomsnittet og standardavviket til sosial
# status. Oppgi verdien på gjennomsnittet.
mean(tillit$rsosstat, na.rm = TRUE) # Snittet på variabelen sosial status er 2.248
sd(tillit$rsosstat, na.rm = TRUE) # Standardavviket til variabelen sosial status er 1.488

# 5. Vis hvordan du oppretter en variabel (sosstat.ms) for sentrert
# sosial status. Hva skal verdiene til gjennomsnittet og
# standardavviket til denne variabelen være?
tillit$sosstat.ms <- tillit$rsosstat - mean(tillit$rsosstat, na.rm = TRUE)

# Snittet skal være 0 og standardavviket det samme som over (1.488) etter sentrering

# 6. Vis hvordan du oppretter en variabel utd3 for utdanning slik at:
#   utd3 = 1: Grunnskole
#   utd3 = 2: Mer enn grunnskole, men mindre enn ett år
#             på universitet / høgskole
#   utd3 = 3: Minst ett år på universitet/høgskole
table(tillit$utdanning)
attributes(tillit$utdanning)

tillit$utd3 <- ifelse(tillit$utdanning == 1, 1, NA)
tillit$utd3 <- ifelse(tillit$utdanning != 1 & tillit$utdanning < 5, 2, tillit$utd3)
tillit$utd3 <- ifelse(tillit$utdanning > 4, 3, tillit$utd3)
table(tillit$utdanning, tillit$utd3)

# 7. Vis hvordan du oppretter variabler for samspill mellom sosial
# status og utdanning (3-delt) i regresjonsanalyse.
tillit$utd_sosstat_samspill <- tillit$rsosstat * tillit$utd3

# 8. Vis hvordan du gjennomfør en regresjonsanalyse med tillit som
# AV og med sosial status, utdanning og samspill mellom sosial
# status og utdanning som UV. Gjør kort rede for relasjonen mellom
# tillit og sosial status i lys av samspill mellom sosial status og
# utdanning.
tillit_reg3 <- lm(tillit ~ utd3 + rsosstat + utd_sosstat_samspill, data = tillit)
summary(tillit_reg3)

# Eller bare gjøre det enklere med å kjøre samspillet direkte inn i regresjonen
  # Resultatene fra de to modellene blir helt identiske!
tillit_reg3 <- lm(tillit ~ utd3 * rsosstat, data = tillit)
summary(tillit_reg3)

# 9. Ta vare på datasettet og scriptet.
# Ok.