R fordypningsseminar 3: Faktoranalyse
================

``` r
########################
### Faktoranalyse   ####
########################


## For mer dokumentasjon/tutorials - sjekk (evt. kan du google):
#https://cran.r-project.org/web/packages/psych/index.html

#install.packages("psych")
library(psych)
library(tidyverse)
```

    ## -- Attaching packages --------------------------------------------------------------------------------------------------------------------------- tidyverse 1.3.0 --

    ## v ggplot2 3.3.2     v purrr   0.3.4
    ## v tibble  3.0.1     v dplyr   1.0.0
    ## v tidyr   1.1.0     v stringr 1.4.0
    ## v readr   1.3.1     v forcats 0.5.0

    ## -- Conflicts ------------------------------------------------------------------------------------------------------------------------------ tidyverse_conflicts() --
    ## x ggplot2::%+%()   masks psych::%+%()
    ## x ggplot2::alpha() masks psych::alpha()
    ## x dplyr::filter()  masks stats::filter()
    ## x dplyr::lag()     masks stats::lag()

``` r
library(GPArotation)

## Start med samme data fra European Social Survey som i flernivå-scriptet
## Last ned fra data-mappen på github, lagre data i prosjektmappen din (working directory)
# og kjør følgende kode:

load("../data/ess.rda")

## Ser på korrelasjoner mellom tillitsvariabler

korrel <- ess %>%
  select(contains("trust")) %>%
cor(, use = "complete.obs")
korrel
```

    ##                     trust_parl trust_legalsys trust_police trust_politicians
    ## trust_parl           1.0000000      0.6653743    0.5182319         0.7475047
    ## trust_legalsys       0.6653743      1.0000000    0.6603981         0.6078917
    ## trust_police         0.5182319      0.6603981    1.0000000         0.4979014
    ## trust_politicians    0.7475047      0.6078917    0.4979014         1.0000000
    ## trust_polparties     0.7153119      0.5740346    0.4627198         0.8678236
    ## trust_eurparl        0.5965263      0.5095607    0.4041702         0.6299152
    ## trust_unitednations  0.5455322      0.5149316    0.4500541         0.5322303
    ##                     trust_polparties trust_eurparl trust_unitednations
    ## trust_parl                 0.7153119     0.5965263           0.5455322
    ## trust_legalsys             0.5740346     0.5095607           0.5149316
    ## trust_police               0.4627198     0.4041702           0.4500541
    ## trust_politicians          0.8678236     0.6299152           0.5322303
    ## trust_polparties           1.0000000     0.6298852           0.5353490
    ## trust_eurparl              0.6298852     1.0000000           0.6838491
    ## trust_unitednations        0.5353490     0.6838491           1.0000000

``` r
cor.plot(korrel, numbers = TRUE)
```

![](Fordypningsseminar-3-Faktoranalyse_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

``` r
KMO(korrel) # Keyser-Meyer-Olkin, alle er godt over .5
```

    ## Kaiser-Meyer-Olkin factor adequacy
    ## Call: KMO(r = korrel)
    ## Overall MSA =  0.87
    ## MSA for each item = 
    ##          trust_parl      trust_legalsys        trust_police   trust_politicians 
    ##                0.93                0.88                0.87                0.83 
    ##    trust_polparties       trust_eurparl trust_unitednations 
    ##                0.84                0.88                0.87

``` r
## Induktivt valg av faktorer: principal component
trust_prin <- princomp(~., ess %>% 
                         select(contains("trust")),
                       scores = TRUE)

summary(trust_prin)
```

    ## Importance of components:
    ##                           Comp.1    Comp.2    Comp.3     Comp.4     Comp.5
    ## Standard deviation     5.2150545 2.1128970 1.9541738 1.44571233 1.33772021
    ## Proportion of Variance 0.6517995 0.1069924 0.0915214 0.05009104 0.04288712
    ## Cumulative Proportion  0.6517995 0.7587919 0.8503133 0.90040431 0.94329143
    ##                            Comp.6     Comp.7
    ## Standard deviation     1.28221457 0.84978286
    ## Proportion of Variance 0.03940195 0.01730662
    ## Cumulative Proportion  0.98269338 1.00000000

``` r
loadings(trust_prin)
```

    ## 
    ## Loadings:
    ##                     Comp.1 Comp.2 Comp.3 Comp.4 Comp.5 Comp.6 Comp.7
    ## trust_parl           0.424         0.296  0.502  0.387  0.571       
    ## trust_legalsys       0.400  0.520 -0.114  0.477 -0.366 -0.442       
    ## trust_police         0.306  0.601 -0.265 -0.597         0.331       
    ## trust_politicians    0.397 -0.124  0.424 -0.257        -0.211 -0.732
    ## trust_polparties     0.384 -0.185  0.417 -0.309        -0.301  0.677
    ## trust_eurparl        0.369 -0.454 -0.282        -0.659  0.379       
    ## trust_unitednations  0.355 -0.335 -0.629         0.523 -0.302       
    ## 
    ##                Comp.1 Comp.2 Comp.3 Comp.4 Comp.5 Comp.6 Comp.7
    ## SS loadings     1.000  1.000  1.000  1.000  1.000  1.000  1.000
    ## Proportion Var  0.143  0.143  0.143  0.143  0.143  0.143  0.143
    ## Cumulative Var  0.143  0.286  0.429  0.571  0.714  0.857  1.000

``` r
screeplot(trust_prin, type = "lines")
```

![](Fordypningsseminar-3-Faktoranalyse_files/figure-gfm/unnamed-chunk-1-2.png)<!-- -->

``` r
## Vi velger antall faktorer, her 2, under 3.
trust_factor1 <- factanal(~., 2, ess %>% 
                            select(trust_parl, trust_legalsys, trust_police, 
                                   trust_politicians, trust_polparties, 
                                   trust_eurparl, trust_unitednations))
names(trust_factor1)
```

    ##  [1] "converged"    "loadings"     "uniquenesses" "correlation"  "criteria"    
    ##  [6] "factors"      "dof"          "method"       "rotmat"       "na.action"   
    ## [11] "STATISTIC"    "PVAL"         "n.obs"        "call"

``` r
print(loadings(trust_factor1), cutoff = .5)
```

    ## 
    ## Loadings:
    ##                     Factor1 Factor2
    ## trust_parl          0.631   0.540  
    ## trust_legalsys              0.794  
    ## trust_police                0.691  
    ## trust_politicians   0.855          
    ## trust_polparties    0.870          
    ## trust_eurparl       0.573          
    ## trust_unitednations                
    ## 
    ##                Factor1 Factor2
    ## SS loadings      2.614   2.052
    ## Proportion Var   0.373   0.293
    ## Cumulative Var   0.373   0.667

``` r
trust_factor2 <- factanal(~., 3, ess %>% 
                            select(trust_parl, trust_legalsys, trust_police, 
                                   trust_politicians, trust_polparties, 
                                   trust_eurparl, trust_unitednations))


print(loadings(trust_factor2), cutoff = .5)
```

    ## 
    ## Loadings:
    ##                     Factor1 Factor2 Factor3
    ## trust_parl          0.593                  
    ## trust_legalsys              0.861          
    ## trust_police                0.604          
    ## trust_politicians   0.845                  
    ## trust_polparties    0.813                  
    ## trust_eurparl                       0.602  
    ## trust_unitednations                 0.828  
    ## 
    ##                Factor1 Factor2 Factor3
    ## SS loadings      2.154   1.671   1.442
    ## Proportion Var   0.308   0.239   0.206
    ## Cumulative Var   0.308   0.546   0.752

``` r
## Rotasjon
varimax(loadings(trust_factor2), normalize = TRUE)
```

    ## $loadings
    ## 
    ## Loadings:
    ##                     Factor1 Factor2 Factor3
    ## trust_parl          0.593   0.471   0.325  
    ## trust_legalsys      0.306   0.861   0.239  
    ## trust_police        0.264   0.604   0.250  
    ## trust_politicians   0.845   0.330   0.277  
    ## trust_polparties    0.813   0.292   0.305  
    ## trust_eurparl       0.450   0.262   0.603  
    ## trust_unitednations 0.248   0.282   0.828  
    ## 
    ##                Factor1 Factor2 Factor3
    ## SS loadings      2.154   1.670   1.443
    ## Proportion Var   0.308   0.239   0.206
    ## Cumulative Var   0.308   0.546   0.752
    ## 
    ## $rotmat
    ##               [,1]          [,2]         [,3]
    ## [1,]  1.000000e+00 -0.0001547644 4.355716e-05
    ## [2,]  1.547545e-04  0.9999999622 2.271306e-04
    ## [3,] -4.359231e-05 -0.0002271238 1.000000e+00

``` r
promax(loadings(trust_factor2))
```

    ## $loadings
    ## 
    ## Loadings:
    ##                     Factor1 Factor2 Factor3
    ## trust_parl           0.534   0.291         
    ## trust_legalsys               0.999         
    ## trust_police                 0.650         
    ## trust_politicians    1.005                 
    ## trust_polparties     0.960                 
    ## trust_eurparl        0.285           0.594 
    ## trust_unitednations -0.136           1.006 
    ## 
    ##                Factor1 Factor2 Factor3
    ## SS loadings      2.318   1.510   1.381
    ## Proportion Var   0.331   0.216   0.197
    ## Cumulative Var   0.331   0.547   0.744
    ## 
    ## $rotmat
    ##            [,1]       [,2]       [,3]
    ## [1,]  1.5218255 -0.4399056 -0.4543902
    ## [2,] -0.4647856  1.4155118 -0.2809153
    ## [3,] -0.4614796 -0.3549989  1.4473241

``` r
oblimin(loadings(trust_factor2))
```

    ## Oblique rotation method Oblimin Quartimin converged.
    ## Loadings:
    ##                      Factor1 Factor2 Factor3
    ## trust_parl           0.52573  0.2953  0.0933
    ## trust_legalsys      -0.00278  0.9533 -0.0118
    ## trust_police         0.03968  0.6239  0.0818
    ## trust_politicians    0.94934  0.0222 -0.0248
    ## trust_polparties     0.91040 -0.0242  0.0330
    ## trust_eurparl        0.31966 -0.0113  0.5592
    ## trust_unitednations -0.04470  0.0265  0.9211
    ## 
    ## Rotating matrix:
    ##        [,1]   [,2]   [,3]
    ## [1,]  1.391 -0.395 -0.360
    ## [2,] -0.405  1.331 -0.247
    ## [3,] -0.332 -0.303  1.305
    ## 
    ## Phi:
    ##       [,1]  [,2]  [,3]
    ## [1,] 1.000 0.676 0.649
    ## [2,] 0.676 1.000 0.605
    ## [3,] 0.649 0.605 1.000

``` r
## Opprette additive indekser - eksempel (her finnes det mange muligheter - se pensum/forelesning):
ess$political_trust <- (ess$trust_parl + ess$trust_politicians + ess$trust_polparties) / 3
ess$legal_trust <- (ess$trust_legalsys + ess$trust_police) / 2
ess$international_trust <- (ess$trust_unitednations + ess$trust_eurparl) / 2
```
