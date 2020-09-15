R fordypningsseminar 2: Flernivåanalyse
================

## Flernivåanalyse

Den statistiske motivasjonen bak flernivåanalyse er å ta hensyn til
avhengighet mellom observasjoner i en hierarkisk struktur. *I R:* Som de
andre regresjonsformene vi har sett på, ligner syntaksen for
flernivåanalyse på syntaksen for ols. Den største forskjellen ligger i
spesifisering av nivå for variabler. Hensikten med dette dokumentet er å
hjelpe deg til å forstå hvordan du kan oversette teorien fra
forelesning/pensum om variabler på ulike nivå til R-syntaks i `lmer()`
funksjonen fra pakken `lme4`. Dersom du ikke helt forstår hva som skjer
i flernivå-scriptet, vil forhåpentligvis dette dokumentet være til
hjelp, og vice versa. Installer og last inn `lme4` med koden under.

``` r
# install.packages("lme4")
library(lme4) # For å kjøre flernivåmodeller
```

    ## Loading required package: Matrix

``` r
library(tidyverse) # Bl.a. for å preppe data
```

    ## -- Attaching packages --------------------------------------------------------------------------------------------------------------------------- tidyverse 1.3.0 --

    ## v ggplot2 3.3.2     v purrr   0.3.4
    ## v tibble  3.0.1     v dplyr   1.0.0
    ## v tidyr   1.1.0     v stringr 1.4.0
    ## v readr   1.3.1     v forcats 0.5.0

    ## -- Conflicts ------------------------------------------------------------------------------------------------------------------------------ tidyverse_conflicts() --
    ## x tidyr::expand() masks Matrix::expand()
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()
    ## x tidyr::pack()   masks Matrix::pack()
    ## x tidyr::unpack() masks Matrix::unpack()

``` r
library(stargazer) # For pene tabeller
```

    ## 
    ## Please cite as:

    ##  Hlavac, Marek (2018). stargazer: Well-Formatted Regression and Summary Statistics Tables.

    ##  R package version 5.2.2. https://CRAN.R-project.org/package=stargazer

``` r
# install.packages("sjlabelled")
library(sjlabelled) # For å hente ut informasjon om labels e.l. 
```

    ## 
    ## Attaching package: 'sjlabelled'

    ## The following object is masked from 'package:forcats':
    ## 
    ##     as_factor

    ## The following object is masked from 'package:dplyr':
    ## 
    ##     as_label

I dag og på torsdag/fredag skal vi bruke et datasett fra European Social
Survey. Observasjonene i datasettet er individer og disse er nøstet
innad i land. Nivå 1-enhetene vår er altså individer, mens nivå
2-enhetene er land i Europa. Datasettet ligger på github. Last ned
datasettet og last det inn i Rstudio.

``` r
# Laster inn Rdata
load("../data/ess.rda") # Her må du bytte ut mappestien "../data/" med stien til mappen du lagret data i

str(ess)
```

    ## 'data.frame':    28221 obs. of  14 variables:
    ##  $ idno               : num  1 2 3 4 5 6 7 13 14 21 ...
    ##   ..- attr(*, "label")= chr "ID number"
    ##  $ cntry              : chr  "AT" "AT" "AT" "AT" ...
    ##  $ country            : chr  "Austria" "Austria" "Austria" "Austria" ...
    ##  $ gender             : chr  "male" "male" "female" "male" ...
    ##   ..- attr(*, "label")= chr "Gender"
    ##  $ age                : num  50 66 88 31 55 66 65 66 33 65 ...
    ##   ..- attr(*, "label")= chr "Age"
    ##  $ income_feel        : num  2 3 2 2 2 2 2 1 2 2 ...
    ##   ..- attr(*, "label")= chr "Feeling about household's income nowadays"
    ##  $ income_decile      : num  3 3 2 4 8 5 4 3 3 2 ...
    ##   ..- attr(*, "label")= chr "Household's total net income, all sources"
    ##  $ trust_parl         : 'labelled' num  3 7 2 1 0 1 3 4 7 2 ...
    ##   ..- attr(*, "labels")= Named num [1:11] 0 1 2 3 4 5 6 7 8 9 ...
    ##   .. ..- attr(*, "names")= chr [1:11] "No trust at all" "1" "2" "3" ...
    ##   ..- attr(*, "label")= chr "Trust in country's parliament"
    ##  $ trust_legalsys     : 'labelled' num  7 4 8 8 2 2 6 1 8 5 ...
    ##   ..- attr(*, "labels")= Named num [1:11] 0 1 2 3 4 5 6 7 8 9 ...
    ##   .. ..- attr(*, "names")= chr [1:11] "No trust at all" "1" "2" "3" ...
    ##   ..- attr(*, "label")= chr "Trust in the legal system "
    ##  $ trust_police       : 'labelled' num  4 5 8 8 5 8 7 8 7 5 ...
    ##   ..- attr(*, "labels")= Named num [1:11] 0 1 2 3 4 5 6 7 8 9 ...
    ##   .. ..- attr(*, "names")= chr [1:11] "No trust at all" "1" "2" "3" ...
    ##   ..- attr(*, "label")= chr "Trust in the police"
    ##  $ trust_politicians  : 'labelled' num  3 3 3 0 0 0 0 4 3 2 ...
    ##   ..- attr(*, "labels")= Named num [1:11] 0 1 2 3 4 5 6 7 8 9 ...
    ##   .. ..- attr(*, "names")= chr [1:11] "No trust at all" "1" "2" "3" ...
    ##   ..- attr(*, "label")= chr "Trust in politicians"
    ##  $ trust_polparties   : 'labelled' num  3 5 3 1 1 0 0 4 3 2 ...
    ##   ..- attr(*, "labels")= Named num [1:11] 0 1 2 3 4 5 6 7 8 9 ...
    ##   .. ..- attr(*, "names")= chr [1:11] "No trust at all" "1" "2" "3" ...
    ##   ..- attr(*, "label")= chr "Trust in political parties"
    ##  $ trust_eurparl      : 'labelled' num  0 0 2 0 0 2 0 1 6 2 ...
    ##   ..- attr(*, "labels")= Named num [1:11] 0 1 2 3 4 5 6 7 8 9 ...
    ##   .. ..- attr(*, "names")= chr [1:11] "No trust at all" "1" "2" "3" ...
    ##   ..- attr(*, "label")= chr "Trust in the European Parliament"
    ##  $ trust_unitednations: 'labelled' num  5 3 5 0 2 3 3 7 5 2 ...
    ##   ..- attr(*, "labels")= Named num [1:11] 0 1 2 3 4 5 6 7 8 9 ...
    ##   .. ..- attr(*, "names")= chr [1:11] "No trust at all" "1" "2" "3" ...
    ##   ..- attr(*, "label")= chr "Trust in the United Nations"

Datasettet inneholder følgende variabler:

  - `id`: observasjonens id-nummer
  - `cntry`: landforkortelse
  - `country`: land
  - `gender`: kjønn
  - `age`: alder
  - `income_feel`: “Feeling about household’s income nowadays”
  - `incomde_decil`: inntektsdesil
  - `trust_parl`: “Trust in country’s parliament”
  - `trust_legalsys`: “Trust in legal system”
  - `trust_police`: “Trust in police”
  - `trust_polparties`: “Trust in political parties”
  - `trust_eurparl`: “Trust in the European Parliament”
  - `trust_unitednations`: “Trust in the United Nations”

ESS dataene i dette formatet kommer med labels. Det kan være et nyttig
supplement til kodeboken. En pakke som er fin å installere dersom
datasettet du skal bruke har labels er `sjlabelled`. Vi installerer og
laster inn pakken før vi ser nærmere på labels ved hjelp av funksjonen
`get_label` og `get_labels`:

``` r
get_label(ess$trust_eurparl)
```

    ## [1] "Trust in the European Parliament"

``` r
summary(ess$trust_eurparl)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
    ##   0.000   2.000   5.000   4.287   6.000  10.000    1644

``` r
get_labels(ess$trust_eurparl)
```

    ##  [1] "No trust at all" "1"               "2"               "3"              
    ##  [5] "4"               "5"               "6"               "7"              
    ##  [9] "8"               "9"               "Complete trust"

Som vi ser forteller `get_label()` oss hvilket spørsmål som er stilt,
mens `get_labels()` forteller oss hva som er laveste og høyeste verdi på
variabelen. Her ser vi at variabelen `trust_eurparl` går fra 0-10, og
`get_labels()` forteller oss at 0 betyr “No trust at all”, mens 10 betyr
“Complete trust”. Du kan selv sjekke hva som gjelder for noen av de
andre variablene.

## Flernivåanalyse i R

Under finner dere syntaksen for flernivå med samme notasjon som på
forelesning, oversatt til `lmer`. Jeg bruker `group_var` for å betegne
variabelen som forteller hvilken gruppe observasjoner tilhører (den
hierarkiske strukturen). `x` refererer til variabler på nivå 1, mens `z`
referer til variabler på nivå 2 (skiller mellom z og x for å gjøre det
lettere og oversette til **R**).

**Flernivå med kun random intercept:**
\[Y_i = \beta_{0} + u_{0j} + e_{ij}\] `lmer(y ~ 1 + (1|group_var), data
= data)`

Denne kalles også ofte for en nullmodell.

**Flernivå med uavh. variabel på nivå 1, fixed effects, random
intercept:**

\[Y_i = \beta_{0} + \beta_{1}X_{1ij} +  u_{0j} + e_{ij}\]

`lmer(y ~ (1|group_var) + x1, data = data)`

**Flernivå med uavh. variabel på nivå1, random slopes:**

\[Y_i = \beta_{0} + \beta_{1}X_{1ij} + u_{1j}X_{1ij} + u_{0j} +  e_{ij}\]

`lmer(y ~ x1 + (x1|group_var), data=data)`

**Flernivå med uavh. var på mikronivå med random effects, og uavhengig
variabel på makronivå:**

\[Y_i = \beta_{0} + \beta_{1}X_{1ij} + \beta_{2j} Z_{2j} + + u_{1j}X_{1ij} + u_{0j} + e_{ij}\]

`lmer(y ~ x1 + (x1|group_var) + z2, data=data)`

**Flernivå med uavh. var på mikronivå med random effects,
kryssnivåsamspill, og uavhengig variabel på makronivå:**

\[Y_i = \beta_{0} + \beta_{1}X_{1ij} + \beta_{2j}Z_{2j} + \beta_{3}X_{1ij}Z_{2j} + + u_{1j}X_{1ij} + u_{0j} + e_{ij}\]

`lmer(y ~ x1*z2 + x1 + (x1|group_var) + z2, data=data)`

### Beregne intraklassekorrelasjon

I forelesning kommer dere til å snakke om noe som heter intra-class
correlation. Intra-class correlation forteller oss hvor stor andel av
total varians som ligger på nivå 2, i vårt tilfelle på landnivå. Resten
av variansen skyldes at nivå 1-enhetene, i vårt tilfelle personer,
avviker fra nivå 2-gjennomsnittet. Intra-class correlation kan tolkes
som graden av avhengighet mellom enhetene.

For å finne intra-class correlation så kan vi bruke modellen med kun
random intercept. Vi kjører først modellen:

``` r
m0 <- lmer(data = ess, 
           trust_politicians ~ (1|country))
```

Dersom vi har brukt `lmer()` til å kjøre en flernivåmodell med kun
random intercept, får vi outputen vi trenger til å regne ut ICC etter
denne formelen med `summary()`. For å finne intra-class correlation så
deler vi varians på nivå 2 på summen av varians på nivå en og nivå 2:

\[var(u_j)/(var(u_j) + var(e_{ij}))\]

I vårt eksempel blir det:

``` r
summary(m0)
```

    ## Linear mixed model fit by REML ['lmerMod']
    ## Formula: trust_politicians ~ (1 | country)
    ##    Data: ess
    ## 
    ## REML criterion at convergence: 122731.3
    ## 
    ## Scaled residuals: 
    ##     Min      1Q  Median      3Q     Max 
    ## -2.4115 -0.7283  0.0312  0.7135  3.7136 
    ## 
    ## Random effects:
    ##  Groups   Name        Variance Std.Dev.
    ##  country  (Intercept) 1.220    1.104   
    ##  Residual             4.749    2.179   
    ## Number of obs: 27899, groups:  country, 15
    ## 
    ## Fixed effects:
    ##             Estimate Std. Error t value
    ## (Intercept)   3.8720     0.2855   13.56

``` r
# ICC
1.220/(1.220 + 4.749)
```

    ## [1] 0.2043893

Vi kan også bruke `VarCorr(model, comp=`Variance`)`.

``` r
# Vi lagrer først et element med de estimerte variansene
m0var <- VarCorr(m0)

# Så bruker vi print() og ber om å få varians
print(m0var, comp = "Variance")
```

    ##  Groups   Name        Variance
    ##  country  (Intercept) 1.2198  
    ##  Residual             4.7491

I vårt eksempel ligger altså 20 % av variansen på nivå 2 (landnivå). I
følge Christophersen er det en veiledende hovedregel at ICC \>= 0,05
indikerer at flernivåanalyse bør velges.

**Flernivå med uavh. variabel på nivå 1, fixed effects, random
intercept:**

``` r
m1 <- lmer(data = ess, 
           trust_politicians ~ (1|country) + gender)

summary(m1)
```

    ## Linear mixed model fit by REML ['lmerMod']
    ## Formula: trust_politicians ~ (1 | country) + gender
    ##    Data: ess
    ## 
    ## REML criterion at convergence: 100154.8
    ## 
    ## Scaled residuals: 
    ##     Min      1Q  Median      3Q     Max 
    ## -2.4730 -0.6916  0.0139  0.7364  3.7882 
    ## 
    ## Random effects:
    ##  Groups   Name        Variance Std.Dev.
    ##  country  (Intercept) 1.233    1.110   
    ##  Residual             4.508    2.123   
    ## Number of obs: 23036, groups:  country, 15
    ## 
    ## Fixed effects:
    ##             Estimate Std. Error t value
    ## (Intercept) 3.877534   0.287426   13.49
    ## gendermale  0.006738   0.028020    0.24
    ## 
    ## Correlation of Fixed Effects:
    ##            (Intr)
    ## gendermale -0.049

**Flernivå med uavh. variabel på nivå 1, random slopes:**
\[Y_i = \beta_{0} + \beta_{1}X_{1ij} + u_{1j}X_{1ij} + u_{0j} +  e_{ij}\]
`lmer(y ~ x1 + (x1|group_var), data=data)`

``` r
m2 <- lmer(data = ess, 
           trust_politicians ~ (gender|country) + gender,
           na.action = "na.exclude")

summary(m2)
```

    ## Linear mixed model fit by REML ['lmerMod']
    ## Formula: trust_politicians ~ (gender | country) + gender
    ##    Data: ess
    ## 
    ## REML criterion at convergence: 100147.6
    ## 
    ## Scaled residuals: 
    ##     Min      1Q  Median      3Q     Max 
    ## -2.4970 -0.6978  0.0155  0.7451  3.7951 
    ## 
    ## Random effects:
    ##  Groups   Name        Variance Std.Dev. Corr 
    ##  country  (Intercept) 1.28671  1.1343        
    ##           gendermale  0.01402  0.1184   -0.42
    ##  Residual             4.50436  2.1223        
    ## Number of obs: 23036, groups:  country, 15
    ## 
    ## Fixed effects:
    ##              Estimate Std. Error t value
    ## (Intercept)  3.882327   0.293587  13.224
    ## gendermale  -0.001767   0.041717  -0.042
    ## 
    ## Correlation of Fixed Effects:
    ##            (Intr)
    ## gendermale -0.342

``` r
stargazer(m0, m1, m2, type = "text")
```

    ## 
    ## =======================================================
    ##                             Dependent variable:        
    ##                     -----------------------------------
    ##                              trust_politicians         
    ##                         (1)         (2)         (3)    
    ## -------------------------------------------------------
    ## gendermale                         0.007      -0.002   
    ##                                   (0.028)     (0.042)  
    ##                                                        
    ## Constant             3.872***    3.878***    3.882***  
    ##                       (0.285)     (0.287)     (0.294)  
    ##                                                        
    ## -------------------------------------------------------
    ## Observations          27,899      23,036      28,221   
    ## Log Likelihood      -61,365.640 -50,077.400 -50,073.780
    ## Akaike Inf. Crit.   122,737.300 100,162.800 100,159.600
    ## Bayesian Inf. Crit. 122,762.000 100,195.000 100,207.800
    ## =======================================================
    ## Note:                       *p<0.1; **p<0.05; ***p<0.01

Før vi ser nærmere på de andre variablene så skal vi hente inn litt
informasjon på landnivå. Jeg har lastet ned informasjon om
gini-koeffisienten i ulike land i 2016. Gini-koeffisienten er et mål på
inntekstulikhet. Jeg laster inn OECD-datasettet og lagrer det som `gini`
i Environment.

``` r
gini <- read.csv("../data/OECD_gini.csv") 
str(gini)
```

    ## 'data.frame':    35 obs. of  2 variables:
    ##  $ cntry: chr  "AUS" "AUT" "BEL" "CAN" ...
    ##  $ gini : num  0.33 0.284 0.266 0.307 0.253 0.261 0.259 0.291 0.294 0.333 ...

``` r
# cntry i gini-dataene ligner på cntry i ess

str(ess)
```

    ## 'data.frame':    28221 obs. of  14 variables:
    ##  $ idno               : num  1 2 3 4 5 6 7 13 14 21 ...
    ##   ..- attr(*, "label")= chr "ID number"
    ##  $ cntry              : chr  "AT" "AT" "AT" "AT" ...
    ##  $ country            : chr  "Austria" "Austria" "Austria" "Austria" ...
    ##  $ gender             : chr  "male" "male" "female" "male" ...
    ##   ..- attr(*, "label")= chr "Gender"
    ##  $ age                : num  50 66 88 31 55 66 65 66 33 65 ...
    ##   ..- attr(*, "label")= chr "Age"
    ##  $ income_feel        : num  2 3 2 2 2 2 2 1 2 2 ...
    ##   ..- attr(*, "label")= chr "Feeling about household's income nowadays"
    ##  $ income_decile      : num  3 3 2 4 8 5 4 3 3 2 ...
    ##   ..- attr(*, "label")= chr "Household's total net income, all sources"
    ##  $ trust_parl         : 'labelled' num  3 7 2 1 0 1 3 4 7 2 ...
    ##   ..- attr(*, "labels")= Named num [1:11] 0 1 2 3 4 5 6 7 8 9 ...
    ##   .. ..- attr(*, "names")= chr [1:11] "No trust at all" "1" "2" "3" ...
    ##   ..- attr(*, "label")= chr "Trust in country's parliament"
    ##  $ trust_legalsys     : 'labelled' num  7 4 8 8 2 2 6 1 8 5 ...
    ##   ..- attr(*, "labels")= Named num [1:11] 0 1 2 3 4 5 6 7 8 9 ...
    ##   .. ..- attr(*, "names")= chr [1:11] "No trust at all" "1" "2" "3" ...
    ##   ..- attr(*, "label")= chr "Trust in the legal system "
    ##  $ trust_police       : 'labelled' num  4 5 8 8 5 8 7 8 7 5 ...
    ##   ..- attr(*, "labels")= Named num [1:11] 0 1 2 3 4 5 6 7 8 9 ...
    ##   .. ..- attr(*, "names")= chr [1:11] "No trust at all" "1" "2" "3" ...
    ##   ..- attr(*, "label")= chr "Trust in the police"
    ##  $ trust_politicians  : 'labelled' num  3 3 3 0 0 0 0 4 3 2 ...
    ##   ..- attr(*, "labels")= Named num [1:11] 0 1 2 3 4 5 6 7 8 9 ...
    ##   .. ..- attr(*, "names")= chr [1:11] "No trust at all" "1" "2" "3" ...
    ##   ..- attr(*, "label")= chr "Trust in politicians"
    ##  $ trust_polparties   : 'labelled' num  3 5 3 1 1 0 0 4 3 2 ...
    ##   ..- attr(*, "labels")= Named num [1:11] 0 1 2 3 4 5 6 7 8 9 ...
    ##   .. ..- attr(*, "names")= chr [1:11] "No trust at all" "1" "2" "3" ...
    ##   ..- attr(*, "label")= chr "Trust in political parties"
    ##  $ trust_eurparl      : 'labelled' num  0 0 2 0 0 2 0 1 6 2 ...
    ##   ..- attr(*, "labels")= Named num [1:11] 0 1 2 3 4 5 6 7 8 9 ...
    ##   .. ..- attr(*, "names")= chr [1:11] "No trust at all" "1" "2" "3" ...
    ##   ..- attr(*, "label")= chr "Trust in the European Parliament"
    ##  $ trust_unitednations: 'labelled' num  5 3 5 0 2 3 3 7 5 2 ...
    ##   ..- attr(*, "labels")= Named num [1:11] 0 1 2 3 4 5 6 7 8 9 ...
    ##   .. ..- attr(*, "names")= chr [1:11] "No trust at all" "1" "2" "3" ...
    ##   ..- attr(*, "label")= chr "Trust in the United Nations"

For å kombinere `gini`-dataene med `ess`-dataene så må vi ha en felles
nøkkelvariabel som knytter observasjonene sammen. `cntry`-variablene i
de to datasettene ligner på hverandre, men mens OECD bruker tre
bokstaver i navnforkortelsen så bruker bare ESS bare to. Dette er ofte
tilfellet når en forsøker å slå sammen data fra ulike kilder. Det finnes
en pakke i R som heter `countrycode` som kan hjelpe oss med dette.
Funksjonen `countrycode()` lar oss omkode landforkortelse fra en type
til en annen. Vi laster inn pakken. Hvis ikke du har brukt den før så må
du først installere den ved hjelp av `install.packages()`-funksjonen.

``` r
# install.packages("countrycode")
library(countrycode)
```

Om du skriver `?codelist` så får du en oversikt over de ulike
landforkortelsene som finnes i pakken. Jeg har kikket gjennom på forhånd
og funnet ut at `iso3c` ser ut til å matche godt med forkortelsene i
OECD-dataene og `iso2c` ser ut til å passe godt med ESS-dataene. Denne
informasjonen bruker jeg til å lage en ny variabel `cntry2` i
OECD-dataene (`gini`). Til slutt bruker jeg denne til å slå sammen de to
datasettene.

``` r
# Lager ny landkodevariabel
gini$cntry2 <- countrycode(gini$cntry, "iso3c", "iso2c")

# Slår sammen datasettene
ess2 <- ess %>% 
  left_join(gini, by = c("cntry" = "cntry2"))

# Sjekker om alle land har fått en giniverdi ved hjelp av is.na
table(is.na(ess2$gini))
```

    ## 
    ## FALSE 
    ## 28221

``` r
# Dette ser fint ut
```

Nå som vi har slått sammen datasettene så kan vi også kjøre analyser med
variabler på nivå 2 (landnivå her).

**Flernivå med uavh. var på mikronivå med random effects, og uavhengig
variabel på makronivå:**

``` r
m3 <- lmer(data = ess2, 
           trust_politicians ~  gender + (gender|country) + gini)
```

**Flernivå med uavh. var på mikronivå med random effects,
kryssnivåsamspill, og uavhengig variabel på makronivå:**
\[Y_i = \beta_{0} + \beta_{1}X_{1ij} + \beta_{2j}Z_{2j} + \beta_{3}X_{1ij}Z_{2j} + + u_{1j}X_{1ij} + u_{0j} + e_{ij}\]
`lmer(y ~ x1*z2 + x1 + (x1|group_var) + z2, data=data)`

``` r
m4 <- lmer(data = ess2, 
           trust_politicians ~ gender + (gender|country) + gini + gender*gini)
```

Med kryssnivåsamspill så lar vi nivå 2 konteksten påvirke effekten av
nivå 1 variabelen på avhengig variabel. Dere kan hente ut random
slopes/intercepts med `ranef()`, mens faste effekter kan hentes ut med
`coef()`.

``` r
# Ser på model 1
ranef(m1)
```

    ## $country
    ##             (Intercept)
    ## Austria     -0.41581385
    ## Belgium      0.28889850
    ## Czechia     -0.64055049
    ## Denmark      1.09509112
    ## Estonia     -0.44105734
    ## Finland      0.72250070
    ## France      -1.14565748
    ## Germany     -0.01239641
    ## Ireland     -0.53119112
    ## Netherlands  1.02569035
    ## Norway       1.35860048
    ## Poland      -1.84280701
    ## Slovenia    -1.92047369
    ## Sweden       1.09293588
    ## Switzerland  1.36623035
    ## 
    ## with conditional variances for "country"

``` r
coef(m1)
```

    ## $country
    ##             (Intercept)  gendermale
    ## Austria        3.461720 0.006737933
    ## Belgium        4.166432 0.006737933
    ## Czechia        3.236983 0.006737933
    ## Denmark        4.972625 0.006737933
    ## Estonia        3.436476 0.006737933
    ## Finland        4.600034 0.006737933
    ## France         2.731876 0.006737933
    ## Germany        3.865137 0.006737933
    ## Ireland        3.346343 0.006737933
    ## Netherlands    4.903224 0.006737933
    ## Norway         5.236134 0.006737933
    ## Poland         2.034727 0.006737933
    ## Slovenia       1.957060 0.006737933
    ## Sweden         4.970470 0.006737933
    ## Switzerland    5.243764 0.006737933
    ## 
    ## attr(,"class")
    ## [1] "coef.mer"

``` r
# Random slopes i ranef() tilsvarer differensansen mellom interceptene vi får med coef()
```

## Tolke resultater

Estimatene i flernivåanalyser kan tolkes på samme måte som med
OLS-regresjon.

## Modellevaluering

### Blir variansen mindre?

AIC og BIC straffer modeller med mane uavhengige variabler og/eller
mange nivå 1-enheter.

``` r
AIC(m0,m1,m2,m3,m4)
```

    ## Warning in AIC.default(m0, m1, m2, m3, m4): models are not all fitted to the
    ## same number of observations

    ##    df      AIC
    ## m0  3 122737.3
    ## m1  4 100162.8
    ## m2  6 100159.6
    ## m3  7 100154.4
    ## m4  8 100152.7

``` r
BIC(m0,m1,m2,m3,m4)
```

    ## Warning in BIC.default(m0, m1, m2, m3, m4): models are not all fitted to the
    ## same number of observations

    ##    df      BIC
    ## m0  3 122762.0
    ## m1  4 100195.0
    ## m2  6 100207.8
    ## m3  7 100210.8
    ## m4  8 100217.0

## Plotte effekter?

``` r
library(sjPlot)
plot_model(m3, type = "pred")
```

    ## $gender

![](Fordypningsseminar-2-Flernivaa_files/figure-gfm/unnamed-chunk-16-1.png)<!-- -->

    ## 
    ## $gini

![](Fordypningsseminar-2-Flernivaa_files/figure-gfm/unnamed-chunk-16-2.png)<!-- -->

## Flernivå i hjemmeoppgaven?

Her er en mer utdypende [forklaring av lme4 pakken med
eksempler](https://cran.r-project.org/web/packages/lme4/vignettes/lmer.pdf).
Mye av teksten er teknisk, men se seksjon 5.2 dersom du tenker å kjøre
en flernivåanalyse til hjemmeoppgaven for detaljer om diagnostikk for
`lmer`.
