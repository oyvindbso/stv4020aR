
#--------- Oppgave 1)-------------
steak_survey <- read_csv("~/Documents/R-seminar/steak_survey.csv") # Oppretter et objekt for datasettet
View(steak_survey) # Sjekker at datasettet har blitt lastet inn riktig

# KOMMENTAR: Flott!

#--------- Oppgave 2)-------------- 
barplot(table(steak_survey$steak_prep)) # Lager et enkelt barplot
# alternativt litt mer avansert 
library(ggplot2)
ggplot(steak_survey, aes(x = steak_prep, fill = steak_prep)) + 
  geom_bar() + labs(x = "Steak preparation", y = "Frekvens") # Setter egendefinerte navn på x- og y-aksen.
# Verdien "medium rare" har høyest frekvens

# KOMMENTAR: Flott! =D
#--------- Oppgave 3) --------------
steak_survey$steak_prep2 <- steak_survey$steak_prep # Lager ny variabel 'steak_prep2'

steak_survey$steak_prep[which(steak_survey$steak_prep == "Rare" & steak_survey$steak_prep == "Medium rare")] <- "Rare"
steak_survey$steak_prep[which(steak_survey$steak_prep == "Medium")] <- "Medium"
steak_survey$steak_prep[which(steak_survey$steak_prep == "Medium well" & steak_survey$steak_prep == "Well")] <- "Well"

# Bruker 'which'-funksjonen for å definere at variable på datasettet steak_survey med verdiene "Rare" og "Medium rare" skal
#.. få en samlet verdi lik "Rare". Dette gjør jeg for de andre verdiene også.
# Sjekker i datasettet at det har blitt opprettet en ny kolonne kalt 'steak_prep2' som oppfyller kravene jeg har satt ovenfor.

# KOMMENTAR: Dette er veldig nære, men litt upresist. Husk at "&" betyr OG (AND), mens "|" betyr ELLER (OR) -- men kan ikke foretrekke både "Rare" OG "Medium rare",
          # Men men man kan foretrekke "Rare" ELLER "Medium rare". Løsning:
steak_survey$steak_prep2 <- steak_survey$steak_prep # Lager ny variabel 'steak_prep2'

steak_survey$steak_prep[which(steak_survey$steak_prep == "Rare" | steak_survey$steak_prep == "Medium rare")] <- "Rare"
steak_survey$steak_prep[which(steak_survey$steak_prep == "Medium")] <- "Medium"
steak_survey$steak_prep[which(steak_survey$steak_prep == "Medium well" | steak_survey$steak_prep == "Well")] <- "Well"

table(steak_survey$steak_prep, steak_survey$steak_prep2)

#--------- Oppgave 4) --------------

steak_prep2 <- factor(steak_survey$steak_prep2) # Jeg omkoder variabelen 'steak_prep2' til faktorer 
table(steak_prep2)
# Fikk error på å sette "medium rare" som referansekateogri, prøver igjen hvis tid


steak_survey$steak_prep2 <- ifelse(steak_survey$steak_prep2 != , "variabel",
                       ifelse(steak_survey$steak_prep2 !=, "variabel", "Medium rare"))
# Har ikke nok tid, men prøver meg på en 'ifelse' steak_prep2 "ikke er lik de andre variablene" skal referanse settes som "Medium rare"

# KOMMENTAR: Du er veldig inne på det. Men det er nok en konsekvens av feilen fra oppgave 3. Løsning (gitt riktig oppgave 3):
steak_survey$steak_prep2 <- factor(steak_survey$steak_prep2, levels = c("Rare", "Medium", "Well"))


#--------- Oppgave 5)------------------
cor(steak_survey$smoke, steak_survey$alcohol, use = "complete.obs") # Jeg sjekker korrelasjonen mellom de to variablene
# Korrelasjonen er 0.09890018

# KOMMENTAR: Flott!

#--------- Oppgave 6)-------------
library(ggplot2)
ggplot(steak_survey, aes(x = steak_prep2, y = age)) + geom_point() + geom_boxplot() # Lager et boxplot
# Kategorien "Medium" har laves median 

# KOMMENTAR: Flott! Men du trenger ikke geom_point() her. Det kan forvirre litt ang uteliggere!

#--------- Oppgave 7) -------------

steak_prep_reg2 <- multinom(steak_prep2 ~ age + hhold_income + smoke + alcohol, 
                      data = steak_survey,
                      useNA = "always", Hess = TRUE)
summary(steak_prep_reg2)

# KOMMENTAR: Flott! Men mangler tolkning

#--------- Oppgave 8) -----------------------
confint(steak_prep_reg2) #sjekker konfidensintervallet som er satt til default på 5%-nivå

# KOMMENTAR: Flott! Men mangler tolkning

#--------- Oppgave 9) ---------------
predict(steak_prep_reg2) # Predikerer verdiene for regresjonen 'steak_prep_reg2'
predict(steak_prep_reg2, type = "probs") # Setter verdiene i ordnet rekkefølge 

# KOMMENTAR: Fint! Men mangler krysstabell med faktiske verdier. Løsning:
steak_survey$pred <- predict(steak_prep_reg2) # Her får du error fordi du ikke har "na.exclude" i regresjonen din.
table(steak_survey$pred, steak_survey$steak_prep2)

#--------- Oppgave 10) ----------------
median(steak_survey$hhold_income, na.rm = TRUE) # Sjekker medianen for variabel 'hhold_income', lik 67889

hhold_income_median <- steak_survey$hhold_income - median(steak_survey$hhold_income, na.rm = TRUE) 
# Lager nytt objekt 'hhold_income_median' hvor verdi 0 er satt til medianen lik 67889
summary(hhold_income_median) # Sjekker at det fungerte 


test_set <- data.frame(steak_survey$age [18:90], hhold_income_median, steak_survey$smoke == 0, steak_survey$alcohole == 1,
                      stringsAsFactors = FALSE)
# Her er utfordringen ar jeg har ulikt antall rader for hver variabel.

# KOMMENTAR: + litt andre utfordinger. Løsning (gitt din løsning fra oppgave 3):
test_set <- data.frame(age = min(steak_survey$age, na.rm = TRUE):max(steak_survey$age, na.rm = TRUE),
                       hhold_income = median(steak_survey$hhold_income, na.rm = TRUE),
                       smoke = 0,
                       alcohol = 1)


test_set <- cbind(test_set, predict(steak_prep_reg2, newdata = test_set, type = "probs"))
names(test_set)
library(reshape2)

test_set <- melt(test_set, measure.vars = c("Medium", "Medium rare", "Medium Well", "Rare", "Well"))
ggplot(test_set, aes(x = age, y = value, color = variable)) + geom_line()
