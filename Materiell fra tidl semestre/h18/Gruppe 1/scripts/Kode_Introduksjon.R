"Hello world!"

1+1    # addisjon
2-3    # subtraksjon
4/2    # divisjon
2*2    # multiplikasjon
2^3    # potens
exp(2) # eksponentiering
log(2) # logaritme (default er naturlig logaritme)
2*(4-2)/(4-2) # parentesregler fungerer som i vanlig algebra: den innerste parentesen regnes ut først

# kommentarere i R skrives forøvrig etter #

1==2 # tester om 1 er lik 2
2==2 # tester om 2 er lik 2
"Statsvitenskap"=="statsvitenskap" # Logiske tester kan også brukes på tekst
"statsvitenskap"=="statsvitenskap" # R er imidlertid sensitivt til store og små bokstaver.
1<=2  # tester om 1 er mindre enn eller lik 2
1>=2  # tester om 1 er større eller lik 2  
1!=2  # tester om 1 er ulik 2
1==2 | 1==1 # tester om en av de to påstandene 1 er lik 2 eller 1 er lik 1 er sanne
1==2 & 1==1 # tester om begge de to påstandene 1 er lik 2 og 1 er lik 1 er sanne.

x <- 3     # lager objektet x
y <- 6     # lager objektet y
z <- x + y # man kan lage objekter fra andre objekter

# Vi kan også gi andre navn til objekter:
gull   <- 3
solv   <- 1
bronse <- 1
medaljer <- gull + solv + bronse

medaljer

## Ved å bruke parenteser rundt denne koden oppretter jeg objektet samtidig som jeg printer innholdet i objektet i console.
(x <- 1:5)          # med : teller vi på heltall mellom de to tallene


z <- c(1,2,"tre","fire",5)

x*y 
x+y
x*2


class(x)
class(y)
class(z)
class(list(1:5))


class(as.character(x))
class(as.list(y))
class(as.numeric(z))
as.numeric(z)
class(unlist(list(1:5)))

karaktersnitt <- as.factor(c(6,5,4))
karaktersnitt
as.numeric(karaktersnitt)

test_data <- data.frame(x = c(rep(1,5), rep(0,5)), y = seq(2, 20 ,2), z = rnorm(10), w = "tekst", q = c(1,2))

beer <- read.csv("https://raw.githubusercontent.com/martigso/stv4020aR/master/Gruppe%201/data/beer.csv")

class(beer)    # Er dette faktisk en data.frame, eller et annet type objekt?
colnames(beer) # denne funksjonen forteller deg kolonnenavn i datasettet.
head(beer, 5)  # denne funksjonen viser deg de første observasjonene i datasettet.
tail(beer, 5)  # denne funksjonen viser deg de siste observasjonene i datasettet.
str(beer)      # denne funksjonen beskriver strukturen til et objekt.


y[4]               # Tallet i '[]', her 4, refererer til 4. element i objektet, ikke tallet 4.
z[3:4]             # Vi kan bruke : til å velge flere elementer
y[c(1,2,3,4)]      # Vi kan også bruke c() til å velge flere elementer
y[which(y>=3)]     # which() er en funksjon vi kan bruke til å sette logiske tester inn i [], dette kan være svært nyttig, særlig i store datasett, for å se på observasjoner med spesielle kombinasjoner av variabelverdier


x==y # Vi kan bruke == til å sammenligne verdiene i to vektorer som er like lange
y <- y[c(1,2,4,3,5)]
x==y # Vi ser at y nå er endret, slik at alle verdiene i x og y er like


beer$mrall
beer$mrall[5]

beer$mrall_cent <- beer$mrall - mean(beer$mrall) # sentrert versjon av variabelen
str(beer)


dim(beer) # my_data har 32 rows (observasjoner) og 11 columns (variabler).
beer[, 3]
beer[1,]
beer[, 3][15]
head(beer[,c(1,3,4)])


#install.packages("dplyr") # Denne trenger du bare kjøre dersom dplyr ikke er installert allerede
library(dplyr) # denne må du kjøre hver gang

# Man kan spesifisere datasett på egen linje før man bruker select og filter - gir ryddig kode
beer %>%                     # i dplyr brukes %>% til å binde sammen linjer med kode
  filter(mrall >3)           # samme filtrering som over, alle variabler

beer %>%        
  select(mrall, beertax) %>% # her velger jeg to variabler med select 
  filter(mrall >3)


(a <- list(a1 = list(1, 2), a2 = c(3, 4)))
str(a)

a$a1[1]
a[[1]][2]


mean(beer$mrall, na.rm = TRUE)   # gjennomsnitt
# Jeg fjerner missing med na.rm = TRUE, fungerer for de fleste funksjonene under.
median(beer$mrall) # median
min(beer$mrall)    # minimumsverdi
max(beer$mrall)    # maksimumsverdi
summary(beer$mrall)# alt over + 1. og 3. kvartil
summary(beer)      # kan også brukes på hele datasettet 
sd(beer$mrall)     # standardavvik
var(beer$mrall)    # varians
#install.packages("moments") # kjør dersom du ikke har pakken installert på pcen
library(moments)   # laster inn pakke med funksjonene under
skewness(beer$mrall) # skjevhet
kurtosis(beer$mrall) # kurtose
table(beer$jaild)    # lager frekvenstabell - fin for ikke numeriske variabler
prop.table(table(beer$jaild)) # lag proposjoner av frekvenstabell med prop.table, se ?prop.table for detaljer


beer$mrall - mean(beer$mrall) # kan vi skrive en funksjon for sentreringen vi gjør her?

center <- function(min_data_var){   # denne linjen definerer input i funksjonen, den skal alltid ha samme form
  
  centered <- min_data_var - mean(min_data_var, na.rm = T)  # denne linjen/innmat angir hva som skal gjøres med input
  
  return(centered) # denne linjen angir hvilken output vi vil har, det er andre funksjoner som kan stå på denne linjen i stedet
}

center(beer$mrall)==(beer$mrall - mean(beer$mrall))


apply(beer[,c(3:5, 8:10 )], MARGIN =  2, FUN =  center) 
# arg 1: velger et par numeriske variabler fra datasett, siden center ikke virker på factor
# arg 2: angir om operasjonen skal utføres på rader (1) eller kolonner (2), 
# arg 3: angir funksjonen som skal anvendes


#install.packages("ggplot2") # Kjør dersom ggplot2 ikke er installert
library(ggplot2)


ggplot(beer, aes(mrall)) + geom_histogram(bins = 50)
(y <- c(1,2,4,gull,5)) # med c() kan vi kombinere ulike tall/informasjon i den rekkefølgen vi vil. Vi kan også kombinere verdier fra objekter som "gull"

ggplot(beer, aes(x = beertax, y = mrall, col = jaild)) + geom_point()

ggplot(beer, aes(x = beertax, y = mrall)) + geom_point() + geom_smooth(method = "lm")

ggplot(beer, aes(x = beertax, y = mrall, col = jaild)) + geom_point() + facet_wrap(~year)


m1 <- lm(mrall ~ beertax + jaild, data = beer)
summary(m1