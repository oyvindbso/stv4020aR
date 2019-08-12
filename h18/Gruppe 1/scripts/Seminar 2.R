#### Regresjonsoppgaver til seminar 2 ####

#### Forberedelser ####

##  Sett working directory, last ned data fra github, og lagre i wd.

setwd("")

load("Seminar2.RData")

## Laster inn pakker

library(stargazer)
library(ggplot2)
library(ggthemes)

#### Oppgave 2.1 ####
reg1 <- lm(tillit~skala10, data=tillit)
summary(reg1)

nobs(reg1)

stargazer(reg1, type="text") # Viser all output du trenger til denne oppgaven

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
summary(reg3b)
stargazer(reg3, reg3b, type="text")
#### Oppgave 2.9 ####
save(tillit, 
     file = "Seminar2_ed.RData")

names(tillit)
summary(tillit$skala10)
## Lager datasett som bare har observasjoner brukt i reg3b:
reg3b_data <- tillit %>% 
  select(c("skala10", "utd3" , "tillit"))
reg3b_data <- reg3b_data %>%
  filter(complete.cases(reg3b_data)==T)
### Løsning tilleggsopgave

data_for_prediction <- data.frame(skala10   = rep(seq(min(reg3b_data$skala10),
                                                 max(reg3b_data$skala10), .1),3),
                                  utd3      = as.factor(c(rep(1, 91), rep(2, 91), rep(3, 91))))


## Trinn 3: Lager nytt datasett med predikerte verdier for avhengig variabel, og standardfeil:
predicted_data <- predict(reg3b, newdata = data_for_prediction, 
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

