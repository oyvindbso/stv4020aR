#######################
### FLERNIVÅANALYSE ###
#######################

# Laget du prosjekt i går? Husk å åpne prosjektfilen, ikke bare scriptet
# Dette scriptet kan du eventuelt lagre i prosjektmappen din

# Laster inn nødvendige pakker
# install.packages("lme4")
library(tidyverse) # Bl.a. for å preppe data
library(stargazer) # For pene tabeller
# install.packages("sjlabelled")
library(sjlabelled) # For å hente ut informasjon om labels e.l.
library(lmtest) # For å kjøre likelihood ratio test
library(countrycode) # For å endre landkoder
library(lme4) # For å kjøre flernivåmodeller

# Laster inn Rdata
load("H20-seminarer/Fordypningsseminarer/data/ess.RData") # Her må du bytte ut mappestien "../data/" med stien til mappen du lagret data i

# Sjekker ut datasettet
str(ess)

# Sjekker ut noen av variablene
# Dette går nok ikke med csv-filen
get_label(ess$trust_eurparl)
summary(ess$trust_eurparl)
get_labels(ess$trust_eurparl)

# Labelled data er i utgangspunktet supert, men klassen "labelled" kan
# også gi noen utfodringer. Jeg lager derfor et datasett uten labels:
ess_nolabel <- remove_all_labels(ess)

# I tillegg fjerner jeg de observasjonene som har missing på noen 
# av variablene vi skal bruke senere sånn at modellene er nøstede
# mtp observasjoner
ess_nolabel <- ess_nolabel %>% 
  filter(!is.na(income_decile) &
         !is.na(trust_politicians))
# Ved å skrive !is.na(variabelnavn) sier jeg is.na(variabelnavn) = FALSE

# Kjører nullmodell for å beregne intra class correlation
m0 <- lmer(data = ess_nolabel, 
           trust_politicians ~ (1|country))

summary(m0)

# ICC
1.294/(1.294 + 4.642)

## Flernivå med uavh. variabel på nivå 1, fixed effects, random intercept:** 
m1 <- lmer(data = ess_nolabel, 
           trust_politicians ~ (1|country) + income_decile,
           na.action = "na.exclude")

summary(m1)
# I flernivåmodeller varierer koeffisientene på tvers av klasser. 
# Koeffisientestimatet er derfor bare den forventede verdier på tvers av alle klasser. 
# Følg med i forelesningen for mer info om hvordan tolke estimater. 

stargazer(m1, type = "text")

# Plotter predikerte effekter for å illustere forskjellen mellom flernivåmodeller
# Tar ikke med KI denne gangen - her er det intercept og slope vi er ute etter
# 1. Esimtere modell (gjort)

# 2. Lage plot data
plot_data_m1 <- data.frame(income_decile = rep(1:10, 2),
                        country = c(rep("Sweden", 10), rep("Switzerland", 10)))

# 3. Henter ut predikerte verdier på avhengig variabel og lagrer i plotdata
plot_data_m1$pred <- predict(m1, plot_data)                        

# 4. Plotter
ggplot(plot_data_m1) +
  geom_line(aes(y = pred, x = income_decile, col = country)) +
  theme_minimal() +
  xlab("Inntektsdesil") + 
  ylab("Predikert tillit til politikere") +
  scale_x_continuous(limits = c(1,10)) +
  scale_y_continuous(limits = c(0,10)) +
  ggtitle("Modell med random intercept") + 
  theme(legend.title = element_blank())
# Land er våre nivå 2 variabler. Her har de ulikt skjæringspunkt på y-aksen,
# men linjen har lik helning

## Flernivå med uavh. variabel på nivå 1, random slopes, dvs. vi lar
# effekten av nivå 1 variabelen varierer mellom land
# Kjører modellen, lar effekten av income_decile variere mellom land
m2 <- lmer(data = ess_nolabel, 
           trust_politicians ~ (income_decile|country) + income_decile,
           na.action = "na.exclude")

summary(m2)
# Vi skal se mer på hvordan vi kan tolke varians etterpå

stargazer(m0, m1, m2, type = "text")

# Plotter effekter
# 1. Kjører modellen

# 2. Lager plotdata
plot_data_m2 <- data.frame(income_decile = rep(1:10, 2),
                        country = c(rep("Sweden", 10), rep("Switzerland", 10)))

# 3. Lagrer predikerte verdier på AVAR i datasettet
plot_data_m2$pred <- predict(m2, plot_data)                        

# 4. Plotter
ggplot(plot_data_m2) +
  geom_line(aes(y = pred, x = income_decile, col = country)) +
  theme_minimal() +
  theme_minimal() +
  xlab("Inntektsdesil") + 
  ylab("Predikert tillit til politikere") +
  scale_x_continuous(limits = c(1,10)) +
  scale_y_continuous(limits = c(0,10)) +
  ggtitle("Modell med random intercept og random slopes") +
  theme(legend.title = element_blank())

# Her har de både forskjellig intercept og slope

## Før vi går videre så skal vi legge til en nivå 2-variabel
## Laster inn data på nivå 2 
gini <- read.csv("H20-seminarer/Fordypningsseminarer/data/OECD_gini.csv") 

str(gini)

# cntry i gini-dataene ligner på cntry i ess
str(ess)

# Kan bruke en pakke til å forenkle jobben
?codelist

# Lager ny landkodevariabel
gini$cntry2 <- countrycode(gini$cntry, "iso3c", "iso2c")

# Slår sammen datasettene
ess2 <- ess_nolabel %>% 
  left_join(gini, by = c("cntry" = "cntry2"))

# Sjekker om alle land har fått en giniverdi ved hjelp av is.na
table(is.na(ess2$gini))

# Ingen har missing så dette ser fint ut


## Flernivå med uavh. var på nivå 1 med random effects, og uavhengig variabel på nivå 2:
m3 <- lmer(data = ess2, 
           trust_politicians ~  income_decile + (income_decile|country) + gini)

plot_data_m3 <- data.frame(income_decile = rep(1:10, 2),
                           country = c(rep("Sweden", 10), rep("Switzerland", 10)),
                           gini = mean(ess2$gini))

plot_data_m3$pred <- predict(m3, plot_data_m3)                        

ggplot(plot_data_m3) +
  geom_line(aes(y = pred, x = income_decile, col = country)) +
  theme_minimal() +
  theme_minimal() +
  xlab("Inntektsdesil") + 
  ylab("Predikert tillit til politikere") +
  scale_x_continuous(limits = c(1,10)) +
  scale_y_continuous(limits = c(0,10)) +
  ggtitle("Random intercept, random slopes") +
  theme(legend.title = element_blank())
# I denne modellen har vi åpnet for random intercept, random slopes (income_decile)
# Men holdt effekten av gini konstant på tvers av land

plot_data_m3b <- data.frame(income_decile = mean(ess2$income_decile, na.rm = TRUE),
                           country = c(rep("Sweden", 10), rep("Switzerland", 10)),
                           gini = c(rep(seq(min(ess2$gini), 
                                            max(ess2$gini), 0.0075), 2)))
plot_data_m3b$pred <- predict(m3, plot_data_m3b)                        

ggplot(plot_data_m3b) +
  geom_line(aes(y = pred, x = gini, col = country)) +
  theme_minimal() +
  theme_minimal() +
  xlab("Gini") + 
  ylab("Predikert tillit til politikere") +
  scale_x_continuous(limits = c(0.2,0.35)) +
  scale_y_continuous(limits = c(0,10)) +
  ggtitle("Random intercept & slopes, fixed nivå 2 (gini)") +
  theme(legend.title = element_blank())
## OBS!! Dette er bare for å illustrere, men husk at vi bare har observasjoner
# for ett år. Derfor har vi egentlig bare en observasjon av gini per land

## Flernivå med uavh. var på mikronivå med random effects, kryssnivåsamspill, 
# og uavhengig variabel på makronivå:
m4 <- lmer(data = ess2, 
           trust_politicians ~ (income_feel|country) + income_feel*gini, 
           na.action = "na.exclude")

plot_data_m4 <- data.frame(income_feel = rep(1:4, 4),
                            country = c(rep("Sweden", 8), rep("Switzerland", 8)),
                            gini = c(rep(c(min(ess2$gini), 
                                           min(ess2$gini),
                                           min(ess2$gini),
                                           min(ess2$gini),
                                           max(ess2$gini),
                                           max(ess2$gini),
                                           max(ess2$gini),
                                           max(ess2$gini)), 2)))

plot_data_m4$pred <- predict(m4, plot_data_m4)                        

ggplot(plot_data_m4) +
  geom_line(aes(y = pred, x = income_feel, col = as.factor(gini))) +
  facet_wrap(~country)+ 
  theme_minimal() +
  theme_minimal() +
  xlab("Income feel") + 
  ylab("Predikert tillit til politikere") +
  scale_x_continuous(limits = c(1,4)) +
  scale_y_continuous(limits = c(3,6)) +
  ggtitle("Random intercept og slopes + kryssnivåsamspill") 
# OBS! I dette plottet har jeg "juksa" litt med y-aksen for å få frem forskjellene
# OBS! Husk at dette ikke er tidsserie så vi har egentlig bare en gini-verdi per 
# land. Derfor er det et lite egnet plot der vi gjør prediksjoner langt utover 
# datamaterialet vårt. I dette tilfellet har jeg gjort det først og fremst for å
# vise dere hvordan disse slår ut. 


## Hente ut informasjon om koeffisienten fra modell-objektene
# Bruker modellen med random intercept og random slope som eksempel
# Random effects
ranef(m2)
# Koeffisienter
coef(m2)
# Random slopes i ranef() tilsvarer differensansen mellom interceptene vi får med coef()

## Hente ut informasjon om varians fra modell-objektene
# Vi lagrer først et element med de estimerte variansene
m2var <- VarCorr(m2)

# Så bruker vi print() og ber om å få varians
print(m2var, comp = "Variance")

# Vi kan tolke variansen for å vurdere om effekten av en variabel 
# varierer mellom klasser. Om den er lik null så betyr  det at 
# effekten er lik i alle klasser og vi kan inkludere den som fixed
# Dersom den er forskjellig fra null så bruker vi variansens standardavvik
# for å vurdere om variansen er signifikant eller ikke. 
# I mine notater fra 4020A så står det at variansen er signifikant
# forskjellig fra null dersom den er mer enn dobbelt så stor som
# standardavviket (ta dette med ei klype salt og hør på Staffan/pensum)

# Henter frem summary fra modellen vår med random intercept og random slop
summary(m2)
# Variansen til income_decile er tilnærmet lik null. 
# Vi kan også bruke en logisk test for å sjekke om variansen er minst 
# dobbelt så stor som standardavviket. Det er den ikke. 
0.001434 > 2*0.03787

## Modellevaluering
AIC(m0,m1,m2,m3)
BIC(m0,m1,m2,m3)

## Likelihood-ratio
stargazer(m0, m1, m2, type = "text")

# Tar en LR-test
lrtest(m1, m2)
# Positiv og signifikant Lr-test betyr at den fullstendige modellen
# er signifikant bedre tilpasset datamaterialet enn den reduserte

## Sentrering
# I flernivåanalyse er det ganske vanlig å sentrere variabler
# Det har vi ikke gjort i dag, men dere kan gjøre det enkelt 
# hjemme. I eksempelet under lager jeg en sentrert variabel.
# Skal dere gjøre dette hjemme så bytter dere ut uavhengig
# variabler med sentrerte varianter

ess_nolabel$income_decile_sent <- ess_nolabel$income_decile - mean(ess_nolabel$income_decile, na.rm = TRUE)
summary(ess_nolabel$income_decile_sent)
# Gjennomsnittet er lik null 

ess_nolabel$income_decile_stand <- (ess_nolabel$income_decile-mean(ess_nolabel$income_decile, na.rm = TRUE))/sd(ess_nolabel$income_decile, na.rm = TRUE)
summary(ess_nolabel$income_decile_stand)
sd(ess_nolabel$income_decile_stand, na.rm = TRUE)
# Gjennomsnitt er lik null og standardavvik er lik 1