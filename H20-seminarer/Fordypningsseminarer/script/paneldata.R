###########################################
### FORDYPNINGSSEMINAR 1: PANELDATA I R ###
###########################################

### Hvordan opprette prosjekt

### Laster inn nødvendige pakker
# Husk å kjør install.packages("pakkenavn") først om det er første gang du bruker pakken
library(haven) # For å kunne lese inn .dta-filer
library(tidyverse) # For å kunne bruke ggplot, dplyr og liknende
library(stargazer) # For å kunne lage pene tabeller
library(plm) # For å kjøre paneldatamodeller
library(sandwich) # For å justere standardfeil

### Laster inn data 
data <- read_dta("H20-seminarer/Fordypningsseminarer/data/neumayer_spess_2005.dta")

### Undersøker data nærmere: 
head(data)
tail(data)

### Viser panelstruktur

### Gjør om til plm-objekt
# Dette kan unngås ved å spesifisere index i plm-modellene
data.plm <- pdata.frame(data, index = c("country", "year"))

class(data.plm)

head(attr(data.plm, "index"))


### Sjekker om data er balansert
is.pbalanced(data.plm)
# Tilsynelatende balansert - men hva med missing? 

# Lager et datasett uten missingverdier: 
data.complete <- data.plm %>% 
  na.omit() %>% 
  mutate(year = droplevels(year), 
         country = droplevels(country)) # Her fjerner jeg faktornivåene (levels) til de årene og landene som ikke lengre er med i datasettet

# Sjekker om det nye datasettet som blir lagt til grunn for analysen er balansert
is.pbalanced(data.complete)
# Ikke balansert lengre.. 

### Balanserer data
data.balanced.time <- make.pbalanced(data.complete, balance.type = "shared.times") # Beholder bare de enhetene vi har data for alle tidsperiode for
# Dette datasettet inneholder 0 observasjoner fordi vi ikke har data for alle tidsperioder for noen enheter

data.balanced.ind <- make.pbalanced(data.complete, balance.type = "shared.individuals") %>%  # Beholder bare de tidsperiodene vi har data for alle enhetene for
  mutate(year = droplevels(year),                               
         country = droplevels(country)) # Her fjerner jeg faktornivåene (levels) til de årene og landene som ikke lengre er med i datasettet

# Finner antall tidsperioder i opprinnelig datasett uten missing
length(unique(data.complete$country))
length(unique(data.balanced.ind$country))

length(unique(data.complete$year))
length(unique(data.balanced.ind$year))

# Går videre med data.complete, fjerner tidligere elementer
rm(data.balanced.ind, data.balanced.time)

### POOLED OLS 
# I plm får vi en vanlig OLS-modell om vi velger model = "pooling". 
mod1ols <- plm(data = data.complete, 
               fdi_inflow ~ bits + ln_gdp_pr_cap + ln_population +
                 economic_growth + inflation + resource_rent + 
                 bilateral_trade_agreements + wto_member + polcon3,
               na.action = "na.exclude", model = "pooling")

# Beregner PCSE:
bkse <- round(sqrt(diag(vcovBK(mod1ols, cluster = "group"))), digits = 4)

# Beregner HC1 standardfeil
hc3se <- round(sqrt(diag(vcovHC(mod1ols, type = "HC3"))), digits = 4)

# Printer resultatene i en tabell
stargazer(mod1ols, mod1ols, mod1ols, type = "text",
          column.labels = c("Med PCSE", "Med HC3 SE", "Med vanlige SE"),
          se = list(bkse, hc3se))
# Med argumentet se = list(bkse) forteller jeg stargazer at jeg i den første kolonnen
# vil erstatte de opprinnelige standardfeilene med de panelkorrigerte standardfeilene
# jeg regnet ut over. 


### Restleddsutfordringer med OLS
## Kjører durbin watson test for AR(1) seriekorrelasjon på modellobjektet
pdwtest(mod1ols)

## Panel-spesifikk heterogenitet
# Henter ut predikerte verdier
ols.predict <- predict(mod1ols)

# Legger predikerte verdier og residualer inn i datasettet
data.complete <- data.complete %>% 
  mutate(resid = resid(mod1ols),
         resid_lag = lag(resid),
         fdi_inflow_pred = ols.predict)

# Eye ball test av heteroskedastisitet
ggplot(data.complete %>% 
         filter(country %in% c("Norway", "Ethiopia", "Chile", "Estonia",
                               "Chad", "Switzerland", "Spain")),
       aes(x = fdi_inflow_pred, y = resid)) +         # Velger noen land som jeg plotter for å ikke få et helt uoversiktelig plot
  geom_point(aes(col = country)) +
  geom_smooth(method = lm)


### Kjører modeller med fixed effects
# Med tversnittsfaste effekter (i dette tilfellet land)
plm.fe.ind <- plm(data = data.complete, 
                  fdi_inflow ~ bits + ln_gdp_pr_cap + ln_population +
                    economic_growth + inflation + resource_rent + 
                    bilateral_trade_agreements + wto_member + polcon3,
                  na.action = "na.exclude", model = "within", effect = "individual")


# Med tidsfaste effekter (i dette tilfellet år)
plm.fe.time <- plm(data = data.complete, 
                   fdi_inflow ~ bits + ln_gdp_pr_cap + ln_population +
                     economic_growth + inflation + resource_rent + 
                     bilateral_trade_agreements + wto_member + polcon3,
                   na.action = "na.exclude",model = "within", effect = "time")

# Med tversnitts- og tidsfaste effekter (i dette tilfellet år og land)
plm.fe.two <- plm(data = data.complete, 
                  fdi_inflow ~ bits + ln_gdp_pr_cap + ln_population +
                    economic_growth + inflation + resource_rent + 
                    bilateral_trade_agreements + wto_member + polcon3,
                  na.action = "na.exclude", model = "within", effect = "twoways")

# Viser resultatene i en tabell
stargazer(plm.fe.ind, plm.fe.time, plm.fe.two, type = "text",
          column.labels = c("Tversnitts FE", "Tids FE", "Tversnitts og tids FE"),
          omit = c("country", "year"))

# Henter ut faste effekter:
fixef(plm.fe.ind)[1:5] # Henter ut de fem første tversnittsfaste effektene
fixef(plm.fe.time)[1:5] # Henter ut de fem første tidsfaste effektene
# I modeller med både tversnitts- og tidsfaste effekter må du spesifiser effect = "time" 
# om du vil ha de tidsfaste effektene
fixef(plm.fe.two)[1:5] # Henter ut de fem første tversnittssfaste effektene
fixef(plm.fe.two, effect = "time")[1:5] # Henter ut de fem første tidsfaste effektene

# bruker summary til å hente ut mer informasjon om faste effekter:
summary(fixef(plm.fe.ind))
summary(fixef(plm.fe.two, effect = "time"))


## OBS! ved fixed effects - lite endring i variabel
ggplot(data.complete%>% 
         filter(country %in% c("Bagladesh", "Lesotho", "India", "Chile",
                               "China", "Lithuania", "Mozambique", "Togo", 
                               "Zambia", "Fiji", "Belize", "Peru", "Guyana"))) + # Velger ut utvalg av land
  geom_point(aes(x = as.numeric(as.character(year)), y = as.factor(wto_member))) + # Bruker as.numeric(as.character(year)) fordi year er en faktor
  facet_wrap(~country) + 
  theme_bw() +
  xlab("Year") + ylab("WTO membership") # Legger til aksetitler

ggplot(data.complete%>% 
         filter(country %in% c("Bagladesh", "Lesotho", "India", "Chile",
                               "China", "Lithuania", "Mozambique", "Togo", 
                               "Zambia", "Fiji", "Belize", "Peru", "Guyana"))) + 
  geom_point(aes(x = as.numeric(as.character(year)), y = bits)) +
  facet_wrap(~country) +
  theme_bw() +
  xlab("Year") + ylab("Antall BITs")


### Kjører modeller med random effects
plm.re.ind <- plm(data = data.complete, 
                  fdi_inflow ~ bits + ln_gdp_pr_cap + ln_population +
                    economic_growth + inflation + resource_rent + 
                    bilateral_trade_agreements + wto_member + polcon3,
                  na.action = "na.exclude", model = "random", effect = "individual")

plm.re.time <- plm(data = data.complete, 
                   fdi_inflow ~ bits + ln_gdp_pr_cap + ln_population +
                     economic_growth + inflation + resource_rent + 
                     bilateral_trade_agreements + wto_member + polcon3,
                   na.action = "na.exclude", model = "random", effect = "time")

plm.re.two <- plm(data = data.complete, 
                  fdi_inflow ~ bits + ln_gdp_pr_cap + ln_population +
                    economic_growth + inflation + resource_rent + 
                    bilateral_trade_agreements + wto_member + polcon3,
                  na.action = "na.exclude", model = "random", effect = "twoways")

stargazer::stargazer(plm.re.ind, plm.re.time, plm.re.two, type = "text",
                     column.labels = c("Tversnitts RE", "Tids RE", "Tversnitts og tids RE"))


# Sammenligne faktiske og predikerte verdier
# I dette eksempelet tar jeg utgangspunkt i både tids- og enhetseffekter
# Legger til predikerte verdier på avhengig variabel for random effects i datasett
data.complete$pred_fdi_inflow_re <- predict(plm.re.two)
# Legger til predikerte verdier for pooled OLS i datasett 
data.complete$pred_fdi_inflow_ols <- predict(mod1ols)
# Legger til predikerte verdier for fixed effects i datasett
data.complete$pred_fdi_inflow_fe <- predict(plm.fe.two)


# Jeg gjør om en dataframe fra wide til long for å kunne få ulik farge på de predikerte verdiene i plottet
plot_data <- data.complete %>%
  data.frame() %>% # Gjør om fra plm-objekt til data.frame
  select(country, year, fdi_inflow, pred_fdi_inflow_fe, pred_fdi_inflow_ols, pred_fdi_inflow_re) %>%  # Velger ut de aktuelle variablene
  pivot_longer(cols = contains("fdi_inflow"), names_to = "model", "values_to" = "FDI_inflow")  # omformer datasettet 
# Argumentet cols = sier hvilke kolonner(variabler) som skal slås sammen til en kolonne
# contains("fdi_inflow") betyr at jeg vil ha med alle variablene som inneholder fdi_inflow


ggplot(plot_data %>% 
         filter(country %in% c("Bagladesh", "Lesotho", "India", "Chile",
                               "China", "Lithuania", "Mozambique", "Togo", 
                               "Zambia", "Fiji", "Belize", "Peru", "Guyana"))) +    # Tar med et utvalg av land
  geom_line(aes(x = as.numeric(as.character(year)), y = FDI_inflow, col = model)) + # Plotter linjen
  facet_wrap(~country) +                                                            # Lager et plot per land  
  theme_classic() +
  scale_color_discrete(labels = c("True value", "Predicted FE", "Predicted pooled OLS", "Prediced RE")) + # Setter inn labels på fargeoversikt
  xlab("Year") + ylab("FDI inflow") +
  theme(legend.position = "right", legend.title = element_blank())


# Gjennom PLM kan vi kjøre en hausman test
# Modellene med både tverrsnitts- og tidsfaste effekter
phtest(plm.fe.two, plm.re.two)

# Modellene med tverssnitssfaste effekter
phtest(plm.fe.ind, plm.re.ind)

# Modellene med tidsfaste effekter
phtest(plm.fe.time, plm.re.time)
