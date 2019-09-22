##########################################
### Løsningsforslag oppgaver seminar 5 ###
##########################################

#### Forberededelser ####
library(tidyverse)

## Oppgave 1

beer <- read_csv("https://raw.githubusercontent.com/langoergen/stv4020aR/master/data/beer.csv")


## Oppgave 2

# Alt 1: se på toppen av hver kolonne
beer 

# Alt 2: 
str(beer)

# Alt 3 
# her bruker jeg lapply-funksjonen, som vi ikke har brukt tid på i seminar,
# Denne lar deg anvende en funksjon på alle variablene i en tibble.
# Sjekk også apply, sapply m.m
lapply(beer, class)

table(beer$state, beer$year) # 1-tall overalt, balanse.
complete(beer) # Ser det skal være 10 + 325 observasjoner - vi har 336, derfor balanse
## Oppgave 3:

ggplot(beer) + geom_point(aes(x = beertax, y = mrall)) +
  geom_smooth(aes(x = beertax, y = mrall), method = "lm") 
# Tegner alltid den bivariate lineære regresjonen mellom x og y når du setter method = "lm"

## Oppgave 4:

# Hopper over å lage eget datasett
beer %>%
  select(year, mrall, beertax, vmiles, unrate, perinc) %>%
  cor(, use = "complete.obs")



cor.test(beer$beertax, beer$mrall) 
# cor.test() har dere ikke lært, oppgaven tester hvor flinke dere er til å finne funksjonene dere trenger på egenhånd 

# Korrelasjonen er er positiv - mer skatt er assossiert med flere trafikkdødsfall. 
# Korrelasjonen er også statistisk signifikant - dette kan du lese fra p-verdien,
# 1.082e-08 betyr sett åtte 0-er foran tallet, er 0.00000001082

## Oppgave 5

beer82 <- beer %>%
  filter(year == 1982)

mean(beer82$mrall)
mean(beer82$beertax)


beer88 <- beer %>%
  filter(year == 1988)

mean(beer88$mrall)
mean(beer88$beertax)

# Annen måte å få frem samme informasjon (men ikke det oppgaven spør om):

beer %>%
  group_by(year) %>%
  summarise(mrall_snitt = mean(mrall),
            beertax_snitt = mean(beertax))

## Oppgave 6: 

m1 <- lm(mrall ~ beertax + vmiles + unrate, data = beer)
summary(m1)

# Den forventede effekten av en enhets økning i beertax er en økning i dødsfall per 10 000 innbygger på
# 0.26

summary(beer$beertax)

# Hvis vi går fra minimumsverdien til beertax til maksimumsverdien til beertax i utvalget, 
# tilsier dette en økinng i forventet antall dødsfall på:
0.26997*(max(beer$beertax) - min(beer$beertax))

# Når vi ser på variasjonen i mrall, må dette kunne sies å være en substansiell effekt å skrive hjem om
summary(beer$mrall)
sd(beer$mrall) # Fint å se på for å vurdere substansiell styrke


## Oppgave 7:

beer$state_fac <- as.factor(beer$state)

ggplot(beer) + geom_boxplot(aes(x = state_fac, y = mrall))

ggplot(beer) + geom_point(aes(x = beertax, y = mrall)) + 
  facet_wrap(~state_fac)

## Oppgave 8

m2 <- lm(mrall ~ beertax + vmiles + unrate + state_fac, data = beer)
summary(m2)

# Effekten av beertax er fortsatt statistisk signifikant, men retningen på effekten er snudd.
# Den forventede effekten av en enhets økning i beertax er nå en forventet reduksjon i dødsfall 
# per 10 000. innbygger på -0.42. Substansiell effekt, se diskusjon over.

# kult?

