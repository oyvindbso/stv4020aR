# Nå skal vi lage et datasett basert på bli-kjent-runden
# Fremgangsmåten er nærmere beskrevet i .md-dokumentet på github

# Lager vektorer
navn <- c("Thea", "Ole", "Mari")
alder <- c(23, 20, 25)
bachelor <- c("UIO", "UIB", "UIS")

# Binder vektorene sammen til et datasett
data <- data.frame(navn, alder, bachelor) # Her slår vi de tre vektorene sammen for å lage et datasett

# Vi prøver ut regneoperasjoner:


# vi prøver ut logiske tester: 


# Vi installerer pakker
#install.packages("tidyverse") # Fjern hashtag på starten av denne og neste linje!
#install.packages("haven") # legg merke til at vi bruker "" i install.packages(), men ikke i library()
library(tidyverse)


# Vi indekserer


# Vi sjekker hva slags vektorer vi har med å gjøre

install.packages("haven")
install.packages("titanic")
library(titanic)
data.frame(Titanic)
test <- data.frame(titanic_test)
train <- data.frame(titanic_train)

summary(train$Age)

test <- train %>% 
  filter(Age > 70)
table(train$Age, useNA = "always")
table(is.na(train$Age))
?is.na()

max(train[train$Sex == "male",]$Age, na.rm = TRUE) == max(train[train$Sex == "female", ]$Age, na.rm = TRUE)
