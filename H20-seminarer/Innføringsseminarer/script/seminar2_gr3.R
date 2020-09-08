#####################
##### SEMINAR 2 #####
#####################

# Rydder environment (dvs. gjerner alt som er i environment)
# rm(list = ls()) # Fjern # foran om du vil kjøre denne

# Til dere som sleit med å laste inn direkte fra github, prøv dette (uten #):
# install.packages("RCurl")
# library(RCurl)
# dataurl <- getURL("https://raw.githubusercontent.com/liserodland/stv4020aR/master/H20-seminarer/Innf%C3%B8ringsseminarer/data/aid.csv")
# aid <- read.csv(text = dataurl,
#                 stringsAsFactors = FALSE)

getwd()
setwd("")

# litt om set.wd()
# litt om ?pakkenavn

# Laster inn pakker 

library(tidyverse)
# install.packages("haven")
library(haven)

# Laster inn data
aid <- read_csv("https://raw.githubusercontent.com/liserodland/stv4020aR/master/H20-seminarer/Innf%C3%B8ringsseminarer/data/aid.csv")

# Undersøker datasettet
str(aid) 
aid 
head(aid, 6) 
tail(aid, 4) 
sample_n(aid, 10)

# Finner navn på variabler
names(aid)

# Sjekker missingverdier
table(complete.cases(aid))
table(is.na(aid$gdp_growth))

# Oppretter alternativ policy-variabel
# Base R
aid$policy2 <- aid$economic_open + aid$inflation 

# Tidyverse (vanlig + sentrert)
aid <- aid %>% 
  mutate(policy2 = economic_open + inflation, 
         policy_sent = policy - mean(policy, na.rm = TRUE))


# Omkoder klasser (country + gdp_growth)
aid$gdp_growth_ch <- as.character(aid$gdp_growth) 
mean(aid$gdp_growth_ch, na.rm = TRUE)

# Ifelse med periode for å lage tiårsvariabel

## Aggregering


# Oppretter region-variabel
names(aid)
aid$region <- ifelse(aid$sub_saharan_africa == 1, "Sub Saharan Africa", 
                     ifelse(aid$central_america == 1, "Central America", 
                            ifelse(aid$fast_growing_east_asia == 1, "East Asia", "Other")))

table(aid$region, aid$fast_growing_east_asia, useNA = "always")

# Group by region og summarise
aid <- aid %>% 
  group_by(region) %>% 
  mutate(growth_mean = mean(gdp_growth, na.rm = TRUE))

table(aid$region, aid$growth_mean)

aid_agg <- aid %>% 
  group_by(region) %>% 
  summarise(growth_mean = mean(gdp_growth, na.rm = TRUE))


# Bivariat korrelasjon


# Korrelasjonsmatrise (6:13)

# Tabell

# Prosenttabell

# Tabell med logisk test (gdp_growth og region)

# ggplot2
# installere pakken

# laste inn pakken

# Histogram

# Boxplot

# Linje (med col = country)

# Linje med SSA

# Linje med utvalgte land og %in%

# Spredning


## OLS (m1: aid og gdp_growth)

# m2: multivariat

# m3: samspill

# m4: andregradsledd (I(^2))

# Pene tabeller
# install.packages("stargazer)
library(stargazer)
