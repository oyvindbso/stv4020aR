# 1 Først laster jeg inn datasettet med readrpakken fra tidyverse:

library(tidyverse)
datasett <- read_csv('http://folk.uio.no/martigso/encrypt/steak_survey.csv')

# KOMMENTAR: Flott!

# 2 Stolpediagram over frekvenser i variablen steak_prep
# Jeg bruker grafikkpakken ggplot fra tidyverse

ggplot(datasett,aes(steak_prep))+
  geom_bar(fill = 'salmon')

# Vi ser at medium rare har høyest frekvens

# KOMMENTAR: Flott!

# 3 & 4 Jeg lager en tredelt variabel (steak_prep2) med nivåene rare, well done og medium
# Jeg gjør variabelen om til en faktor med nivåene Rare, Medium og Well, ordnet i
# den rekkefølgen

datasett <- datasett%>%
  mutate(
    steak_prep2 = 'Well',
    steak_prep2 = ifelse(steak_prep == 'Medium rare' |
                           steak_prep == 'Rare',
                         yes = 'Rare',
                         no = 'Well'),
    steak_prep2 = ifelse(steak_prep == 'Medium', 
                         yes = 'Medium',
                         no = steak_prep2),
    steak_prep2 = factor(steak_prep2,levels = c('Rare','Medium','Well')))

# Her sjekker jeg at variabelen er kodet riktig

ggplot(datasett,aes(steak_prep2))+
  geom_bar(fill = 'salmon')

# KOMMENTAR: Flott! Men husk å kryssjekk med den gamle variabelen:
table(datasett$steak_prep, datasett$steak_prep2)

# 5 Her finner jeg korrelasjonen (kovarians) mellom variabelen 'smoke' og 'alcohol':
# Først ser jeg i en tabell
table(select(datasett,smoke,alcohol))
# Deretter finner jeg korrelasjonen
cor(datasett$alcohol,datasett$smoke,method = 'pearson',use = 'complete.obs')
# Korrelasjonen mellom alcohol og smoke er 0.0989.

# KOMMENTAR: Flott!

# 6 Her lager jeg et boxplot for å sjekke hvilken biffkategori som har lavest snittalder
ggplot(datasett,aes(steak_prep2,age))+
  geom_boxplot()
# Det er kategorien medium

# KOMMENTAR: Flott!

# 7 Her lager jeg en multinomisk logistisk regresjonsmodell med pakken nnet
# Etterpå undersøker jeg den med stargazer
library(nnet)
library(stargazer)
fit1 <- multinom(steak_prep2~age+hhold_income+smoke+alcohol,datasett,na.action = 'na.exclude')
summary(fit1)
stargazer(fit1,
          type = 'text')
# Vi ser at kun koeffisientene smoke og alcohol er signifikante på femprosentsnivå.
# Koeffisientene til smoke antyder at det er mest sannsynlig at røykere befinner seg i referanse-
# kategorien "rare". Omregnet gir koeffisientene oddsene :
# smoke <-> medium: 0.845
# smoke <-> well: 0.88

# smoke er en dikotom kategorivariabel der røykere er én og ikke-røykere er null. Dermed kan vi
# tolke oddsraten ≈0.845 som at røykere (1) har lavere odds på kategorien medium og well.

# KOMMENTAR: Flott!

# 8 Her finner jeg konfidensintervallet for variabelen 'age' på 5-pst nivå
ciFit1 <- confint(fit1,parm = 'age',level = 0.95)
summary(ciFit1)
# Intervallet omfatter 0. Dermed kan nullhypotesen (B=0) ikke forkastes

# KOMMENTAR: Flott!

# 9 Her legger jeg inn verdien 'predict' fra regresjonsmodellen, som gir hver enhet
# en variabel som inneholder den predikerte verdien på steak_prep2
datasett$predictedSteak <- predict(fit1)

# Her ser jeg hvor mange ganger steak_prep2 og predictedSteak er samme verdi, og ulik verdi
nrow(filter(datasett,
            steak_prep2 != predictedSteak))
nrow(filter(datasett,
            steak_prep2 == predictedSteak))
# Det store antallet mismatch (189) antyder en dårlig modell, men resultatet kan også komme av 
# missingverdier som "smitter" over på predictedvariabelen fra UV-er, og gir en 'mismatch'. (NA på
# predicted telles som mismatch)

# Her ser vi en tabell som viser tilfellene på predikert og faktisk verdi:
table(select(datasett,steak_prep2,predictedSteak))
# Modellen predikerer aldri verdien 'Well', selv om denne forekommer 83 ganger.
# Den predikerer rett 154 ganger, og feil 189 ganger.
# Dette gir prosenttallet ≈44% rette prediksjoner og ≈56% gale prediksjoner.

# Håndteringen av missing gjør resultatet mindre bra. Det ville vært lurere å f.eks erstatte
# missing med median på inntektsvariabelen…

# KOMMENTAR: Flott!

# 10 Her lager jeg et testsett for å vise predikerte sannsynligheter for variabelen steak_prep2
# I predprob ville jeg lagt inn en ligning som regnet ut sannsynligheten for hver
# kategoriene

# Men jeg fikk ikke tid :( 

testset <- tibble(age = 18:90)

testset <- testset%>%
  mutate(
    hhold_income = mean(datasett$hhold_income,na.rm = T),
    smoke = 0,
    alcohol = 1,
    predProbRare =,
    predProbMedium=,
    predProbWell =
  )

# KOMMENTAR: Men det er helt greit!