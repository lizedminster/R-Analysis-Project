library(tidyverse)
#The goal of this file is to pull data from 2018, 2019, 2020, & 2021 to see how libraries have changed over the years.
#The matching factor will be FSCSKEY
setwd("C:/Users/lized/OneDrive/Documents/GitHub/R-Analysis-Project/data")
df21 <- read.csv("PLS_FY21_AE_pud21i.csv")
df20 <- read.csv("PLS_FY20_AE_pud20i.csv")
df19 <- read.csv("PLS_FY19_AE_pud19i.csv")
df18 <- read.csv("pls_fy18_ae_pud18i.csv")

libs21 <- unique(df21$FSCSKEY)
libs20 <- unique(df20$FSCSKEY)
libs19 <- unique(df19$FSCSKEY)
libs18 <- unique(df18$FSCSKEY)

libs <- c(libs21, libs20, libs19, libs18)
libs <- unique(libs)

final <- data.frame( FSCSKEY = libs)

final <- merge(final, df21, by="FSCSKEY", all = T)
final <- final[,c("FSCSKEY", "VISITS")]
final$VISITS21 <- final$VISITS
final$VISITS <- NULL

final <- merge(final, df20, by="FSCSKEY", all = T)
final <- final[,c("FSCSKEY", "VISITS", "VISITS21")]
final$VISITS20 <- final$VISITS
final$VISITS <- NULL

final <- merge(final, df19, by="FSCSKEY", all = T)
final <- final[,c("FSCSKEY", "VISITS", "VISITS21", "VISITS20")]
final$VISITS19 <- final$VISITS
final$VISITS <- NULL

final <- merge(final, df18, by="FSCSKEY", all = T)
final <- final[,c("FSCSKEY", "VISITS", "VISITS21", "VISITS20", "VISITS19")]
final$VISITS18 <- final$VISITS
final$VISITS <- NULL

