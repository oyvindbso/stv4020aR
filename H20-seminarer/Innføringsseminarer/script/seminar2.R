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
table(complete.cases())
table(is.na())

# Oppretter alternativ policy-variabel
# Base R

# Tidyverse (vanlig + sentrert)

# Omkoder klasser (country + gdp_growth)

# Ifelse med periode for å lage tiårsvariabel

## Aggregering


# Oppretter region-variabel

# Group by region og summarise

# Group by region og mutate

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
