library(tidyverse)
library(gtools)
data <- read.csv("C:/Users/lized/OneDrive/Documents/GitHub/R-Analysis-Project/pls_fy2021_csv/PLS_FY2021 PUD_CSV/PLS_FY21_AE_pud21i.csv")

#This data specifically is the 2021 data
df <- data %>% select(c(LIBID, LIBNAME, STABR, C_LEGBAS, POPU_LSA, VISITS, BKVOL, EBOOK, CAPITAL, PRMATEXP, ELMATEXP, STAFFEXP, STATNAME, LOCALE_MOD, WEBVISIT, WIFISESS, PITUSR, LOANTO, LOANFM, TOTCIR, ELMATCIR, PHYSCIR, REGBOR, AUDIO_PH, AUDIO_DL, VIDEO_PH, VIDEO_DL))
df$LOCALE_MOD <- as.factor(df$LOCALE_MOD)
df$C_LEGBAS <- as.factor(df$C_LEGBAS)
df$STATNAME <- as.factor(df$STATNAME)
summary(df)
head(df[,1:5], 5)

# Combining physical and downloadable copies of audio books into one column called Total_Audio_Books
df <- df %>% mutate( Total_Audio_Books = AUDIO_PH + AUDIO_DL)
# Combining physical and downloadable copies of videos into one column called Total_Videos
df <- df %>% mutate(Total_Videos = VIDEO_PH + VIDEO_DL)


df <- df %>% filter(TOTCIR != -1) %>% filter(TOTCIR != -3)
df <- df %>% filter(VISITS != -1) %>% filter(VISITS != -3)
df <- df %>% filter(REGBOR != -1) %>% filter(REGBOR != -3)
df <- df %>% filter(POPU_LSA != -1) %>% filter(POPU_LSA != -3) %>% filter(POPU_LSA != -9)
#45 rows removed thus far


df <- df %>% mutate(VISITS_adjusted = VISITS/POPU_LSA)
df <- df %>% mutate(TOTCIR_adjusted = TOTCIR/POPU_LSA)
df <- df %>% mutate(REGBOR_adjusted = REGBOR/POPU_LSA)

df <- df %>% mutate(VISITS_factor = quantcut(VISITS_adjusted, q = 4, na.rm = TRUE, labels = c(1, 2, 3, 4)))
df <- df %>% mutate(TOTCIR_factor = quantcut(TOTCIR_adjusted, q = 4, na.rm = TRUE, labels = c(1, 2, 3, 4)))
df <- df %>% mutate(REGBOR_factor = quantcut(REGBOR_adjusted, q = 4, na.rm = TRUE, labels = c(1, 2, 3, 4)))

VISITS.aov <- aov(formula = LOANTO~VISITS_factor, data = df) 
TOTCIR.aov <- aov(formula = LOANTO~TOTCIR_factor, data = df)
REGBOR.aov <- aov(formula = LOANTO~REGBOR_factor, data = df)


plot(TukeyHSD(VISITS.aov))
plot(TukeyHSD(TOTCIR.aov))
plot(TukeyHSD(REGBOR.aov))

boxplot(LOANTO~VISITS_factor,data=df,
        ylab = "Number of loans given", xlab = "Quantile position of Visits")
boxplot(LOANTO~TOTCIR_factor,data=df,
        ylab = "Number of loans given", xlab = "Quantile position of Total Circulation")
boxplot(LOANTO~REGBOR_factor,data=df,
        ylab = "Number of loans given", xlab = "Quantile position of Registered Users")


