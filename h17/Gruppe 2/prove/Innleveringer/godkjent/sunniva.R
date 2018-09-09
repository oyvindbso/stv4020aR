### R-prøve ## SUNNIVA HUSTAD ### 

#' OPPGAVE 1

dir()

steak1 <- read.csv("steak_survey.csv", stringsAsFactors = FALSE)

# KOMMENTAR: Flott!

#' OPPGAVE 2 
#' 
variable.names(steak1)

table(steak1$steak_prep, useNA = "always")

steak1$steak_prep_num <-as.numeric(steak1$steak_prep)

### Verdien medium rare har høyest frekvens

table(steak1$steak_prep_num)

hist(steak1$steak_prep, na.rm=TRUE)


library(ggplot2)

ggplot(steak1, aes(x=steak_prep, y =smoke))+ geom_smooth(method = "lm")

# KOMMENTAR: Her var det litt rotete. Du har funnet den største kategorien, så helt ok. Men stolpediagram:
ggplot(steak1, aes(x=steak_prep))+ geom_bar() 


## OPPGAVE 3


table(steak1$steak_prep3)
steak1$steak_prep2<-NA

table(steak1$steak_prep)

steak1$steak_prep3[which(steak1$steak_prep == "Rare" | steak1$steak_prep == "Medium rare")] <- "Rare"
steak1$steak_prep3[which(steak1$steak_prep == "Medium" )] <- "Medium"
steak1$steak_prep3[which(steak1$steak_prep == "Medium Well" | steak1$steak_prep == "Well")] <- "Well"

table(steak1$steak_prep3)

## På grunn  av en feil heter variabelen steak_prep3

# KOMMENTAR: Det blir ikke helt riktig når jeg kjører skriptet. Det er også veldig rotete her. Men kodebitene i seg selv er veldig nær. Løsning:
steak1$steak_prep3 <- NA
steak1$steak_prep3[which(steak1$steak_prep == "Rare" | steak1$steak_prep == "Medium rare")] <- "Rare"
steak1$steak_prep3[which(steak1$steak_prep == "Medium" )] <- "Medium"
steak1$steak_prep3[which(steak1$steak_prep == "Medium Well" | steak1$steak_prep == "Well")] <- "Well"


## Oppgave 4

steak1$steak_prep3 <- factor(steak1$steak_prep2, levels = c("Rare", "Medium", "Well"))

table(steak1$steak_prep3)

## "Rare" er satt til referansekategori

# KOMMENTAR: Riktig kode, men feil utgangspunkt fordi oppgave 3 ikke lager variabelen riktig.

## Oppgave 5

cor(steak1$smoke, steak1$alcohol, use = "complete.obs")
## Korrelasjonen er 0.098 i dette tilfelle

# KOMMENTAR: Flott!

## Oppgave 6

boxplot(steak1$age~steak1$steak_prep3)


## .
boxplot(steak1$age~steak1$steak_prep3)

## Det ser ut som om Medium og Well har like lav median.

# KOMMENTAR: Flott! Men hvorfor har du skrevet det to ganger?

## Oppgave 7

library(nnet)

log_steak <- multinom(steak_prep3 ~ age + hhold_income + smoke + alcohol,
                  data = steak1, na.action="na.exclude", Hess =TRUE)


summary(log_steak)

## Retningen til smoke vil si at den er positiv, for å kunne tolke den videre må man ta antilogaritmen av den

# KOMMENTAR: Flott! Men tolkningen er feil! Du har nok sett på standardfeilene her?

## Oppgave 8

## Kjører konfidensintervall

vcov(log_steak)

sqrt(diag(vcov(log_steak)))

# KOMMENTAR: Hehe. Dette er standardfeil -- ikke konfidensintervall:
confint(log_steak)

## Oppgave 9 

steak1$pred <- predict(log_steak, newdata = steak1, type = "probs")
summary(log_steak)

plot(steak1$pred)

# KOMMENTAR: Dette er heller ikke helt riktig. Løsning:
steak1$pred <- predict(log_steak)
table(steak1$pred, steak1$steak_prep3)

## Oppgave 10 

test_set<- data.frame(age=18:90,
                      hhold_income=median(steak1$hhold_income,na.rm = TRUE),
                      smoke=0,
                      alchol=1,
                      steak_prep3=pred)


ggplot(test_set, aes(x = steak_prep3, y = value, color = variable)) +  geom_line() +  theme_minimal() + 
  scale_color_manual(values = c("darkred", "darkblue", "blue")) + 
 labs(x = "Alder", y = "Forventet verdi på Y", color = "Parti") 

## Fikk ikk helt til å laste det nye datasettet, men slik, ville det sett ut.

# KOMMENTAR: Det ble ikke helt riktig dette heller, og jeg får error med skriptet ditt. Løsning (gitt din regresjon):
test_set <- data.frame(age = min(steak_survey$age, na.rm = TRUE):max(steak_survey$age, na.rm = TRUE),
                       hhold_income = median(steak_survey$hhold_income, na.rm = TRUE),
                       smoke = 0,
                       alcohol = 1)


test_set <- cbind(test_set, predict(log_steak, newdata = test_set, type = "probs"))

ggplot(test_set, aes(x = age)) +
  geom_line(aes(y = Rare, color = "Rare")) +
  geom_line(aes(y = Medium, color = "Medium")) +
  geom_line(aes(y = Well, color = "Well"))

# evt.

library(reshape2)

test_set <- melt(test_set, measure.vars = c("Rare", "Medium", "Well"))
ggplot(test_set, aes(x = age, y = value, color = variable)) + geom_line()
