###Prøve 09.10.2017###

#Oppgave 1#

steak_survey <- read.csv("Kursmappe Høst-2017/Kvantitativ/R-statistikk/steak_survey.csv")

#Oppgave 2#

table(steak_prep)

library(ggplot2)
ggplot(steak_survey,aes(x = steak_prep, fill = steak_prep)) +
  geom_bar()

##Man ser at medium rare er høyest frekvens ut i fra stolpediagrammet.

#Opgpave 3#

library(dplyr)

steak_survey$steak_prep2 <- factor(steak_prep, levels = c("Raw", "Medium", "Well"))


attatch(steak_survey$steak_prep)
steak_survey$steak_prep2[steak_survey$steak_prep >= "Medium"] <- "Well"

steak_survey$steak_prep2[steak_survey$steak_prep == "Medium"] <- "Medium"

steak_survey$steak_prep2[steak_survey$steak_prep <= "Medium"] <- "Raw"

table(steak_survey$steak_prep2)

#== bety er lik
#<= betyr midre eller lik
#>= betyr større eller lik


steak_survey$steak_prep2 <- factor(steak_survey$steak_prep, levels =c("Rare","Medium","Well")
                                   
table(steak_prep2)

##skulle nok ha brukt which

#Oppgave 4#

steak_prep2

#Oppgave 5#
cor(steak_survey[,c("smoke", "alcohol")],
    use = "complete.obs",
    method = "pearson")

# korrelasjonen melllom smoke og alcohol har en veldig svak korelasjon på veriden 0.09890018. 

#Oppgave 6#

library(ggplot2)

ggplot(steak_survey, aes(x=steak_prep2, y=age)) +
  geom_boxplot() +
  theme_minimal()

#Oppgave 7#

library(nnet)

multinomisk_reg <- multinom(steak_prep2 ~ age + smoke + hhold_income + alcohol data = steak_survey,
                            na.action= "na.exclude", Hess = TRUE)

#Oppgave 8#
table(steak_survey$predlang <- steak_survey$pred > 0.05, steak_survey$age)