# 1. Last inn data "steak_survey.csv"
steak_survey <- read.csv("http://folk.uio.no/martigso/encrypt/steak_survey.csv", stringsAsFactors = FALSE)

# 2. Lag et stolediagram av variabelen steak_prep. Kommenter hvilken verdi på variabelen som har høyest frekvens
library(ggplot2)
ggplot(steak_survey, aes(x = steak_prep)) + geom_bar()

# 3. Lag en ny variabel -- steak_prep2 -- som tar verdien "Rare" når steak_prep er "Rare" eller "Medium rare", "Medium" når steak_prep er "Medium" og "Well når steak_prep er "Medium Well" eller "Well". Sjekk at variabelen ble kodet riktig med en tabell.
steak_survey$steak_prep2 <- NA
steak_survey$steak_prep2[which(steak_survey$steak_prep == "Rare" | steak_survey$steak_prep == "Medium rare")] <- "Rare"
steak_survey$steak_prep2[which(steak_survey$steak_prep == "Medium")] <- "Medium"
steak_survey$steak_prep2[which(steak_survey$steak_prep == "Medium Well" | steak_survey$steak_prep == "Well")] <- "Well"

table(steak_survey$steak_prep, steak_survey$steak_prep2, useNA = "always")


# 4. Gjør om den nye steak_prep2 variabelen til en faktor, og sett kategorien med flest enheter til referansekategori
table(steak_survey$steak_prep2)
steak_survey$steak_prep2 <- factor(steak_survey$steak_prep2, levels = c("Rare", "Medium", "Well"))

# 5. Vis hvordan du finner korrelasjonen mellom variblene smoke og alcohol. Oppgi korrelasjonen i en kommentar.
cor(steak_survey$smoke, steak_survey$alcohol, use = "complete.obs")

# 6. Lag et boxplot med steak_prep2 på x-aksen og age på y-aksen. Hvilken kategori på steak_prep2 har lavest median?
ggplot(na.omit(steak_survey[, c("steak_prep2", "age")]), aes(x = steak_prep2, y = age), na.action = na.omit()) + geom_boxplot(na.rm = TRUE)

# 7. Estimer en multinomisk logistisk regresjon med steak_prep2 som avhengig variabel og age, hhold_income, smoke og alcohol som uavhengige variabler. Husk også å ta vare på informasjon om NA i regresjonen. Tolk begee koeffisientene for smoke substansielt.
library(nnet)

reg <- multinom(steak_prep2 ~ age + hhold_income + factor(smoke) + factor(alcohol), data = steak_survey, na.action = "na.exclude")

# 8. Vis hvordan du sjekker konfidensintervall på 5% nivå for effektene i regresjonen fra oppgave 6
confint(reg)

# 9. Legg inn predikerte _kategorier_ (ikke sannsynligheter) i datasettet fra regresjonen i oppgave 6. Lag en tabell over predikerte (forventede) og faktiske verdier på steak_prep2. Kommenter kort hva tabellen viser.
steak_survey$pred <- predict(reg)
table(steak_survey$pred, steak_survey$steak_prep2, dnn = list("pred", "actual"))


# 10. Lag datasett (test set) der alder går fra 18:90, hhold income er satt til median, smoke er satt til 0 og alcohol er satt til 1. Legg så inn predikerte sannsynligheter (løs regresjonsligningen) fra regresjonen (oppgave 6) i dette datasettet. Lag deretter et plot som har de forventede sannsynlighetene til test settet på y-aksen, alder på x-aksen og fargede linjer for hver av kategoriene på steak prep2.
test_set <- data.frame(age = min(steak_survey$age, na.rm = TRUE):max(steak_survey$age, na.rm = TRUE),
                       hhold_income = median(steak_survey$hhold_income, na.rm = TRUE),
                       smoke = 0,
                       alcohol = 1)


test_set <- cbind(test_set, predict(reg, newdata = test_set, type = "probs"))

ggplot(test_set, aes(x = age)) +
  geom_line(aes(y = Rare, color = "Rare")) +
  geom_line(aes(y = Medium, color = "Medium")) +
  geom_line(aes(y = Well, color = "Well"))

# evt.

library(reshape2)

test_set <- melt(test_set, measure.vars = c("Rare", "Medium", "Well"))
ggplot(test_set, aes(x = age, y = value, color = variable)) + geom_line()
