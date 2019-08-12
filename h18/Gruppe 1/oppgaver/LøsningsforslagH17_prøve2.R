########################################
###### Løsingsforslag Prøve 2 H17  #####
########################################

rm(list=ls())
setwd()
## Laster inn pakker:
library(moments)
library(ggplot2)

### Oppgave 1)
## Laster inn datasett
load("prove2.RData")
#### Oppgave 2) ####
## Sjekker for missing
table(complete.cases(data))
table(is.na(data))

## Hvilke klasse har variabelen bluecol?
class(data$bluecol)

## deskriptiv statistikk for lwage
median(data$lwage)
mean(data$lwage)
sd(data$lwage)
skewness(data$lwage)
kurtosis(data$lwage)

#### Oppgave 3): ####
## lag en ny variabel, bluecol.d, slik at  blue collar har verdien 1, og 
## de som ikke er blue collar har verdien 0.Vis hvordan du kan  sjekke at den
## nye variabelen er omkodet til riktige verdier, og at den nye variabelen er numerisk

## Alternativ 1:
data$bluecol.d <- as.numeric(data$bluecol)
data$bluecol.d <- data$bluecol.d - 1



## Alternativ 2:
data$bluecol.d <- ifelse(data$bluecol=="yes", 1, 0)


table(data$bluecol.d, data$bluecol)
class(data$bluecol.d)

#### Oppgave 4) ####
## histogram for lwage:
hist(data$lwage)

## scatterplot lwage ~ exp
plot(data$ed, data$lwage)

## korrelasjon:
cor(data$ed, data$lwage)



### Oppgave 5:
summary(data$lwage)
summary(data$ed)
summary(lm(lwage ~ ed, data = data))


data2 <- subset(data, data$married=="no")

summary(data2$lwage)
summary(data2$ed)

summary(lm(lwage ~ ed, data= data2))


data3 <- subset(data2, data2$union=="no")
summary(data3$lwage)
summary(data3$ed)
summary(lm(lwage ~ ed, data=data3))


## Kontrollerer at data 3 består av riktig subset
table(data3$union, data3$married)


## Størst økning for dem som er ugift og som ikke får lønnen sin bestemt av fagforening (effekt = 0.11) 
## Lavest økning for dem som er gift og som får lønnen in bestemt av fagforening (effekt = 0.065)
# Effekten for ugifte generelt er 0.09

## Oppgave 6:
data4 <- data[,c("lwage", "ed")]
rm(data4)

## Oppgave 7:
names(data)
class(data$south)
data$south <- as.character(data$south)

summary(m1 <- lm(lwage ~ ed + south + bluecol + married + union + exp + black + wks, data=data))

# b)
data$wage <- exp(data$lwage)
summary(m2 <- lm(wage ~ ed + south + bluecol + married + union + exp + black + wks, data=data))

# c)


## Dersom du jobber i 6 måneder, har du allerede tjent inn kostnadene ved utdanningen:
# Effekten av et års utdanning på månedslønn er 54.6723
54.6723*6 # 328 USD
## Jeg mener derfor det er lønnsomt å ta mer utdanning.

# d)

hist(m1$residuals, breaks=20)
hist(m2$residuals, breaks=20)

kurtosis(m1$residuals)
kurtosis(m2$residuals)

skewness(m1$residuals)
skewness(m2$residuals)

## Modell 1 gir mest normalfordelte residualer. Dette kommer frem av alle testene her:
## histogram, skewness og kurtose.

## Oppgave 8
summary(m3 <- lm(lwage ~ ed*married + ed*union + south + bluecol + married + union + exp + black + wks, data=data))

#nei, et års utdanning ekstra gir ingen sterkere effekt for dem som er gift enn dem som er ugift da estimatet for samspillet er -0,0156

# ugift person uten fagforeningskontrakt:
0.0874629

# gift person med fagforeningskontrakt:
0.0874629 - 0.0156723 -0.0444388 # 0.027

# Differanse:
0.0874629 - (0.0874629 - 0.0156723 -0.0444388) 
# Differansen er 0.0601111

## Oppgave 9:
summary(m4 <- lm(lwage ~ ed + I(ed^2) + south + bluecol + married + union + exp + black + wks, data=data))


# Koeffisienten for ed kvadrert er ikke signifikant, det er derfor ikke grunnlag
# for å si at effekten av ed er ikke-lineær med utgangspunkt i modellen






