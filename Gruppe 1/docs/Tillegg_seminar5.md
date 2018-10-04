---
title: "Etter seminar 5 - mer om modellene"
author: "Erlend Langørgen"
date: "September 29, 2018"
output: 
  html_document:
    keep_md: true
---



### Introduksjon

I dette dokumentet gir jeg en oversikt over ytterligere R-ressurser for de av dere som planlegger å bruke flernivå/multinomisk logistisk regresjon/faktoranalyse/paneldata i hjemmeoppgaven. Dere vil ikke bli testet i disse emnene til prøven. Dokumentet er *Work in progress*, skal få ferdig deler om flernivå og faktoranalyse **asap**. Si i fra dersom du savner noe,

### Multinomisk logistisk regresjon


Her viser jeg hvordan du kan plotte predikert sannsynlighet for resultatene fra multinomisk logistisk regresjon. Jeg bygger videre på det jeg viste av kode i seminar 5:


```r
library(nnet)
library(ggplot2)

load("../data/aidgrowth.Rdata")

summary(aid$gdp_growth)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
## -12.204  -1.292   1.186   1.039   3.392  13.899       6
```

```r
aid$gdp_g_categories <- ifelse(aid$gdp_growth< 0, "negative", NA)
aid$gdp_g_categories <- ifelse(aid$gdp_growth>=0 & aid$gdp_growth< 1, "low", aid$gdp_g_categories)
aid$gdp_g_categories <- ifelse(aid$gdp_growth>=1 & aid$gdp_growth<3, "medium", aid$gdp_g_categories)
aid$gdp_g_categories <- ifelse(aid$gdp_growth>=3, "high", aid$gdp_g_categories)

table(aid$gdp_g_categories) #test
```

```
## 
##     high      low   medium negative 
##       94       25       81      125
```

```r
# Dersom vi omgjør variabelen til factor, kan vi kontrollere referansekategori:
aid$gdp_g_categories <- as.factor(aid$gdp_g_categories)
levels(aid$gdp_g_categories) 
```

```
## [1] "high"     "low"      "medium"   "negative"
```

```r
# setter "negative" til referansekategori. 
aid$gdp_g_categories <- relevel(aid$gdp_g_categories, ref = "negative")


aid$gdp_pr_capita_log <- log(aid$gdp_pr_capita)


## Kjører regresjon
m7 <- multinom(gdp_g_categories ~ gdp_pr_capita_log + 
           institutional_quality + m2_gdp_lagged +
           sub_saharan_africa + fast_growing_east_asia + policy + aid, data= aid,
         Hess = T, na.action="na.exclude")
```

```
## # weights:  36 (24 variable)
## initial  value 374.299478 
## iter  10 value 307.074620
## iter  20 value 288.285087
## iter  30 value 284.643229
## iter  40 value 284.599735
## iter  50 value 284.592156
## iter  50 value 284.592156
## final  value 284.592156 
## converged
```

```r
summary(m7)
```

```
## Call:
## multinom(formula = gdp_g_categories ~ gdp_pr_capita_log + institutional_quality + 
##     m2_gdp_lagged + sub_saharan_africa + fast_growing_east_asia + 
##     policy + aid, data = aid, na.action = "na.exclude", Hess = T)
## 
## Coefficients:
##        (Intercept) gdp_pr_capita_log institutional_quality m2_gdp_lagged
## high      3.473988        -0.8993799             0.6712125   -0.01042812
## low       3.825400        -0.5966850             0.1387170   -0.04843885
## medium   10.068856        -1.4098052             0.2311572   -0.00481870
##        sub_saharan_africa fast_growing_east_asia    policy         aid
## high            -2.165540              1.1858899 0.7915622 -0.07038696
## low             -1.118220            -10.6380237 0.4137655 -0.06644735
## medium          -1.467001             -0.7734943 0.6354399 -0.53330146
## 
## Std. Errors:
##        (Intercept) gdp_pr_capita_log institutional_quality m2_gdp_lagged
## high      2.921658         0.4006349             0.1896522    0.01563937
## low       4.078240         0.5519184             0.2470825    0.02929763
## medium    2.893170         0.3901350             0.1693027    0.01444013
##        sub_saharan_africa fast_growing_east_asia    policy       aid
## high            0.6837218           0.8786306612 0.1964897 0.1563171
## low             0.7954025           0.0001321678 0.2639425 0.1833258
## medium          0.5585862           0.9613430124 0.1965917 0.1671429
## 
## Residual Deviance: 569.1843 
## AIC: 617.1843
```

Nå er vi klare til å begynne å plotte modell-resultatene. Det nye elementet vi må ta hensyn til, er at de uavhengige variablene har ulike effekter på de ulike utfallene på avhengig variabel. Når vi plotter effekten av en uavhengig variabel, er det derfor fint å plotte alle disse effektene samtidig. Det får vi til. Under viser jeg hvordan du kan lage et datasett som egner seg til plotting av multinomiske modeller ved hjelp av pakkend `effects` og `reshape2`


```r
library(effects)
```

```
## Loading required package: carData
```

```
## lattice theme set by effectsTheme()
## See ?effectsTheme for details.
```

```r
# Funksjonen Effect gjør mye av det samme som predict(), men er litt lettere å bruke med output fra multinom() funksjonen

# ?Effect.multinom sjekk denne før bruk. Er flere argumenter/mer info om output.
# Les også seksjonen om "warnings and limitations"" grundig.
m7.eff <- Effect("aid", m7, xlevels = 100, typical = median)
str(m7.eff)
```

```
## List of 19
##  $ term            : chr "aid"
##  $ formula         :Class 'formula'  language gdp_g_categories ~ gdp_pr_capita_log + institutional_quality + m2_gdp_lagged +      sub_saharan_africa + fast_gro| __truncated__
##   .. ..- attr(*, "variables")= language list(gdp_g_categories, gdp_pr_capita_log, institutional_quality, m2_gdp_lagged,      sub_saharan_africa, fast_gro| __truncated__
##   .. ..- attr(*, "factors")= int [1:8, 1:7] 0 1 0 0 0 0 0 0 0 0 ...
##   .. .. ..- attr(*, "dimnames")=List of 2
##   .. .. .. ..$ : chr [1:8] "gdp_g_categories" "gdp_pr_capita_log" "institutional_quality" "m2_gdp_lagged" ...
##   .. .. .. ..$ : chr [1:7] "gdp_pr_capita_log" "institutional_quality" "m2_gdp_lagged" "sub_saharan_africa" ...
##   .. ..- attr(*, "term.labels")= chr [1:7] "gdp_pr_capita_log" "institutional_quality" "m2_gdp_lagged" "sub_saharan_africa" ...
##   .. ..- attr(*, "order")= int [1:7] 1 1 1 1 1 1 1
##   .. ..- attr(*, "intercept")= int 1
##   .. ..- attr(*, "response")= int 1
##   .. ..- attr(*, ".Environment")=<environment: R_GlobalEnv> 
##   .. ..- attr(*, "predvars")= language list(gdp_g_categories, gdp_pr_capita_log, institutional_quality, m2_gdp_lagged,      sub_saharan_africa, fast_gro| __truncated__
##   .. ..- attr(*, "dataClasses")= Named chr [1:8] "factor" "numeric" "numeric" "numeric" ...
##   .. .. ..- attr(*, "names")= chr [1:8] "gdp_g_categories" "gdp_pr_capita_log" "institutional_quality" "m2_gdp_lagged" ...
##  $ response        : chr "gdp_g_categories"
##  $ y.levels        : chr [1:4] "negative" "high" "low" "medium"
##  $ variables       :List of 1
##   ..$ aid:List of 3
##   .. ..$ name     : chr "aid"
##   .. ..$ is.factor: logi FALSE
##   .. ..$ levels   : num [1:100] -0.00797 0.0873 0.182 0.278 0.373 0.468 0.563 0.659 0.754 0.849 ...
##  $ x               :'data.frame':	100 obs. of  1 variable:
##   ..$ aid: num [1:100] -0.00797 0.0873 0.182 0.278 0.373 0.468 0.563 0.659 0.754 0.849 ...
##  $ model.matrix    : num [1:100, 1:8] 1 1 1 1 1 1 1 1 1 1 ...
##   ..- attr(*, "dimnames")=List of 2
##   .. ..$ : chr [1:100] "1" "2" "3" "4" ...
##   .. ..$ : chr [1:8] "(Intercept)" "gdp_pr_capita_log" "institutional_quality" "m2_gdp_lagged" ...
##   ..- attr(*, "assign")= int [1:8] 0 1 2 3 4 5 6 7
##  $ data            :'data.frame':	270 obs. of  8 variables:
##   ..$ gdp_g_categories      : Factor w/ 4 levels "negative","high",..: 4 4 1 1 1 2 4 4 1 1 ...
##   ..$ gdp_pr_capita_log     : num [1:270] 8.64 8.73 8.67 8.61 8.63 ...
##   ..$ institutional_quality : num [1:270] 4.28 4.28 4.28 4.28 4.28 ...
##   ..$ m2_gdp_lagged         : num [1:270] 24.8 28.8 30.2 29.7 20.3 ...
##   ..$ sub_saharan_africa    : int [1:270] 0 0 0 0 0 0 0 0 0 0 ...
##   ..$ fast_growing_east_asia: int [1:270] 0 0 0 0 0 0 0 0 0 0 ...
##   ..$ policy                : num [1:270] 0.657 -0.579 -0.136 -1.348 -1.09 ...
##   ..$ aid                   : num [1:270] 0.0182 0.0172 0.024 0.03 0.0157 ...
##   ..- attr(*, "terms")=Classes 'terms', 'formula'  language gdp_g_categories ~ gdp_pr_capita_log + institutional_quality + m2_gdp_lagged +      sub_saharan_africa + fast_gro| __truncated__ ...
##   .. .. ..- attr(*, "variables")= language list(gdp_g_categories, gdp_pr_capita_log, institutional_quality, m2_gdp_lagged,      sub_saharan_africa, fast_gro| __truncated__
##   .. .. ..- attr(*, "factors")= int [1:8, 1:7] 0 1 0 0 0 0 0 0 0 0 ...
##   .. .. .. ..- attr(*, "dimnames")=List of 2
##   .. .. .. .. ..$ : chr [1:8] "gdp_g_categories" "gdp_pr_capita_log" "institutional_quality" "m2_gdp_lagged" ...
##   .. .. .. .. ..$ : chr [1:7] "gdp_pr_capita_log" "institutional_quality" "m2_gdp_lagged" "sub_saharan_africa" ...
##   .. .. ..- attr(*, "term.labels")= chr [1:7] "gdp_pr_capita_log" "institutional_quality" "m2_gdp_lagged" "sub_saharan_africa" ...
##   .. .. ..- attr(*, "order")= int [1:7] 1 1 1 1 1 1 1
##   .. .. ..- attr(*, "intercept")= int 1
##   .. .. ..- attr(*, "response")= int 1
##   .. .. ..- attr(*, ".Environment")=<environment: 0x000000001c36dab0> 
##   .. .. ..- attr(*, "predvars")= language list(gdp_g_categories, gdp_pr_capita_log, institutional_quality, m2_gdp_lagged,      sub_saharan_africa, fast_gro| __truncated__
##   .. .. ..- attr(*, "dataClasses")= Named chr [1:8] "factor" "numeric" "numeric" "numeric" ...
##   .. .. .. ..- attr(*, "names")= chr [1:8] "gdp_g_categories" "gdp_pr_capita_log" "institutional_quality" "m2_gdp_lagged" ...
##   ..- attr(*, "na.action")= 'exclude' Named int [1:61] 19 20 24 31 32 34 35 36 37 63 ...
##   .. ..- attr(*, "names")= chr [1:61] "194" "195" "199" "226" ...
##  $ discrepancy     : num 0
##  $ model           : chr "multinom"
##  $ prob            : num [1:100, 1:4] 0.187 0.192 0.197 0.203 0.208 ...
##   ..- attr(*, "dimnames")=List of 2
##   .. ..$ : NULL
##   .. ..$ : chr [1:4] "prob.negative" "prob.high" "prob.low" "prob.medium"
##  $ logit           : num [1:100, 1:4] -1.47 -1.44 -1.4 -1.37 -1.34 ...
##   ..- attr(*, "dimnames")=List of 2
##   .. ..$ : NULL
##   .. ..$ : chr [1:4] "logit.negative" "logit.high" "logit.low" "logit.medium"
##  $ se.prob         : num [1:100, 1:4] 0.0429 0.0427 0.0427 0.0426 0.0426 ...
##   ..- attr(*, "dimnames")=List of 2
##   .. ..$ : NULL
##   .. ..$ : chr [1:4] "se.prob.negative" "se.prob.high" "se.prob.low" "se.prob.medium"
##  $ se.logit        : num [1:100, 1:4] 0.282 0.275 0.269 0.264 0.259 ...
##   ..- attr(*, "dimnames")=List of 2
##   .. ..$ : NULL
##   .. ..$ : chr [1:4] "se.logit.negative" "se.logit.high" "se.logit.low" "se.logit.medium"
##  $ lower.logit     : num [1:100, 1:4] -2.02 -1.97 -1.93 -1.89 -1.84 ...
##   ..- attr(*, "dimnames")=List of 2
##   .. ..$ : NULL
##   .. ..$ : chr [1:4] "L.logit.negative" "L.logit.high" "L.logit.low" "L.logit.medium"
##  $ upper.logit     : num [1:100, 1:4] -0.917 -0.896 -0.874 -0.852 -0.83 ...
##   ..- attr(*, "dimnames")=List of 2
##   .. ..$ : NULL
##   .. ..$ : chr [1:4] "U.logit.negative" "U.logit.high" "U.logit.low" "U.logit.medium"
##  $ lower.prob      : num [1:100, 1:4] 0.117 0.122 0.127 0.132 0.137 ...
##   ..- attr(*, "dimnames")=List of 2
##   .. ..$ : NULL
##   .. ..$ : chr [1:4] "L.prob.negative" "L.prob.high" "L.prob.low" "L.prob.medium"
##  $ upper.prob      : num [1:100, 1:4] 0.286 0.29 0.294 0.299 0.304 ...
##   ..- attr(*, "dimnames")=List of 2
##   .. ..$ : NULL
##   .. ..$ : chr [1:4] "U.prob.negative" "U.prob.high" "U.prob.low" "U.prob.medium"
##  $ confidence.level: num 0.95
##  - attr(*, "class")= chr "effpoly"
```

```r
# lar deg indeksere data som er brukt for å estimere sannsynlighetene
head(m7.eff$model.matrix) 
```

```
##   (Intercept) gdp_pr_capita_log institutional_quality m2_gdp_lagged
## 1           1          7.516705              4.471354      24.75599
## 2           1          7.516705              4.471354      24.75599
## 3           1          7.516705              4.471354      24.75599
## 4           1          7.516705              4.471354      24.75599
## 5           1          7.516705              4.471354      24.75599
## 6           1          7.516705              4.471354      24.75599
##   sub_saharan_africa fast_growing_east_asia    policy      aid
## 1                  0                      0 0.9432316 -0.00797
## 2                  0                      0 0.9432316  0.08730
## 3                  0                      0 0.9432316  0.18200
## 4                  0                      0 0.9432316  0.27800
## 5                  0                      0 0.9432316  0.37300
## 6                  0                      0 0.9432316  0.46800
```

```r
# Lar deg se på predikerte sannsynligheter for observasjoner i datasettet ditt. 
head(m7.eff$data)
```

```
##    gdp_g_categories gdp_pr_capita_log institutional_quality m2_gdp_lagged
## 34           medium          8.637107               4.28125      24.82476
## 35           medium          8.727130               4.28125      28.79304
## 36         negative          8.674026               4.28125      30.23452
## 37         negative          8.610137               4.28125      29.73977
## 38         negative          8.634798               4.28125      20.33055
## 39             high          8.456594               4.28125      21.72240
##    sub_saharan_africa fast_growing_east_asia     policy       aid
## 34                  0                      0  0.6565560 0.0182389
## 35                  0                      0 -0.5792648 0.0171555
## 36                  0                      0 -0.1356454 0.0239942
## 37                  0                      0 -1.3482960 0.0299630
## 38                  0                      0 -1.0904191 0.0157275
## 39                  0                      0  1.2945040 0.0007560
```

```r
# predikerte sannsynligheter:
head(m7.eff$prob)
```

```
##      prob.negative prob.high   prob.low prob.medium
## [1,]     0.1870955 0.2294053 0.08014361   0.5033556
## [2,]     0.1922822 0.2341893 0.08184560   0.4916830
## [3,]     0.1974726 0.2389131 0.08352767   0.4800866
## [4,]     0.2027648 0.2436639 0.08522085   0.4683504
## [5,]     0.2080274 0.2483219 0.08688249   0.4567682
## [6,]     0.2133104 0.2529313 0.08852833   0.4452300
```

```r
# nedre grense konfidensintervall på sannsynlighetsskala
head(m7.eff$lower.prob) 
```

```
##      L.prob.negative L.prob.high L.prob.low L.prob.medium
## [1,]       0.1169955   0.1499711 0.03795727     0.3831896
## [2,]       0.1218869   0.1555086 0.03949295     0.3759677
## [3,]       0.1267631   0.1608787 0.04100343     0.3685015
## [4,]       0.1317042   0.1661491 0.04250950     0.3606195
## [5,]       0.1365754   0.1711574 0.04396591     0.3524906
## [6,]       0.1414120   0.1759259 0.04537934     0.3440205
```

```r
# øvre grense konfidensintervall på sannsynlighetsskala
head(m7.eff$upper.prob)
```

```
##      U.prob.negative U.prob.high U.prob.low U.prob.medium
## [1,]       0.2856115   0.3343632  0.1613528     0.6231352
## [2,]       0.2899110   0.3368022  0.1619591     0.6082964
## [3,]       0.2943302   0.3394849  0.1626726     0.5936944
## [4,]       0.2989650   0.3424887  0.1635176     0.5791148
## [5,]       0.3037118   0.3457627  0.1644839     0.5649776
## [6,]       0.3086242   0.3493538  0.1655888     0.5511956
```

```r
# For å lage fine plot, må vi omorganisere det vi får ut av Effect med melt fra reshape2

library(reshape2)
prob_data <- as.data.frame(cbind(m7.eff$model.matrix, m7.eff$prob))
prob_data <- melt(prob_data, id.vars =1:8, value.name = "probability")

lower_data <- as.data.frame(cbind(m7.eff$x, m7.eff$lower.prob))
lower_data <- melt(lower_data, id.vars = "aid", value.name = "lower")

upper_data <- as.data.frame(cbind(m7.eff$x, m7.eff$upper.prob))
upper_data <- melt(upper_data, id.vars = "aid", value.name = "upper")


plot_data <- prob_data
plot_data$lower <- lower_data$lower
plot_data$upper <- upper_data$upper
str(plot_data)
```

```
## 'data.frame':	400 obs. of  12 variables:
##  $ (Intercept)           : num  1 1 1 1 1 1 1 1 1 1 ...
##  $ gdp_pr_capita_log     : num  7.52 7.52 7.52 7.52 7.52 ...
##  $ institutional_quality : num  4.47 4.47 4.47 4.47 4.47 ...
##  $ m2_gdp_lagged         : num  24.8 24.8 24.8 24.8 24.8 ...
##  $ sub_saharan_africa    : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ fast_growing_east_asia: num  0 0 0 0 0 0 0 0 0 0 ...
##  $ policy                : num  0.943 0.943 0.943 0.943 0.943 ...
##  $ aid                   : num  -0.00797 0.0873 0.182 0.278 0.373 0.468 0.563 0.659 0.754 0.849 ...
##  $ variable              : Factor w/ 4 levels "prob.negative",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ probability           : num  0.187 0.192 0.197 0.203 0.208 ...
##  $ lower                 : num  0.117 0.122 0.127 0.132 0.137 ...
##  $ upper                 : num  0.286 0.29 0.294 0.299 0.304 ...
```

```r
levels(plot_data$variable) 
```

```
## [1] "prob.negative" "prob.high"     "prob.low"      "prob.medium"
```

```r
# Nå er vi klare til å plotte.
```

Nå er datasettet klart til å produsere plot. Under viser jeg tre alternative måter å plotte resultatene på. I dette tilfellet blir det rotetet å plotte alle utfall med konfidensintervall i det samme plottet, fordi konfidensintervallene er så store. Med et større datasett/færre kategorier, får man som regel mindre konfidensintervall, slik at det fungerer bra å plotte alle sannsynligheter med konfidensintervall i et og samme plot. Kjør koden selv i eget script for å teste.


```r
# Effekter for hver kategori i et separat plot med konfidensintervall
ggplot(plot_data, aes(x = aid, y = probability)) +
  geom_rangeframe() +
  ggtitle("probability for all outcomes")  + 
  theme_tufte() + 
  ylab("Predicted probabilities") +
  xlab("Aid") + 
  geom_point() +
  geom_ribbon(data=plot_data, aes(y=probability, ymin=lower, ymax=upper), alpha=.2) +
  geom_line(data=plot_data, aes(y=probability)) + facet_wrap(variable ~.)

# Alt i ett, det beste dersom det er mulig å tolke
ggplot(plot_data, aes(x = aid, y = probability, col = variable)) +
  geom_rangeframe() +
  ggtitle("probability for all outcomes")  + 
  theme_tufte() + 
  ylab("Predicted probabilities") +
  xlab("Aid") + 
  geom_ribbon(data=plot_data, aes(y=probability, ymin=lower, ymax=upper), alpha=.05) +
  geom_line(data=plot_data, aes(y=probability))
# merk at lavere alpha-verdi gir mer "gjennomsiktige" konfidensintervaller 

# uten konfidensintervaller
ggplot(plot_data, aes(x = aid, y = probability, col = variable)) +
  geom_rangeframe() +
  ggtitle("probability for all outcomes")  + 
  theme_tufte() + 
  ylab("Predicted probabilities") +
  xlab("Aid") + 
  geom_line(data=plot_data, aes(y=probability))
```



### Paneldata:

I denne seksjonen viser jeg hvordan noen triks vi allerede har lært kan brukes til å analysere paneldata. Jeg viser også metoder for paneldata som ble gjennomgått på forelesning. Vær sikker på at du forstår hva som foregår dersom du velger å bruke noen av disse funksjonene (både statistisk og i R).

**Balansert eller ubalansert panel?**

```r
# sjekker om panelet er balansert.
table(aid$country, aid$period) 
```

```
##      
##       2 3 4 5 6 7
##   ARG 1 1 1 1 1 1
##   BOL 1 1 1 1 1 1
##   BRA 1 1 1 1 1 1
##   BWA 1 1 1 1 1 1
##   CHL 1 1 1 1 1 1
##   CIV 1 1 1 1 1 1
##   CMR 1 1 1 1 1 1
##   COL 1 1 1 1 1 1
##   CRI 1 1 1 1 1 1
##   DOM 1 1 1 1 1 1
##   DZA 1 1 1 1 1 1
##   ECU 1 1 1 1 1 1
##   EGY 1 1 1 1 1 1
##   ETH 1 1 1 1 1 1
##   GAB 1 1 1 1 1 1
##   GHA 1 1 1 1 1 1
##   GMB 1 1 1 1 0 0
##   GTM 1 1 1 1 1 1
##   GUY 1 1 1 1 1 0
##   HND 1 1 1 1 1 1
##   HTI 1 1 1 1 1 1
##   IDN 1 1 1 1 1 1
##   IND 1 1 1 1 1 1
##   JAM 1 1 1 1 1 1
##   KEN 1 1 1 1 1 1
##   KOR 1 1 1 1 1 1
##   LKA 1 1 1 1 1 1
##   MAR 1 1 1 1 1 1
##   MDG 1 1 1 1 1 1
##   MEX 1 1 1 1 1 1
##   MLI 1 1 1 1 1 1
##   MWI 1 1 1 1 1 1
##   MYS 1 1 1 1 1 1
##   NER 1 1 1 1 1 1
##   NGA 1 1 1 1 1 1
##   NIC 1 1 1 1 0 0
##   PAK 1 1 1 1 1 1
##   PER 1 1 1 1 1 1
##   PHL 1 1 1 1 1 1
##   PRY 1 1 1 1 1 1
##   SEN 1 1 1 1 1 1
##   SLE 1 1 1 1 1 1
##   SLV 1 1 1 1 1 1
##   SOM 1 1 1 1 1 1
##   SYR 1 1 1 1 1 1
##   TGO 1 1 1 1 1 1
##   THA 1 1 1 1 1 1
##   TTO 1 1 1 1 1 1
##   TUN 1 1 1 1 1 1
##   TUR 1 1 1 1 1 1
##   TZA 1 1 1 1 1 1
##   URY 1 1 1 1 1 1
##   VEN 1 1 1 1 1 1
##   ZAR 1 1 1 1 1 1
##   ZMB 1 1 1 1 1 1
##   ZWE 1 1 1 1 1 1
```

```r
# sjekker om panelet er balansert etter at missing er fjernet, gjør dette for datasett.
# med kun variablene du bruker i analysene dine.
with(aid[complete.cases(aid),], table(country, period))
```

```
##        period
## country 2 3 4 5 6 7
##     ARG 1 1 1 1 1 1
##     BOL 1 1 1 1 1 1
##     BRA 1 1 1 1 1 1
##     BWA 0 0 1 1 1 0
##     CHL 1 1 1 1 1 1
##     CIV 0 0 1 0 0 0
##     CMR 0 1 1 1 1 1
##     COL 1 1 1 1 1 1
##     CRI 1 1 1 1 1 1
##     DOM 1 1 1 1 1 1
##     DZA 1 1 0 0 0 0
##     ECU 1 1 1 1 1 1
##     EGY 0 1 1 1 1 1
##     ETH 0 0 0 1 1 0
##     GAB 1 1 1 1 1 1
##     GHA 1 1 1 1 1 1
##     GMB 1 1 1 1 0 0
##     GTM 1 1 1 1 1 1
##     GUY 1 1 1 1 1 0
##     HND 1 1 1 1 1 1
##     HTI 1 1 1 1 1 0
##     IDN 1 1 1 1 1 1
##     IND 1 1 1 1 1 1
##     JAM 0 1 1 1 0 0
##     KEN 1 1 1 1 1 1
##     KOR 1 1 1 1 1 1
##     LKA 1 1 1 1 1 1
##     MAR 1 1 1 1 1 1
##     MDG 1 1 0 0 1 1
##     MEX 1 1 1 1 1 1
##     MLI 0 0 0 0 1 0
##     MWI 0 0 1 1 1 1
##     MYS 1 1 1 1 1 1
##     NER 0 1 1 0 0 0
##     NGA 1 1 1 1 1 1
##     NIC 1 1 1 1 0 0
##     PAK 1 1 1 1 1 1
##     PER 1 1 1 1 1 1
##     PHL 1 1 1 1 1 1
##     PRY 1 1 1 1 1 1
##     SEN 1 1 1 1 0 0
##     SLE 1 1 1 1 1 1
##     SLV 1 1 1 1 1 1
##     SOM 0 1 1 0 0 0
##     SYR 1 1 1 0 1 1
##     TGO 0 1 1 1 1 0
##     THA 1 1 1 1 1 1
##     TTO 1 1 1 1 1 0
##     TUN 0 0 0 1 1 1
##     TUR 0 0 0 0 0 1
##     TZA 0 0 0 1 1 0
##     URY 1 1 1 1 1 1
##     VEN 1 1 1 1 1 1
##     ZAR 1 1 1 1 1 0
##     ZMB 1 1 1 1 1 1
##     ZWE 0 0 0 1 1 1
```


**Visualisere trender i ulike land på avh.var, se også funksjon i fasit til oppgaver sem 2:**

```r
library(ggplot2)
# Vurder å plotte færre land om gangen 
ggplot(aid, aes(x = period, y = gdp_growth)) + geom_line() + facet_wrap(~country)

# Enda mer info i plottet:
# Oppretter standardiserte versjoner av aid og gdp_growth 
aid$aid_s <- (aid$aid - mean(aid$aid, na.rm = T))/sd(aid$aid, na.rm = T)
aid$gdp_growth_s <- (aid$gdp_growth - mean(aid$gdp_growth, na.rm = T))/sd(aid$gdp_growth, na.rm = T)
# Lager plot der jeg tegner to linjer oppå hverandre, ut fra verdier på standardiserte var.
ggplot(aid) + geom_line(aes(x = period, y = gdp_growth_s, col = "growth")) + 
   geom_line(aes(x = period, y = aid_s, col = "aid")) +
  facet_wrap(~country) +
  ylab("Standardized values for aid and growth")

# ggplot er ganske fleksibelt:)

# Husk at du kan forstørre bildet ved å trykke på Zoom. 
# Du kan også bestemme størrelse på bilder du lagrer med ggsave
```

**Fixed-effects i OLS**
Ved å kode en variabel til `factor`, blir alle det opprettet dummyer for aller verdier på variabelen bortsett fra en referansekategori. Vi kan bruke dette trikse rett inn i en OLS med `as.factor()`, eller opprette en faktor-variabel og bestemme referansekategori med `relevel()`:

```r
class(aid$country)
```

```
## [1] "character"
```

```r
aid$country_f <- as.factor(aid$country)
levels(aid$country_f)
```

```
##  [1] "ARG" "BOL" "BRA" "BWA" "CHL" "CIV" "CMR" "COL" "CRI" "DOM" "DZA"
## [12] "ECU" "EGY" "ETH" "GAB" "GHA" "GMB" "GTM" "GUY" "HND" "HTI" "IDN"
## [23] "IND" "JAM" "KEN" "KOR" "LKA" "MAR" "MDG" "MEX" "MLI" "MWI" "MYS"
## [34] "NER" "NGA" "NIC" "PAK" "PER" "PHL" "PRY" "SEN" "SLE" "SLV" "SOM"
## [45] "SYR" "TGO" "THA" "TTO" "TUN" "TUR" "TZA" "URY" "VEN" "ZAR" "ZMB"
## [56] "ZWE"
```

```r
aid$country_f <- relevel(aid$country_f, ref = "EGY") # Setter Egypt som referanse
```

Siden fixed-effects vanligvis legges inn som kontrollvariabler, og ikke for substansiell tolkning, er det som regel ikke behov for å definere referansekategori, slik jeg gjorde over. I stedet kan du legge inn `as.factor()` direkte i regresjonsligningen:


```r
summary(lm(gdp_growth ~ aid + policy + as.factor(country), data = aid))
```

```
## 
## Call:
## lm(formula = gdp_growth ~ aid + policy + as.factor(country), 
##     data = aid)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -11.1531  -1.3755   0.1155   1.4889  11.6146 
## 
## Coefficients:
##                       Estimate Std. Error t value Pr(>|t|)    
## (Intercept)            0.56589    1.27598   0.443   0.6578    
## aid                   -0.00795    0.23867  -0.033   0.9735    
## policy                 0.93455    0.22873   4.086  6.1e-05 ***
## as.factor(country)BOL -1.98247    1.89213  -1.048   0.2959    
## as.factor(country)BRA  2.01426    1.80333   1.117   0.2652    
## as.factor(country)BWA  2.52274    2.36166   1.068   0.2866    
## as.factor(country)CHL -0.52457    1.88469  -0.278   0.7810    
## as.factor(country)CIV -3.55763    3.38259  -1.052   0.2940    
## as.factor(country)CMR -0.78613    1.96668  -0.400   0.6897    
## as.factor(country)COL  0.03422    1.85166   0.018   0.9853    
## as.factor(country)CRI -0.53135    1.86438  -0.285   0.7759    
## as.factor(country)DOM  1.15762    1.82963   0.633   0.5276    
## as.factor(country)DZA  1.24287    2.57313   0.483   0.6295    
## as.factor(country)ECU -0.10537    1.89464  -0.056   0.9557    
## as.factor(country)EGY  2.87731    1.97837   1.454   0.1472    
## as.factor(country)ETH -4.62822    2.43912  -1.897   0.0590 .  
## as.factor(country)GAB -0.14461    1.87596  -0.077   0.9386    
## as.factor(country)GHA -2.59071    1.89432  -1.368   0.1728    
## as.factor(country)GMB -0.40533    2.36219  -0.172   0.8639    
## as.factor(country)GTM -1.41199    1.84939  -0.763   0.4460    
## as.factor(country)GUY -1.40097    1.95642  -0.716   0.4747    
## as.factor(country)HND -0.81447    1.90346  -0.428   0.6691    
## as.factor(country)HTI -2.62636    1.87484  -1.401   0.1626    
## as.factor(country)IDN  1.39547    1.96132   0.711   0.4775    
## as.factor(country)IND  0.79082    1.81761   0.435   0.6639    
## as.factor(country)JAM -3.58553    2.23478  -1.604   0.1100    
## as.factor(country)KEN -0.02628    1.90180  -0.014   0.9890    
## as.factor(country)KOR  3.41936    1.96545   1.740   0.0833 .  
## as.factor(country)LKA  1.13568    1.85368   0.613   0.5407    
## as.factor(country)MAR -0.32338    1.86325  -0.174   0.8624    
## as.factor(country)MDG -3.15441    2.13100  -1.480   0.1402    
## as.factor(country)MEX -0.33916    1.83381  -0.185   0.8534    
## as.factor(country)MLI  2.32153    3.86381   0.601   0.5485    
## as.factor(country)MWI -2.18760    2.42926  -0.901   0.3688    
## as.factor(country)MYS  1.15480    1.93127   0.598   0.5505    
## as.factor(country)NER  0.08481    2.86421   0.030   0.9764    
## as.factor(country)NGA -0.58247    1.81947  -0.320   0.7492    
## as.factor(country)NIC -3.49192    2.05172  -1.702   0.0901 .  
## as.factor(country)PAK  1.61635    1.82256   0.887   0.3761    
## as.factor(country)PER -1.41420    1.80749  -0.782   0.4348    
## as.factor(country)PHL -1.08130    1.84746  -0.585   0.5589    
## as.factor(country)PRY  0.20284    1.85255   0.109   0.9129    
## as.factor(country)SEN -1.62709    2.20849  -0.737   0.4620    
## as.factor(country)SLE -1.24649    1.85119  -0.673   0.5014    
## as.factor(country)SLV -2.18902    1.89269  -1.157   0.2487    
## as.factor(country)SOM -0.52772    2.37750  -0.222   0.8245    
## as.factor(country)SYR  1.82785    1.95483   0.935   0.3508    
## as.factor(country)TGO -1.25180    2.39063  -0.524   0.6011    
## as.factor(country)THA  1.61694    1.96568   0.823   0.4116    
## as.factor(country)TTO -0.98105    1.91393  -0.513   0.6087    
## as.factor(country)TUN -0.91658    2.26229  -0.405   0.6857    
## as.factor(country)TUR  1.25200    1.82392   0.686   0.4931    
## as.factor(country)TZA -0.68832    2.60496  -0.264   0.7918    
## as.factor(country)URY -0.09145    1.81864  -0.050   0.9599    
## as.factor(country)VEN -2.46018    1.84332  -1.335   0.1833    
## as.factor(country)ZAR -3.79873    1.87986  -2.021   0.0445 *  
## as.factor(country)ZMB -2.65594    2.13573  -1.244   0.2149    
## as.factor(country)ZWE -1.63316    1.93764  -0.843   0.4002    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 3.123 on 226 degrees of freedom
##   (47 observations deleted due to missingness)
## Multiple R-squared:  0.4099,	Adjusted R-squared:  0.2611 
## F-statistic: 2.754 on 57 and 226 DF,  p-value: 5.494e-08
```

Dersom dere husker tilbake til analysen av `beer` datasettet fra introen og første seminar, var det dette vi gjorde i en av oppgavene der.

**Praise-Winsten**


```r
#install.packages("prais")
library(prais)
library(stargazer)
```

```
## 
## Please cite as:
```

```
##  Hlavac, Marek (2018). stargazer: Well-Formatted Regression and Summary Statistics Tables.
```

```
##  R package version 5.2.2. https://CRAN.R-project.org/package=stargazer
```

```r
pw1 <-prais.winsten(gdp_growth ~ aid*policy, data = aid) # bytt lm med prais.winsten
pw1 # her fungerer ikke summary så bra
```

```
## [[1]]
## 
## Call:
## lm(formula = fo)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -12.3616  -1.6230   0.2097   1.7060  11.5213 
## 
## Coefficients:
##           Estimate Std. Error t value Pr(>|t|)    
## Intercept -0.05209    0.35451  -0.147    0.883    
## aid       -0.19107    0.11591  -1.648    0.100    
## policy     1.30035    0.16968   7.663 2.95e-13 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 3.209 on 281 degrees of freedom
## Multiple R-squared:  0.2543,	Adjusted R-squared:  0.2464 
## F-statistic: 31.95 on 3 and 281 DF,  p-value: < 2.2e-16
## 
## 
## [[2]]
##        Rho Rho.t.statistic Iterations
##  0.1171306        1.979471          4
```

```r
# Funksjon for å gjøre det lettere å jobbe med output, løsning herfra:
# https://stackoverflow.com/questions/49109282/how-to-work-with-prais-winsten-results-in-stargazer-and-broom-r
prais.winsten2 <- function (formula, data, iter = 50, rho = 0, tol = 1e-08) 
{
    mod <- model.frame(formula, data = data)
    lm <- lm(mod)
    n <- length(mod[, 1])
    list.rho <- c(0)
    imax <- ncol(mod) - 1
    fo <- as.formula(paste("y ~ -1 + x0 +", paste(paste0("x", 
        1:imax), collapse = "+")))
    if (rho != 0) {
        y <- c((1 - rho^2)^(1/2) * mod[1, 1], mod[2:n, 1] - rho * 
            mod[1:(n - 1), 1])
        x0 <- c((1 - rho^2)^(1/2), rep(1 - rho, n - 1))
        for (i in 1:imax) {
            x <- c((1 - rho^2)^(1/2) * mod[1, (i + 1)], mod[2:n, 
                (i + 1)] - rho * mod[1:(n - 1), (i + 1)])
            assign(paste("x", i, sep = ""), x)
        }
        lm <- lm(fo)
        j <- 1
        rho.tstat <- "none"
    }
    else {
        res <- lm$res
        res_1 <- c(NA, res[-n])
        for (i in 1:iter) {
            rho.lm <- lm(res ~ res_1 - 1)
            rho <- rho.lm$coeff[1]
            if (abs(rho - tail(list.rho, n = 1)) < tol) {
                j <- i
                break
            }
            else {
                list.rho <- append(list.rho, rho)
                y <- c((1 - rho^2)^(1/2) * mod[1, 1], mod[2:n, 
                  1] - rho * mod[1:(n - 1), 1])
                x0 <- c((1 - rho^2)^(1/2), rep(1 - rho, n - 1))
                for (k in 1:imax) {
                  x <- c((1 - rho^2)^(1/2) * mod[1, (k + 1)], 
                    mod[2:n, (k + 1)] - rho * mod[1:(n - 1), 
                      (k + 1)])
                  assign(paste("x", k, sep = ""), x)
                }
                lm <- lm(fo)
                fit <- as.vector(rep(lm$coef[1], n)) + as.vector(as.matrix(mod[, 
                  2:(imax + 1)]) %*% lm$coef[2:(imax + 1)])
                res <- mod[, 1] - fit
                res_1 <- c(NA, res[-n])
                j <- i
                rho.tstat <- summary(rho.lm)$coef[1, 3]
            }
        }
    }
    if (iter == 50) 
        i <- j - 1
    else i <- j
    attr(lm$coefficients, "names") <- c("Intercept", names(mod)[2:ncol(mod)])
    s <- summary(lm)
    r <- data.frame(Rho = rho, `Rho.t-statistic` = rho.tstat, 
        Iterations = i, row.names = c(""))
    results <- list(s, r)
    return(lm)
}
pw2 <- prais.winsten2(gdp_growth ~ aid*policy, data = aid)
summary(pw2)
```

```
## 
## Call:
## lm(formula = fo)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -12.3616  -1.6230   0.2097   1.7060  11.5213 
## 
## Coefficients:
##           Estimate Std. Error t value Pr(>|t|)    
## Intercept -0.05209    0.35451  -0.147    0.883    
## aid       -0.19107    0.11591  -1.648    0.100    
## policy     1.30035    0.16968   7.663 2.95e-13 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 3.209 on 281 degrees of freedom
## Multiple R-squared:  0.2543,	Adjusted R-squared:  0.2464 
## F-statistic: 31.95 on 3 and 281 DF,  p-value: < 2.2e-16
```

```r
stargazer(pw2, type = "text")
```

```
## 
## ===============================================
##                         Dependent variable:    
##                     ---------------------------
##                                  y             
## -----------------------------------------------
## aid                           -0.191           
##                               (0.116)          
##                                                
## policy                       1.300***          
##                               (0.170)          
##                                                
## Constant                      -0.052           
##                               (0.355)          
##                                                
## -----------------------------------------------
## Observations                    284            
## R2                             0.254           
## Adjusted R2                    0.246           
## Residual Std. Error      3.209 (df = 281)      
## F Statistic           31.947*** (df = 3; 281)  
## ===============================================
## Note:               *p<0.1; **p<0.05; ***p<0.01
```

```r
# For å se på rho, må du indeksere fra pw1:
pw1[2]
```

```
## [[1]]
##        Rho Rho.t.statistic Iterations
##  0.1171306        1.979471          4
```

**Hausman-test**
Skal du velge random effects eller fixed effects? Hausman-testen gir en indikasjon. Her bruker jeg `plm` pakken, som er laget for å jobbe med paneldata. Se [her](http://ftp.uni-bayreuth.de/math/statlib/R/CRAN/doc/vignettes/plm/plmEN.pdf) for en tutorial.



```r
#install.packages("plm")
library(plm)
```

```
## Loading required package: Formula
```

```r
# Sett model = "within" for faste effekter
pm1 <- plm(gdp_growth ~ aid + policy, data = aid, index = c("country", "period"), model = "within")
summary(pm1) # gjemmer de faste effektene fra output, ellers likt som modell med lm over.
```

```
## Oneway (individual) effect Within Model
## 
## Call:
## plm(formula = gdp_growth ~ aid + policy, data = aid, model = "within", 
##     index = c("country", "period"))
## 
## Unbalanced Panel: n = 56, T = 1-6, N = 284
## 
## Residuals:
##      Min.   1st Qu.    Median   3rd Qu.      Max. 
## -11.15307  -1.37545   0.11554   1.48887  11.61458 
## 
## Coefficients:
##          Estimate Std. Error t-value Pr(>|t|)    
## aid    -0.0079495  0.2386666 -0.0333   0.9735    
## policy  0.9345478  0.2287252  4.0859  6.1e-05 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Total Sum of Squares:    2367.7
## Residual Sum of Squares: 2204.9
## R-Squared:      0.068789
## Adj. R-Squared: -0.16607
## F-statistic: 8.34731 on 2 and 226 DF, p-value: 0.00031802
```

```r
# Sett model = "random" for random effects
pm2 <- plm(gdp_growth ~ aid + policy, data = aid, index = c("country", "period"), model = "random")
summary(pm2)
```

```
## Oneway (individual) effect Random Effect Model 
##    (Swamy-Arora's transformation)
## 
## Call:
## plm(formula = gdp_growth ~ aid + policy, data = aid, model = "random", 
##     index = c("country", "period"))
## 
## Unbalanced Panel: n = 56, T = 1-6, N = 284
## 
## Effects:
##                  var std.dev share
## idiosyncratic 9.7560  3.1235 0.945
## individual    0.5687  0.7541 0.055
## theta:
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
## 0.02793 0.12005 0.13926 0.12828 0.13926 0.13926 
## 
## Residuals:
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
## -12.2215  -1.6276   0.2527   0.0028   1.7152  12.1667 
## 
## Coefficients:
##              Estimate Std. Error t-value  Pr(>|t|)    
## (Intercept) -0.059179   0.353846 -0.1672    0.8673    
## aid         -0.180912   0.116159 -1.5575    0.1205    
## policy       1.288358   0.168487  7.6466 3.292e-13 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Total Sum of Squares:    3410.9
## Residual Sum of Squares: 2775.3
## R-Squared:      0.18634
## Adj. R-Squared: 0.18055
## F-statistic: 32.1756 on 2 and 281 DF, p-value: 2.6155e-13
```

```r
# hausman test
phtest(pm1, pm2)
```

```
## 
## 	Hausman Test
## 
## data:  gdp_growth ~ aid + policy
## chisq = 5.6297, df = 2, p-value = 0.05991
## alternative hypothesis: one model is inconsistent
```



**OLS PCSE**

```r
#install.packages("lmtest")
library(lmtest)
```

```
## Loading required package: zoo
```

```
## 
## Attaching package: 'zoo'
```

```
## The following objects are masked from 'package:base':
## 
##     as.Date, as.Date.numeric
```

```r
library(plm)
#?vcovBK -> les under Details!
pm3 <- plm(gdp_growth ~ aid + policy, data = aid, index = c("country", "period"), model = "pooling")
# Sjekk vcovHC() fra sandwich pakken for å lage andre typer standardfeil
vcovBK(pm1, type = "HC3", cluster = "group")
```

```
##                 aid       policy
## aid     0.075935524 -0.002405484
## policy -0.002405484  0.059589642
## attr(,"cluster")
## [1] "group"
```

```r
coeftest(pm3, vcov=vcovBK(pm1, type = "HC3", cluster = "group"))
```

```
## 
## t test of coefficients:
## 
##        Estimate Std. Error t value  Pr(>|t|)    
## aid    -0.19701    0.27556 -0.7149    0.4752    
## policy  1.33027    0.24411  5.4495 1.105e-07 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```


 
