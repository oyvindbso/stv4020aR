###Oppgave 1###
survey <- read.csv ("http://folk.uio.no/martigso/encrypt/steak_survey.csv")
# KOMMENTAR: Flott!

###Oppgave 2###
plot(survey$steak_prep) ### Medium rare har høyest verdi

# KOMMENTAR: Flott!

###Oppgave 3####
survey$steak_prep2 <- survey$steak_prep
table(survey$steak_prep2)
survey$steak_prep2[which(survey$steak_prep2 == "Medium rare")] <- "Rare"
survey$steak_prep2[which(survey$steak_prep2 == "Medium Well")] <- "Well"
table(survey$steak_prep2)

# KOMMENTAR: Flott! Men husk å kryssabuler med den gamle variabelen:
table(survey$steak_prep2, survey$steak_prep)

####Oppgave 4#####
survey$steak_prep2 <- factor(survey$steak_prep2, levels = c("Rare", "Medium", "Well"))

# Flott!

###Oppgave 5####
cor.test(survey$smoke, survey$alcohol) ###Korrelasjonen er 0,0989

# KOMMENTAR: Flott!

###Oppgave 6####
library("ggplot2") 
 
ggplot(survey, aes( x= steak_prep2, y = age)) + 
  geom_boxplot()
###Medium har lavest median, da medianen er merket med den vannrette streken i boksen###

# KOMMENTAR: Flott!

###Oppgave 7####
library(nnet)

survey_multinom <- multinom(steak_prep2 ~ age + hhold_income + smoke + alcohol, data = survey, na.action = "na.omit", Hess = TRUE)
summary(survey_multinom)

### De som foretrekker biffen medium done, har -0,006 logit lavere sannsynlighet for å røyke enn de som liker biffen rare. 
### De som foretrekker biffen well done, har -0,0007 logit lavere sannynlighet for å røyke enn de som liker biffen rare. 


# KOMMENTAR: Flott! Men tolkningen har feil kausalretning: "De som røyker, har -0,006 logit lavere sannsynlighet for å foretrekker biffen medium done enn de som liker biffen rare..."
  # Og hvor kommer -0.006 logiten fra? Hos meg er den -0.16...

###Oppgave 8 ####
confint(survey_multinom)
###Effekten av age er ikke signifikant, da intervallet inneholder 0. Ser også at 1,96*SE > b 

# KOMMENTAR: Flott!

###Oppgave 9###
survey$pred <- predict(survey_multinom, type = "response") #Vet ikke hva som kommer etter type =, da "response" er den jeg har benyttet før. 

survey$pred_multinom <- ifelse(survey_multinom > 0.5, 1, 0) #Vet ikke hvordan denne funksjonen fungerer for multinom. Oppsett for binomisk logistisk reg. 
table(survey$pred_multinom, survey$steak_prep2) #Funker ikke, men det er slik man ville satt opp tabell. 

# KOMMENTAR: Det er veldig nære. Du kan bare bruke default ("class"):
survey$pred <- predict(survey_multinom) # KOMMENTAR: Men du har tatt na.omit og ikke na.exclude i regresjonen, og da er det ikke mulig å legge inn de predikerte verdiene


###Oppgave 10###
survey$age2 <- survey$age - 18.90 # Oppretter age2 hvor age = 18.90 er satt til 0.

test_sett <- data.frame(pred_multinom, 
                        age2, 
                        hhold.income = median(survey$hhold_income, na.rm = TRUE), #setter hhold.income til median.
                        smoke = 0,
                        alcohol = 1)

###Plot forhindres av følgefeil, forsøker likevel på script: 
ggplot(test_sett, aes(x = age2, y = pred_multinom, color = variable))
+ geom_line()
+ theme_minimal()
+ scale_color_manual(valeus = c("red", "blue", "yellow4"))
+ labs( x = "Alder", y = "Forventet verdi på Y", color = "steak_prep2")

# KOMMENTAR: Dette ble ikke helt riktig. Det skulle være:
test_set <- data.frame(age = min(survey$age, na.rm = TRUE):max(survey$age, na.rm = TRUE),
                       hhold_income = median(survey$hhold_income, na.rm = TRUE),
                       smoke = 0,
                       alcohol = 1)


test_set <- cbind(test_set, predict(survey_multinom, newdata = test_set, type = "probs"))

ggplot(test_set, aes(x = age)) +
  geom_line(aes(y = Rare, color = "Rare")) +
  geom_line(aes(y = Medium, color = "Medium")) +
  geom_line(aes(y = Well, color = "Well"))

# evt.

library(reshape2)

test_set <- melt(test_set, measure.vars = c("Rare", "Medium", "Well"))
ggplot(test_set, aes(x = age, y = value, color = variable)) + geom_line()
