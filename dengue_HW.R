install.packages("tidyverse")    # 安裝 tidyverse，包含 readr、dplyr、ggplot2 等
install.packages("lubridate")    # 安裝時間處理的套件
# External packages
library(tidyverse)
library(lubridate)
install.packages("ISOweek")   # 只需裝一次
library(ISOweek)

setwd("C:/Users/user/Documents/GitHub/ghp_r13459005")
# 讀取資料
dengue_data <- read_csv("dengue_assignment.csv")

dengue_data <- dengue_data %>%
  mutate(iso_week = paste0(year, "-W", sprintf("%02d", week)),
         date = ISOweek2date(paste0(iso_week, "-1")))  # 每週的星期一

# 確保日期格式正確
dengue_data <- dengue_data %>%
  mutate(date = ymd(date))  # 假設有 date 欄位，格式為 YYYY-MM-DD

# 篩選出 2014 年資料
dengue_2014 <- dengue_data %>%
  filter(year(date) == 2014)

# 加總 2014 年所有通報病例
total_2014_cases <- sum(dengue_2014$case_number, na.rm = TRUE)
print(total_2014_cases)
