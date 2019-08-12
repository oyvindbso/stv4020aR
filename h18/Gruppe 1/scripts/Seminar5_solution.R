###################################################
#### Seminar 5: Løsning                        #### 
###################################################

## I en del tilfeller er mange fremgangsmåter mulig,
## Så lenge du får jobben gjort kan du velge metode fritt.

#### Oppgave 1 ####
## Husk å sette working directory!
load("ess.rda")
summary(ess)
str(ess) 
View(ess) ## også mulig å dobbeltklikke på data

#### Oppgave 2 ####
table(ess$country)

## alternativ 1 (dplyr):
install.packages("dplyr")
library(dplyr)

data <- ess %>%
  filter(country=="Germany")

## alternativ 2:
data <- subset(ess, ess$country=="Germany")


#### Oppgave 3: ####
## alternativ 1:
cordata <- data %>%
  select(gender, age, income_decile, trust_police)

## alternativ 2:
cordata <- data[,c("gender", "age", "income_decile", "trust_police")]

## Omkoding:
cordata$gender <- ifelse(cordata$gender=="female", 1, 0)

#### Oppgave 4 ####
cor(cordata, use="pairwise.complete.obs")
cor(cordata, use="complete.obs")

cordata <- subset(cordata, complete.cases(cordata)==T)

cor(cordata)

#### Oppgave 5 ####
library(ggplot2)


cordata$trust_police <- as.numeric(cordata$trust_police)

table(cordata$age, cordata$trust_police)

ggplot(cordata, aes(x=age, y=trust_police)) +
  geom_point()


#### Oppgave 6 ####
ggplot(cordata , aes(x=age, y=trust_police)) +
  geom_point() +
  geom_smooth(method="lm")

#### Oppgave 7 ####
install.packages("moments")
library(moments)

mean(cordata$age)
sd(cordata$age)
skewness(cordata$age)
kurtosis(cordata$age)
hist(cordata$age)

#### Oppgave 8 ####

m1 <- lm(trust_police ~ age + gender + income_decile, data=cordata)
summary(m1)



#### Oppgave 9 ####
str(m1)
names(m1)
m1resid <- m1$residuals

cordata <- cbind(cordata, m1resid)
str(cordata)




ggplot(cordata, aes(x=m1resid, y=trust_police)) + 
  geom_point()

#### Oppgave 10 ####

cordata$trust_police_d <- ifelse(cordata$trust_police<5, 0, 1)  
m2 <- glm(trust_police_d ~ age + gender + income_decile, data=cordata, family=binomial())
summary(m2)
names(m2)

m2$coefficients
## oddsrater:
exp(m2$coefficients)

## Beregning av effekt av gender:
## med predict og newdata:
newdata <- data.frame(age =           mean(cordata$age),
                      income_decile = mean(cordata$income_decile),
                      gender = c(0,1))

predict(m2, newdata = newdata, type="response")

## Med formel:
m2$coefficients

# male:
m <- 1/(1 + exp(-(0.733184547 + 0.003245418*mean(cordata$age) + 0.161126455*mean(cordata$income_decile))))

# female:
f <- 1/(1 + exp(-(0.733184547 + 0.003245418*mean(cordata$age) + 0.021412553  + 0.161126455*mean(cordata$income_decile))))

f-m

### Dersom du ble ferdig, og skal se på effekten av income_decile:
## Ser på effekten for kvinner og de som har median alder
newdata <- newdata <- data.frame(age =           median(cordata$age),
                                 income_decile = 1:10,
                                 gender = 1)
pred_prob_m2 <- predict(m2, newdata = newdata, type="response")

pred_prob_m2 
max(pred_prob_m2) - min(pred_prob_m2) 
# Ser at det er en økning i sannsynlighet for å ha tillit til politiet på tilnærmet
# .18, noe som jeg vil anse som en substansiell effekt.

## Dersom vi derimot vurderer endringen fra 3 til 4 (basert på en hypotese)
pred_prob_m2[4] - pred_prob_m2[3]
## med en endring på 2.4 prosent er det litt mer uklart om effekten er substansiell
## men jeg vil fortsatt påstå at det er en substansiell effekt. Hva synes dere?


