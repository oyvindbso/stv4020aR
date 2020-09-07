##############################################
##### SEMINAR 2 LØSNINGSFORSLAG OPPGAVER #####
##############################################

# OPPGAVE 1
# vi trenger ingen pakker for å laste inn .RData
load("H20-seminarer/Innføringsseminarer/data/aid.RData")

# bruker read_csv funksjonen fra tidyverse for å laste inn .csv filen
library(tidyverse)
aid_csv <- read_csv("H20-seminarer/Innføringsseminarer/data/aid.csv")

# vi trenger haven-pakken for å laste inn .dta (stata) og .sav (spss) filer
#install.packages("haven")
library(haven)
aid_dta <- read_dta("H20-seminarer/Innføringsseminarer/data/aid.dta")
aid_sav <- read_sav("H20-seminarer/Innføringsseminarer/data/aid.sav")

# Fjerner tre av datasettene - det holder jo med ett
rm(aid_csv, aid_dta, aid_sav)


# OPPGAVE 2
# Kjører en OLS og lagrer som objekt ved navn m1
m1 <- lm(data = aid, 
         gdp_growth ~ gdp_pr_capita + ethnic_frac*assasinations + 
           institutional_quality + m2_gdp_lagged + sub_saharan_africa + 
           fast_growing_east_asia + policy*aid, 
         na.action = "na.exclude")
summary(m1)


# OPPGAVE 3
# Lager den logtransformerte variabelen 
# med base R
aid$log_gdp_pr_capita <- log(aid$gdp_pr_capita)

# Sjekker om det blir flere missing
table(is.na(aid$gdp_pr_capita), is.na(aid$log_gdp_pr_capita), useNA = "always")
# Ser fint ut 

# Gjør periode om til en faktor
# med base R
aid$period_fac <- as.factor(aid$period)

# Sjekker resultatet med en tabell
table(aid$period, aid$period_fac, useNA = "always")

# Lager region variabel
aid$region <- ifelse(aid$fast_growing_east_asia == 1, "East Asia", 
                     ifelse(aid$sub_saharan_africa == 1, "Sub-Saharan Africa", "Other"))

# Sjekker resultatet med en tabell
table(aid$region, aid$sub_saharan_africa, useNA = "always")

# Setter "other" til referansekategori 
# OBS! her overskriver jeg variabelen min
aid$region <- factor(aid$region, levels = c("Other", "Sub-Saharan Africa", "East Asia"))

# Gjør "alt i ett" med tidyverse
aid <- aid %>% 
  mutate(log_gdp_pr_capita = log(gdp_pr_capita),
         period_fac = as.factor(period),
         region = ifelse(fast_growing_east_asia == 1, "East Asia",
                         ifelse(sub_saharan_africa == 1, "Sub-Saharan Africa", "Other")),
         region = factor(region, levels = c("Other", "Sub-Saharan Africa", "East Asia")))


# OPPGAVE 4
m2 <- lm(data = aid, 
         gdp_growth ~ log_gdp_pr_capita + ethnic_frac*assasinations + 
           institutional_quality + m2_gdp_lagged + region + policy*aid +
           period_fac, 
         na.action = "na.exclude")
summary(m2)


# OPPGAVE 5
# Laster inn stargazerpakken for fine tabelle
library(stargazer)
stargazer(m1, m2, type = "text")

# For latex
stargazer(m1, m2, type = "latex")

# For word e.l.
stargazer(m1, m2, type = "html",
          out = "H20-seminarer/Innføringsseminarer/bilder/seminar2_regtabell.htm")
# Bruk Open with -> word for å åpne tabellen i word


# OPPGAVE 6 
# Laster inn ggplot2 for å lage plot
# install.packages("ggplo2")
library(ggplot2)

ggplot(aid) + # Sier at jeg vil bruke aid-data
  geom_point(aes(x = gdp_pr_capita, y = log_gdp_pr_capita))

# Økningen i log_gdp_per_capita er større om BNP øker fra 0 til 1500 enn fra 
# 6000 til 7500