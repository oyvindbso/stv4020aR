############################################
#### Løsningsforslag oppgaver seminar 2 ####
############################################

##### Oppgave 1 #####
# Lagre datasett i en mappe, og sett working directory til denne mappen.
setwd("")
load("bd_full.Rdata")

str(full) # gir nødvendig informasjon

##### Oppgave 2 #####

summary(full$elraid) # ser at det er missing observasjoner
full$elraid==min(full$elraid, na.rm =T) 


# indekserer meg frem til observasjonen i datasettet på to måter:

# metode 1:
which(full$elraid==min(full$elraid, na.rm =T)) # observasjon 1122
full[which(full$elraid==min(full$elraid, na.rm =T)),] # ferdig

# metode 2 - dplyr:
full %>%
  filter(elraid==min(full$elraid, na.rm =T)) # ferdig

# Resten av indekseringen foregår helt likt.

##### Oppgave 3 #####
summary(full$elrssa)
full$regions <- ifelse(full$elreasia==1, "East Asia", "Other")
full$regions <- ifelse(full$elrcentam==1, "Central America", full$regions)
full$regions <- ifelse(full$elrssa==1, "Sub-Saharan Africa", full$regions)
table(full$regions) # sjekker omkoding
class(full$regions) # character
full$regions <- as.factor(full$regions) 
class(full$regions) # factor
levels(full$regions)


##### Oppgave 4 #####

full$elrpolicy <- (-1)*full$elrinfl +  full$elrbb + full$elrsacw
summary(full$elrpolicy)

# dplyr-løsning:
ssa <- full %>%
  filter(full$elrssa==1)

nossa <- full %>%
  filter(full$elrssa!=1)

# klammeparentes-løsning

ssa <- full[which(full$elrssa==1),]
nossa <- full[which(full$elrssa!=1),]

# regresjoner:

summary(lm(elrgdpg ~ elraid*elrpolicy + as.factor(period) + elrlpop + elrassas*elrethnf , data = ssa)) 
# aid ingen effekt, policy har effekt

summary(lm(elrgdpg ~ elraid*elrpolicy + as.factor(period) + elrlpop + elrassas*elrethnf , data = nossa))
# aid ingen effekt, policy har effekt

summary(lm(gdp_growth ~ aid*policy + as.factor(period) + bdlpop + bdassas*bdethnf , data = ssa))
# svakt signifikant positivt samspill

summary(lm(gdp_growth ~ aid*policy + as.factor(period) + bdlpop + bdassas*bdethnf , data = nossa))
# svakt signifikant negativt samspill

# Merk N som faktisk brukes når du leser regresjonsoutput...

##### Oppgave 5 #####
summary(full$elrgdp)

land <- full %>%
  group_by(country) %>%
  summarise(snitt = mean(elrgdpg, na.rm = T))

# Løsning med ifelse()

land$growth_group <- ifelse(land$snitt < -6, "Extremely low", NA) # I stedet for NA kunne jeg satt hva som helst
land$growth_group <- ifelse(land$snitt >= -6 & land$snitt < 0, "low", land$growth_group)
land$growth_group <- ifelse(land$snitt >= 0 & land$snitt < 2, "medium", land$growth_group)
land$growth_group <- ifelse(land$snitt >= 2 & land$snitt < 6, "high", land$growth_group)
land$growth_group <- ifelse(land$snitt >= 6, "Extremely high", land$growth_group)

table(land$growth_group)

# Løsning med cut - sjekk ?cut
land$growth_group <- cut(land$snitt, breaks = c(min(land$snitt, na.rm = T), -6, 0, 2, 6, max(land$snitt, na.rm = T)), 
                         labels = c("Extremely low", "low", "medium", "high", "Extremely high"))

names(land)

full_m <- merge(full, land, by.x = "country", by.y = "country", all.x = T)

g_group <- full_m %>%
  group_by(growth_group) %>%
  summarise(bdaid_a  = mean(bdaid, na.rm=T),
            elraid_a  = mean(elraid, na.rm=T),
            elrpolicy_a = mean(elrpolicy, na.rm = T),
            bdpolicy_a = mean(policy, na.rm = T))
g_group

# Sjekk forskjellene mellom policy-variablene!

##### Oppgave 6 #####

ggplot(filter(full, country == "MEX"), aes(x = elraid, y = elrgdpg, col = elrpolicy)) + geom_line()

landplot <- function(land){
  ggplot(filter(full, country == land), aes(x = elraid, y = elrgdpg, col = elrpolicy)) + geom_line()
}
landplot("MEX")

##### Oppgave 7 #####

full$elrgdpg_lag <- lag(full$elrgdpg)

summary(lm(elraid ~ elrpolicy + elrgdpg_lag + elrlpop, data = full))


# Statistisk signifikant negativ effekt på bistand av vekst.

# Bonus:

summary(lm(elraid ~ elrpolicy + elrgdpg_lag + I(elrgdpg_lag^2) +  elrlpop, data = full))
# signifikant andregradsledd

# God regresjon?
ggplot(full, aes(x = elrgdpg_lag, y = elraid)) + geom_point()

##### Oppgave 7 #####

?complete.cases()
# lager datasett kun bestående av variabler fra regresjon i oppgave 4:

# Kan gjøres på to måter:
elr_miss <- full %>%
  select(elraid, elrpolicy, period, elrlpop, elrassas, elrethnf) 
# har samme lendge og organisering som full

bd_miss <- full[, c("aid", "policy", "period", "bdlpop", "bdassas", "bdethnf")]

table(complete.cases(elr_miss))
table(complete.cases(bd_miss))

full$miss <- ifelse(complete.cases(elr_miss)==F, 1, 0)
table(full$miss)

ggplot(full, aes(x = as.factor(miss), y = elrgdpg)) + geom_boxplot()
# Ganske likt for observasjonene vi har vekst-data til.