#####################
##### SEMINAR 2 #####
#####################

# Rydder environment (dvs. gjerner alt som er i environment)
# rm(list = ls()) # Fjern # foran om du vil kjøre denne

# rm(dataurl)
# rm(list = ls())

# Til dere som sleit med å laste inn direkte fra github, prøv dette (uten #):
# install.packages("RCurl")
# library(RCurl)
# dataurl <- getURL("https://raw.githubusercontent.com/liserodland/stv4020aR/master/H20-seminarer/Innf%C3%B8ringsseminarer/data/aid.csv")
# aid <- read.csv(text = dataurl,
#                 stringsAsFactors = FALSE)
# rm(dataurl)

# litt om set.wd()
# litt om ?pakkenavn

# Laster inn pakker 
library(tidyverse)
library(haven)

# Laster inn data
aid <-  read_csv("H20-seminarer/Innføringsseminarer/data/aid.csv")

# Undersøker datasettet
str(aid) 
aid 
head(aid, 10) 
tail(aid, 10) 
sample_n(aid, 10)

# Finner navn på variabler
names(aid)

# Sjekker missingverdier
table(complete.cases(aid))
table(is.na(aid$gdp_growth))

# Oppretter alternativ policy-variabel
# Base R
aid$policy2 <- aid$inflation + aid$economic_open

table(is.na(aid$policy2), is.na(aid$inflation))

# Tidyverse (vanlig + sentrert)
aid <- aid %>% 
  mutate(policy2 = inflation + economic_open,
         policy_sent = policy - mean(policy, na.rm = TRUE))

# Omkoder klasser (country + gdp_growth)
class(aid$country)
class(aid$gdp_growth)
aid$gdp_growth_char <- as.character(aid$gdp_growth)
mean(aid$gdp_growth_char, na.rm = TRUE)

# Ifelse med periode for å lage tiårsvariabel
aid <- aid %>% 
  mutate(decade = ifelse(periodstart < 1980, "70s", 
                         ifelse(periodstart > 1980 & periodstart < 1990, "80s", "90s")))

table(aid$periodstart, aid$decade, useNA = "always")
## Aggregering


# Oppretter region-variabel
names(aid)
aid <- aid %>% 
  mutate(region = ifelse(sub_saharan_africa  == 1, "Sub Saharan Africa", 
                         ifelse(central_america == 1, "Central America",
                                ifelse(fast_growing_east_asia == 1, "East Asia", "Other"))))

table(aid$region, aid$sub_saharan_africa, useNA = "always")

# Group by region og summarise
region_snitt <- aid %>% 
  group_by(region) %>% 
  mutate(mean = mean(gdp_growth, na.rm = TRUE)) %>% 
  ungroup()

table(region_snitt$mean, region_snitt$region, useNA = "always")

# Group by region og mutate
region_snitt <- aid %>% 
  group_by(region) %>% 
  summarise(mean = mean(gdp_growth, na.rm = TRUE))


# Bivariat korrelasjon
cor(aid$gdp_growth, aid$aid, use = "pairwise")

# Korrelasjonsmatrise (6:13)

# Tabell

# Prosenttabell
prop.table(table(aid$region))

# Tabell med logisk test (gdp_growth og region)

# ggplot2
# installere pakken
# install.packages("ggplot2")
library(ggplot2)

# laste inn pakken

# Histogram
ggplot(aid) + 
  geom_histogram(aes(x = gdp_growth))

# Boxplot
ggplot(aid) +
  geom_boxplot(aes(x = factor(region), y = aid)) +
  theme_classic()


# Linje (med col = country)
ggplot(aid) +
  geom_line(aes(x = period, y = gdp_growth, col = country))

# Linje med SSA

# Linje med utvalgte land og %in%

# Spredning


## OLS (m1: aid og gdp_growth)

m1 <- lm(data = aid, 
         gdp_growth ~ aid, 
         na.action = "na.exclude") 

summary(m1)
# m2: multivariat

m2 <- lm(data = aid, 
         gdp_growth ~ aid + policy + assasinations, 
         na.action = "na.exclude") 


summary(m2)
# m3: samspill
m3 <- lm(data = aid, 
         gdp_growth ~ aid + policy*assasinations, 
         na.action = "na.exclude") 


summary(m3)


# m4: andregradsledd (I(^2))
m4 <- lm(data = aid, 
         gdp_growth ~ aid + policy + assasinations + I(assasinations^2), 
         na.action = "na.exclude") 


# Pene tabeller
# install.packages("stargazer)
library(stargazer)

stargazer(m1,m2,m3,m4, type = "text")
