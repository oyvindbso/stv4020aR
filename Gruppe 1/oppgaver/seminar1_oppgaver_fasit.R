################################
### Fasit oppgaver seminar 1 ###
################################


#################
##### Del 1 #####
#################

#### Oppgave 1 ####

aid <- read.csv("https://raw.githubusercontent.com/martigso/stv1020R/master/data/aidgrowth.csv")
str(aid)

# Løsning 1
aid <-  aid[,2:13] 

# Løsning 2
# install.packages("dplyr")
library(dplyr)
aid <- aid %>%
  select(-"X") # Med - i select(), velger jeg alle variabler bortsett fra de variablene jeg setter inn.

#### Oppgave 2 ####

aid$gdp_pr_capita_log <- log(aid$gdp_pr_capita)


#### Oppgave 3 ####

## Alternativ 1: Med which()

# aid > 5
aid[which(aid$aid>5),]

# gdp_growth < -5
aid[which(aid$gdp_growth< (-5)),] 
# Merk: hvis vi skriver aid[which(aid$gdp_growth<-5),], vil R endre verdien av gdp_growth til 5 for alle observasjoner, 
# fordi koden inneholder aid$gdp_growth<-5.    

# policy > 3
aid[which(aid$policy>3), ]

## Alternativ 2: med filter() fra dplyr

aid %>%
  filter(aid > 5)

aid %>%
  filter(gdp_growth < -5)

aid %>%
  filter(policy > 3)

#### Oppgave 4 ####

aid$regions <- ifelse(aid$sub_saharan_africa==1, "Sub-Saharan Africa", "Other")
aid$regions <- ifelse(aid$fast_growing_east_asia==1, "East Asia", aid$regions)

table(aid$fast_growing_east_asia, aid$sub_saharan_africa, aid$regions) 
# sjekker omkoding med tabell. Loddrett til venstre vises verdier på fast_growing_east_asia, på toppen vises verdier på Sub-Saharan Africa


###########################
##### Del 2 ###############
###########################

#### Oppgave 5 ####

m5 <- lm(gdp_growth ~ gdp_pr_capita_log + ethnic_frac * assasinations +
           institutional_quality + m2_gdp_lagged + regions + policy * aid +
           factor(period),
         data = aid, na.action = "na.exclude")
summary(m5)
 
# Samspillsleddet mellom  policy og aid er svakt statistisk signifikant (p-verdi 0.067). 
# Substansiell tolkning av effekten til aid, gitt ulike verdier av policy:

names(coef(m5))
coef(m5)[["aid"]] + coef(m5)[["policy:aid"]] * min(aid$policy, na.rm = T) # Forventet effekt av en enhets økning i aid ved minimumsverdi av policy
coef(m5)[["aid"]] + coef(m5)[["policy:aid"]] * median(aid$policy, na.rm = T) # Forventet effekt av en enhets økning i aid ved medianverdi av policy
coef(m5)[["aid"]] + coef(m5)[["policy:aid"]] * max(aid$policy, na.rm = T) # Forventet effekt av en enhets økning i aid ved maksimumsverdi av policy

# For å vurdere om disse effektene er store/små substansielt, kan vi gjøre to ting:
# 1) Vurdere om den forventede økningen/reduksjonen i vekst som en konsekvens av samspillet er stor/liten, ved å tenke på hva variablene måler. 
# Er en økning i vekst på 0.15 prosent på et år ved 1 % økning i bistand som prosentandel av BNP mye? Jeg vil si dette er ganske så god avkastning, og at det er en stor forskjell fra reduksjon på -0.86.
# 2) Se på deskriptiv statistikk for variablene vi er interessert i - 1 % reduksjon i sjansen for en sykdom 2% av befolkningen får i løpet av livet er mer imponerende enn 1 % reduksjon i sjansen for forkjølelse, dersom vi tenker på forklaringskraft. 

summary(aid$aid) # gjennomsnittsbistanden er over 1, så gjennomsnittsutslagene av bistandspolitikk blir større enn (men proporsjonale med) det vi regnet ut over.
summary(aid$policy) # 
summary(aid$gdp_growth) # 

sd(aid$policy, na.rm = T) # typisk avvik er litt over 1 - ser på effekten av median-policy vs. policy et standardavvik under median

(coef(m5)[["aid"]] + coef(m5)[["policy:aid"]] * median(aid$policy, na.rm = T)) - 
  (coef(m5)[["aid"]] + coef(m5)[["policy:aid"]] * (median(aid$policy, na.rm = T))-sd(aid$policy, na.rm =T))

# En forskjell på 1.19 monner - kan ta et land fra gjennomsnittsveksten på like over 1 til svak negativ vekst.

sd(aid$aid) # Typisk variasjon i bistand - mer variasjon gir mer substansielt viktig forklaringsvariabel, alt annet likt. Hvis den typiske variasjonen var 1, ville bistand vært mindre viktig enn når den er 2.
# Hvis en variabel lett kan manipuleres (bistand kan f.eks. kanskje lettere endres av vestlige land enn politikken landet fører), vil effekten også være mer substansiell.
# En variabel med mye forklaringskraft, men som ikke kan endres, vil gi oss innsikt i hvorfor verden er som den er, men ikke i hvordan verden kan gjøres bedre.

sd(aid$gdp_growth, na.rm =T) # typisk variasjon i gdp_growth - ganske store variasjoner, så det mye annet enn svingninger i aid og policy som må til for å forklare variasjon i vekst for de fleste land.


# P.S.: For substansiell tolkning av samspillseffekter anbefaler jeg å plotte effekten, det skal vi se på i neste seminar.


#### Oppgave 6 ####

load("Gruppe 1/data/bd_full.Rdata")

m5b <- lm(gdp_growth ~ gdp_pr_capita_log + ethnic_frac * assasinations +
           institutional_quality + m2_gdp_lagged + regions + bdbb * aid +
           factor(period),
         data = full, na.action = "na.exclude")
summary(m5b)
# ser at både individuell koeffisient (svakt signifikant) og samspillskoeffisient blir positiv for aid

m5c <- lm(gdp_growth ~ gdp_pr_capita_log + ethnic_frac * assasinations +
            institutional_quality + m2_gdp_lagged + regions + bdinfl * aid +
            factor(period),
          data = full, na.action = "na.exclude")
summary(m5c)
# ser at både individuell koeffisient og samspillskoeffisient blir tilnærmet lik 0, inflasjon har en betydelig (og signifikant), negativ effekt.

m5d <- lm(gdp_growth ~ gdp_pr_capita_log + ethnic_frac * assasinations +
            institutional_quality + m2_gdp_lagged + regions + bdsacw * aid +
            factor(period),
          data = full, na.action = "na.exclude")
summary(m5d)

# ser at individuell koeffisient blir svakt negativ (nesten 0) og samspillskoeffisient blir positiv for aid (svakt signifikant).

full$policy2 <- full$bdbb + (-1)*full$bdinfl + full$bdsacw
# Ganger inflasjon med -1 for å snu skalaretning, fordi høyere verdi da tolkes som "bedre politikk" for alle variablene i indeksen.

m5e <- lm(gdp_growth ~ gdp_pr_capita_log + ethnic_frac * assasinations +
            institutional_quality + m2_gdp_lagged + regions + policy2 * aid +
            factor(period),
          data = full, na.action = "na.exclude")
summary(m5e)

# ser at både individuell koeffisient (ikke-signifikant) og samspillskoeffisient (signifikant) blir positiv for aid.
# Man kan spørre seg om støtten til Burnside og Dollar's hypotese, gitt den store variasjonen i resultater som en følge operasjonalisering som regresjonene over viser.


##### Oppgave 7 #####

library(ggplot2)


# Plot for sammenheng mellom komponenter i policy og bnp-vekst:

ggplot(full) + geom_point(aes(x = bdsacw, y = gdp_growth)) + facet_wrap(~as.factor(regions))

ggplot(full) + geom_point(aes(x = bdbb, y = gdp_growth)) + facet_wrap(~as.factor(regions))

ggplot(full) + geom_point(aes(x = bdinfl, y = gdp_growth)) + facet_wrap(~as.factor(regions))

# For sammenligning: plot mot policy og policy 2

ggplot(full) + geom_point(aes(x = policy, y = gdp_growth)) + facet_wrap(~as.factor(regions))

ggplot(full) + geom_point(aes(x = policy2, y = gdp_growth)) + facet_wrap(~as.factor(regions))
                                                                        
                                                                        
# Plot for sammenheng mellom komponenter i policy og bistand:

ggplot(full) + geom_point(aes(x = bdsacw, y = aid)) + facet_wrap(~as.factor(regions))

ggplot(full) + geom_point(aes(x = bdbb, y = aid)) + facet_wrap(~as.factor(regions))

ggplot(full) + geom_point(aes(x = bdinfl, y = aid)) + facet_wrap(~as.factor(regions))

# For sammenligning: plot mot policy og policy 2

ggplot(full) + geom_point(aes(x = policy, y = aid)) + facet_wrap(~as.factor(regions))

ggplot(full) + geom_point(aes(x = policy2, y = aid)) + facet_wrap(~as.factor(regions))

# Bonus (avansert): Tenk gjennom forskjeller i den deskriptive statistikken under. Hva gjør større varians og sterkere kovarians med aid for policy sammenlignet med policy 2?

summary(full$policy)
summary(full$policy2)
sd(full$policy, na.rm = T) 
sd(full$policy2, na.rm = T)

cov(full$aid, full$policy, use = "pairwise.complete.obs") # cov() beregner kovarians.
cov(full$aid, full$policy2, use = "pairwise.complete.obs")

cov(full$gdp_growth, full$policy, use = "pairwise.complete.obs")
cov(full$gdp_growth, full$policy2, use = "pairwise.complete.obs")
