
#--------- Oppgave 1)-------------
steak_survey <- read_csv("~/Documents/R-seminar/steak_survey.csv") # Oppretter et objekt for datasettet
View(steak_survey) # Sjekker at datasettet har blitt lastet inn riktig

#--------- Oppgave 2)-------------- 
barplot(table(steak_survey$steak_prep)) # Lager et enkelt barplot
# alternativt litt mer avansert 
library(ggplot2)
ggplot(steak_survey, aes(x = steak_prep, fill = steak_prep)) + 
  geom_bar() + labs(x = "Steak preparation", y = "Frekvens") # Setter egendefinerte navn på x- og y-aksen.
# Verdien "medium rare" har høyest frekvens

#--------- Oppgave 3) --------------
steak_survey$steak_prep2 <- steak_survey$steak_prep # Lager ny variabel 'steak_prep2'

steak_survey$steak_prep[which(steak_survey$steak_prep == "Rare" & steak_survey$steak_prep == "Medium rare")] <- "Rare"
steak_survey$steak_prep[which(steak_survey$steak_prep == "Medium")] <- "Medium"
steak_survey$steak_prep[which(steak_survey$steak_prep == "Medium well" & steak_survey$steak_prep == "Well")] <- "Well"

# Bruker 'which'-funksjonen for å definere at variable på datasettet steak_survey med verdiene "Rare" og "Medium rare" skal
#.. få en samlet verdi lik "Rare". Dette gjør jeg for de andre verdiene også.
# Sjekker i datasettet at det har blitt opprettet en ny kolonne kalt 'steak_prep2' som oppfyller kravene jeg har satt ovenfor.

#--------- Oppgave 4) --------------

steak_prep2 <- factor(steak_survey$steak_prep2) # Jeg omkoder variabelen 'steak_prep2' til faktorer 
table(steak_prep2)
# Fikk error på å sette "medium rare" som referansekateogri, prøver igjen hvis tid


steak_survey$steak_prep2 <- ifelse(steak_survey$steak_prep2 != , "variabel",
                       ifelse(steak_survey$steak_prep2 !=, "variabel", "Medium rare"))
# Har ikke nok tid, men prøver meg på en 'ifelse' steak_prep2 "ikke er lik de andre variablene" skal referanse settes som "Medium rare"





#--------- Oppgave 5)------------------
cor(steak_survey$smoke, steak_survey$alcohol, use = "complete.obs") # Jeg sjekker korrelasjonen mellom de to variablene
# Korrelasjonen er 0.09890018
#--------- Oppgave 6)-------------
library(ggplot2)
ggplot(steak_survey, aes(x = steak_prep2, y = age)) + geom_point() + geom_boxplot() # Lager et boxplot
# Kategorien "Medium" har laves median 

#--------- Oppgave 7) -------------

steak_prep_reg2 <- multinom(steak_prep2 ~ age + hhold_income + smoke + alcohol, 
                      data = steak_survey,
                      useNA = "always", Hess = TRUE)
summary(steak_prep_reg2)


#--------- Oppgave 8) -----------------------
confint(steak_prep_reg2) #sjekker konfidensintervallet som er satt til default på 5%-nivå

#--------- Oppgave 9) ---------------
predict(steak_prep_reg2) # Predikerer verdiene for regresjonen 'steak_prep_reg2'
predict(steak_prep_reg2, type = "probs") # Setter verdiene i ordnet rekkefølge 

#--------- Oppgave 10) ----------------
median(steak_survey$hhold_income, na.rm = TRUE) # Sjekker medianen for variabel 'hhold_income', lik 67889

hhold_income_median <- steak_survey$hhold_income - median(steak_survey$hhold_income, na.rm = TRUE) 
# Lager nytt objekt 'hhold_income_median' hvor verdi 0 er satt til medianen lik 67889
summary(hhold_income_median) # Sjekker at det fungerte 


test_set <- data.frame(steak_survey$age [18:90], hhold_income_median, steak_survey$smoke == 0, steak_survey$alcohole == 1,
                      stringsAsFactors = FALSE)
# Her er utfordringen ar jeg har ulikt antall rader for hver variabel.
