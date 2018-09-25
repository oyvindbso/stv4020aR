##############################################
########## Seminar 4 - STV 4020 A ############
##############################################

#### Forberedelser ####

## pakker til seminaret

#install.packages("car")
#install.packages("stargazer")


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

m6_dfbeta <- as.data.frame(dfbetas(m6))
head(m6_dfbeta)


# Kan se på deskriptiv statistikk/plot for å finne en terskelverdi for dfbetas vi vil undersøke:
summary(m6_dfbeta$aid) # Kan f.eks. se på alle som har lavere verdi enn -0.2 og større verdi enn 0.2
hist(m6_dfbeta$aid)

# Opprett datasett uten missing på noen av observasjonene som inngår i regresjon, og
# bruk dette datasettet til å kjøre regresjon. Deretter kan du bruke cbind()
# til å legge dfbetas til regresjonsdatasettet. 




## Henter ut interessante observasjoner og kjører separate regresjoner:

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


#### Missing data ####

load("../data/bd_full.Rdata")
table(is.na(full$bdaid)) # Burnside og Dollar sin originale variabel
table(is.na(full$elraid)) # Easterly sin utvidede variabel


boligpris <- data.frame(year = c(2013, 2015:2017), bydel = c(rep("Sagene", 4), rep("Manglerud", 4)), pris = c(2.8, 3.6, 4.2, 4, 2.6, 3.1, 3.4, 3.3))
table(is.na(boligpris))
boligpris


# Siden as.factor(period) lager en dummvariabel for alle perioder unntatt periode 1, må vi gjøre dette for å inkludere denne variabelen i korrelasjonsmatrisen (inkluder gjerne også periode 1 i matrise):

full$period2 <- ifelse(full$period==2, 1, 0)
full$period3 <- ifelse(full$period==3, 1, 0)
full$period4 <- ifelse(full$period==4, 1, 0)
full$period5 <- ifelse(full$period==5, 1, 0)
full$period6 <- ifelse(full$period==6, 1, 0)
full$period7 <- ifelse(full$period==7, 1, 0)
full$period8 <- ifelse(full$period==8, 1, 0)

cor(full[, c("bdgdpg", "bdaid", "policy", "bdlpop", "ethnic_frac", "assasinations",
             "period2", "period3", "period4", "period5", "period6", "period7")],
    use = "pairwise.complete.obs")

# Alternativet "pairwise.complete.obs" fjerner bare missing for de enkelte bivariate korrelasjonene

cor(full[, c("bdgdpg", "bdaid", "policy", "bdlpop", "ethnic_frac", "assasinations",
             "period2", "period3", "period4", "period5", "period6", "period7")],
    use = "complete.obs")


table(complete.cases(full[, c("bdgdpg", "bdaid", "policy", "bdlpop", "ethnic_frac", "assasinations",
                              "period2", "period3", "period4", "period5", "period6", "period7")]))
full$m1_miss <- complete.cases(full[, c("bdgdpg", "bdaid", "policy", "bdlpop", "ethnic_frac", "assasinations",
                                        "period2", "period3", "period4", "period5", "period6", "period7")])


miss_mod <- glm(m1_miss ~ bdaid*policy + bdlpop + as.factor(period), data = full)
summary(miss_mod) # ingen store forskjeller, signifikante uavh. var her er ikke bra.

miss_mod2 <- glm(m1_miss ~ elraid + elrsacw + elrbb + elrinfl + elrlpop + as.factor(period), data = full)
summary(miss_mod2)
# Her er koeffisienten til bistand negativ og signifikant. Dette indikerer at land som fjernes pga missing,
# får mindre bistand enn land som ikke fjernes. 
# Ser også at land med større befolkning i mindre grad fjernes pga. missing.

influenceIndexPlot(miss_mod2)


### Likelihood ratio test:

# kjører redusert versjon av miss modell 2, uten periode-dummyer

miss_mod2b <-  glm(m1_miss ~ elraid + elrsacw + elrbb + elrinfl + elrlpop , data = full)
summary(miss_mod2b)

# Modellene må være nøstede, dvs. samme observasjoner inngår, 
# og den ene modellen er en utvidet versjon av den andre (flere variabler).
anova(miss_mod2, miss_mod2b)
?anova.glm


## Hosmer-lemeshow:

#install.packages("ResourceSelection")
library(ResourceSelection)

hoslem.test(miss_mod2$y, fitted(miss_mod2), g = 10) # ikke signifikant.
