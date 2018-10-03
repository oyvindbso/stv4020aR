####  Data  ####
#install.packages("Ecdat")
library(Ecdat)
library(dplyr)
library(ggplot2)
#data <- Caschool
?Caschool
####
## 1) Importer data fra github, og last inn i R (velg mellom csv og RData).
data <- read.csv("https://raw.githubusercontent.com/martigso/stv4020aR/master/Gruppe%201/data/test4020a.csv")
load("test4020a.RData")

#######
## 2) Omkod med ifelse: lag data$compstu.d som en ny variabel
## med de som har compstu under .1 som 0, resten som 1.
## Sjekk om omkodingen fungerte med scatterplot eller table eller på annet vis
## kommenter kontrollen din av omkodingen



data$compstu.d <-  ifelse(data$compstu <.1, 0, 1)

ggplot(data, aes(compstu, compstu.d)) + geom_point()
plot(data$compstu, data$compstu.d) # alternativ til ggplot dersom du skal ha et helt enkelt plot
table(data$compstu, data$compstu.d)

#####
## 3) Lag et nytt datasett, som du kaller la,  
## bestående av observasjoner fra Los Angeles

# 3 måter å gjøre dette på:
# fra dplyr:
la <- data %>% filter(county == "Los Angeles")

la <- subset(data, data$county=="Los Angeles")

la <- data[which(data$county=="Los Angeles"),]

######
## 4) Lag et nytt datasett, cordata, bestående av variablene:
## testscr, compstu, expnstu, mealpct, str og elpct
## Lag også en korrelasjonsmatrise som inneholder disse variablene 
## (du kan gjøre dette selv om du ikke klarte å lage et nytt datasett).

# Alternativ 1
library(dplyr)
cordata <- data %>%
  select(c(testscr, compstu, expnstu, mealpct, str, elpct))

# Alternativ 2
cordata <- data[ ,c("testscr", "compstu", "expnstu", "mealpct", "str", "elpct") ]

cor(cordata, use="complete.obs")

#####
## 5) Lag et scatterplot mellom testscr (y-akse) og elpct (x-akse)

plot(data$elpct, data$testscr)

ggplot(data, aes(x=elpct, y=testscr)) + geom_point()

#####
## 6) Finn mean, sd, skewness og kurtose for data$testscr. Lag et histogram med
## Samme variabel. Det kan være hjelpsomt å bruke en pakke, men det er også mulig
## å regne alt ut for hånd.

library(moments)
mean(data$testscr)
sd(data$testscr)
skewness(data$testscr)
kurtosis(data$testscr)


#####
## 7) Kjør en lineær regresjon med testscr som avh. var, og
## compstu, expnstu, mealpct, str og elpct som uavhengige variabler
## Kjør deretter en ny modell med samspill mellom expnstu og mealpct
## Lagre modellene som objekter.

summary(m1 <- lm(testscr ~ compstu + expnstu + mealpct + str + elpct, data=data))
summary(m2 <- lm(testscr ~ compstu + expnstu*mealpct + str + elpct, data=data))

######
## 8) Vis hvordan du kan lage et histogram med residualene fra modellene
hist(m1$residuals)
hist(m2$residuals)


ggplot(data, aes(x = m1$residuals)) + geom_histogram(bins = 50)
ggplot(data, aes(x = m2$residuals)) + geom_histogram(bins = 50)

######
## 9) Kjør en flernivåanalyse med variabelen testscr som avhengig variabel. 
## den hierarkiske strukturen: de 420 skolene er lokalisert i 45 data$county. 
## Kjør først en modell med bare random intercept, skriv ned varians e.l. standard
## avvik på de to nivåene.
## sett deretter opp en modell med random intercept, samme gruppering og avh.var, og
## med random slope for elpcts, og ellers de samme kontrollvariablene som i modellen over. 

#install.packages("lme4")
library(lme4)


summary(fm1 <- lmer(testscr ~ 1 + (1|county), data=data)) # Kan lese svaret herfra
VarCorr(fm1, comp=c("Variance", "Std.Dev")) # Gir standardavvik og varians på nivå 1 og nivå 2 

summary(fm2 <- lmer(testscr ~ compstu + expnstu + mealpct + str + elpct+ (elpct|county), data= data))
summary(fm2)
#############
## 10) Sammenlign de to modellene fra forrige oppgavene ved hjelp av likelihood
## hvilken modell passer best til data?

anova(fm1, fm2) ## Kan også bruke summary informasjon.


