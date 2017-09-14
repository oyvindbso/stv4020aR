#' ---
#' title: "Seminar 3"
#' author: "Martin Søyland"
#' output:
#'   pdf_document: default
#'   html_document: html_notebook
#' header-includes: \usepackage{setspace}\onehalfspacing
#' urlcolor: cyan
#' ---
#' 
## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, tidy.opts = list(width.cutoff = 80), tidy = FALSE)
knitr::opts_knit$set(root.dir = "../")

#' 
#' # Disposisjon
#' 1. Laste inn data #advanced
#' 2. Omkoding #intermediate
#' 3. Subsetting av data
#' 4. OLS Samspill
#' 5. Plotte predikerte effekter
#' 
#' 
#' # Laste inn data
#' 
#' Så langt i seminarene har vi gjort det veldig enkelt ved å laste inn data fra helt standard .csv-filer. Det finnes, dessverre, en haug med andre filtyper. La oss laste ned et datasett i mange forskjellige format fra http://folk.uio.no/martigso/stv4020/aiddata.zip
#' 
#' Her ligger data fra [Burnside & Dollar (2000)](http://www.jstor.org/stable/117311?seq=1#page_scan_tab_contents) i STATA- (.dta), SPSS- (.sav) og to versjoner av R-format (.rda / .RData). Pakk ut disse i mappen du vil jobbe fra, og la oss starte med det siste:
#' 
#' ### R-data
## ----lasteRdata----------------------------------------------------------
load("./data/aidgrowth/aidgrowth.rda")

head(aid, 3)

rm(aid) # rm() fjerner objektet fra Environment


#' 
#' 
#' ### SPSS-data
## ----lasteSPSS-----------------------------------------------------------
#install.packages("haven")

library(haven)

aid <- read_sav("./data/aidgrowth/aidgrowth.sav")
head(aid, 3)

rm(aid)

#' 
#' ### STATA-data
## ----lasteSTATA----------------------------------------------------------
#install.packages("haven")
# library(haven)

aid <- read_dta("./data/aidgrowth/aidgrowth.dta")
head(aid, 3)


#' 
#' # Kort introduksjon til subsetting av data
#' 
#' Noen ganger vil vi fjerne enheter fra datasettene våre. Det kan være vi kun vil se på trender innad i et land, sammenligne spesifikke grupper, fjerne enheter som skaper systematisk missing, og så videre. Under viser jeg to måter dette kan gjøres på -- det finnes mange flere.
#' 
## ----subsetEks, tidy=FALSE-----------------------------------------------
aid$country == "ARG"
which(aid$country == "ARG")
aid[which(aid$country == "ARG"), ]


argentina <- aid[which(aid$country == "ARG"), ]
rm(argentina)

argentina <- subset(aid, country == "ARG")





#######
nomiss_policy <- aid[which(is.na(aid$policy) == FALSE), ]
nomiss_policy <- subset(aid, is.na(policy) == FALSE)

# "&" Betyr AND, "|" betyr OR
nomiss_policy_growth <- aid[which(is.na(aid$gdp_growth) == FALSE & is.na(aid$policy) == FALSE), ]
nomiss_policy_growth <- subset(aid, is.na(gdp_growth) == FALSE | is.na(policy) == FALSE)

rm(argentina, nomiss_policy, nomiss_policy_growth)

#' 
#' 
#' 
#' # Replikasjon uten å gjøre noe
#' 
#' La oss kjapt kjøre alle variablene fra modell 5 i artikkelen inn i en regresjon og se om vi får samme resultat. Da bare putter vi inn variablene fra artikkelen i en `lm()`.
#' 
## ----initialOLS, tidy=FALSE----------------------------------------------

model5 <- lm(gdp_growth ~ gdp_pr_capita + ethnic_frac * assasinations + 
               institutional_quality + m2_gdp_lagged + 
               sub_saharan_africa + fast_growing_east_asia + policy * aid,
             data = aid)
summary(model5)







#' 
#' Hvis vi sammenligner disse resultatene med resultatene i artikkelen ser vi kjapt at vi ikke har klart å replisere resultatene. Da må vi tilbake og lese teksten i artikkelen. Jeg har juksa og lest den på forhånd. Så jeg kan avsløre at det er noe som mangler her:
#' 
#' 1. Gdp pr capita skal log-transformeres
#' 2. De har kontrollert for periode, men ikke rapportert det
#' 3. Område-dummiene er ikke satt til riktig målenivå
#' 4. De viser ikke konstantledd; alltid vis konstantledd
#' 5. (De bruker også "heteroskedasticity-consistent standard errors")
#' 
#' # Omkoding
#' 
#' ### Logging av variabler
#' 
#' I artikkelen blir gdp per capit log-transformert. Derfor må vi også gjøre det for å klare å replisere resultatene. Det er også lurt å ta vare på den gamle variabelen ved å gi den nye et nytt navn. Her `gdp_pr_capita_log`.
## ----logGdp--------------------------------------------------------------

aid$gdp_pr_capita_log <- log(aid$gdp_pr_capita)

library(ggplot2)

ggplot(aid, aes(x = gdp_pr_capita, y = gdp_pr_capita_log)) + geom_point()


#' 
#' Her ser vi veldig tydelig hva som skjer når vi logger en variabel; en økning på 1 er viktigere for lave tall enn for høye tall. Kort sagt betyr dette at vi mener det er viktigere å gå fra å være veldig fattig til litt mindre fattig, enn å gå fra å være veldig rik til enda rikere.
#' 
#' 1. ~~Gdp pr capita skal log-transformeres~~
#' 2. De har kontrollert for periode, men ikke rapportert det
#' 3. Område-dummiene er ikke satt til riktig målenivå
#' 4. ~~De viser ikke konstantledd; alltid vis konstantledd~~
#' 5. (De bruker også "heteroskedasticity-consistent standard errors")
#' 
#' ### Omkode dummies til èn variabel
#' 
#' Mest for å vise litt forskjellige måter å kode på, fikser vi også dummysettet fra artikkelen inn i èn variabel. Dette kan gjøres på en million måter, men jeg skal vise to. Den første utnytter indeksering. Den andre bruker en snarvei, via funksjonen `ifelse()`.
#' 
## ----whichIllustrasjon, tidy=FALSE, eval=FALSE---------------------------
## # Illustrasjon på which():
## aid$country[which(aid$sub_saharan_africa == 0 & aid$fast_growing_east_asia == 1)]
## which(aid$sub_saharan_africa == 0 & aid$fast_growing_east_asia == 1)
## aid$sub_saharan_africa == 0 & aid$fast_growing_east_asia == 1

#' 
## ----whichOmkoding, tidy=TRUE--------------------------------------------
aid$regions <- NA
aid$regions[which(aid$sub_saharan_africa == 0 & aid$fast_growing_east_asia == 0)] <- "Other"
aid$regions[which(aid$sub_saharan_africa == 1)] <- "Sub-Saharan Africa"
aid$regions[which(aid$fast_growing_east_asia == 1)] <- "East Asia"

table(aid$regions, aid$sub_saharan_africa)
table(aid$regions, aid$fast_growing_east_asia)

#' 
#' I den neste funksjonen bruker vi **nesting** med `ifelse()` for å gjøre akkurat det samme. Dette viser at de to variablene er helt identiske. Vi sjekker at det blir riktig, og setter kategorien "Other" til referansekategori med funksjonen `factor()`.
#' 
#' 
## ----ifelseOmkoding, tidy=FALSE------------------------------------------
# ?ifelse()

aid$regions2 <- ifelse(aid$sub_saharan_africa == 1, "Sub-Saharan Africa",
                       ifelse(aid$fast_growing_east_asia == 1, "East Asia", "Other"))

table(aid$regions, aid$regions2)
#######
aid$regions <- factor(aid$regions, levels = c("Other", "Sub-Saharan Africa", "East Asia"))
table(aid$regions)

#' 
#' 1. ~~Gdp pr capita skal log-transformeres~~
#' 2. De har kontrollert for periode, men ikke rapportert det
#' 3. ~~Område-dummiene er ikke satt til riktig målenivå~~
#' 4. ~~De viser ikke konstantledd; alltid vis konstantledd~~
#' 5. (De bruker også "heteroskedasticity-consistent standard errors")
#' 
#' # Korrekt modell
#' 
#' Nå er vi faktisk klar til å kjøre regresjonen! Legg merke til at vi har satt inn `factor(period)` direkte i regresjonen
## ----fixedOLS, tidy=FALSE------------------------------------------------

model5 <- lm(gdp_growth ~ gdp_pr_capita_log + ethnic_frac * assasinations +
               institutional_quality + m2_gdp_lagged + regions + policy * aid +
               factor(period),
             data = aid, na.action = "na.exclude")
results <- summary(model5)
results

# "Heteroskedasticity-consistent standard errors"
library(sandwich)

results$coefficients[, "Std. Error"] <- sqrt(diag(vcovHC(model5, type = "HC")))
results$cov.unscaled <- vcovHC(model5, type = "HC")
round(results$coefficients[, c("Estimate", "Std. Error")], digits = 2)


#' 
#' 1. ~~Gdp pr capita skal log-transformeres~~
#' 2. ~~De har kontrollert for periode, men ikke rapportert det~~
#' 3. ~~Område-dummiene er ikke satt til riktig målenivå~~
#' 4. ~~De viser ikke konstantledd; alltid vis konstantledd~~
#' 5. ~~(De bruker også "heteroskedasticity-consistent standard errors")~~
#' 
#' 
#' # Plot av forventede verdier (og restledd)
#' 
#' For å evaluere hvor bra modellen er, må vi gjøre flere ting. Koden `plot(modell5)` vil vise mange forskjellige model-fit plot. Nedefor lager jeg ett av disse manuelt: restledd mot forventede verdier.
#' 
## ----predPlot1-----------------------------------------------------------
theme_set(theme_bw())

aid$pred <- predict(model5)
aid$restledd <- resid(model5)

ggplot(aid, aes(x = restledd, y = pred)) + geom_point() +
  geom_smooth(method = "lm") +
  labs(x = "Restledd", y = "Forventet Y")


#' 
#' Ser dette bra ut?
#' 
#' # Bonus!
#' Samspillsledd er vanskelige å tolke fra en regresjonstabell. Jeg foretrekker å plotte effektene. Her er et eksempel på hvordan dette kan gjøres. Det er mye som skjer her, så ha tunga rett i munnen når dere prøver dere på dette.
#' 
## ----predPlot2,tidy=FALSE------------------------------------------------
snitt_data <- data.frame(gdp_pr_capita_log = mean(aid$gdp_pr_capita_log, na.rm = TRUE),
                         ethnic_frac = mean(aid$ethnic_frac, na.rm = TRUE),
                         assasinations = mean(aid$assasinations, na.rm = TRUE),
                         institutional_quality = mean(aid$institutional_quality, na.rm = TRUE),
                         m2_gdp_lagged = mean(aid$m2_gdp_lagged, na.rm = TRUE),
                         regions = "Other",
                         policy = c(rep(-4, 9), rep(4, 9)),
                         aid = rep(0:8, 2),
                         period = median(aid$period, na.rm = TRUE))

predict(model5, newdata = snitt_data, se = TRUE)

snitt_data <- cbind(snitt_data, predict(model5, newdata = snitt_data,
                                        se = TRUE, interval = "confidence"))

ggplot(snitt_data, aes(x = aid, y = fit.fit, 
                       group = factor(policy), 
                       color = factor(policy), 
                       fill = factor(policy))) +
  geom_line() +
  scale_y_continuous(breaks = seq(-12, 12, 2)) +
  geom_ribbon(aes(ymin = fit.lwr, ymax = fit.upr, color = NULL), alpha = .2) +
  labs(x = "Bistandsnivå", y = "Forventet GDP vekst", color = "Policy", fill = "Policy")

#' 
## ----ikketenkpådenne, eval=FALSE, echo=FALSE-----------------------------
## knitr::purl("./docs/seminar3.Rmd", output = "./scripts/3seminar.R", documentation = 2)
## 

