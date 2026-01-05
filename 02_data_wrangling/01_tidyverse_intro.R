# ========================================================================
# Module 02: Data Wrangling - Tidyverse Introduction
# ========================================================================
#
# Learning Objectives:
#   - Master the core dplyr verbs (filter, select, mutate, arrange, summarize)
#   - Understand the pipe operator %>%
#   - Chain operations for readable data transformations
#   - Work with grouped operations
#
# Estimated time: 3-4 hours
# Difficulty: Beginner-Intermediate
#
# ========================================================================

# Load packages
library(tidyverse)  # Includes dplyr, ggplot2, tidyr, etc.

# ========================================================================
# 1. THE PIPE OPERATOR %>%
# ========================================================================

# The pipe %>% passes the result of one function to the next
# Read it as "then"

# Without pipe (hard to read):
round(mean(c(1, 2, 3, 4, 5)), 2)

# With pipe (readable):
c(1, 2, 3, 4, 5) %>%
  mean() %>%
  round(2)

# Keyboard shortcut: Ctrl/Cmd + Shift + M

# ========================================================================
# 2. DPLYR: THE CORE VERBS
# ========================================================================

# Create example data: gene expression in different conditions
gene_data <- data.frame(
  gene_id = rep(paste0("GENE_", 1:100), each = 3),
  sample = rep(c("control_1", "treated_1", "treated_2"), times = 100),
  condition = rep(c("control", "treated", "treated"), times = 100),
  expression = rnorm(300, mean = 10, sd = 3),
  p_value = runif(300, 0, 0.1),
  fold_change = rnorm(300, mean = 1, sd = 0.5)
)

# 2.1 FILTER: Keep rows based on conditions

# Filter for significant results (p < 0.05)
significant <- gene_data %>%
  filter(p_value < 0.05)

# Multiple conditions (AND)
significant_upregulated <- gene_data %>%
  filter(p_value < 0.05 & fold_change > 1.5)

# OR condition
extreme <- gene_data %>%
  filter(p_value < 0.01 | fold_change > 2)

# Using %in% for multiple values
specific_genes <- gene_data %>%
  filter(gene_id %in% c("GENE_1", "GENE_2", "GENE_3"))

# 2.2 SELECT: Choose columns

# Select specific columns
minimal <- gene_data %>%
  select(gene_id, condition, expression)

# Select range of columns
range_cols <- gene_data %>%
  select(gene_id:expression)

# Remove columns with -
no_sample <- gene_data %>%
  select(-sample)

# Helper functions:
# starts_with(), ends_with(), contains()
gene_data %>%
  select(gene_id, starts_with("fold"))

# 2.3 MUTATE: Create or modify columns

# Add new column
gene_data_with_log <- gene_data %>%
  mutate(log_expression = log2(expression))

# Multiple new columns
gene_data_enhanced <- gene_data %>%
  mutate(
    log_expression = log2(expression),
    is_significant = p_value < 0.05,
    regulation = case_when(
      fold_change > 1.5 & p_value < 0.05 ~ "up",
      fold_change < 0.67 & p_value < 0.05 ~ "down",
      TRUE ~ "unchanged"
    )
  )

# 2.4 ARRANGE: Sort rows

# Sort by p-value (ascending)
sorted <- gene_data %>%
  arrange(p_value)

# Sort descending
sorted_desc <- gene_data %>%
  arrange(desc(fold_change))

# Multiple columns
sorted_multi <- gene_data %>%
  arrange(condition, p_value)

# 2.5 SUMMARIZE: Aggregate data

# Overall statistics
summary_stats <- gene_data %>%
  summarize(
    mean_expression = mean(expression),
    sd_expression = sd(expression),
    n_samples = n()
  )

# 2.6 GROUP_BY: Split-Apply-Combine

# Statistics by condition
condition_stats <- gene_data %>%
  group_by(condition) %>%
  summarize(
    mean_expr = mean(expression),
    sd_expr = sd(expression),
    n = n()
  )

# Multiple grouping variables
gene_condition_stats <- gene_data %>%
  group_by(gene_id, condition) %>%
  summarize(
    mean_expr = mean(expression),
    .groups = "drop"  # Ungroup after summarize
  )

# ========================================================================
# 3. CHAINING OPERATIONS
# ========================================================================

# Real-world example: Full analysis pipeline
# This is the power of tidyverse!

analysis_result <- gene_data %>%
  # 1. Filter for treated samples only
  filter(condition == "treated") %>%
  # 2. Create new columns
  mutate(
    log_fc = log2(fold_change),
    is_significant = p_value < 0.05
  ) %>%
  # 3. Group by gene
  group_by(gene_id) %>%
  # 4. Calculate mean per gene
  summarize(
    mean_log_fc = mean(log_fc),
    min_pvalue = min(p_value),
    .groups = "drop"
  ) %>%
  # 5. Filter for significant genes
  filter(min_pvalue < 0.05) %>%
  # 6. Sort by fold change
  arrange(desc(mean_log_fc)) %>%
  # 7. Keep top 10
  slice_head(n = 10)

print(analysis_result)

# ========================================================================
# 4. PRACTICAL EXAMPLES FROM RESEARCH
# ========================================================================

# Example 1: Single-cell RNA-seq metadata processing
# (Inspired by Brain_Blast project patterns)

process_metadata <- function(metadata) {
  metadata %>%
    # Remove low quality samples
    filter(
      n_genes > 200,
      n_genes < 5000,
      percent_mito < 10
    ) %>%
    # Add quality categories
    mutate(
      quality = case_when(
        n_genes < 500 ~ "low",
        n_genes < 2000 ~ "medium",
        TRUE ~ "high"
      ),
      # Normalize age if needed
      age_scaled = scale(age)[,1]
    ) %>%
    # Group analysis
    group_by(cell_type, condition) %>%
    mutate(
      n_cells_per_group = n()
    ) %>%
    ungroup() %>%
    # Keep only groups with sufficient cells
    filter(n_cells_per_group >= 10)
}

# Example 2: Calculate differential expression summary
summarize_differential_expression <- function(de_results) {
  de_results %>%
    mutate(
      # Categorize genes
      regulation = case_when(
        log2FoldChange > 1 & padj < 0.05 ~ "Upregulated",
        log2FoldChange < -1 & padj < 0.05 ~ "Downregulated",
        TRUE ~ "Not significant"
      )
    ) %>%
    group_by(regulation) %>%
    summarize(
      n_genes = n(),
      mean_fc = mean(log2FoldChange),
      mean_expr = mean(baseMean)
    )
}

# ========================================================================
# EXERCISES
# ========================================================================

# Exercise 1: From gene_data, find genes with:
#   - p_value < 0.01
#   - expression > median expression
#   - Sort by fold_change descending
# Your answer:

# Exercise 2: Calculate mean and SD of expression for each condition
# Your answer:

# Exercise 3: Find the top 5 genes with highest fold_change in treated condition
# Your answer:

# Solutions: 02_data_wrangling/exercises/solutions_01.R

# ========================================================================
# KEY TAKEAWAYS
# ========================================================================

cat("\n")
cat("========================================\n")
cat("Key Takeaways: Tidyverse Basics\n")
cat("========================================\n")
cat("\n")
cat("1. Use %>% pipe to chain operations (readable!)\n")
cat("2. filter() for rows, select() for columns\n")
cat("3. mutate() creates/modifies columns\n")
cat("4. arrange() sorts, summarize() aggregates\n")
cat("5. group_by() enables split-apply-combine\n")
cat("6. Chain operations for complex workflows\n")
cat("\n")

# Next: 02_data_import_export.R
