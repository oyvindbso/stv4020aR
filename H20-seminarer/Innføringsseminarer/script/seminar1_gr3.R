# Nå skal vi lage et datasett basert på bli-kjent-runden
# Fremgangsmåten er nærmere beskrevet i .md-dokumentet på github

# Lager vektorer
navn <- c("Signe", "Tarjei", "Ingebjørg", "Paal", "Kristine", "Sofie", 
          "Thomas", "Kristian", "Johannes", "Martine", "Bendik", "Andreas",
          "Anders")
alder <- c(22, 27, 22, 25, 26, 25, 24, 25, 28, 25, 23, 25, 24)
bachelor <- c("UIB", "NTNU", "UIO", "UIO", "UIO", "UIB", 
              "UIO", "UIO", "Madrid", "UIO", "Nord", "Nord", "West Virginia")

# Binder vektorene sammen til et datasett
data <- data.frame(navn, alder, bachelor) # Her slår vi de tre vektorene sammen for å lage et datasett

# Vi prøver ut R som kalkulator:
2 + 2
2*5
log(2)

# vi prøver ut logiske tester: 
1 == 2
1 != 2

"statsvitenskap" == "Statsvitenskap"
"statsvitenskap" == "statsvitenskap"

1 <= 2
1 >= 2

1 == 2 & 2 == 2
1 == 2 | 2 == 2

# Vi installerer pakker
install.packages("tidyverse") # Fjern hashtag på starten av denne og neste linje!
#install.packages("haven") # legg merke til at vi bruker "" i install.packages(), men ikke i library()
library(tidyverse)


# Vi indekserer
data[navn == "Paal", ]

data[5, ]

data %>% 
  filter(navn == "Paal")

data[, "navn"]
data[, 2]

data %>% 
  select(navn)

# Vi sjekker hva slags vektorer vi har med å gjøre
summary(data)
summary(data$alder)

class(data$navn)
class(data$alder)

max(data$alder, na.rm = TRUE)
median(data$alder, na.rm = TRUE)
table(data$bachelor)

# Vi laster inn data vi skal bruke i de neste oppgavene 
titanic <- read_csv("https://raw.githubusercontent.com/liserodland/stv4020aR/master/H20-seminarer/Innf%C3%B8ringsseminarer/data/titanic.csv")

# Uten tidyverse
titanic <- read.csv("https://raw.githubusercontent.com/liserodland/stv4020aR/master/H20-seminarer/Innf%C3%B8ringsseminarer/data/titanic.csv", 
                    stringsAsFactors = FALSE)

## OM IKKE GITHUB-LENKEN VIRKER SÅ LAST NED RDATA-VERSJONEN FRA FILER-MAPPEN PÅ CANVAS