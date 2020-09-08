##############################################
##### LØSNINGSFORSLAG OPPGAVER SEMINAR 1 #####
##############################################

# Laster først inn data
library(tidyverse)
titanic <- read_csv("https://raw.githubusercontent.com/liserodland/stv4020aR/master/H20-seminarer/Innf%C3%B8ringsseminarer/data/titanic.csv")

## OPPGAVE 1
titanic

## OPPGAVE 2
# Variablenes klasse står under variabelnavnene (chr = character, dbl = en numerisk klasse)
# Vi kan også bruke class()

class(titanic$PassengerId)

## OPPGAVE 3
# Datasettet har 891 observasjoner. Det kan vi lese under beskrivelse under Environment
# Vi kan også se på antall rader når vi kjører koden titanic


## OPPGAVE 4
table(titanic$Sex, useNA = "always")
# Det var flest kvinner. Vi tar med argumentet "useNA = "always"" så vi også for informasjon om eventuelle missingverdier 

## OPPGAVE 5
mean(titanic[titanic$Sex == "male", ]$Age, na.rm = TRUE) # Finner gjennomsnittsaldere til menn ved hjelp av indeksering

## OPPGAVE 6
# Lager en logisk test med større eller lik (>=)
max(titanic[titanic$Sex == "male", ]$Age, na.rm = TRUE) >= max(titanic[titanic$Sex == "female", ]$Age, na.rm = TRUE)

## OPPGAVE 7
# Dette kan vi gjøre på to måter
# Med tidyverse
over70 <- titanic %>% 
  filter(Age > 70)

# Med indeksering
over70_2 <- titanic[titanic$Age > 70, ]  # Her fikk vi også med alle de vi ikke vet alderen på
over70_2 <- titanic[titanic$Age > 70 & !is.na(titanic$Age), ] # Derfor må vi si at vi ønsker de observasjonene som er over 70 OG (&) som ikke har missing

## OPPGAVE 8
?is.na()
# is.na() er en logisk test som forteller oss om en observasjon har missing (TRUE) eller ikke (FALSE) (på en fastsatt variabel)
# Den er nyttig å kombinere med andre funksjoner

## OPPGAVE 9
table(is.na(titanic$Age))

## OPPGAVE 10
titanic_q <- titanic %>% # Sier at vi vil jobbe med datasettet titatnic
  filter(Embarked == "Q")  # Her er det viktig å huske hermetegn fordi Embarked er en character variabel

## OPPGAVE 11
titanic$age_above_mean <- ifelse(titanic$Age >= mean(titanic$Age, na.rm = TRUE), 1, 0)

## OPPGAVE 12
titanic$age_squared <- titanic$Age^2

## OPPGAVE 13
m1 <- lm(Survived ~ Pclass + Sex + Age, 
         data = titanic, na.action = "na.exclude")
summary(m1)
