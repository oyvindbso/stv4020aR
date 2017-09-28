##########################################
#### Seminar 5: Hint til  oppgaver første time #### 
##########################################

## I en del tilfeller er mange fremgangsmåter mulig,
## Så lenge du får jobben gjort kan du velge metode fritt.


#### Oppgave 1 ####
## Husk å sette working directory!
load()
summary()
str() 
View() ## også mulig å dobbeltklikke på data

#### Oppgave 2 ####
table()

## alternativ 1 (dplyr):
install.packages("dplyr")
library(dplyr)

data <- ess %>%
  filter()

## alternativ 2:
data <- subset(, )


#### Oppgave 3: ####
## alternativ 1:
cordata <- data %>%
  select()

## alternativ 2:
cordata <- data[,]

## Omkoding:
cordata$gender <- ifelse("logical condition", "yes", "no")

#### Oppgave 4 ####
cor(, use=)
cor(, use=)

?complete.cases
cordata <- subset(, complete.cases()==T)

cor(cordata)

#### Oppgave 5 ####
install.packages("ggplot2")
library(ggplot2)


as.numeric()

table()

ggplot(, aes()) +
  geom_point()


#### Oppgave 6 ####
ggplot( , aes() +
  geom_point() +
  geom_smooth(method=)

#### Oppgave 7 ####
install.packages()
library()

mean()
sd()
skewness()
kurtosis()
hist()

#### Oppgave 8 ####

m1 <- lm( ~ , data=)
summary()



#### Oppgave 9 ####
str()
names()
m1resid <- 

?cbind()
cbind()
str(cordata)




ggplot(, aes()) + 
  geom_point()

#### Oppgave 10 ####

cordata$trust_police_d <- ifelse()  
m2 <- glm( ~ , data=, family=)
summary(m2)
names(m2)

## oddsrater:
m2$
exp()

## Beregning av effekt av gender:
## med predict og newdata:
newdata <- data.frame(age =           ,
                      income_decile = ,
                      gender = )

predict(, newdata = , type=)

## Med formel:
m2$coefficients

# male:
m <- 1/(1 + exp(-()))

# female:
f <- 1/(1 + exp(-()))

## effekt
f-m
