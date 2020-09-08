#####################
##### SEMINAR 2 #####
#####################

# Rydder environment (dvs. gjerner alt som er i environment)
# rm(list = ls()) # Fjern # foran om du vil kjøre denne
# rm(aid)
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
#install.packages("haven")
library(haven)

# Laster inn data
aid <-  read_dta("H20-seminarer/Innføringsseminarer/data/aid.dta")
#read_sav

# Undersøker datasettet
str(aid) 
aid 
head(aid, 2) 
tail(aid, 4) 
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
         policy_sent =  policy - mean(policy, na.rm = TRUE))

# Omkoder klasser (country + gdp_growth)
class(aid$gdp_growth)

aid$gdp_growth_ch <- as.character(aid$gdp_growth)

mean(aid$gdp_growth_ch, na.rm = TRUE)

# Ifelse med periode for å lage tiårsvariabel

## Aggregering


# Oppretter region-variabel
aid$region <- ifelse(aid$fast_growing_east_asia == 1, "East Asia",
                     ifelse(aid$sub_saharan_africa == 1, "Sub Saharan Africa", 
                            ifelse(aid$central_america == 1, "Central America", 
                                   "Other"))) 


table(aid$region, aid$fast_growing_east_asia, useNA = "always")

# Group by region og summarise
aid <- aid %>% 
  group_by(region) %>%
  mutate(gjsnitt = mean(gdp_growth, na.rm = TRUE))

table(aid$region, aid$gjsnitt, useNA = "always")

# Group by region og mutate
aid_region <- aid %>% 
  group_by(region) %>%
  summarise(gjsnitt = mean(gdp_growth, na.rm = TRUE))


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
