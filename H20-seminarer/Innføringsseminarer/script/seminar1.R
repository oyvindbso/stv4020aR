# Nå skal vi lage et datasett basert på bli-kjent-runden
# Fremgangsmåten er nærmere beskrevet i .md-dokumentet på github

# Lager vektorer
navn <- c("Thea", "Ole", "Mari")
alder <- c(23, 20, 25)
bachelor <- c("UIO", "UIB", "UIS")

# Binder vektorene sammen til et datasett
data <- data.frame(navn, alder, bachelor) # Her slår vi de tre vektorene sammen for å lage et datasett

# Vi prøver ut R som kalkulator:


# vi prøver ut logiske tester: 


# Vi installerer pakker
#install.packages("tidyverse") # Fjern hashtag på starten av denne og neste linje!
#install.packages("haven") # legg merke til at vi bruker "" i install.packages(), men ikke i library()
library(tidyverse)


# Vi indekserer


# Vi sjekker hva slags vektorer vi har med å gjøre


# Vi laster inn data vi skal bruke i de neste oppgavene 
titanic <- read_csv("https://raw.githubusercontent.com/liserodland/stv4020aR/master/H20-seminarer/Innf%C3%B8ringsseminarer/data/titanic.csv")
