rm(list = ls())
library(haven);library(stringr);library(labelled)

# Spør meg om du vil ha det fulle datasettet
ess <- read_dta("http://folk.uio.no/martigso/stv4020/ESS7e01.dta", encoding = "ISO-8859-1")

ess <- ess[which(ess$cntry == "NO"), ]


# Party voted for in last national election
ess$party_vote <- ess$prtvtbno
ess$party_vote <- factor(ess$party_vote, labels = names(attr(ess$prtvtbno, "label"))[1:14])
ess$party_vote <- rvest::repair_encoding(ess$party_vote)

# Pet name for party
ess$party_vote_short <- gsub("\\(|\\)", "", str_extract(ess$party_vote, "\\(.*?\\)"))

# Respondent gender
ess$gender <- ifelse(ess$icgndra == 1, "male",
                     ifelse(ess$icgndra == 2, "female", NA))

# Year born
ess$year_born <- ess$yrbrn

# Income
ess$income_feel <- ess$hincfel
ess$income_decile <- ess$hinctnta

# Trust in institutions
ess$trust_parl <- ifelse(ess$trstprl > 10, NA, ess$trstprl)        # parliament
ess$trust_legalsys <- ifelse(ess$trstlgl > 10, NA, ess$trstlgl)    # legal system
ess$trust_police <- ifelse(ess$trstplc > 10, NA, ess$trstplc)      # police
ess$trust_politicians <- ifelse(ess$trstplt > 10, NA, ess$trstplt) # politicians
ess$trust_polparties <- ifelse(ess$trstprt > 10, NA, ess$trstprt)  # political parties
ess$trust_eurparl <- ifelse(ess$trstep > 10, NA, ess$trstep)       # european parliament
ess$trust_unitednations <- ifelse(ess$trstun > 10, NA, ess$trstun) # united nations

relab <- function(x){
  labelled(x, c("No trust at all" = 0, 
                "1" = 1, "2" = 2, "3" = 3, "4" = 4, "5" = 5,
                "6" = 6, "7" = 7, "8" = 8, "9" = 9,
                "Complete trust" = 10))
}

ess$trust_parl <- relab(ess$trust_parl)
ess$trust_legalsys <- relab(ess$trust_legalsys)
ess$trust_police <- relab(ess$trust_police)
ess$trust_politicians <- relab(ess$trust_politicians)
ess$trust_polparties <- relab(ess$trust_polparties)
ess$trust_eurparl <- relab(ess$trust_eurparl)
ess$trust_unitednations <- relab(ess$trust_unitednations)

cor(ess[, names(ess)[which(grepl("trust_", names(ess)))]], use = "complete.obs")

final <- ess[, c("idno", "party_vote", "party_vote_short", 
                 "gender", "year_born",
                 "income_feel", "income_decile",
                 "trust_parl", "trust_legalsys", "trust_police", "trust_politicians",
                 "trust_polparties", "trust_eurparl", "trust_unitednations")]

var_label(final) <- list(idno = "ID number", party_vote = "Party voted for in last national election",
                         party_vote_short = "Pet name for party",
                         gender = "Gender", year_born = "Year born", 
                         income_feel = "Feeling about household's income nowadays",
                         income_decile = "Household's total net income, all sources",
                         trust_parl = "Trust in country's parliament",
                         trust_legalsys = "Trust in the legal system ", 
                         trust_police = "Trust in the police", 
                         trust_politicians = "Trust in politicians", 
                         trust_polparties = "Trust in political parties", 
                         trust_eurparl = "Trust in the European Parliament", 
                         trust_unitednations = "Trust in the United Nations")

ess_nor <- final
save(ess_nor, file = "./data/ess_norge.rda")
