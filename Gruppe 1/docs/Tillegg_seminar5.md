---
title: "Etter seminar 5 - mer om modellene"
author: "Erlend Langørgen"
date: "September 29, 2018"
output: 
  html_document:
    keep_md: true
---



### Introduksjon

I dette dokumentet gir jeg en oversikt over ytterligere R-ressurser for de av dere som planlegger å bruke flernivå/multinomisk logistisk regresjon/faktoranalyse i hjemmeoppgaven. Dere vil ikke bli testet i disse emnene til prøven. Dokumentet er *Work in progress*, skal få ferdig deler om flernivå og faktoranalyse **asap**.

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
##   .. .. ..- attr(*, ".Environment")=<environment: 0x00000000215512a8> 
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





