data("steak_survey")
write.csv(steak_survey, file = "./prove/steak_survey.csv", row.names = FALSE)
rm(list = ls())
steak_survey <- read.csv("./prove/steak_survey.csv", stringsAsFactors = FALSE)

head(steak_survey)
table(steak_survey$hhold_income)


steak_survey$hhold_income <- ifelse(steak_survey$hhold_income == "$0 - $24,999", sample(0:24999, length(which(steak_survey$hhold_income == "$0 - $24,999"))),
                                    ifelse(steak_survey$hhold_income == "$100,000 - $149,999", sample(100:149999, length(which(steak_survey$hhold_income == "$100,000 - $149,999"))),
                                           ifelse(steak_survey$hhold_income == "$150,000+", sample(150000:200000, length(which(steak_survey$hhold_income == "$150,000+"))),
                                                  ifelse(steak_survey$hhold_income == "$25,000 - $49,999", sample(25000:49999, length(which(steak_survey$hhold_income == "$25,000 - $49,999"))),
                                                         ifelse(steak_survey$hhold_income == "$50,000 - $99,999", sample(50000:99999, length(which(steak_survey$hhold_income == "$50,000 - $99,999"))), NA)))))


steak_survey$age <- ifelse(steak_survey$age == "18-29", sample(18:29, length(which(steak_survey$age == "18-29")), replace = TRUE),
                           ifelse(steak_survey$age == "30-44", sample(30:44, length(which(steak_survey$age == "30-44")), replace = TRUE),
                                  ifelse(steak_survey$age == "45-60", sample(45:60, length(which(steak_survey$age == "45-60")), replace = TRUE),
                                         ifelse(steak_survey$age == "> 60", sample(61:90, length(which(steak_survey$age == "> 60")), replace = TRUE), NA))))

steak_survey$smoke <- ifelse(steak_survey$smoke == TRUE, 1, 0)
steak_survey$alcohol <- ifelse(steak_survey$alcohol == TRUE, 1, 0)
steak_survey <- steak_survey[, c("respondent_id", "steak_prep", "hhold_income", "age", "smoke", "alcohol")]
write.csv(steak_survey, file = "./prove/steak_survey.csv", row.names = FALSE)