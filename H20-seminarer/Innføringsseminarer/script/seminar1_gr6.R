# Nå skal vi lage et datasett basert på bli-kjent-runden
# Fremgangsmåten er nærmere beskrevet i .md-dokumentet på github

# Lager vektorer
navn <- c("Henrik", "Tuva", "Truls", "Live", "Richard", "Aurora", "Jenny", "Emilie", "Ranghild", "Torun", "Alissar", "Selina", "Jakob")
alder <- c(24, 24, 23, 24, 23, 23, 23, 26, 22, 24, 22, 23, 24)
bachelor <- c("UIO", "UOE", "UIO", "UIO", "UIO", "UIO", "NTNU", "UIO", "UIO", "UIB", "UIO", "UIO", "UIO")

# Binder vektorene sammen til et datasett
data <- data.frame(navn, alder, bachelor) # Her slår vi de tre vektorene sammen for å lage et datasett

# Vi prøver ut R som kalkulator:
2+2
2-2
4/8
4^2
log(2)
2*2

# vi prøver ut logiske tester: 
2 == 2
1 == 2
1 != 2

"statsvitenskap" == "Statsvitenskap"
"statsvitenskap" == "statsvitenskap"

2 == 2 & 1 == 1
2 == 2 & 1 != 1

2 == 2 | 1 != 1


# Vi installerer pakker
# install.packages("tidyverse") # Fjern hashtag på starten av denne og neste linje!
# install.packages("haven") # legg merke til at vi bruker "" i install.packages(), men ikke i library()
library(tidyverse)


# Vi indekserer
data[navn == "Tuva", ]
data[7, ]

data %>%
  filter(navn == "Tuva") 


data[, "navn"]
data[, 2]

test <- data %>% 
  select(navn, alder)

# Vi sjekker hva slags vektorer vi har med å gjøre
class(data$navn)
class(data$alder)


# Noen funksjoner
summary(data)

mean(data$alder, na.rm = TRUE)
sd(data$alder, na.rm = TRUE)

# Vi laster inn data vi skal bruke i de neste oppgavene 
titanic <- read_csv("https://raw.githubusercontent.com/liserodland/stv4020aR/master/H20-seminarer/Innf%C3%B8ringsseminarer/data/titanic.csv")

# Uten tidyverse
titanic <- read.csv("https://raw.githubusercontent.com/liserodland/stv4020aR/master/H20-seminarer/Innf%C3%B8ringsseminarer/data/titanic.csv", 
                    stringsAsFactors = FALSE)

## OM IKKE GITHUB-LENKEN VIRKER SÅ LAST NED RDATA-VERSJONEN FRA FILER-MAPPEN PÅ CANVAS