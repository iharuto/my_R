# ========================================================================
# Module 05: Programming Patterns - Functional Programming
# ========================================================================
#
# Learning Objectives:
#   - Master the apply family (lapply, sapply, mapply)
#   - Use purrr for modern functional programming
#   - Write cleaner code with map functions
#   - Avoid loops when vectorization works better
#
# Estimated time: 3-4 hours
# Difficulty: Intermediate-Advanced
#
# ========================================================================

library(tidyverse)  # Includes purrr

# ========================================================================
# 1. WHY FUNCTIONAL PROGRAMMING?
# ========================================================================

# Functional programming in R means:
#   - Writing functions that take functions as arguments
#   - Avoiding explicit loops when possible
#   - Writing more concise, readable code
#   - Leveraging R's vectorization

# Compare these approaches:

# ❌ Imperative (loop-based)
results <- vector("list", length = 5)
for (i in 1:5) {
  results[[i]] <- mean(rnorm(100))
}

# ✓ Functional (map-based)
results <- map(1:5, ~mean(rnorm(100)))

# ========================================================================
# 2. THE APPLY FAMILY (Base R)
# ========================================================================

# 2.1 lapply: Apply function to list/vector, return list

# Example: Calculate mean for each column
data_list <- list(
  sample1 = rnorm(100, mean = 5),
  sample2 = rnorm(100, mean = 7),
  sample3 = rnorm(100, mean = 6)
)

means <- lapply(data_list, mean)
means  # Returns list

# 2.2 sapply: Same as lapply but simplifies output

means_simplified <- sapply(data_list, mean)
means_simplified  # Returns vector

# 2.3 mapply: Multivariate version

# Apply function with multiple arguments
mapply(
  rnorm,
  n = c(5, 10, 15),
  mean = c(0, 10, 20),
  sd = c(1, 2, 3)
)

# 2.4 apply: For matrices/arrays

mat <- matrix(1:12, nrow = 3, ncol = 4)
apply(mat, 1, sum)  # Row sums (margin = 1)
apply(mat, 2, sum)  # Column sums (margin = 2)

# ========================================================================
# 3. PURRR: MODERN FUNCTIONAL PROGRAMMING
# ========================================================================

# purrr is more consistent and powerful than apply family

# 3.1 map: Always returns a list

gene_list <- list(
  gene1 = rnorm(50, 5, 1),
  gene2 = rnorm(50, 7, 1.5),
  gene3 = rnorm(50, 3, 0.8)
)

# Calculate mean for each gene
map(gene_list, mean)

# 3.2 map_dbl: Returns numeric vector
map_dbl(gene_list, mean)

# 3.3 map_chr: Returns character vector
map_chr(gene_list, ~paste("Mean:", round(mean(.x), 2)))

# 3.4 map_df/map_dfr: Returns data frame
gene_stats <- map_dfr(gene_list, ~{
  data.frame(
    mean = mean(.x),
    sd = sd(.x),
    n = length(.x)
  )
}, .id = "gene")

gene_stats

# ========================================================================
# 4. ANONYMOUS FUNCTIONS
# ========================================================================

# Three ways to write anonymous functions in purrr:

# Method 1: Full function syntax
map(gene_list, function(x) mean(x) + sd(x))

# Method 2: Tilde shorthand (preferred)
map(gene_list, ~mean(.x) + sd(.x))

# Method 3: For very simple cases
map(gene_list, mean)

# Multiple arguments with tilde
map2_dbl(
  c(5, 10, 15),
  c(1, 2, 3),
  ~rnorm(.x, mean = .y) %>% mean()
)

# ========================================================================
# 5. REAL-WORLD EXAMPLES FROM RESEARCH
# ========================================================================

# Example 1: Process multiple data files
# (Pattern from Brain_Blast project)

# Simulate reading multiple datasets
simulate_read_dataset <- function(file_path) {
  data.frame(
    gene_id = paste0("GENE_", 1:100),
    expression = rnorm(100, mean = 5, sd = 2),
    file = basename(file_path)
  )
}

file_paths <- paste0("data/sample_", 1:5, ".csv")

# Read and combine all files
all_data <- map_dfr(file_paths, simulate_read_dataset)

# Example 2: Apply same transformation to multiple columns
clinical_data <- data.frame(
  age = rnorm(50, 45, 10),
  bmi = rnorm(50, 25, 3),
  blood_pressure = rnorm(50, 120, 15)
)

# Z-score normalize all columns
normalized <- clinical_data %>%
  map_df(~scale(.x)[, 1])

# Example 3: Nested list operations
# Process grouped data (similar to single-cell analysis)

process_cell_data <- function(cell_df) {
  cell_df %>%
    summarize(
      mean_expr = mean(expression),
      cv = sd(expression) / mean(expression)
    )
}

nested_data <- all_data %>%
  group_by(file) %>%
  nest() %>%
  mutate(
    stats = map(data, process_cell_data)
  ) %>%
  unnest(stats)

# ========================================================================
# 6. ADVANCED: PARALLEL MAPPING
# ========================================================================

library(furrr)  # Parallel purrr

# Setup parallel processing
plan(multisession, workers = 4)

# Run in parallel
results_parallel <- future_map(1:100, ~{
  # Simulate expensive computation
  Sys.sleep(0.01)
  mean(rnorm(1000))
}, .options = furrr_options(seed = TRUE))

# ========================================================================
# 7. ERROR HANDLING WITH PURRR
# ========================================================================

# safely: Returns list with result and error
safe_mean <- safely(mean)

# Try with valid data
safe_mean(c(1, 2, 3))

# Try with invalid data
safe_mean("not a number")

# Use in mapping
mixed_data <- list(
  good = c(1, 2, 3),
  bad = "text",
  also_good = c(4, 5, 6)
)

results <- map(mixed_data, safely(mean))

# Extract successful results
successful <- results %>%
  keep(~is.null(.x$error)) %>%
  map_dbl(~.x$result)

# possibly: Return default value on error
possibly_mean <- possibly(mean, otherwise = NA)
map_dbl(mixed_data, possibly_mean)

# ========================================================================
# 8. REDUCE: COMBINE LIST ELEMENTS
# ========================================================================

# reduce: Apply function recursively

# Example: Merge multiple data frames
df_list <- list(
  data.frame(id = 1:3, val_a = c(10, 20, 30)),
  data.frame(id = 1:3, val_b = c(40, 50, 60)),
  data.frame(id = 1:3, val_c = c(70, 80, 90))
)

# Merge all by 'id'
combined <- reduce(df_list, left_join, by = "id")

# Example: Calculate cumulative product
reduce(1:5, `*`)  # 1 * 2 * 3 * 4 * 5 = 120

# ========================================================================
# 9. KEEP, DISCARD, COMPACT
# ========================================================================

# keep: Filter list based on predicate
numbers <- list(a = 1, b = -2, c = 3, d = -4)
keep(numbers, ~.x > 0)  # Keep positive

# discard: Remove based on predicate
discard(numbers, ~.x > 0)  # Remove positive

# compact: Remove NULL/NA
messy_list <- list(1, NULL, 3, NA, 5)
compact(messy_list)  # Removes NULL and NA

# ========================================================================
# 10. PRACTICAL PATTERN: SPLIT-APPLY-COMBINE
# ========================================================================

# Alternative to group_by %>% summarize

# Split data by group
split_data <- split(iris, iris$Species)

# Apply function to each group
group_means <- map_dfr(split_data, ~{
  data.frame(
    mean_sepal_length = mean(.x$Sepal.Length),
    mean_petal_length = mean(.x$Petal.Length)
  )
}, .id = "Species")

# ========================================================================
# WHEN TO USE LOOPS VS FUNCTIONAL PROGRAMMING
# ========================================================================

# ✓ Use loops when:
#   - Each iteration depends on the previous
#   - You need to modify objects in place
#   - The logic is complex and loops are clearer

# ✓ Use functional programming when:
#   - Operations are independent
#   - You're applying same function to multiple inputs
#   - You want more readable, concise code
#   - You need easy parallelization

# ========================================================================
# KEY TAKEAWAYS
# ========================================================================

cat("\n")
cat("========================================\n")
cat("Key Takeaways: Functional Programming\n")
cat("========================================\n")
cat("\n")
cat("1. Use map() instead of lapply() for consistency\n")
cat("2. Use map_dbl(), map_chr() for specific output types\n")
cat("3. Use ~ and .x for anonymous functions\n")
cat("4. Use safely() and possibly() for error handling\n")
cat("5. Use reduce() to combine list elements\n")
cat("6. Functional code is often more readable than loops\n")
cat("7. Easy to parallelize with furrr\n")
cat("\n")

# ========================================================================
# EXERCISES
# ========================================================================

# Exercise 1: Calculate mean and SD for each column in mtcars
# Use map_dfr() to return a data frame
# Your answer:

# Exercise 2: Read multiple files and combine them
# Create a function that simulates reading a file and use map_dfr()
# Your answer:

# Exercise 3: Safely calculate log of each element in a list that contains
# both positive and negative numbers. Handle errors gracefully.
# Your answer:

# Solutions: 05_programming_patterns/advanced_examples/solutions_01.R
