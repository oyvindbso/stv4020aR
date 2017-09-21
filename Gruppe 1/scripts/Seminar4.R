##############################################
########## Seminar 4 - STV 4020 A ############
##############################################

#### Forberedelser ####

## pakker til seminaret
#install.packages("nnet")
#install.packages("car")
#install.packages("stargazer")

library(nnet)
library(car)
library(stargazer)

## Data til seminaret, ligger i github mappen
load("aidgrowth.RData")

str(aid)


## Lager datasett uten missing for policy
aid <- subset(aid, is.na(policy)==F)

## Burnside and Dollar reported regression:
m5 <- lm(gdp_growth ~ gdp_pr_capita + ethnic_frac*assasinations + 
               institutional_quality + m2_gdp_lagged +
               sub_saharan_africa + fast_growing_east_asia + policy*aid,
             data = aid)
summary(m5)



## The actual regression they run, include period and log of gdp_pr_capita
aid$gdp_pr_capita_log <- log(aid$gdp_pr_capita)

m6 <- lm(gdp_growth ~ gdp_pr_capita_log + ethnic_frac*assasinations + 
           institutional_quality + m2_gdp_lagged +
           sub_saharan_africa + fast_growing_east_asia + policy*aid + 
           as.factor(period),
         data = aid)
summary(m6)

## Model without interaction for running ceresplot:
m6b <- lm(gdp_growth ~ gdp_pr_capita_log + ethnic_frac + assasinations + 
            institutional_quality + m2_gdp_lagged +
            sub_saharan_africa + fast_growing_east_asia + policy + aid + 
            as.factor(period),
          data = aid)

## Linearity:
ceresPlots(m6b, term = "policy") ## Ikke lineært
ceresPlots(m6b, term = "aid") ## lineært

## Independent errors:
durbinWatsonTest(m6) ## Ingen autokorrelasjon

## Normally distributed errors:
qqPlot(m6) ## Stort sett ganske bra, litt dårlig i utkantene (fat-tails).


## Homoskedasticity:
spreadLevelPlot(m6) ## Heteroskedastisitet
ncvTest(m6) ## Formell test.

### Multikolinearitet:
vif(m6) ## Ikke store problemer
cor(aid[,3:10], use="pairwise.complete.obs") ## Kan også brukes til å se på korrelasjon

### Inflytelsesrike observasjoner og uteliggere:
influenceIndexPlot(m6, id.n=5)

## Henter ut interessante observasjoner:

## Hack fordi rownames ikke går fra 1 til 286
aid$obs_nr <- as.numeric(rownames(aid)) 


aid[aid$obs_nr==403,]
aid[aid$obs_nr==476,]

aid2 <- aid[aid$obs_nr!=403,]
summary(m6c <- lm(gdp_growth ~ gdp_pr_capita_log + ethnic_frac*assasinations + 
                    institutional_quality + m2_gdp_lagged +
                    sub_saharan_africa + fast_growing_east_asia + policy*aid + 
                    as.factor(period),
                  data = aid2))
aid3 <- aid[aid$obs_nr!=476,]
summary(m6d <- lm(gdp_growth ~ gdp_pr_capita_log + ethnic_frac*assasinations + 
                    institutional_quality + m2_gdp_lagged +
                    sub_saharan_africa + fast_growing_east_asia + policy*aid + 
                    as.factor(period),
                  data = aid3))

aid4 <- aid2[aid2$obs_nr!=476,]
summary(m6e <- lm(gdp_growth ~ gdp_pr_capita_log + ethnic_frac*assasinations + 
                    institutional_quality + m2_gdp_lagged +
                    sub_saharan_africa + fast_growing_east_asia + policy*aid + 
                    as.factor(period),
                  data = aid4))
stargazer(m6, m6c, m6d, m6e, type="text")


## Lager variabel til multinomisk:
summary(aid$gdp_growth)
aid$gdp_g_categories <- ifelse(aid$gdp_growth<0, 1, NA)
aid$gdp_g_categories <- ifelse(aid$gdp_growth>=0 & aid$gdp_growth< 1, 2, aid$gdp_g_categories)
aid$gdp_g_categories <- ifelse(aid$gdp_growth>=1 & aid$gdp_growth<3, 3, aid$gdp_g_categories)
aid$gdp_g_categories <- ifelse(aid$gdp_growth>=3, 4, aid$gdp_g_categories)

table(aid$gdp_g_categories) #test


## Kjører regresjon
m7 <- multinom(gdp_g_categories ~ gdp_pr_capita_log + 
           institutional_quality + m2_gdp_lagged +
           sub_saharan_africa + fast_growing_east_asia + policy + aid, data= aid,
         Hess = T, na.action="na.exclude")
stargazer(m7, type="text")
summary(m7)
