# ============================================================
# Customer Transaction Analysis & Segmentation
# Single-run R script
# Update: data_path below to point to your CSV (e.g., "/Users/kt1u1/Downloads/anz.csv")
# Author: Kang Tian
# Github: https://github.com/kang-tian
# ============================================================

# ---------------------------
# 0. Setup: packages
# ---------------------------
packages <- c(
  "tidyverse", "lubridate", "readr", "scales", "gridExtra", "cowplot",
  "cluster", "factoextra", "corrplot",
  "rpart", "rpart.plot", "randomForest", "caret", "pROC", "ggpubr"
)

# Install any missing packages
to_install <- packages[!(packages %in% installed.packages()[, "Package"])]
if (length(to_install) > 0) {
  install.packages(to_install, dependencies = TRUE)
}

# Load libraries
library(tidyverse)
library(lubridate)
library(readr)
library(scales)
library(gridExtra)
library(cowplot)
library(cluster)
library(factoextra)
library(corrplot)
library(rpart)
library(rpart.plot)
library(randomForest)
library(caret)
library(pROC)
library(ggpubr)

# ---------------------------
# 1. Configuration
# ---------------------------
data_path <- "/Users/kt1u1/Downloads/anz.csv"   # <<< UPDATE this path
output_dir <- "plots"   # where plots are saved
dir.create(output_dir, showWarnings = FALSE). # create plots folder if it doesn't exist 

set.seed(123)

# ---------------------------
# 2. Load data (robust)
# ---------------------------
message("Loading data...")
df <- read_csv(data_path, guess_max = 20000, show_col_types = FALSE)
message("Data loaded. Rows:", nrow(df), "Cols:", ncol(df))
glimpse(df)


# Check parsing problems
problems_df <- problems(df)
if (nrow(problems_df) > 0) {
  message("Parsing issues detected. Showing first 10 rows of problems():")
  print(head(problems_df, 10))
} else {
  message("No parsing problems detected.")
}

# ---------------------------
# 3. Initial cleaning & type fixes
# ---------------------------
# Trim whitespace for character columns
df <- df %>% mutate(across(where(is.character), ~str_trim(.)))
                    
# Ensure key numeric cols below are numeric
if ("amount" %in% names(df)) df <- df %>% mutate(amount = as.numeric(amount))
if ("balance" %in% names(df)) df <- df %>% mutate(balance = as.numeric(balance))
if ("card_present_flag" %in% names(df)) df <- df %>% mutate(card_present_flag = as.numeric(card_present_flag))

# Replace NA card_present_flag with 0 (assume no card)
sum(is.na(df$card_present_flag)) ## no missing


# Ensure customer_id exists and is character
if (!"customer_id" %in% names(df)) stop("customer_id column not found. Please check dataset.")
df <- df %>% mutate(customer_id = as.character(customer_id))
# ---------------------------
# 4. Date parsing (robust)
# ---------------------------
# Try lubridate mdy() first
df <- df %>%
  mutate(
    date_parsed = mdy(date)
  )

# Fallback: try dmy()
if (sum(is.na(df$date_parsed)) / nrow(df) > 0.1) {
  message("Some NAs detected; trying dmy() format...")
  df <- df %>%
    mutate(date_parsed = if_else(is.na(date_parsed), dmy(date), date_parsed))
}

# Fallback: try ymd()
if (sum(is.na(df$date_parsed)) / nrow(df) > 0.1) {
  message("Still many NAs; trying ymd() format...")
  df <- df %>%
    mutate(date_parsed = if_else(is.na(date_parsed), ymd(date), date_parsed))
}

# If still NAs, warn user
if (sum(is.na(df$date_parsed)) > 0) {
  warning("Some date values could not be parsed. Check 'date' column.")
}

# Create date-only and time features
df <- df %>% mutate(
  txn_datetime = date_parsed,
  txn_date = as_date(txn_datetime),
  txn_year = year(txn_datetime),
  txn_month = month(txn_datetime),
  txn_day = day(txn_datetime),
  txn_hour = hour(txn_datetime),
  txn_wday = wday(txn_datetime, label = TRUE, abbr = TRUE)
)

## transform age group
if ("age" %in% names(df)) {
  df <- df %>%
    mutate(age_group = case_when(
      age < 20 ~ "<20",
      age >= 20 & age < 30 ~ "20-29",
      age >= 30 & age < 40 ~ "30-39",
      age >= 40 & age < 50 ~ "40-49",
      age >= 50 & age < 60 ~ "50-59",
      age >= 60 ~ "60+",
      TRUE ~ "Unknown"
    ))
}

# create balance group
table(df$balance)
if ("balance" %in% names(df)) {
  df <- df %>%
    mutate(balance_group = case_when(
      balance < 1000 ~ "(a) <1000",
      balance >= 1000 & balance < 5000 ~ "(b) 1000-4999",
      balance >= 5000 & balance < 10000 ~ "(c) 5000-9999",
      balance >= 10000 ~ "(4) 10000+",
      TRUE ~ "(5) Unknown"
    ))
}
table(df$balance_group)

# ---------------------------
# 5. Missingness summary
# ---------------------------
missing_summary <- df %>% summarise(across(everything(), ~sum(is.na(.)))) %>%
  pivot_longer(everything(), names_to = "column", values_to = "na_count") %>%
  arrange(desc(na_count))
message("Missingness summary (top 20):")
print(head(missing_summary, 20))

# ---------------------------
# 6. Descriptive statistics (transaction-level)
# ---------------------------

## customer count

# Total unique customers
n_distinct(df$customer_id)

count_customers_age <- df %>%
  group_by(age_group) %>%
  summarise(Count_Customer = n_distinct(customer_id), .groups = "drop")

count_customers_gender <- df %>%
  group_by(gender) %>%
  summarise(Count_Customer = n_distinct(customer_id), .groups = "drop")


#  Demographic visualization function
plot_demographic <- function(data, x_var, x_label, title, output_file) {
  p <- data %>%
    pivot_longer(cols = Count_Customer) %>%  # only one column to long format for consistency
    ggplot(aes_string(x = x_var, y = "value", fill = x_var)) +
    geom_col(position = "dodge") +
    facet_wrap(~name, scales = "free_y") +
    scale_y_continuous(labels = label_number(big.mark = ",", scale = 1)) +
    labs(title = title, y = "Count of Customers", x = x_label) +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
  
  print(p)
  ggsave(file.path(output_dir, output_file), p, width = 8, height = 5)
}

#  Generate plots
plot_demographic(count_customers_age, "age_group", "Age Group", "# of Customers by Age Group", "customer_age_group.png")
plot_demographic(count_customers_gender, "gender", "Gender", "# of Customers by Gender", "customer_gender.png")

message("Basic transaction statistics:")
trans_stats <- df %>% summarise(
  total_transactions = n(),
  total_amount = sum(amount, na.rm = TRUE),
  mean_amount = mean(amount, na.rm = TRUE),
  median_amount = median(amount, na.rm = TRUE),
  sd_amount = sd(amount, na.rm = TRUE),
  min_amount = min(amount, na.rm = TRUE),
  max_amount = max(amount, na.rm = TRUE),
  n_customers = n_distinct(customer_id)
)
print(trans_stats)

# Top percentiles
quantiles <- df %>% summarise(
  p50 = quantile(amount, 0.5, na.rm = TRUE),
  p75 = quantile(amount, 0.75, na.rm = TRUE),
  p90 = quantile(amount, 0.9, na.rm = TRUE),
  p95 = quantile(amount, 0.95, na.rm = TRUE),
  p99 = quantile(amount, 0.99, na.rm = TRUE)
)
print(quantiles)

# ---------------------------
# 7. Visualizations (transaction-level)
# ---------------------------

library(scales)
library(dplyr)

df_pos <- df %>% filter(amount > 0)
# ---------------------------
# 7.1 Histogram + density (log scale)
p_amount_hist <- ggplot(df_pos, aes(x = amount)) +
  geom_histogram(bins = 50, fill = "steelblue", color = "white", alpha = 0.9) +
  scale_x_continuous(trans = "log10", labels = comma) +
  labs(title = "Distribution of Transaction Amounts (log scale)",
       x = "Amount (log10)", y = "Count") +
  theme_minimal()
print(p_amount_hist)
ggsave(file.path(output_dir, "amount_hist_log.png"), p_amount_hist, width = 10, height = 5)

# ---------------------------
# 7.2 Boxplot (show outliers)
p_amount_box <- ggplot(df_pos, aes(y = amount)) +
  geom_boxplot(fill = "lightgreen", outlier.alpha = 0.6) +
  scale_y_continuous(trans = "log10", labels = dollar) +
  labs(title = "Boxplot of Transaction Amounts (log scale)", y = "Amount") +
  theme_minimal()
ggsave(file.path(output_dir, "amount_boxplot.png"), p_amount_box, width = 6, height = 5)
print(p_amount_box)

# ---------------------------
# 7.3 Time series: daily volume & count
daily <- df %>%
  group_by(txn_date) %>%
  summarise(daily_count = n(), daily_amount = sum(amount, na.rm = TRUE)) %>%
  arrange(txn_date)

p_daily_count <- ggplot(daily, aes(x = txn_date, y = daily_count)) +
  geom_line(color = "darkblue") + geom_smooth(method = "loess", se = FALSE, color = "red") +
  labs(title = "Daily Transaction Count", x = "Date", y = "Count") + theme_minimal()
p_daily_amount <- ggplot(daily, aes(x = txn_date, y = daily_amount)) +
  geom_line(color = "darkgreen") + geom_smooth(method = "loess", se = FALSE, color = "red") +
  labs(title = "Daily Transaction Amount", x = "Date", y = "Amount") + theme_minimal() +
  scale_y_continuous(labels = comma_format())
print(p_daily_count)   ## 3
print(p_daily_amount)   ## 4

ggsave(file.path(output_dir, "daily_count.png"), p_daily_count, width = 10, height = 4)
ggsave(file.path(output_dir, "daily_amount.png"), p_daily_amount, width = 10, height = 4)

#----Decomposite
library(dplyr)
library(ggplot2)
library(scales)

# Aggregate daily stats by movement
daily_movement <- df %>%
  group_by(txn_date, movement) %>%
  summarise(
    daily_count = n(),
    daily_amount = sum(amount, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  arrange(txn_date)

# Plot daily count by movement (stacked vertically)
p_daily_count_movement <- ggplot(daily_movement, aes(x = txn_date, y = daily_count, color = movement)) +
  geom_line() +
  geom_smooth(method = "loess", se = FALSE) +
  facet_wrap(~movement, scales = "free_y", ncol = 1) +   # 👈 force vertical layout
  labs(title = "Daily Transaction Count by Movement Type",
       x = "Date", y = "Count") +
  theme_minimal() +
  theme(legend.position = "none")

# Plot daily amount by movement (stacked vertically)
p_daily_amount_movement <- ggplot(daily_movement, aes(x = txn_date, y = daily_amount, color = movement)) +
  geom_line() +
  geom_smooth(method = "loess", se = FALSE) +
  facet_wrap(~movement, scales = "free_y", ncol = 1) +   #force vertical layout
  labs(title = "Daily Transaction Amount by Movement Type",
       x = "Date", y = "Amount") +
  scale_y_continuous(labels = comma) +
  theme_minimal() +
  theme(legend.position = "none")

# Print plots
print(p_daily_count_movement)
print(p_daily_amount_movement)

install.packages("patchwork")
library(patchwork)
# Combine plots vertically
combined_plot <- p_daily_count_movement / p_daily_amount_movement
# Show combined plot
print(combined_plot)

# ---------------------------
library(scales)
# 7.4 Heatmap:  weekday by card type -- count & amount
# ---------------------------
# 1) Compute total transaction count by weekday and transaction type
des_wday_c <- df %>%
  group_by(txn_wday, txn_description  ) %>%
  summarise(count = n(), .groups = "drop")

p_heat_c_des <- ggplot(des_wday_c, aes(x = txn_description , y = txn_wday, fill = count)) +
  geom_tile() +
  scale_fill_gradient(low = "mistyrose", high = "darkred")+
  labs(title = "Transaction Count by Transaction Type and Day of Week", x = "Transaction type", y = "Weekday") +
  theme_minimal()
ggsave(file.path(output_dir, "heat_des_wday_c.png"), p_heat, width = 10, height = 5)
print(p_heat_c_des)    ## 5



# ---------------------------
# 2) Compute total transaction amount by weekday and transaction type
des_wday_amount <- df %>%
  group_by(txn_wday, txn_description) %>%
  summarise(total_amount = sum(amount, na.rm = TRUE), .groups = "drop")

# Plot heatmap
p_heat_m_des <- ggplot(des_wday_amount, aes(x = txn_description, y = txn_wday, fill = total_amount)) +
  geom_tile() +
  scale_fill_gradient(
    low = "lightblue", high = "darkblue",
    labels = label_number(big.mark = ",", scale = 1)
  ) +
  labs(
    title = "Transaction Amount by Transaction Type and Day of Week",
    x = "Transaction type", y = "Weekday"
  ) +
  theme_minimal()
ggsave(file.path(output_dir, "heat_des_wday_amount.png"), p_heat_m, width = 10, height = 5)
print(p_heat_m_des) ## 6

# ---------------------------
# 3) Compute total transaction count by weekday and movement
movement_wday_c <- df %>%
  group_by(txn_wday, movement) %>%
  summarise(count = n(), .groups = "drop")

p_heat_c_mov <- ggplot(movement_wday_c, aes(x = movement, y = txn_wday, fill = count)) +
  geom_tile() +
  scale_fill_gradient(low = "mistyrose", high = "darkred")+
  labs(title = "Transaction Count by Card Type and Day of Week", x = "Card type", y = "Weekday") +
  theme_minimal()
ggsave(file.path(output_dir, "heat_card_wday.png"), p_heat, width = 10, height = 5)
print(p_heat_c_mov)    ## 7

# 4)Compute total transaction mount by weekday and movement
mov_wday_amount <- df %>%
  group_by(txn_wday, movement) %>%
  summarise(total_amount = sum(amount, na.rm = TRUE), .groups = "drop")

p_heat_m_mov <- ggplot( mov_wday_amount, aes(x = movement, y = txn_wday, fill = total_amount)) +
  geom_tile() +
  scale_fill_gradient(
    low = "lightblue", high = "darkblue",
    labels = label_number(big.mark = ",", scale = 1)
  ) +
  labs(
    title = "Transaction Amount by Card Type and Day of Week",
    x = "Card type", y = "Weekday"
  ) +
  theme_minimal()
ggsave(file.path(output_dir, "heat_card_wday_amount.png"), p_heat_m, width = 10, height = 5)
print(p_heat_m_mov) ## 8


# ---------------------------
# 5) Compute total transaction count by weekday and transaction type
des_age_c <- df %>%
  group_by(age_group, txn_description  ) %>%
  summarise(count = n(), .groups = "drop")

p_heat_c_age_des <- ggplot(des_age_c, aes(x = age_group , y = txn_description, fill = count)) +
  geom_tile() +
  scale_fill_gradient(low = "mistyrose", high = "darkred")+
  labs(title = "Transaction Count by Transaction Type and Day of Week", x = "Transaction type", y = "Weekday") +
  theme_minimal()
ggsave(file.path(output_dir, "heat_des_wday_c.png"), p_heat, width = 10, height = 5)
print(p_heat_c_age_des)    ## 5



# 6) Compute total transaction amount by weekday and transaction type
des_age_amount <- df %>%
  group_by(age_group, txn_description) %>%
  summarise(total_amount = sum(amount, na.rm = TRUE), .groups = "drop")

# Plot heatmap
p_heat_m_age_des <- ggplot(des_age_amount, aes(x = age_group , y = txn_description, fill = total_amount)) +
  geom_tile() +
  scale_fill_gradient(
    low = "lightblue", high = "darkblue",
    labels = label_number(big.mark = ",", scale = 1)
  ) +
  labs(
    title = "Transaction Amount by Transaction Type and Day of Week",
    x = "Transaction type", y = "Weekday"
  ) +
  theme_minimal()
ggsave(file.path(output_dir, "heat_des_wday_amount.png"), p_heat_m, width = 10, height = 5)
print(p_heat_m_age_des) ## 6


# ---------------------------
# 7.5 Top merchants by total amount
# Create the merchant_group summary
merchant_group <- df %>%
  mutate(merchant_group = if_else(is.na(merchant_id), "NA Merchant", "Valid Merchant")) %>%
  group_by(merchant_group) %>%
  summarise(total_amount = sum(amount, na.rm = TRUE), .groups = "drop") %>%
  mutate(perc = total_amount / sum(total_amount) * 100,
         label = paste0( "\n", dollar(total_amount), "\n", round(perc, 1), "%"))

# Pie chart with labels
p_pie_na <- ggplot(merchant_group, aes(x = "", y = total_amount, fill = merchant_group)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  scale_fill_manual(values = c("NA Merchant" = "lightgray", "Valid Merchant" = "lightblue")) +
  geom_text(aes(label = label), position = position_stack(vjust = 0.5)) +
  labs(title = "Total Transaction Amount: NA vs Non-NA Merchants", fill = "Merchant Group") +
  theme_void()

# Print and save
print(p_pie_na) ## 8
ggsave(file.path(output_dir, "pie_na_vs_valid.png"), p_pie_na, width = 6, height = 6)

# ---------------------------
# Top merchants excluding NA
top_merchants <- df %>%
  filter(!is.na(merchant_id)) %>%  # exclude NA
  group_by(merchant_id) %>%
  summarise(total_amount = sum(amount, na.rm = TRUE), .groups = "drop") %>%
  arrange(desc(total_amount)) %>%
  slice_head(n = 15) 

# Bar chart
p_bar_top <- ggplot(top_merchants, aes(x = reorder(merchant_id, total_amount), y = total_amount)) +
  geom_col(fill = "steelblue") +
  coord_flip() +  # flip for horizontal bars
  labs(title = "Top 15 Merchants by Total Amount", x = "Merchant ID", y = "Total Amount") +
  scale_y_continuous(labels = scales::comma_format()) +
  theme_minimal()

# Print and save
print(p_bar_top) ## 9
ggsave(file.path(output_dir, "bar_top_merchants.png"), p_bar_top, width = 8, height = 6)


# ---------------------------
# 7.6 Transaction counts by movement/status/gender
if ("movement" %in% names(df)) {
  p_movement <- df %>%
    group_by(movement) %>%
    summarise(
      total_amount = sum(amount, na.rm = TRUE),
      txns = n(),
      .groups = "drop"
    ) %>%
    pivot_longer(cols = c(total_amount, txns)) %>%
    mutate(name = recode(name,
                         total_amount = "Total Amount",
                         txns = "Transaction Count")) %>%
    ggplot(aes(x = movement, y = value, fill = movement)) +
    geom_col(position = "dodge") +
    facet_wrap(~name, scales = "free_y") +
    scale_y_continuous(labels = label_number(big.mark = ",", scale = 1)) +
    labs(title = "Transaction Amount and Count by Card Type", y = "Value", x = "Card Type") +
    theme_minimal()}

if ("status" %in% names(df)) {
  p_status <- df %>%
    group_by(status) %>%
    summarise(
      total_amount = sum(amount, na.rm = TRUE),
      txns = n(),
      .groups = "drop"
    ) %>%
    pivot_longer(cols = c(total_amount, txns)) %>%
    mutate(name = recode(name,
                         total_amount = "Total Amount",
                         txns = "Transaction Count")) %>%
    ggplot(aes(x = status, y = value, fill = status)) +
    geom_col(position = "dodge") +
    facet_wrap(~name, scales = "free_y") +
    scale_y_continuous(labels = label_number(big.mark = ",", scale = 1)) +
    labs(title = "Transaction Amount and Count by Status", y = "Value", x = "Status") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))  # rotate labels if needed
}

  if ("txn_description" %in% names(df)) {
    p_txn_desc <- df %>%
      group_by(txn_description) %>%
      summarise(
        total_amount = sum(amount, na.rm = TRUE),
        txns = n(),
        .groups = "drop"
      ) %>%
      pivot_longer(cols = c(total_amount, txns)) %>%
      mutate(name = recode(name,
                           total_amount = "Total Amount",
                           txns = "Transaction Count")) %>%
      ggplot(aes(x = txn_description, y = value, fill = txn_description)) +
      geom_col(position = "dodge") +
      facet_wrap(~name, scales = "free_y") +
      scale_y_continuous(labels = label_number(big.mark = ",", scale = 1)) +
      labs(title = "Transaction Amount and Count by Description", y = "Value", x = "Transaction Description") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))  # rotate labels for readability
    ggsave(file.path(output_dir, "txn_description_amount_count.png"), p_txn_desc, width = 10, height = 6)
  }

p_gender <- df %>%
  group_by(gender) %>%
  summarise(
    total_amount = sum(amount, na.rm = TRUE),
    txns = n(),
    .groups = "drop"
  ) %>%
  pivot_longer(cols = c(total_amount, txns)) %>%
  mutate(name = recode(name,
                       total_amount = "Total Amount",
                       txns = "Transaction Count")) %>%
  ggplot(aes(x = gender, y = value, fill = gender)) +
  geom_col(position = "dodge") +
  facet_wrap(~name, scales = "free_y") +
  scale_y_continuous(labels = label_number(big.mark = ",", scale = 1)) +
  labs(title = "Transaction Amount and Count by Gender", y = "Value", x = "Gender") +
  theme_minimal()

# Plot by age_group
if ("age_group" %in% names(df)) {
  p_age_group <- df %>%
    group_by(age_group) %>%
    summarise(
      total_amount = sum(amount, na.rm = TRUE),
      txns = n(),
      .groups = "drop"
    ) %>%
    pivot_longer(cols = c(total_amount, txns)) %>%
    mutate(name = recode(name,
                         total_amount = "Total Amount",
                         txns = "Transaction Count")) %>%
    ggplot(aes(x = age_group, y = value, fill = age_group)) +
    geom_col(position = "dodge") +
    facet_wrap(~name, scales = "free_y") +
    scale_y_continuous(labels = label_number(big.mark = ",", scale = 1)) +
    labs(title = "Transaction Amount and Count by Age Group", 
         y = "Value", x = "Age Group") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))  # rotate labels

  ggsave(file.path(output_dir, "age_group_amount_count.png"), p_age_group, width = 10, height = 6)
}

print(p_movement)
print(p_status)
print(p_gender)
print(p_txn_desc)
print(p_age_group)

# 7.7 Save a multi-plot summary (amount hist + box + daily plots)
multi_plot <- plot_grid(p_amount_hist,p_cust_total_hist, p_daily_amount, p_daily_count, ncol = 1, align = "v")
ggsave(file.path(output_dir, "summary_multi.png"), multi_plot, width = 10, height = 16)
print(multi_plot)

message("Transaction-level visualizations saved to ", output_dir)

# ---------------------------
# 8. Feature engineering: customer-level summary (comprehensive)
# ---------------------------
message("Building customer-level features...")
customer_summary <- df %>%
  group_by(customer_id) %>%
  summarise(
    txn_count = n(),
    total_amount = sum(amount, na.rm = TRUE),
    avg_amount = mean(amount, na.rm = TRUE),
    median_amount = median(amount, na.rm = TRUE),
    max_amount = max(amount, na.rm = TRUE),
    balance_mean = mean(balance, na.rm = TRUE),
    distinct_merchants = n_distinct(if_else(is.na(merchant_id), "UNKNOWN", merchant_id)),
    card_present_pct = mean(card_present_flag, na.rm = TRUE),
    salary_txn_count = sum(str_detect(str_to_lower(coalesce(txn_description, "")), "salary|payroll|pay |pay/|pay-"), na.rm = TRUE),
    first_txn = min(txn_date, na.rm = TRUE),
    last_txn = max(txn_date, na.rm = TRUE),
    days_active = as.numeric(max(txn_date, na.rm = TRUE) - min(txn_date, na.rm = TRUE)) + 1,
    recency_days = as.numeric(max(txn_date, na.rm = TRUE) - max(txn_date, na.rm = TRUE)) # placeholder; will set below relative to analysis_date
  ) %>%
  ungroup()

# Set analysis date and recency properly
analysis_date <- max(df$txn_date, na.rm = TRUE) + 1
customer_summary <- customer_summary %>%
  mutate(
    recency_days = as.numeric(analysis_date - last_txn),
    txn_per_day = txn_count / pmax(days_active, 1),
    txn_per_month = txn_count / pmax((days_active / 30), 1)
  )

# Quick view
customer_summary %>% arrange(desc(total_amount)) %>% slice_head(n = 8) %>% print()

# ---------------------------
# 9. Customer-level EDA & plots
# ---------------------------

# 9.1 Distribution of total_amount per customer (log)
p_cust_total_hist <- ggplot(customer_summary, aes(x = total_amount)) + geom_histogram(bins = 40, fill = "dodgerblue") + scale_x_continuous(trans = "log10", labels = dollar_format()) + labs(title = "Distribution of Total Spending per Customer (log scale)", x = "Total Amount", y = "Count") + theme_minimal()
ggsave(file.path(output_dir, "cust_total_hist_log.png"), p_cust_total_hist, width = 8, height = 5)
print(p_cust_total_hist)

# 9.2 Scatter: txn_count vs total_amount
p_scatter <- ggplot(customer_summary, aes(x = txn_count, y = total_amount)) + geom_point(alpha = 0.6) + scale_y_continuous(labels = dollar_format()) + labs(title = "Customer Total Amount vs Transaction Count", x = "Transaction Count", y = "Total Amount") + theme_minimal()
ggsave(file.path(output_dir, "cust_scatter_txncount_total.png"), p_scatter, width = 7, height = 5)
print(p_scatter)

# 9.3 Avg transaction value by age group (if age exists)
if ("age" %in% names(df)) {
  age_plot <- customer_summary %>%
    left_join(df %>% select(customer_id, age) %>% distinct(), by = "customer_id") %>%
    mutate(age_group = cut(age, breaks = c(16,25,35,45,55,65,100), right = FALSE)) %>%
    ggplot(aes(x = age_group, y = avg_amount)) +
    geom_boxplot() + labs(title = "Average Transaction Amount by Age Group", x = "Age group", y = "Avg transaction") + theme_minimal()
  ggsave(file.path(output_dir, "avg_amount_by_agegroup.png"), age_plot, width = 8, height = 5)
}
print(age_plot)

# 9.4 Correlation matrix of numeric features
num_for_corr <- customer_summary %>% select(total_amount, txn_count, avg_amount, median_amount, max_amount, balance_mean, distinct_merchants, card_present_pct, txn_per_day, txn_per_month, recency_days)
corr_mat <- cor(num_for_corr %>% replace(is.na(.), 0))
png(file.path(output_dir, "customer_corrplot.png"), width = 900, height = 700)
corrplot::corrplot(corr_mat, method = "color", tl.cex = 0.8, number.cex = 0.7)
dev.off()
print(corr_mat)

#------
# Replace NA with 0 in numeric variables
num_for_corr <- customer_summary %>% 
  select(total_amount, txn_count, avg_amount, median_amount, max_amount, 
         balance_mean, distinct_merchants, card_present_pct, 
         txn_per_day, txn_per_month, recency_days) %>%
  replace(is.na(.), 0)

# Compute correlation matrix
corr_mat <- cor(num_for_corr)

# Save heatmap as PNG
png(file.path(output_dir, "customer_corr_heatmap.png"), width = 900, height = 700)

# Heatmap using pheatmap
pheatmap::pheatmap(
  corr_mat,
  cluster_rows = TRUE,
  cluster_cols = TRUE,
  color = colorRampPalette(c("red", "white", "blue"))(50),
  display_numbers = TRUE,
  number_format = "%.2f",
  fontsize = 10,
  main = "Customer Features Correlation Heatmap"
)

dev.off()

# Print correlation matrix
print(pheatmat)
# Select numeric columns
num_for_corr <- customer_summary %>% 
  select(total_amount, txn_count, avg_amount, median_amount, 
         max_amount, balance_mean, distinct_merchants, 
         card_present_pct, txn_per_day, txn_per_month, recency_days)

# Compute correlation matrix (replace NA with 0 to avoid errors)
corr_mat <- cor(num_for_corr %>% replace(is.na(.), 0))

# Show heatmap directly
corrplot::corrplot(
  corr_mat, 
  method = "color", 
  tl.cex = 0.8, 
  number.cex = 0.7
)

# Optionally print the matrix itself
print(corr_mat)

# ---------------------------
# 10. Clustering: determine best K via silhouette (k=2..8)
# ---------------------------
message("Determining optimal cluster K using silhouette...")

cluster_features <- customer_summary %>%
  select(total_amount, txn_count, avg_amount, balance_mean, distinct_merchants, card_present_pct, txn_per_month, recency_days) %>%
  replace(is.na(.), 0)

# scale
cluster_scaled <- scale(cluster_features)

# compute average silhouette for k = 2:8
sil_scores <- map_dbl(2:8, function(k) {
  km <- kmeans(cluster_scaled, centers = k, nstart = 20)
  ss <- silhouette(km$cluster, dist(cluster_scaled))
  mean(ss[, 3])
})

sil_df <- tibble(k = 2:8, sil = sil_scores)
print(sil_df)
best_k <- sil_df$k[which.max(sil_df$sil)]
message("Suggested best_k (by silhouette): ", best_k)

# Also show elbow for reference
png(file.path(output_dir, "elbow_wss.png"), width = 800, height = 500)
fviz_nbclust(cluster_scaled, kmeans, method = "wss") + ggtitle("Elbow Method (WSS)")
dev.off()

# ---------------------------
# 11. Run final k-means with best_k
# ---------------------------
k_final <- best_k
set.seed(123)
km_final <- kmeans(cluster_scaled, centers = k_final, nstart = 50)
customer_summary$cluster <- factor(km_final$cluster)

# Visualize clusters (PCA)
p_cluster <- fviz_cluster(km_final, data = cluster_scaled, repel = TRUE, show.clust.cent = TRUE) + ggtitle(paste("K-means clusters (k=", k_final, ")", sep = ""))
ggsave(file.path(output_dir, "kmeans_clusters_pca.png"), p_cluster, width = 8, height = 6)
print(p_cluster)

# ---------------------------
# 12. Cluster profiling
# ---------------------------
cluster_profiles <- customer_summary %>%
  group_by(cluster) %>%
  summarise(
    n_customers = n(),
    avg_total_amount = mean(total_amount, na.rm = TRUE),
    avg_txn_count = mean(txn_count, na.rm = TRUE),
    avg_avg_amount = mean(avg_amount, na.rm = TRUE),
    avg_balance = mean(balance_mean, na.rm = TRUE),
    avg_distinct_merchants = mean(distinct_merchants, na.rm = TRUE),
    pct_salary = mean(salary_txn_count > 0) * 100,
    avg_txn_per_month = mean(txn_per_month, na.rm = TRUE),
    avg_recency_days = mean(recency_days, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  arrange(desc(avg_total_amount))

print(cluster_profiles)
write_csv(cluster_profiles, file.path(output_dir, "cluster_profiles.csv"))

# Visualize profile: bar chart of avg_total_amount by cluster
p_profile_amount <- ggplot(cluster_profiles, aes(x = reorder(cluster, -avg_total_amount), y = avg_total_amount, fill = cluster)) +
  geom_col() + scale_y_continuous(labels = dollar_format()) + labs(title = "Avg Total Amount by Cluster", x = "Cluster", y = "Avg Total Amount") + theme_minimal()
ggsave(file.path(output_dir, "profile_avg_total_amount.png"), p_profile_amount, width = 8, height = 5)
print(p_)

# ---------------------------
# 13. Save customer summary + clusters
# ---------------------------
write_csv(customer_summary, "customer_summary_with_clusters.csv")
message("Saved customer_summary_with_clusters.csv and cluster_profiles.csv")

# ---------------------------
# 14. Modeling: Predict high-value customers (binary)
# ---------------------------
# Define high_value target: top 25% total_amount
threshold <- quantile(customer_summary$total_amount, 0.75, na.rm = TRUE)
customer_summary <- customer_summary %>% mutate(high_value = if_else(total_amount >= threshold, "High", "Low") %>% as.factor())

# Prepare modeling dataset
model_data <- customer_summary %>%
  select(customer_id, high_value, total_amount, txn_count, avg_amount, balance_mean, distinct_merchants, card_present_pct, txn_per_month, recency_days, cluster) %>%
  replace(is.na(.), 0)

# Split train/test (70/30)
set.seed(123)
train_index <- createDataPartition(model_data$high_value, p = 0.7, list = FALSE)
train <- model_data[train_index, ]
test  <- model_data[-train_index, ]

# ---------------------------
# 14A. Decision Tree
# ---------------------------
tree_formula <- as.formula("high_value ~ txn_count + avg_amount + balance_mean + distinct_merchants + card_present_pct + txn_per_month + recency_days")
tree_model <- rpart(tree_formula, data = train, method = "class", cp = 0.01)
rpart.plot(tree_model, main = "Decision Tree: Predict High Value Customers")

# Evaluate on test
pred_tree <- predict(tree_model, test, type = "prob")[, "High"]
pred_tree_class <- predict(tree_model, test, type = "class")
conf_tree <- confusionMatrix(pred_tree_class, test$high_value, positive = "High")
print(conf_tree)
roc_tree <- roc(as.numeric(test$high_value == "High"), pred_tree)
message("Decision tree AUC: ", round(auc(roc_tree), 3))
# save tree plot
png(file.path(output_dir, "decision_tree.png"), width = 800, height = 600)
rpart.plot(tree_model, main = "Decision Tree: Predict High Value Customers")
dev.off()

# ---------------------------
# 14B. Random Forest
# ---------------------------
# Train RF (using caret wrapper for convenience)
rf_control <- trainControl(method = "cv", number = 5, classProbs = TRUE, summaryFunction = twoClassSummary)
set.seed(123)
rf_model <- train(
  form = tree_formula,
  data = train,
  method = "rf",
  metric = "ROC",
  trControl = rf_control,
  tuneLength = 4
)
print(rf_model)
# Predictions
pred_rf_prob <- predict(rf_model, test, type = "prob")[, "High"]
pred_rf_class <- predict(rf_model, test)
conf_rf <- confusionMatrix(pred_rf_class, test$high_value, positive = "High")
print(conf_rf)
roc_rf <- roc(as.numeric(test$high_value == "High"), pred_rf_prob)
message("Random Forest AUC: ", round(auc(roc_rf), 3))

# Variable importance
varimp <- varImp(rf_model)$importance
write_csv(as.data.frame(varimp), file.path(output_dir, "rf_varimp.csv"))
png(file.path(output_dir, "rf_varimp.png"), width = 800, height = 600)
plot(varImp(rf_model), top = 10, main = "Top variable importance (RF)")
dev.off()

print(varimp)

# ---------------------------
# 15. Salary estimation (optional) - only if salary-like txns exist
# ---------------------------
if ("txn_description" %in% names(df)) {
  df <- df %>% mutate(txn_description_clean = str_to_lower(coalesce(txn_description, "")))
  salary_txns <- df %>%
    filter(str_detect(txn_description_clean, "salary|payroll|pay |pay/|pay-")) %>%
    group_by(customer_id) %>%
    summarise(
      median_salary_txn = median(amount, na.rm = TRUE),
      n_salary_txn = n(),
      .groups = "drop"
    )
  if (nrow(salary_txns) > 0) {
    customer_summary <- customer_summary %>% left_join(salary_txns, by = "customer_id")
    customer_summary <- customer_summary %>% mutate(estimated_annual_salary = if_else(!is.na(median_salary_txn), median_salary_txn * 12, NA_real_))
    # simple regression if enough labeled rows
    model_salary_df <- customer_summary %>% filter(!is.na(estimated_annual_salary))
    if (nrow(model_salary_df) >= 30) {
      salary_lm <- lm(estimated_annual_salary ~ total_amount + txn_count + avg_amount + balance_mean + distinct_merchants, data = model_salary_df)
      summary(salary_lm)
      png(file.path(output_dir, "salary_lm_resid.png"), width = 800, height = 600)
      plot(salary_lm, which = 1)
      dev.off()
    } else {
      message("Not enough salary-labeled customers to build a reliable regression model (need >=30)")
    }
    write_csv(customer_summary, "customer_summary_with_salary.csv")
  } else {
    message("No salary-like transactions detected by keyword search.")
  }
}


# ---------------------------
# 16. Final exports & report summary
# ---------------------------
write_csv(customer_summary, "customer_summary_final.csv")
message("All outputs saved. Plots in '", output_dir, "'; customer_summary_final.csv saved in working directory.")

# Quick executive summary printed to console
exec_summary <- customer_summary %>%
  summarise(
    total_customers = n(),
    mean_total_spent = mean(total_amount, na.rm = TRUE),
    median_total_spent = median(total_amount, na.rm = TRUE),
    top_10pct_spent = quantile(total_amount, 0.9, na.rm = TRUE)
  )
print(exec_summary)

# End of script
message("Analysis complete.")


# ---------------------------
# 17. RFM Analysis
# ---------------------------
message("Performing RFM analysis...")

# 17.1 Define RFM metrics
rfm_table <- customer_summary %>%
  select(customer_id, txn_count, total_amount, last_txn) %>%
  mutate(
    recency_days = as.numeric(analysis_date - last_txn),  # already computed
    frequency = txn_count,
    monetary = total_amount
  ) %>%
  select(customer_id, recency_days, frequency, monetary)

# Quick summary
summary(rfm_table)

# 15.2 Score each dimension: 1 (worst) to 5 (best)
rfm_table <- rfm_table %>%
  mutate(
    R_score = ntile(-recency_days, 5),   # lower recency = higher score
    F_score = ntile(frequency, 5),
    M_score = ntile(monetary, 5),
    RFM_score = paste0(R_score, F_score, M_score)
  )

# 15.3 Assign segments based on RFM (common scheme)
rfm_table <- rfm_table %>%
  mutate(
    segment = case_when(
      R_score >= 4 & F_score >= 4 & M_score >= 4 ~ "Champions",
      R_score >= 3 & F_score >= 3 & M_score >= 3 ~ "Loyal Customers",
      R_score >= 4 & F_score <= 2 & M_score <= 2 ~ "Recent Customers",
      R_score <= 2 & F_score >= 4 & M_score >= 4 ~ "Potential Loyalists",
      R_score <= 2 & F_score <= 2 & M_score <= 2 ~ "At Risk",
      TRUE ~ "Others"
    )
  )

# 15.4 Save RFM table
write_csv(rfm_table, file.path(output_dir, "customer_rfm_table.csv"))
message("RFM table saved to customer_rfm_table.csv")

# 15.5 Visualize RFM distributions
library(ggplot2)

# Histogram of R, F, M
p_r <- ggplot(rfm_table, aes(x = recency_days)) + geom_histogram(fill="salmon", bins=30) + labs(title="Recency Distribution", x="Recency (days)", y="Count") + theme_minimal()
p_f <- ggplot(rfm_table, aes(x = frequency)) + geom_histogram(fill="skyblue", bins=30) + labs(title="Frequency Distribution", x="Frequency (# transactions)", y="Count") + theme_minimal()
p_m <- ggplot(rfm_table, aes(x = monetary)) + geom_histogram(fill="lightgreen", bins=30) + labs(title="Monetary Distribution", x="Monetary ($)", y="Count") + theme_minimal()

ggsave(file.path(output_dir, "rfm_recency_hist.png"), p_r, width=7, height=5)
ggsave(file.path(output_dir, "rfm_frequency_hist.png"), p_f, width=7, height=5)
ggsave(file.path(output_dir, "rfm_monetary_hist.png"), p_m, width=7, height=5)

# 15.6 Summary of segments
rfm_summary <- rfm_table %>%
  group_by(segment) %>%
  summarise(
    count_customers = n(),
    avg_recency = mean(recency_days, na.rm=TRUE),
    avg_frequency = mean(frequency, na.rm=TRUE),
    avg_monetary = mean(monetary, na.rm=TRUE),
    .groups = "drop"
  ) %>%
  arrange(desc(count_customers))

print(rfm_summary)
write_csv(rfm_summary, file.path(output_dir, "rfm_segment_summary.csv"))

# Bar chart of segment counts
p_seg <- ggplot(rfm_summary, aes(x = reorder(segment, -count_customers), y = count_customers, fill = segment)) +
  geom_col() + labs(title="Customer Count by RFM Segment", x="Segment", y="Count") +
  theme_minimal() + scale_y_continuous(labels = scales::comma_format())

ggsave(file.path(output_dir, "rfm_segment_counts.png"), p_seg, width=8, height=5)
print(p_seg)
