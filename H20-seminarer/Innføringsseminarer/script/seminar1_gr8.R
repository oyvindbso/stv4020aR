# Nå skal vi lage et datasett basert på bli-kjent-runden
# Fremgangsmåten er nærmere beskrevet i .md-dokumentet på github

# Lager vektorer
navn <- c("Rebecca", "Ida", "Nora", "Margrethe", "Tuva", "Sara", "Silje", "Maria", "Åshild", "Silje", "Julie", "Sofie", "Christian", "Christian", "Mohamed")
alder <- c(25, 24, 23, 25, 21, 22, 23, 24, 25, 25, 30, 22, 25, 25, 29)
bachelor <- c("NTNU", "NTNU", "NTNU", "UIO", "UIO", "UIO", "UIO", "UIO", "UIO", "UIS", "NTNU", "UIO", "UIO", "UIO", "UIO")

# Binder vektorene sammen til et datasett
data <- data.frame(navn, alder, bachelor) # Her slår vi de tre vektorene sammen for å lage et datasett

# Vi prøver ut R som kalkulator:
4+4

10/2

2^3

# vi prøver ut logiske tester: 
1 == 2
2 == 2

"statsvitenskap" == "Statsvitenskap"
"statsvitenskap" == "statsvitenskap"

1 <= 2

1 != 2

1 != 2 & 2 == 2

# Vi installerer pakker
# install.packages("tidyverse") # Fjern hashtag på starten av denne og neste linje!
# install.packages("haven") # legg merke til at vi bruker "" i install.packages(), men ikke i library()
library(tidyverse)

# Vi indekserer
data[navn == "Christian",]

data[3, ]

data %>%
  filter(navn == "Christian")


data[, 2]
data[, c("alder", "navn")]

data %>% 
  select(alder, navn)
# Vi sjekker hva slags vektorer vi har med å gjøre
class(data$alder)

mean(data$alder)

class(data$navn)


mean(data$navn)
max(data$alder)
min(data$alder)

summary(data)

# Vi laster inn data vi skal bruke i de neste oppgavene 
titanic <- read_csv("https://raw.githubusercontent.com/liserodland/stv4020aR/master/H20-seminarer/Innf%C3%B8ringsseminarer/data/titanic.csv")

# Uten tidyverse
titanic <- read.csv("https://raw.githubusercontent.com/liserodland/stv4020aR/master/H20-seminarer/Innf%C3%B8ringsseminarer/data/titanic.csv", 
                    stringsAsFactors = FALSE)

## OM IKKE GITHUB-LENKEN VIRKER SÅ LAST NED RDATA-VERSJONEN FRA FILER-MAPPEN PÅ CANVAS