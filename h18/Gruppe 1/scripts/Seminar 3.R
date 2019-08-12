#### Seminar 3 ####

#### Forberedelser ####

##  Sett working directory, last ned data fra github, og lagre i wd.

setwd("")

load("Seminar2.RData")

## Laster inn pakker

library(stargazer)
library(ggplot2)
library(ggthemes)
library(moments)

##### Første time #####


#### Oppgave 1 ####
#install.packages("moments")
library(moments)

mean(tillit$skala10, na.rm = T)
sd(tillit$skala10, na.rm = TRUE)
skewness(tillit$skala10, na.rm = T)
kurtosis(tillit$skala10, na.rm = T)

#### Oppgave 2 ####

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

?lm
str(tillit)
#### Oppgave 3 ####

## lag en faktor basert på utd3, og kjør sampill mellom denne og skala 10:
reg3 <- lm(tillit ~ skala10 + as.factor(utd3) + as.factor(utd3)*skala10,
           data=tillit)
summary(reg3)

# kjapt histogram:
hist(tillit$tillit)

# Med ggplot:
ggplot(tillit, aes(x = tillit)) +  geom_histogram()

#### Oppgave 4 #####
## HVa skjer dersom vi sentrerer skala10 og kjører samme modell?
tillit$sosstat.ms <- scale(tillit$skala10, center=TRUE, scale=FALSE)

reg3b <- lm(tillit ~ sosstat.ms+as.factor(utd3)*sosstat.ms, data=tillit)

stargazer(reg3, reg3b, type="text")

#### Oppgave 5 ####
names(tillit)
summary(tillit$skala10)
## Lager datasett som bare har observasjoner brukt i reg3 og reg3b:
library(dplyr)
reg3b_data <- tillit %>% 
  select(c("skala10", "utd3" , "tillit"))
reg3b_data <- reg3b_data %>%
  filter(complete.cases(reg3b_data)==T)
### Løsning tilleggsopgave

data_for_prediction <- data.frame(skala10   = rep(seq(min(reg3b_data$skala10),
                                                      max(reg3b_data$skala10), .1),3),
                                  utd3      = as.factor(c(rep(1, 91), rep(2, 91), rep(3, 91))))


## Trinn 3: Lager nytt datasett med predikerte verdier for avhengig variabel, og standardfeil:
predicted_data <- predict(reg3, newdata = data_for_prediction, 
                          se=TRUE)

## Trinn 4: Kombinerer data fra trinn 2 og 3: 
plot_data <- cbind(predicted_data, data_for_prediction)

## Trinn 5: Kalkulerer konfidensintervall med standardfeil fra trinn 3 og legger til plot_data fra trinn 4. Her lager jeg 95% CI med vanlige standardfeil
plot_data$low  <- plot_data$fit - 1.96*plot_data$se
plot_data$high <- plot_data$fit + 1.96*plot_data$se

## Trinn 6: Plot
p <- ggplot(reg3b_data, aes(x = skala10, y = tillit)) +
  geom_rangeframe() +
  ggtitle("Tillit")  + 
  theme_tufte() + 
  scale_x_continuous(breaks = extended_range_breaks()(reg3b_data$skala10)) +
  scale_y_continuous(breaks = extended_range_breaks()(reg3b_data$tillit)) +
  ylab("Tillit") +
  xlab("Sosial status") + 
  geom_point() +
  geom_ribbon(data=plot_data, aes(y=fit, ymin=low, ymax=high, fill=utd3), alpha=.2) +
  geom_line(data=plot_data, aes(y=fit, colour=utd3))
p
stargazer(reg3, reg3b, type="text")

mean(tillit$skala10,na.rm=T)
summary(tillit$tillit)



#### Andre time ####
#### Oppgave 1 ####
tillit$rtillit2 <- ifelse(tillit$rtillit <= 3.4,
                          0,
                          1)
#### Oppgave 2 ####
table(tillit$rtillit, 
      tillit$rtillit2)


#### Oppgave 3 ####
#install.packages("dplyr")
library(dplyr)

cordata <- tillit %>%
  select(rtillit, skala10, rsosstat, utd3, tillit, rtillit, rtillit2)

cor(cordata, use="pairwise.complete.obs")


#### Oppgave 4 ####

binomisk <- glm(rtillit2 ~ 
                  as.factor(utd3) + 
                  skala10, 
                data = tillit, 
                family = binomial(link = "logit"), 
                na.action = "na.exclude")

summary(binomisk)
names(binomisk)
exp(binomisk$coefficients)
tillit$predikert.sannsynlighet <-  predict(binomisk, type = "response")
summary(tillit$predikert.sannsynlighet)

hist(tillit$skala10)

####Oppgave 5 #####
data_for_prediction <- data.frame(skala10   = rep(seq(min(reg3b_data$skala10),
                                                      max(reg3b_data$skala10), .1),3),
                                  utd3      = as.factor(c(rep(1, 91), rep(2, 91), rep(3, 91))))


## Trinn 3: Lager nytt datasett med predikerte verdier for avhengig variabel, og standardfeil:
predicted_data <- predict(binomisk, newdata = data_for_prediction, 
                          type = "response", se = TRUE)

## Trinn 4: Kombinerer data fra trinn 2 og 3: 
plot_data <- cbind(predicted_data, data_for_prediction)

## Trinn 5: Kalkulerer konfidensintervall med standardfeil fra trinn 3 og legger til plot_data fra trinn 4. Her lager jeg 95% CI med vanlige standardfeil
std <- qnorm(0.95 / 2 + 0.5)

plot_data$low <- plot_data$fit - 1.96 * plot_data$se
plot_data$high <- plot_data$fit + 1.96 * plot_data$se
 

## Trinn 6: Plot
p <- ggplot(tillit, aes(x = skala10, y = rtillit2)) +
  geom_rangeframe() +
  ggtitle("Tillit")  + 
  theme_tufte() + 
  ylab("Tillit") +
  xlab("Sosial status") + 
  geom_point() +
  geom_ribbon(data=plot_data, aes(y=fit, ymin=low, ymax=high, fill=utd3), alpha=.2) +
  geom_line(data=plot_data, aes(y=fit, colour=utd3))
p
