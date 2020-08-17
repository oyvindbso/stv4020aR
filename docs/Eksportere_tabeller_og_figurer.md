---
title: "Eksportere output fra R"
author: "Erlend Langørgen"
date: "October 4, 2018"
output:
  html_document:
    keep_md: yes
  pdf_document: default
  word_document: default
---



### Om valg av skriveprogram:

Mange av dere er sikkert vant til å skrive oppgaver i Microsoft word, eller tilsvarende [WYSIWYG](https://en.wikipedia.org/wiki/WYSIWYG) program. Dette kan dere fortsette med gjennom hele masteren om dere vil. Dere kan også velge å bruke skriveprogramm som er hakket mindre **What you see is what you get**. Et populært alternativ er [*LaTeX*](https://www.latex-project.org/). Et annet alternativ som blir stadig mer populært på grunn av et progam som heter *pandoc*, som lar deg konvertere det du skriver til ulike filtyper, er [*Markdown*](http://pandoc.org/MANUAL.html#pandocs-markdown) og [*Rmarkdown*](https://bookdown.org/yihui/rmarkdown/) (Dette dokumentet, og andre dokumenter til seminarene, er skrevet som Rmarkdown-filer, filer av typen .Rmd). *LaTeX* tilbyr mer funksjonalitet enn *Rmarkdown*/*Markdown*, som har enklere syntaks. Det er mulig å skrive en tekst i *Markdown*, og deretter konvertere til *LaTeX* dersom du trenger funksjonalitet derfra (f.eks. figurer fra [Tikz](https://cremeronline.com/LaTeX/minimaltikz.pdf)). Du kan enkelt bruke referanseprogramvare med både *Markdown* og *LaTeX*, personlig bruker jeg [jabref](http://www.jabref.org/). Det viktigste er ikke hvilket referanseprogram du bruker, men at du bruker et program når du skriver tekster med mange referanser(f.eks. *endnote* hvis du bruker word).

Når du skriver en statistisk oppgave, er det særlig en vektig grunn til å ikke velge word: Hver gang du endrer analysen din, er du nødt til å huske å endre alle tall, tabeller og diskusjoner av resultater fra analysene dine. Ved å velge en av de andre alternativene, kan du automatisk oppdatere  alle tabeller, figurer og tall. Du kan lese hvordan dette kan gjøres med `knitr` pakken [her](https://nbis.se/blog/2018-02-22-olga-knitr.html), eller trykke på `File`, `New File` og deretter `R Markdown..` i Rstudio for å se hvordan det fungerer (se slutten av R for Data Science for mer).

## Eksportere figurer fra ggplot

Vi har lært å lage figurer med ggplot, her er kode for et spredningsplot (kjør på egen maskin):


```r
library(ggplot2)
ggplot(mtcars, aes(x = hp, y = mpg)) + geom_point()
```


Dersom du lager et ggplot du er fornøyd med, kan du lagre det med `ggsave()`, som lagrer ditt siste ggplot (som vist i plot-bosken i Rstudio).


```r
ggsave("testplot.png", width = 8, height = 5) # lagrer ditt siste ggplot i det formatet du vil på working directory, du kan angi dimensjonene du vil ha figuren i. Også mulig å lage i .jpg
```

Dersom du bruker Word, kan du sette inn dette bildet i et dokument. Dersom du bruker *LaTeX* uten `knitr`, kan du lenke til bildefilen, slik at den automatisk oppdateres hver gang du kjører scriptet ditt.

Dersom du kjører figuren i Rmarkdown, kan du trykke på `knit` i toppmenyen i Rstudio, og eksportere til det formatet du ønsker.

## Eksportere regresjonstabeller

Når du skal lage en regresjonstabell i R, finnes det egne funksjoner som `stargazer` (fra pakken med samme navn) og `screenreg` (fra pakken `texreg`) som gjør jobben for deg. Dersom du skal lage en tabell for deskriptiv statistikk, er det som regel nødvendig å lage tabellen som et eget datasett. Funksjoner for deskriptiv statistikk og funksjoner fra dplyr som `group_by` og `summarise` kan ofte være nyttig til dette formålet.

### Eksportere fine regresjonstabeller til word:

Det går helt fint å eksportere fine tabeller til word fra R, uten å bruke *Rmarkdown*. Det eneste du må huske på, er å manuelt oppdatere tabeller og figurer i dokumentet ditt. Vi har allerede sett på hvordan man lagrer et ggplot som et bilde. Det finnes mange forskjellige pakker for å eksportere tabeller. Disse pakkene kan produsere output både til word og til Latex. For å eksportere tabeller til word ber man om output i `html` format, mens til Latex får man koden for Latex tabellen direkte. Pakker som kan være nyttige er [**texreg**](https://cran.r-project.org/web/packages/texreg/vignettes/texreg.pdf), [**stargazer**](https://cran.r-project.org/web/packages/stargazer/stargazer.pdf) og [**xtable**](https://cran.r-project.org/web/packages/xtable/vignettes/xtableGallery.pdf). Den første av disse pakkene, **texreg**, fungerer til alt, og er derfor fin å lære seg, bruk `htmlreg` til word og `texreg` til Latex. Man kan bruke stargazer-pakken til å lage fine regresjonstabeller, mens `xtable` fungerer fint til å lage tabeller med deskriptiv statistikk. Det finnes flere alternativer, det viktigste er at du finner noe som fungerer for deg. 

For å eksportere fine tabeller laget i R til word [finnes det et godt triks](https://www.princeton.edu/~otorres/NiceOutputR.pdf), her eksemplifisert med stargazer. Oppsumert består trikset av 3 trinn:

1. Be om output i `html` format i tabell-funksjonen du bruker (i texreg gjør `htmlreg` dette automatisk).
2. Bruk argumentet i tabell-funksjonen som lar deg lagre tabellen (`file = "filnavn"` i texreg). Lagre filen som `filnavn.htm`, ikke `filnavn.html`.
3. Åpne filen du lagret i word, du bør nå ha en fin tabell.

Både stargazer og texreg (`screenreg()`) kan forøvrig brukes til å sammenlikne regresjonsmodeller i console, dette er ofte nyttig. Her er et eksempel:


```r
#install.packages("texreg")
library(texreg)
```

```
## Version:  1.36.23
## Date:     2017-03-03
## Author:   Philip Leifeld (University of Glasgow)
## 
## Please cite the JSS article in your publications -- see citation("texreg").
```

```r
m1 <- lm(mpg ~ hp ,data = mtcars)
m2 <- lm(mpg ~ hp + am ,data = mtcars)
m3 <- lm(mpg ~ hp + am + wt ,data = mtcars)
screenreg(list(m1,m2,m3))
```

```
## 
## ============================================
##              Model 1    Model 2    Model 3  
## --------------------------------------------
## (Intercept)  30.10 ***  26.58 ***  34.00 ***
##              (1.63)     (1.43)     (2.64)   
## hp           -0.07 ***  -0.06 ***  -0.04 ***
##              (0.01)     (0.01)     (0.01)   
## am                       5.28 ***   2.08    
##                         (1.08)     (1.38)   
## wt                                 -2.88 ** 
##                                    (0.90)   
## --------------------------------------------
## R^2           0.60       0.78       0.84    
## Adj. R^2      0.59       0.77       0.82    
## Num. obs.    32         32         32       
## RMSE          3.86       2.91       2.54    
## ============================================
## *** p < 0.001, ** p < 0.01, * p < 0.05
```

### Eksportere fine regresjonstabeller til *LaTeX*

Funksjoner som kan brukes til å eksportere til word kan stort sett alltid eksportere til *LaTeX*, ofte er dette default option. På samme måte som med figurer, er det mulig å lagre output i egne filer, som du kan referere til i *LaTeX*, slik at de automatisk oppdateres når du gjør endringer.

### Eksportere fine regresjonstabeller til Rmarkdown


```r
library(knitr)
m1 <- lm(mpg ~ hp ,data = mtcars)
m2 <- lm(mpg ~ hp + am ,data = mtcars)
m3 <- lm(mpg ~ hp + am + wt ,data = mtcars)
htmlreg(list(m1,m2,m3)) # hvis du velger knit to word
```


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<table cellspacing="0" align="center" style="border: none;">
<caption align="bottom" style="margin-top:0.3em;">Statistical models</caption>
<tr>
<th style="text-align: left; border-top: 2px solid black; border-bottom: 1px solid black; padding-right: 12px;"><b></b></th>
<th style="text-align: left; border-top: 2px solid black; border-bottom: 1px solid black; padding-right: 12px;"><b>Model 1</b></th>
<th style="text-align: left; border-top: 2px solid black; border-bottom: 1px solid black; padding-right: 12px;"><b>Model 2</b></th>
<th style="text-align: left; border-top: 2px solid black; border-bottom: 1px solid black; padding-right: 12px;"><b>Model 3</b></th>
</tr>
<tr>
<td style="padding-right: 12px; border: none;">(Intercept)</td>
<td style="padding-right: 12px; border: none;">30.10<sup style="vertical-align: 0px;">***</sup></td>
<td style="padding-right: 12px; border: none;">26.58<sup style="vertical-align: 0px;">***</sup></td>
<td style="padding-right: 12px; border: none;">34.00<sup style="vertical-align: 0px;">***</sup></td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;">(1.63)</td>
<td style="padding-right: 12px; border: none;">(1.43)</td>
<td style="padding-right: 12px; border: none;">(2.64)</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;">hp</td>
<td style="padding-right: 12px; border: none;">-0.07<sup style="vertical-align: 0px;">***</sup></td>
<td style="padding-right: 12px; border: none;">-0.06<sup style="vertical-align: 0px;">***</sup></td>
<td style="padding-right: 12px; border: none;">-0.04<sup style="vertical-align: 0px;">***</sup></td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;">(0.01)</td>
<td style="padding-right: 12px; border: none;">(0.01)</td>
<td style="padding-right: 12px; border: none;">(0.01)</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;">am</td>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;">5.28<sup style="vertical-align: 0px;">***</sup></td>
<td style="padding-right: 12px; border: none;">2.08</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;">(1.08)</td>
<td style="padding-right: 12px; border: none;">(1.38)</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;">wt</td>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;">-2.88<sup style="vertical-align: 0px;">**</sup></td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;">(0.90)</td>
</tr>
<tr>
<td style="border-top: 1px solid black;">R<sup style="vertical-align: 0px;">2</sup></td>
<td style="border-top: 1px solid black;">0.60</td>
<td style="border-top: 1px solid black;">0.78</td>
<td style="border-top: 1px solid black;">0.84</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;">Adj. R<sup style="vertical-align: 0px;">2</sup></td>
<td style="padding-right: 12px; border: none;">0.59</td>
<td style="padding-right: 12px; border: none;">0.77</td>
<td style="padding-right: 12px; border: none;">0.82</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;">Num. obs.</td>
<td style="padding-right: 12px; border: none;">32</td>
<td style="padding-right: 12px; border: none;">32</td>
<td style="padding-right: 12px; border: none;">32</td>
</tr>
<tr>
<td style="border-bottom: 2px solid black;">RMSE</td>
<td style="border-bottom: 2px solid black;">3.86</td>
<td style="border-bottom: 2px solid black;">2.91</td>
<td style="border-bottom: 2px solid black;">2.54</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;" colspan="5"><span style="font-size:0.8em"><sup style="vertical-align: 0px;">***</sup>p &lt; 0.001, <sup style="vertical-align: 0px;">**</sup>p &lt; 0.01, <sup style="vertical-align: 0px;">*</sup>p &lt; 0.05</span></td>
</tr>
</table>

```r
#texreg(list(m1, m2, m3)) # hvis du velger knit to pdf
```

Du kan fortsatt bruke `texreg` eller `htmlreg`

## Tabeller for deskriptiv statistikk

For å lage tabeller med deskriptiv statistikk, anbefaler jeg `xtable`. Den kan eksportere både til html for word, eller til tex for Latex. Begge disse alternativene fungerer i Rmarkdown (avhenger av hva slags fil du eksporterer), men her finnes også alternativet `kable` som jeg viser under. 

## Eksportere tabeller med deskriptiv statistikk med `xtable`

Her viser jeg et eksempel på hvordan du kan bygge et datasett med informasjonen du ønsker å sette i en tabell med deskriptiv statistikk. Jeg bygger datasettet mitt radvis - en rad-vektor for hver variabel. Dette fungerer stort sett alltid, men det er mange muligheter - det eneste du trenger for å bruke xtabel er å bygge et datasett med den informasjonen du ønsker, ordnet slik som du vil. Vær kreativ! 

Når du har laget et datasett, vil funksjonene `xtable()` og `print.xtable()` gjøre resten


```r
library(tidyverse)
library(xtable)
#?mtcars # Kjør dersom du ikke henger med på hva som skjer

## Steg 1 Lager tabell til datasett - her lager jeg tre seksjoner basert på målenivå.
## Jeg bygger tabellen radvis - legger inn rader med tekst underveis, som beskriver hva seksjoner i tabellen inneholder.

# Kontinuerlige variabler - velger å vise gj.snitt, sd. avvik, min og max - du kan også bruke andre former for deskriptiv statistikk. Lager separat rad-vektor for hver variabel.

kont_header <- c(var = "Kontinuerlige variabler", p1 = "Gjennomsnitt", p2 = "Standardavvik")

kont1 <-  c(var = c("Hestekrefter"),  p1 = mean(mtcars$hp),  p2 = sd(mtcars$hp))
kont2 <-  c(var = "Miles per Gallon", p1 = mean(mtcars$mpg), p2 = sd(mtcars$mpg))
kont3 <-  c(var = "Vekt i tonn",      p1 = mean(mtcars$wt),  p2 = sd(mtcars$wt))



# Dummyer: viser frekvenser - bruker rbind til å binde sammen rader
dummy_header <- c(var = "Dummy-variabler", p1 = "0", p2 = "1")
dummy <- mtcars %>%
                  group_by(am) %>%
                summarise(my_freq = n()) %>%
                select(my_freq)
                
dummy <- c(var = "Automatisk(0)/Manuelt(1) gir", 
                 p1 = slice(dummy, 1),
                 p2 = slice(dummy, 2))

# sylindre - viser andeler  - sjekk også ut prop.table(table())
kat_header <- c(var =  "4 sylindre", p1 = "6 sylindre", p2 =  "8 sylindre")

kat <- mtcars %>%
  group_by(cyl) %>%
  summarise(my_prop = n()/nrow(mtcars)) %>%
  select(my_prop)

kat <- c(var = slice(kat, 1),
              p1  = slice(kat, 2),
              p2 = slice(kat, 3))

str(kat)
min_tabell <- tibble(kont_header, kont1, kont2 , kont3, dummy_header, dummy, kat_header,kat)
min_tabell <- t(min_tabell)
rownames(min_tabell) <- NULL

# Sjekk ut ?xtable for masse alternativ
eksport_tabell <- xtable(min_tabell)

# For å lagre tabellen på PCen din
print.xtable(eksport_tabell, type = "html", file = "min_desk_stat_tabell.html") # for word
print.xtable(eksport_tabell, type = "latex", file = "min_desk_stat_tabell.tex") # for latex
```




### Eksportere tabeller fra *Rmarkdown*

Dersom du skriver i en *Rmarkdown* fil, kan du bruke funksjonen `kable` fra pakken `knitr`, og sette chunk-option `results` til "asis". Lengre forklaring [her](https://rmarkdown.rstudio.com/lesson-7.html). Deretter trykker du på `knit` fra menyen i Rstudio, og velger det formatet du måtte ønske (f.eks. word). 


```r
library(knitr)
kable(mtcars[1:5,], caption = "A knitr kable")
```



### Eksportere scriptet ditt til en syntaks:

Dersom du har all koden din i et R-script, kan Rmarkdown hjelpe deg til å lage et fint appendiks med kode. Lim all koden din inn i en chunck i et R-markdown dokument og spesifiser chunck-option `eval = FALSE`. Deretter trykker du på `knit` i menyen, og eksporterer til det formatet du ønsker (f.eks. MS word).








