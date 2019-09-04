# * For hver oppgave med 4 variabler eller mindre, lag et spredningsplot der du 
#visualiserer alle variablene som nevnes, samt `aid2$elrgdpg` som du setter på y-aksen. 
# Dersom det er mer enn 4 variabler, lag en korrelasjonsmatrise mellom variablene i oppgaven 
# samt `aid2$elrdgpg`. 

# * For hver oppgave, kjør minst to forskjellige regresjonsspesifikasjoner, der den ene er
#lineær, mens den andre inneholder samspill og/eller høyeregradspolynomer/matematiske 
#transformasjoner. Du står også fritt til å forsøke forskjellige omkodinger

#Tips: I tillegg til argumentet `col =`, kan du bruke `shape = `, `alpha =`, m.m. 
#Du kan også bruke `facet_wrap()` med en eller flere variabler (velg variabler med et begrenset
#antall verdier - dersom du vil bruke denne strategien når du bare har kontinuerlige variabler,
#bruk `cut()` til å lage en ny variabel som deler en kontinuerlig var. i kategorier)


# Forberedelser:
library(tidyverse)

# Lagret det modifiserte datasettet med følgende kode: 
#write_csv(aid2, "aid2.csv")

# Kan derfor laste det inn med:
aid2 <- read_csv("aid2.csv")

## Oppgaver:

#1. Variabler: `elraid`, `policy`, `period`. 

# to alternativ:
ggplot(aid2) + geom_point(aes(x = elraid, y = elrgdpg, col = as.factor(period)))
ggplot(aid2) + geom_point(aes(x = period, y = elrgdpg, col = elraid)) 

summary(m1 <- lm(elrgdpg ~ elraid + period, data = aid2))
summary(m2 <- lm(elrgdpg ~ elraid + I(elraid^2) + as.factor(period), data = aid2))
# med andregradsledd, og periode-faste effekter

#2. Variabler: `elraid`, `elrsacw`, `elrbb`, `elrinfl` - Merk at de tre siste variablene ble brukt til å opprette `policy`- variablene.

ggplot(aid2) + geom_point(aes(y = elrgdpg, x = elraid, alpha = elrinfl, col = elrbb, size = elrsacw))
# Hva foregår med land som får ca. 0 i bistand, men som har veldig høy inflasjon?
# Ser ut som om land stort sett har ekstremverdier på åpenhetsindeksen (elrsacw)
# Her kan man lage flere plot

aid2 %>% 
  select(elrgdpg, elraid, elrsacw, elrbb, elrinfl) %>%
  cor(, use = "complete.obs")

summary(m3 <- lm(elrgdpg ~ elraid + elrsacw + elrbb + elrinfl, data = aid2))
summary(m3b <- lm(elrgdpg ~ elraid*elrbb + elrsacw + elrinfl, data = aid2))
summary(m3c <- lm(elrgdpg ~ elraid*elrsacw + elrbb + elrinfl, data = aid2))
summary(m3d <- lm(elrgdpg ~ elraid*elrinfl + elrsacw + elrbb, data = aid2))
# mange samspillsledd

#3. Variabler: `elraid`, `policy`, `region`, `c_years` (eller en ekvivalent variabel som angir antall konfliktår i ett land i en periode).
ggplot(aid2) + geom_point(aes(x = elraid, y = elrgdpg, col = policy, shape = as.factor(c_years))) +
  facet_wrap(~region)

summary(m4 <- lm(elrgdpg ~ elraid + policy + c_years + region, data = aid2))
summary(m4b <- lm(elrgdpg ~ elraid*policy + c_years + region, data = aid2))



#4. Variabler: `elraid`, `period`, `region`, `policy`, `c_years`

aid2 %>% 
  select(elrgdpg, elraid, period, policy, c_years) %>%
  cor(, use = "complete.obs")



summary(m5 <- lm(elrgdpg ~ elraid + policy + c_years + region + period, data = aid2))
summary(m5b <- lm(elrgdpg ~ elraid*policy + c_years + region + as.factor(period), data = aid2))



#5. Variabler: `elraid`, `period`, `region`, `policy`, `c_years`, `elrgdpg` (ta gjerne `log()`), `elricrge`, `elrassas`. 
#Bruk argumentet `use = "complete.obs"` i korrelasjonsmatrisen - dette kaster ut de samme observasjonene som kastes ut 
#av regresjonsanalysen din pga. missing.

aid2 %>% 
  select(elrgdpg, elraid, period, policy, c_years, elrgdp, elricrge, elrassas) %>%
  cor(, use = "complete.obs")



summary(m6 <- lm(elrgdpg ~ elraid + policy + c_years + region + period, data = aid2))
summary(m6b <- lm(elrgdpg ~ elraid*policy + c_years + region + as.factor(period) + 
                    log(elrgdp) + elricrge + elrassas, data = aid2))

