#### Regresjonsoppgaver til seminar 2 ####
load("https://github.com/martigso/stv4020aR/raw/master/Gruppe%201/data/Seminar2.RData")

#### Forberedelser ####
## Laster inn pakker
library(stargazer)
library(ggplot2)
library(ggthemes)

#### Oppgave 2.1 ####
reg1 <- lm(tillit~skala10, data=tillit)
summary(reg1)

nobs(reg1)

stargazer(reg1, type="text") # Viser all ourput du trenger til denne oppgaven

#### Oppgave 2.2 ####
plot(tillit$skala10, tillit$tillit)
abline(reg1, col="red")

ggplot(tillit, aes(x = skala10, y = tillit)) +
  geom_point() +
  geom_smooth(method="lm") +
  theme_bw()


#### Oppgave 2.3 ####
reg2 <- lm(tillit~skala10+utdanning, data=tillit)
summary(reg2)


#### Oppgave 2.4 ####
mean(tillit$skala10, na.rm=TRUE)
sd(tillit$skala10, na.rm=TRUE)


#### Oppgave 2.5 ####
tillit$sosstat.ms <- scale(tillit$skala10, center=TRUE, scale=FALSE)
summary(tillit$sosstat.ms)

sd(tillit$sosstat.ms, na.rm=TRUE)


#### Oppgave 2.6 ####

#1. Definerer ny variabel: tillit$utd3
#2. Når utdanning har verdi 1 skal den nye variabelen også ha verdi 1
#3. Når utdanning er større enn 1, men mindre enn 5 skal den nye variabelen ha verdi 2
#4. Når utdanning er større enn 4 skal den nye variabelen ha verdi 3
#5. Resten defineres som missing (NA)
attributes(tillit$utdanning)

tillit$utd3 <- ifelse(tillit$utdanning==1, 1, NA)
tillit$utd3 <- ifelse(tillit$utdanning>1 & tillit$utdanning<5, 2, tillit$utd3)
tillit$utd3 <- ifelse(tillit$utdanning>=5, 3, tillit$utd3)

# alt i en kode
tillit$utd3 <- ifelse(tillit$utdanning==1, 1,
                      ifelse(tillit$utdanning>1 & tillit$utdanning<5, 2,
                             ifelse(tillit$utdanning>=5, 3, NA)))

table(tillit$utd3, tillit$utdanning)


str(tillit)
#### Oppgave 2.7 ####
tillit$samspill.status.vgs <- tillit$skala10*ifelse(tillit$utd3 == 2, 1, 0)
tillit$samspill.status.uni <- tillit$skala10*ifelse(tillit$utd3 == 3, 1, 0)

#### Oppgave 2.8 ####
reg3 <- lm(tillit~skala10+as.factor(utd3)+samspill.status.vgs+samspill.status.uni,data=tillit)
summary(reg3)

## Alternativt: lag en faktor basert på utd3, og kjør sampill mellom denne og skala 10:
reg3b <- lm(tillit ~ skala10+as.factor(utd3)*skala10, data=tillit)

stargazer(reg3, reg3b, type="text")
#### Oppgave 2.9 ####
save(tillit, 
     file = "Seminar2_ed.RData")



### Her kommer løsning til tilleggsoppgaven i morgenn