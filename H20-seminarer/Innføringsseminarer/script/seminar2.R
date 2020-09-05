#####################
##### SEMINAR 2 #####
#####################

# Laster inn pakker 
library(tidyverse)
library(haven)

# Laster inn data
aid <-  read_dta("../../data/aid.dta")

# Undersøker datasettet
str(aid) 
aid 
head(aid, 10) 
tail(aid, 10) 
sample_n(aid, 10)

# Finner navn på variabler
names(aid)

# Sjekker missingverdier
table(complete.cases())
table(is.na())

# Oppretter alternativ policy-variabel
# Base R

# Tidyverse (vanlig + sentrert)


# Omkoderklasser (country + gdp_growth)


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