Fordypningsseminar 1: Tidsserie- og paneldata
================
Lise Rødland
03-09-2020

## Tema

I dette seminaret skal vi jobbe med en artikkel fra 2005 skrevet av
Neumayer og spess. Artikkelen heter *Do bilateral investment treaties
increase foreign direct investment to developing countries?* og bruker
paneldata til å undersøke effekten av bilaterale investeringsavtaler på
hvor mye utenlandsinvesteringer utviklingsland mottar. Datasettet har
jeg lastet ned fra [Harvard
Dataverse](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/HQJN8G).
Jeg har bearbeidet datasettet litt før dette seminaret for at variablene
skal ha litt mer intuitive navn. Du kan laste det bearbeidede datasettet
ned fra
[data-mappen](https://github.com/liserodland/stv4020aR/tree/master/H20-seminarer/Fordypningsseminarer/data/Paneldata)
på github.

``` r
# Laster inn nødvendige pakker
# Husk å kjør install.packages("pakkenavn") først om det er første gang du bruker pakken
library(haven) # For å kunne lese inn .dta-filer
library(tidyverse) # For å kunne bruke ggplot, dplyr og liknende
```

    ## -- Attaching packages --------------------------------------------------------------------------------------------------------------------------- tidyverse 1.3.0 --

    ## v ggplot2 3.3.2     v purrr   0.3.4
    ## v tibble  3.0.1     v dplyr   1.0.0
    ## v tidyr   1.1.0     v stringr 1.4.0
    ## v readr   1.3.1     v forcats 0.5.0

    ## -- Conflicts ------------------------------------------------------------------------------------------------------------------------------ tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
library(stargazer) # For å kunne lage pene tabeller
```

    ## 
    ## Please cite as:

    ##  Hlavac, Marek (2018). stargazer: Well-Formatted Regression and Summary Statistics Tables.

    ##  R package version 5.2.2. https://CRAN.R-project.org/package=stargazer

``` r
# Laster inn data
data <- read_dta("../data/Paneldata/Article for World Development (BITs).dta")

data <- data %>% 
  filter(inc_developing == 1) %>% 
  select(country, 
         year, 
         fdi_inflow = flnfdiflow96dollarsnonegatives,
         bits = bitsumoecdweighted,
         ln_gdp_pr_cap = lnrgdpch,
         ln_population = lnpop,
         economic_growth = econgrowth,
         inflation,
         resource_rent = resourcedepletion,
         bilateral_trade_agreements = agreementwithdevcountrydummy,
         wto_member = wtomemberdummy,
         polcon3)

## Husk å lagre data!! 
```

Datasettet inneholder følgende variabler:

  - `country`: land
  - `year`: år
  - `fdi_inflow`: hvor mye investeringer et land får
  - `bits`: hvor mange investeringsavtaler et land har
  - `ln_gdp_pr_cap`: logaritmen til BNP per cap
  - `ln_population`: logaritmen til populasjonen
  - `economic_growth`: økonomisk vekst
  - `inflation`: inflasjon
  - `resource_rent`: ressursrente (her brukt som mål på hvor mye
    naturressurser et land har)
  - `bilateral_trade_agreements`: antall bilaterale handelsavtaler et
    land har
  - `wto_member`: om et land er medlem i WTO (verdens
    handelsorganisasjon)
  - `polcon3`: et mål på troverdigheten til politiske institusjoner når
    de forplikter seg til politiske tiltak

Disse er litt forenklet forklart. Neumayer og Spess har blant annet
vektet variabelen `bits` som måler antall investeringsavtaler et land
har. Om du er interessert så kan du lese mer i [artikkelen deres i World
Development](https://www-sciencedirect-com.ezproxy.uio.no/science/article/pii/S0305750X05001233).

R har en pakke som heter `plm` og som er nyttig når en skal jobbe med
paneldata. Først må du installere og laste inn pakken:

``` r
#install.packages("plm") # Fjern # foran om ikke du har installert pakken før
library(plm)
```

    ## 
    ## Attaching package: 'plm'

    ## The following objects are masked from 'package:dplyr':
    ## 
    ##     between, lag, lead

Når vi skal bruke `plm`-pakken så må vi først lage et `plm`-objekt som
inneholder informasjon om strukturen på datasettet. I funksjonen under
forteller jeg R at enhetene i datasettet er landene i variabelen
`country` og at tidsperiode er registrert i variabelen `year`.

``` r
data.plm <- pdata.frame(data, index = c("country", "year"), stringsAsFactors = FALSE)
class(data.plm)
```

    ## [1] "pdata.frame" "data.frame"

Noe av det første det er lurt å gjøre er å sjekke om et panel er
balansert eller ikke. Et balansert panel inneholder like mange
observasjoner av hver enhet i datasettet. Dette sjekker vi ved hjelp av
`is.pbalanced()` funksjonen i `plm`-pakken.

``` r
is.pbalanced(data.plm)
```

    ## [1] TRUE

“TRUE” betyr at panelet er balansert. Denne testen tar imidlertid ikke
innover seg eventuelle missing-verdier. Om vi lager et nytt datasett som
bare innholder observasjonene som ikke har missing på noen variabler
finner vi fort ut at panelet ikke er balansert likevel.

``` r
# Lager et datasett uten missingverdier: 
data.complete <- data.plm %>% 
  na.omit() %>% 
  mutate(year = droplevels(year), 
         country = droplevels(country)) # Her fjerner jeg faktornivåene (levels) til de årene og landene som ikke lengre er med i datasettet

# Sjekker om det nye datasettet som blir lagt til grunn for analysen er balansert
is.pbalanced(data.complete)
```

    ## [1] FALSE

Ved hjelp av `make.pbalanced()` kan vi gjøre panelet balansert, men da
mister vi data. Vi må velge om vi vil beholde alle enheter, men avgrense
dataene til de tidsperiodene vi har data for alle, eller om vi vil
beholde alle tidsperioder og avgrense data til de enhetene der vi har
data for alle tidsperioder.

``` r
#
data.balanced.time <- make.pbalanced(data.complete, balance.type = "shared.times") # Beholder bare de enhetene vi har data for alle tidsperiode for
# Dette datasettet inneholder 0 observasjoner fordi vi ikke har data for alle tidsperioder for noen enheter

data.balanced.ind <- make.pbalanced(data.complete, balance.type = "shared.individuals") %>%  # Beholder bare de tidsperiodene vi har data for alle enhetene for
  mutate(year = droplevels(year),                               
         country = droplevels(country)) # Her fjerner jeg faktornivåene (levels) til de årene og landene som ikke lengre er med i datasettet
```

I eksempelet har vi ingen enheter med observasjoner for alle år. Vi kan
også sjekke hvor mange enheter eller tidsperioder som forsvinner ut av
analysen ved hjelp av `length` og `unique`. Kombinasjonen av `length` og
`unique` forteller oss hvor mange unike verdier en variabel har (uten å
si noe om hvor mange observasjoner som har denne verdien).

``` r
# Finner antall tidsperioder i opprinnelig datasett uten missing
length(unique(data.complete$country))
```

    ## [1] 120

``` r
length(unique(data.balanced.ind$country))
```

    ## [1] 45

``` r
# I det nye datasettet har vi data for 45 unike land sammenlignet med 120 land opprinnelig

length(unique(data.complete$year))
```

    ## [1] 32

``` r
length(unique(data.balanced.ind$year))
```

    ## [1] 32

``` r
# Vi har fortsatt data for 32 år
# Dette gir mening fordi vi valgte å beholde de enhetene vi hadde observasjoner for alle år for. 
```

Dette illustrerer utfordringen knyttet til at du fort mister veldig mye
data om du skal anvende et balansert panel. Men, dersom du har et
ubalansert panel, vil du ha implisitt missing - det vil si at R ikke
forteller deg at du mangler informasjon om observasjoner du egentlig
burde ha hatt informasjon om. I det følgende vil vi uansett gå videre
med det ubalanserte panelet.

## Paneldataanalyse med plm

Med `plm` må vi spesifisere noen flere elementer enn med `lm()`. Vi må
bestemme `effect` og `model`. Gjennom `model` forteller vi `plm` om vi
ønsker OLS uten faste effekter (`model = "pooling"`), fixed effects
(`model = "within"`) eller random effects (`model = "random"`). Gjennom
`effect` forteller vi `plm` om vi ønsker å se på enheter (`effect =
"individual"`), tid (`effect = "time"`) eller begge deler (`effect =
"twoways"`). En kan også velge andre spesifikasjoner, men de går vi ikke
gjennom i dag.

### Pooled OLS med PCSE

Et første alternativ med paneldata er å kjøre en **pooled ols**
regresjon. Det er som å kjøre en vanlig OLS uten å ta med faste effekter
for enhet eller år.

``` r
# I plm får vi en vanlig OLS-modell om vi velger model = "pooling". 
mod1ols <- plm(data = data.complete, 
              fdi_inflow ~ bits + ln_gdp_pr_cap + ln_population +
                economic_growth + inflation + resource_rent + 
                bilateral_trade_agreements + wto_member + polcon3,
              na.action = "na.exclude", model = "pooling")
```

Vi skal bruke denne modellen for å se på noen av utfordringene knyttet
til paneldata, men først skal vi legge til panelkorrigerte standardfeil
(PCSE). `plm` inneholder funksjonen `vcovBK` som kan brukes til å
beregne panel-korrigerte standardfeil. Jeg kommer ikke til å gå i detalj
om hva funksjonen gjør, men dersom du skal gjøre dette i hjemmeoppgaven
så kan du bytte ut `mod1osl` med de eget plm-modellobjekt. Denne
formelen kan også brukes på fixed effects og random effects modeller.

``` r
# Beregner PCSE:
bkse <- round(sqrt(diag(vcovBK(mod1ols, cluster = "group"))), digits = 4)

# Printer resultatene i en tabell
stargazer(mod1ols, mod1ols, type = "text",
          column.labels = c("Med PCSE", "Med vanlige SE"),
          se = list(bkse))
```

    ## 
    ## =======================================================
    ##                                Dependent variable:     
    ##                            ----------------------------
    ##                                     fdi_inflow         
    ##                              Med PCSE    Med vanlige SE
    ##                                 (1)           (2)      
    ## -------------------------------------------------------
    ## bits                         0.018***       0.018***   
    ##                               (0.004)       (0.001)    
    ##                                                        
    ## ln_gdp_pr_cap                1.236***       1.236***   
    ##                               (0.138)       (0.051)    
    ##                                                        
    ## ln_population                0.567***       0.567***   
    ##                               (0.059)       (0.021)    
    ##                                                        
    ## economic_growth              2.238***       2.238***   
    ##                               (0.607)       (0.539)    
    ##                                                        
    ## inflation                     -0.0001       -0.0001    
    ##                              (0.0001)       (0.0001)   
    ##                                                        
    ## resource_rent                  0.015        0.015***   
    ##                               (0.010)       (0.004)    
    ##                                                        
    ## bilateral_trade_agreements    -0.244         -0.244    
    ##                               (0.357)       (0.150)    
    ##                                                        
    ## wto_member                     0.179        0.179**    
    ##                               (0.193)       (0.078)    
    ##                                                        
    ## polcon3                      1.359***       1.359***   
    ##                               (0.451)       (0.200)    
    ##                                                        
    ## Constant                    -15.672***     -15.672***  
    ##                               (1.563)       (0.566)    
    ##                                                        
    ## -------------------------------------------------------
    ## Observations                   2,767         2,767     
    ## R2                             0.453         0.453     
    ## Adjusted R2                    0.451         0.451     
    ## F Statistic (df = 9; 2757)  253.958***     253.958***  
    ## =======================================================
    ## Note:                       *p<0.1; **p<0.05; ***p<0.01

``` r
# Med argumentet se = list(bkse) forteller jeg stargazer at jeg i den første kolonnen
# vil erstatte de opprinnelige standardfeilene med de panelkorrigerte standardfeilene
# jeg regnet ut over. 
```

### Restleddsutfordringer og paneldata

I det følgende tar vi utgangspunkt i OLS-modellen for å vurdere noen av
utfordringene knyttet til paneldata. PCSE tar hånd om samtidig
korrelasjon og heteroskedastisitet, men hjelper ikke mot
autokorrelasjon. For å håndtere autokorrelasjon kan vi inkludere en
lagget avhengigvariabel eller en trendvariabel som uavhengig variabel.
PCSE hjelper heller ikke mot utelatt variabel skjevhet som vil bli
diskutert nærmere under fixed effects.

#### Autokorrelasjon

Durbin-Watson testen sjekker for AR(1) seriekorrelasjon.

``` r
# Kjører durbin watson test på modellobjektet
pdwtest(mod1ols)
```

    ## 
    ##  Durbin-Watson test for serial correlation in panel models
    ## 
    ## data:  fdi_inflow ~ bits + ln_gdp_pr_cap + ln_population + economic_growth +     inflation + resource_rent + bilateral_trade_agreements +     wto_member + polcon3
    ## DW = 0.74071, p-value < 2.2e-16
    ## alternative hypothesis: serial correlation in idiosyncratic errors

I følge Christophers så indikerer verdier i nærheten av 2 ingen
autokorrelasjon, og verdier i nærheten av 0 positiv autokorrelasjon.
Dette indikerer et behov for panelkorrigerte standardfeil.

#### Panel-spesifikk heteroskedastisitet

OLS forutsetter at residualene er konstante på tvers av enheter. Med
paneldata er det risiko for at restleddene har ulik varians for ulike
tversnittsenheter. En måte å undersøke heterskedastisitet på er å plotte
residualene mot predikerte verdier og bruke `facet_wrap(~country)`.

``` r
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
```

    ## `geom_smooth()` using formula 'y ~ x'

![](Fordypningsseminar-1-Paneldata_files/figure-gfm/unnamed-chunk-11-1.png)<!-- -->

#### Samtidig korrelasjon

Om en hendelse har prefet samtlige enheter på et bestemt tidspunkt så
har vi samtidig korrelasjon. Da vil restleddene være korrelert på tvers
av paneler innenfor samme tidsperiode.

### Modeller med fixed effects

Panelkorrigerte standardfeil tar imidlertid ikke hensyn til utelatt
variabelskjevhet (OVB). Vi har OVB dersom det finnes variabler som
påvirker både den avhengige variabelen og minst en uavhengig variabel,
men som vi ikke har med i modellen vår. Christoffersen nevner
observasjonenes historie idet tidsserien starter som et eksempel på noe
som gjør det urealistisk å legge til grunn en modell med felles
konstantledd (som vi gjør i OLS). Dersom disse karakteristika er
konstante over tid så kan de fanges opp ved hjelp av tverssnittsfaste
effekter, også kalt enhetsspesifikke konstantledd.

Med paneldata så kan en velge å ha tversnittsfaste effekter,
tidsfasteeffekter eller både tversnitts- og tidsfaste effekter. Under
viser jeg hvordan du kan estimere ulike modeller ved hjelp av `plm()`.
Når vi spesifiser `model = "within"` forteller vi plm at vi ønsker å
kjøre fixed effects.

``` r
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
```

    ## 
    ## ======================================================================================================
    ##                                                        Dependent variable:                            
    ##                            ---------------------------------------------------------------------------
    ##                                                            fdi_inflow                                 
    ##                                 Tversnitts FE                Tids FE           Tversnitts og tids FE  
    ##                                      (1)                       (2)                      (3)           
    ## ------------------------------------------------------------------------------------------------------
    ## bits                               0.025***                 0.014***                  0.019***        
    ##                                    (0.002)                   (0.002)                  (0.002)         
    ##                                                                                                       
    ## ln_gdp_pr_cap                      0.803***                 1.263***                  0.570***        
    ##                                    (0.162)                   (0.051)                  (0.171)         
    ##                                                                                                       
    ## ln_population                       0.113                   0.577***                 -1.474***        
    ##                                    (0.201)                   (0.021)                  (0.477)         
    ##                                                                                                       
    ## economic_growth                    1.603***                 1.858***                  1.143**         
    ##                                    (0.473)                   (0.544)                  (0.474)         
    ##                                                                                                       
    ## inflation                         -0.0001**                  -0.0001                 -0.0001**        
    ##                                   (0.00005)                 (0.0001)                 (0.00005)        
    ##                                                                                                       
    ## resource_rent                      0.020***                 0.016***                  0.029***        
    ##                                    (0.006)                   (0.004)                  (0.007)         
    ##                                                                                                       
    ## bilateral_trade_agreements         0.506**                  -0.298**                  0.533**         
    ##                                    (0.211)                   (0.148)                  (0.209)         
    ##                                                                                                       
    ## wto_member                         0.476***                  0.137*                    0.216*         
    ##                                    (0.122)                   (0.077)                  (0.124)         
    ##                                                                                                       
    ## polcon3                            0.886***                 1.080***                  0.546**         
    ##                                    (0.236)                   (0.206)                  (0.237)         
    ##                                                                                                       
    ## ------------------------------------------------------------------------------------------------------
    ## Observations                        2,767                     2,767                    2,767          
    ## R2                                  0.177                     0.422                    0.067          
    ## Adjusted R2                         0.137                     0.414                    0.010          
    ## F Statistic                63.171*** (df = 9; 2638) 221.257*** (df = 9; 2726) 20.713*** (df = 9; 2607)
    ## ======================================================================================================
    ## Note:                                                                      *p<0.1; **p<0.05; ***p<0.01

`plm()` rapporterer ikke koeffisientene for enheter eller tidsperioder
automatisk, og du får heller ikke oppgitt noe konstantledd. For å få
oppgitt de faste effektene bruker vi funksjonen `fixed`.

``` r
fixef(plm.fe.ind)[1:5] # Henter ut de fem første tversnittsfaste effektene
```

    ##             Albania             Algeria              Angola Antigua and Barbuda 
    ##           -6.033565           -6.649452           -3.233274           -6.408387 
    ##           Argentina 
    ##           -3.973221

``` r
fixef(plm.fe.time)[1:5] # Henter ut de fem første tidsfaste effektene
```

    ##      1970      1971      1972      1973      1974 
    ## -15.72773 -16.05330 -15.78942 -15.80233 -15.31956

``` r
# I modeller med både tversnitts- og tidsfaste effekter må du spesifiser effect = "time" 
# om du vil ha de tidsfaste effektene
fixef(plm.fe.two)[1:5] # Henter ut de fem første tversnittssfaste effektene
```

    ##             Albania             Algeria              Angola Antigua and Barbuda 
    ##            20.24440            21.95320            23.89133            13.70754 
    ##           Argentina 
    ##            26.03539

``` r
fixef(plm.fe.two, effect = "time")[1:5] # Henter ut de fem første tidsfaste effektene
```

    ##     1970     1971     1972     1973     1974 
    ## 21.78889 21.47045 21.79265 21.81897 22.12921

Et alternativ til `plm` for å estimere en modell med fixed effects er å
bruke `lm()` funksjonen. I dette eksempelet så vil det innebære å
inkludere variablene `country` og/eller `year`som uavhengige variabler i
regresjonslikningen. Dersom `year` er en numerisk variabel må vi bruke
`as.factor(year)` for at den skal operere som faste effekter. Prøv
gjerne dette selv og se om resultatet blir det samme.

Et alternativ til faste effekter på land- og årnivå er å lage regions-
eller periodevariabler. Du kan bruke funksjonene `cut` eller `ifelse`
til å lage nye variabler som sier noe om hvilken region og tidsperiode
en observasjon tilhører. Deretter kan du estimere en OLS-modell uten
variablene `country` og `year`, men med de nye periode- og
regionvariablene.

**OBS\! ved fixed effects:** Dersom du inkluderer uavhengig med lite
variasjon over tid så vil tverssnitsfaste effekter øke risikoen for
multikolinaritet. Om en uavhengig variabel er konstant over tid så vil
den være perfekt kolinær med de tverrsnittsfaste effektene. Det samme
gjelder dersom en vil estimere effekten av en hendelse som skjedde på
akkurat samme tidspunkt i alle land. Da vil denne være perfekt kolineær
med tidsdummyen for dette året. Om en variabel endrer seg sakte så er
dette også en risiko.

For å undersøke dette kan vi bruke elementet `facet_wrap(~country)` i
`ggplot`. Under er to plot som viser utviklingen over tid for en
variabel i hvert land. I plottene under har jeg valgt et utvalg av land
ved hjelp av `filter()` og `%in%` for å få et litt mer lesbart plot.
Prøv gjerne å fjerne ulike elementer i plottet for å se hva de gjør.

``` r
ggplot(data.complete%>% 
         filter(country %in% c("Bagladesh", "Lesotho", "India", "Chile",
                               "China", "Lithuania", "Mozambique", "Togo", 
                               "Zambia", "Fiji", "Belize", "Peru", "Guyana"))) + # Velger ut utvalg av land
  geom_point(aes(x = as.numeric(as.character(year)), y = as.factor(wto_member))) + # Bruker as.numeric(as.character(year)) fordi year er en faktor
  facet_wrap(~country) + 
  theme_bw() +
  xlab("Year") + ylab("WTO membership") # Legger til aksetitler
```

![](../figures/paneldata_wtomember_land.jpg)

``` r
ggplot(data.complete%>% 
         filter(country %in% c("Bagladesh", "Lesotho", "India", "Chile",
                               "China", "Lithuania", "Mozambique", "Togo", 
                               "Zambia", "Fiji", "Belize", "Peru", "Guyana"))) +
  geom_point(aes(x = as.numeric(as.character(year)), y = bits)) +
  facet_wrap(~country) +
  theme_bw() +
  xlab("Year") + ylab("Antall BITs")
```

![](../figures/paneldata_bits_land.jpg)

### Modeller med random effects

Random effects bygger på en antakelse om at konstantledd er tilfeldig
trukket

``` r
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
```

    ## 
    ## ===========================================================================
    ##                                          Dependent variable:               
    ##                            ------------------------------------------------
    ##                                               fdi_inflow                   
    ##                            Tversnitts RE   Tids RE    Tversnitts og tids RE
    ##                                 (1)          (2)               (3)         
    ## ---------------------------------------------------------------------------
    ## bits                         0.022***      0.016***         0.021***       
    ##                               (0.002)      (0.002)           (0.001)       
    ##                                                                            
    ## ln_gdp_pr_cap                1.028***      1.245***         1.029***       
    ##                               (0.104)      (0.051)           (0.067)       
    ##                                                                            
    ## ln_population                0.492***      0.570***         0.493***       
    ##                               (0.054)      (0.021)           (0.035)       
    ##                                                                            
    ## economic_growth              1.710***      2.091***         1.413***       
    ##                               (0.469)      (0.539)           (0.303)       
    ##                                                                            
    ## inflation                    -0.0001**     -0.0001         -0.0001***      
    ##                              (0.00005)     (0.0001)         (0.00003)      
    ##                                                                            
    ## resource_rent                0.019***      0.016***         0.022***       
    ##                               (0.006)      (0.004)           (0.004)       
    ##                                                                            
    ## bilateral_trade_agreements    0.375**      -0.262*          0.385***       
    ##                               (0.191)      (0.149)           (0.123)       
    ##                                                                            
    ## wto_member                   0.352***      0.165**          0.290***       
    ##                               (0.106)      (0.078)           (0.069)       
    ##                                                                            
    ## polcon3                      0.916***      1.266***         0.802***       
    ##                               (0.222)      (0.201)           (0.144)       
    ##                                                                            
    ## Constant                    -13.028***    -15.743***       -12.998***      
    ##                               (1.269)      (0.565)           (0.826)       
    ##                                                                            
    ## ---------------------------------------------------------------------------
    ## Observations                   2,767        2,767             2,767        
    ## R2                             0.250        0.432             0.442        
    ## Adjusted R2                    0.247        0.431             0.440        
    ## F Statistic                 918.259***   2,100.489***     2,173.457***     
    ## ===========================================================================
    ## Note:                                           *p<0.1; **p<0.05; ***p<0.01

## Tolke effekter

Koeffisientene fra modellene du kjører i plm kan tolkes som OLS
koeffisienter.

``` r
library(prediction)

data.complete$pred_fdi_inflow_ols <- predict(mod1ols)

ggplot(data.complete%>% 
         filter(country %in% c("Bagladesh", "Lesotho", "India", "Chile",
                               "China", "Lithuania", "Mozambique", "Togo", 
                               "Zambia", "Fiji", "Belize", "Peru", "Guyana"))) +
  geom_line(aes(x =  as.numeric(year), y = pred_fdi_inflow_ols)) + 
  geom_line(aes(x = as.numeric(year), y = fdi_inflow), linetype = "dotted") +
  facet_wrap(~country) + 
  theme_classic()
```

![](Fordypningsseminar-1-Paneldata_files/figure-gfm/unnamed-chunk-19-1.png)<!-- -->

``` r
data.complete$pred_fdi_inflow_fe <- predict(plm.fe.two)

ggplot(data.complete%>% 
         filter(country %in% c("Bagladesh", "Lesotho", "India", "Chile",
                               "China", "Lithuania", "Mozambique", "Togo", 
                               "Zambia", "Fiji", "Belize", "Peru", "Guyana"))) +
  geom_line(aes(x =  as.numeric(year), y = pred_fdi_inflow_fe)) + 
  geom_line(aes(x = as.numeric(year), y = fdi_inflow), linetype = "dotted") +
  facet_wrap(~country) + 
  theme_classic()
```

![](Fordypningsseminar-1-Paneldata_files/figure-gfm/unnamed-chunk-20-1.png)<!-- -->

``` r
data.complete$pred_fdi_inflow_re <- predict(plm.re.two)

plot_data <- data.complete %>%
  data.frame() %>% 
  select(country, year, fdi_inflow, pred_fdi_inflow_fe, pred_fdi_inflow_ols, pred_fdi_inflow_re) %>% 
  pivot_longer(cols = contains("fdi_inflow"), names_to = "model", "values_to" = "FDI_inflow") 


ggplot(plot_data %>% 
         filter(country %in% c("Bagladesh", "Lesotho", "India", "Chile",
                               "China", "Lithuania", "Mozambique", "Togo", 
                               "Zambia", "Fiji", "Belize", "Peru", "Guyana"))) +
  geom_line(aes(x = as.numeric(as.character(year)), y = FDI_inflow, col = model)) +
#  geom_line(aes(x =  as.numeric(as.character(year)), y = pred_fdi_inflow_re), color = "royalblue4") + 
#  geom_line(aes(x =  as.numeric(as.character(year)), y = pred_fdi_inflow_fe), color = "violetred4") +
#  geom_line(aes(x =  as.numeric(as.character(year)), y = pred_fdi_inflow_ols), color = "orange") + 
  facet_wrap(~country) + 
  theme_classic() +
  scale_color_discrete(labels = c("True value", "Predicted FE", "Predicted pooled OLS", "Prediced RE")) +
  xlab("Year") + ylab("FDI inflow") +
  theme(legend.position = "right", legend.title = element_blank())
```

![](Fordypningsseminar-1-Paneldata_files/figure-gfm/unnamed-chunk-21-1.png)<!-- -->

## Hvilken modell skal vi bruke?

Funksjonen `phtest` i plm lar deg kjøre en Hausman-test. Random effects
er en mer effisient metode fordi du ikke begrenser deg til “within”
informasjon. Men, random effects er «biased» dersom
enhets-konstantleddene/restleddene er korrelert med minst en av de
uavhengige variablene. Hausman-testen tester om koeffisientene fra
random effects og fixed effects er signifikant forskjellige. Dersom de
er signifikant forskjellige bør en bruke den forventningsrette fixed
effects modellen, om ikke bør en bruke den effisiente random effects
modellen.

``` r
# Gjennom PLM kan vi kjøre en hausman test
# Modellene med både tverrsnitts- og tidsfaste effekter
phtest(plm.fe.two, plm.re.two)
```

    ## 
    ##  Hausman Test
    ## 
    ## data:  fdi_inflow ~ bits + ln_gdp_pr_cap + ln_population + economic_growth +  ...
    ## chisq = 24.036, df = 9, p-value = 0.004244
    ## alternative hypothesis: one model is inconsistent

``` r
# Modellene med tverssnitssfaste effekter
phtest(plm.fe.ind, plm.re.ind)
```

    ## 
    ##  Hausman Test
    ## 
    ## data:  fdi_inflow ~ bits + ln_gdp_pr_cap + ln_population + economic_growth +  ...
    ## chisq = 68.364, df = 9, p-value = 3.184e-11
    ## alternative hypothesis: one model is inconsistent

``` r
# Modellene med tidsfaste effekter
phtest(plm.fe.time, plm.re.time)
```

    ## 
    ##  Hausman Test
    ## 
    ## data:  fdi_inflow ~ bits + ln_gdp_pr_cap + ln_population + economic_growth +  ...
    ## chisq = 28.566, df = 9, p-value = 0.0007668
    ## alternative hypothesis: one model is inconsistent

*Hvordan tolker vi hausman-testen?*

## Paneldata og ikke-lineære modeller

Det er relativt greit å kjøre ikke-lineære modeller med fixed effects.
Du legger bare til variabelene som angir enheter og/eller tid som
uavhengige variabler i f.eks. `glm()`. Skal du kjøre en logistisk modell
med random effects så kan du se på pakken `glmer`.
