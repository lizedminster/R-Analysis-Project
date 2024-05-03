library(tidyverse)
#The goal of this file is to pull data from 2018, 2019, 2020, & 2021 to see how libraries have changed over the years.
#The matching factor will be LIBID
setwd("C:/Users/lized/OneDrive/Documents/GitHub/R-Analysis-Project/data")
df21 <- read.csv("PLS_FY21_AE_pud21i.csv")
df20 <- read.csv("PLS_FY20_AE_pud20i.csv")
df19 <- read.csv("PLS_FY19_AE_pud19i.csv")
df18 <- read.csv("pls_fy18_ae_pud18i.csv")

libs21 <- unique(df21$LIBID)
libs20 <- unique(df20$LIBID)
libs19 <- unique(df19$LIBID)
libs18 <- unique(df18$LIBID)

libs <- c(libs21, libs20, libs19, libs18)
libs <- unique(libs)

final <- data.frame( LIBID = libs,
                     VISITS21 = NA,
                     VISITS20 = NA,
                     VISITS19 = NA,
                     VISITS18 = NA)
final <- merge(x = final, y = df21[ , c("LIBID","VISITS")], by = "LIBID", all.x=TRUE)
final$VISITS21 <- final$VISITS
final$VISITS <- NULL

final <- merge(x = final, y = df20[ , c("LIBID","VISITS")], by = "LIBID", all.x=TRUE)
final$VISITS20 <- final$VISITS
final$VISITS <- NULL

final <- merge(x = final, y = df19[ , c("LIBID","VISITS")], by = "LIBID", all.x=TRUE)
final$VISITS19 <- final$VISITS
final$VISITS <- NULL

final <- merge(x = final, y = df18[ , c("LIBID","VISITS")], by = "LIBID", all.x=TRUE)
final$VISITS18 <- final$VISITS
final$VISITS <- NULL

