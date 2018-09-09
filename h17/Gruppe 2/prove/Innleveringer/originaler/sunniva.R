### R-prøve ## SUNNIVA HUSTAD ### 

#' OPPGAVE 1

dir()

steak1 <- read.csv("steak_survey.csv", stringsAsFactors = FALSE)

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

## OPPGAVE 3


table(steak1$steak_prep3)
steak1$steak_prep2<-NA

table(steak1$steak_prep)

steak1$steak_prep3[which(steak1$steak_prep == "Rare" | steak1$steak_prep == "Medium rare")] <- "Rare"
steak1$steak_prep3[which(steak1$steak_prep == "Medium" )] <- "Medium"
steak1$steak_prep3[which(steak1$steak_prep == "Medium Well" | steak1$steak_prep == "Well")] <- "Well"

table(steak1$steak_prep3)

## På grunn  av en feil heter variabelen steak_prep3


## Oppgave 4

steak1$steak_prep3 <- factor(steak1$steak_prep2, levels = c("Rare", "Medium", "Well"))

table(steak1$steak_prep3)

## "Rare" er satt til referansekategori

## Oppgave 5

cor(steak1$smoke, steak1$alcohol, use = "complete.obs")

## Korrelasjonen er 0.098 i dette tilfelle

## Oppgave 6

boxplot(steak1$age~steak1$steak_prep3)


## .
boxplot(steak1$age~steak1$steak_prep3)

## Det ser ut som om Medium og Well har like lav median.

## Oppgave 7

library(nnet)

log_steak <- multinom(steak_prep3 ~ age + hhold_income + smoke + alcohol,
                  data = steak1, na.action="na.exclude", Hess =TRUE)


summary(log_steak)

## Retningen til smoke vil si at den er positiv, for å kunne tolke den videre må man ta antilogaritmen av den

## Oppgave 8

## Kjører konfidensintervall

vcov(log_steak)

sqrt(diag(vcov(log_steak)))

## Oppgave 9 

steak1$pred <- predict(log_steak, newdata = steak1, type = "probs")
summary(log_steak)

plot(steak1$pred)


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