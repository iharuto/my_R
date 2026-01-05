# ========================================================================
# Module 01: R Fundamentals - Data Types and Structures
# ========================================================================
#
# Learning Objectives:
#   - Understand R's basic data types
#   - Master vectors, lists, and data frames
#   - Learn how to inspect and manipulate data structures
#   - Avoid common beginner mistakes
#
# Estimated time: 2-3 hours
# Difficulty: Beginner
#
# ========================================================================

# ========================================================================
# 1. ATOMIC DATA TYPES
# ========================================================================

# R has 6 atomic types, but we focus on the 4 most common:

# 1.1 Numeric (numbers with decimals)
height <- 1.75  # meters
weight <- 70.5  # kg
temperature <- 37.2

class(height)  # "numeric"
typeof(height)  # "double" (double precision floating point)

# 1.2 Integer (whole numbers)
n_participants <- 100L  # The "L" makes it explicitly integer
age <- 25L

class(age)  # "integer"
typeof(age)  # "integer"

# Note: Without "L", numbers are numeric by default
x <- 5
typeof(x)  # "double", not "integer"!

# 1.3 Character (text strings)
name <- "Alice"
gene_id <- "ENSG00000139618"  # BRCA2 gene
description <- "This is a string with spaces and punctuation!"

class(name)  # "character"
typeof(name)  # "character"

# 1.4 Logical (TRUE/FALSE)
is_control <- TRUE
has_mutation <- FALSE
passed_qc <- TRUE

class(is_control)  # "logical"
typeof(is_control)  # "logical"

# Note: T and F are shortcuts, but TRUE/FALSE are preferred
is_valid <- T  # Works, but not recommended
is_valid <- TRUE  # Preferred - can't be accidentally overwritten

# ========================================================================
# 2. VECTORS: The Foundation of R
# ========================================================================

# In R, everything is a vector!
# Even single values are vectors of length 1

length(height)  # 1
length(name)  # 1

# 2.1 Creating Vectors with c() (combine)

# Numeric vector
ages <- c(25, 30, 35, 40, 45)
ages

# Character vector
names <- c("Alice", "Bob", "Carol", "Dave", "Eve")
names

# Logical vector
passed <- c(TRUE, FALSE, TRUE, TRUE, FALSE)
passed

# 2.2 Sequences

# Sequence from 1 to 10
seq_1_10 <- 1:10
seq_1_10

# Sequence with custom steps
seq_custom <- seq(from = 0, to = 100, by = 10)
seq_custom

# Sequence with specific length
seq_length <- seq(from = 0, to = 1, length.out = 11)
seq_length

# Repeat values
rep_3 <- rep(3, times = 5)  # 3 3 3 3 3
rep_vec <- rep(c(1, 2, 3), times = 3)  # 1 2 3 1 2 3 1 2 3
rep_each <- rep(c(1, 2, 3), each = 3)  # 1 1 1 2 2 2 3 3 3

# 2.3 Vector Arithmetic (Vectorized Operations)

# R operates element-wise on vectors - this is POWERFUL!
x <- c(1, 2, 3, 4, 5)
y <- c(10, 20, 30, 40, 50)

# Element-wise operations
x + y  # 11 22 33 44 55
x * y  # 10 40 90 160 250
x / y  # 0.1 0.1 0.1 0.1 0.1
x ^ 2  # 1 4 9 16 25

# Operations with single values (recycling)
x + 10  # 11 12 13 14 15
x * 2   # 2 4 6 8 10

# Why this matters: No need for loops!
# ❌ Bad (slow):
# result <- numeric(length(x))
# for (i in 1:length(x)) {
#   result[i] <- x[i] + 10
# }

# ✓ Good (fast, readable):
result <- x + 10

# 2.4 Vector Indexing (Subsetting)

# R uses 1-based indexing (unlike Python's 0-based)
names <- c("Alice", "Bob", "Carol", "Dave", "Eve")

# Access single element
names[1]  # "Alice"
names[3]  # "Carol"

# Access multiple elements
names[c(1, 3, 5)]  # "Alice" "Carol" "Eve"
names[1:3]  # "Alice" "Bob" "Carol"

# Negative indexing removes elements
names[-1]  # Everything except first
names[-c(1, 3)]  # Remove 1st and 3rd

# Logical indexing (very powerful!)
ages <- c(25, 30, 35, 40, 45)
ages > 30  # FALSE FALSE TRUE TRUE TRUE
ages[ages > 30]  # 35 40 45

# Named vectors
gene_expression <- c(BRCA1 = 5.2, TP53 = 7.8, MYC = 3.4)
gene_expression["BRCA1"]  # 5.2
gene_expression[c("BRCA1", "MYC")]  # 5.2 3.4

# 2.5 Important Vector Properties

# Type coercion: Vectors can only contain ONE type
# R will coerce to the most flexible type

mixed <- c(1, 2, "three")  # All become character!
class(mixed)  # "character"
mixed  # "1" "2" "three"

# Coercion hierarchy: logical < integer < numeric < character
c(TRUE, 1L)  # 1 1 (logical → integer)
c(1L, 1.5)  # 1.0 1.5 (integer → numeric)
c(1.5, "a")  # "1.5" "a" (numeric → character)

# Missing values: NA
values_with_missing <- c(1, 2, NA, 4, 5)
values_with_missing

# NA propagates through calculations
mean(values_with_missing)  # NA
mean(values_with_missing, na.rm = TRUE)  # 3 (removes NA)

# Check for NA
is.na(values_with_missing)  # FALSE FALSE TRUE FALSE FALSE

# ========================================================================
# 3. FACTORS: Categorical Data
# ========================================================================

# Factors represent categorical data (very important in statistics)

# 3.1 Creating factors
treatment <- c("control", "drug_A", "drug_A", "control", "drug_B", "control")
treatment_factor <- factor(treatment)
treatment_factor

# Factors have levels (unique categories)
levels(treatment_factor)  # "control" "drug_A" "drug_B"

# 3.2 Ordered factors
education <- c("High School", "PhD", "Bachelor", "Master", "Bachelor")
education_ordered <- factor(
  education,
  levels = c("High School", "Bachelor", "Master", "PhD"),
  ordered = TRUE
)
education_ordered

# Now comparisons work:
education_ordered[1] < education_ordered[2]  # TRUE

# 3.3 Common factor operations
nlevels(treatment_factor)  # 3
table(treatment_factor)  # Count frequencies

# ⚠️ Common mistake: Factors look like characters but aren't!
as.numeric(treatment_factor)  # 1 2 2 1 3 1 (NOT what you expect!)

# Convert factor to character first
as.character(treatment_factor)

# ========================================================================
# 4. LISTS: Flexible Containers
# ========================================================================

# Lists can contain different types and structures
# Think of lists as containers that can hold anything

# 4.1 Creating lists
patient_data <- list(
  name = "Alice",
  age = 30,
  measurements = c(120, 80, 72),
  has_condition = TRUE
)

patient_data

# 4.2 Accessing list elements

# By name (preferred)
patient_data$name  # "Alice"
patient_data$measurements  # 120 80 72

# By index with [[]]
patient_data[[1]]  # "Alice"
patient_data[[3]]  # 120 80 72

# Note: Single brackets [] return a list
patient_data[1]  # List with one element
patient_data[[1]]  # The element itself

# Multiple elements
patient_data[c("name", "age")]  # Returns list with 2 elements

# 4.3 Lists of lists (nested structures)
study_data <- list(
  patient1 = list(name = "Alice", age = 30),
  patient2 = list(name = "Bob", age = 35)
)

study_data$patient1$name  # "Alice"

# 4.4 Why lists matter
# - Store complex data structures
# - Return multiple values from functions
# - Handle heterogeneous data
# - Essential for data frames (which are special lists!)

# ========================================================================
# 5. DATA FRAMES: The Workhorse of Data Analysis
# ========================================================================

# Data frames are the most important structure for data analysis
# Think of them as spreadsheets with rows and columns

# 5.1 Creating data frames
patients <- data.frame(
  patient_id = 1:5,
  name = c("Alice", "Bob", "Carol", "Dave", "Eve"),
  age = c(25, 30, 35, 40, 45),
  treatment = c("control", "drug_A", "drug_A", "control", "drug_B"),
  response = c(5.2, 7.8, 6.1, 4.9, 8.3)
)

patients

# 5.2 Inspecting data frames

# Structure
str(patients)  # Show structure

# Dimensions
nrow(patients)  # Number of rows
ncol(patients)  # Number of columns
dim(patients)  # Both: rows, columns

# First/last few rows
head(patients, n = 3)  # First 3 rows
tail(patients, n = 2)  # Last 2 rows

# Column names
names(patients)  # or colnames(patients)

# Summary statistics
summary(patients)

# 5.3 Accessing data frame elements

# Get a column (multiple ways)
patients$age  # Returns vector
patients[, "age"]  # Returns vector
patients["age"]  # Returns data frame with 1 column
patients[, 3]  # By position (not recommended)

# Get a row
patients[1, ]  # First row (returns data frame)

# Get specific element
patients[1, "age"]  # 25
patients$age[1]  # 25

# Multiple columns
patients[, c("name", "age")]

# 5.4 Subsetting data frames (filtering)

# Rows where age > 30
patients[patients$age > 30, ]

# Rows where treatment is control
patients[patients$treatment == "control", ]

# Multiple conditions (& for AND, | for OR)
patients[patients$age > 30 & patients$response > 5, ]

# Select specific columns
patients[patients$age > 30, c("name", "response")]

# 5.5 Adding columns
patients$bmi <- c(22.5, 25.3, 21.8, 24.7, 23.1)
patients

# Computed columns
patients$age_group <- ifelse(patients$age >= 35, "older", "younger")
patients

# 5.6 Important properties

# Data frames are actually lists!
typeof(patients)  # "list"
class(patients)  # "data.frame"

# Each column is a vector
typeof(patients$age)  # "integer"

# All columns must have same length
# This will error:
# bad_df <- data.frame(x = 1:3, y = 1:4)  # Error!

# ========================================================================
# 6. MATRICES: 2D Arrays of Same Type
# ========================================================================

# Matrices are like data frames but all elements must be same type
# Useful for mathematical operations, less common in typical data analysis

# 6.1 Creating matrices
mat <- matrix(1:12, nrow = 3, ncol = 4)
mat

# By row instead of column
mat_byrow <- matrix(1:12, nrow = 3, ncol = 4, byrow = TRUE)
mat_byrow

# 6.2 Matrix operations
mat * 2  # Element-wise multiplication
t(mat)  # Transpose

# Matrix algebra (not covered in detail here)
# mat1 %*% mat2  # Matrix multiplication

# ========================================================================
# 7. TYPE CHECKING AND CONVERSION
# ========================================================================

# 7.1 Checking types

x <- 5.5
is.numeric(x)  # TRUE
is.character(x)  # FALSE
is.logical(x)  # FALSE
is.vector(x)  # TRUE
is.list(x)  # FALSE
is.data.frame(x)  # FALSE

# 7.2 Type conversion

# Numeric to character
x <- 5.5
as.character(x)  # "5.5"

# Character to numeric
y <- "42"
as.numeric(y)  # 42

# Numeric to logical
as.logical(0)  # FALSE
as.logical(1)  # TRUE
as.logical(5)  # TRUE (any non-zero is TRUE)

# Character to numeric (careful!)
as.numeric("abc")  # NA with warning

# 7.3 Conversion between structures

# Vector to list
vec <- c(1, 2, 3)
as.list(vec)

# List to vector (if possible)
my_list <- list(1, 2, 3)
unlist(my_list)  # 1 2 3

# Data frame to matrix (if all columns are same type)
as.matrix(patients[, c("age", "response")])

# ========================================================================
# 8. COMMON MISTAKES AND PITFALLS
# ========================================================================

# 8.1 Using = instead of <- for assignment
# Both work, but <- is preferred for assignment
x = 5  # Works but not idiomatic
x <- 5  # Preferred

# 8.2 Forgetting that R is 1-indexed
vec <- c("a", "b", "c")
vec[0]  # character(0) - empty! (not "a")
vec[1]  # "a" - correct

# 8.3 Type coercion surprises
c(1, 2, "3")  # All become character!

# 8.4 Factor troubles
fac <- factor(c("1", "2", "3"))
as.numeric(fac)  # 1 2 3 - looks right but...
as.numeric(factor(c("3", "1", "2")))  # 3 1 2 - WRONG!
# Correct way:
as.numeric(as.character(fac))

# 8.5 NA vs NULL
x <- c(1, NA, 3)  # NA is a missing value in a vector
x[2]  # NA

y <- NULL  # NULL means absence of value
y[1]  # NULL

# ========================================================================
# 9. PRACTICAL EXAMPLES
# ========================================================================

# Example 1: Gene expression data
genes <- c("BRCA1", "TP53", "MYC", "EGFR")
expression <- c(5.2, 7.8, 3.4, 6.1)
is_upregulated <- expression > 5

gene_data <- data.frame(
  gene = genes,
  expression = expression,
  upregulated = is_upregulated
)

# Filter for upregulated genes
gene_data[gene_data$upregulated, ]

# Example 2: Clinical trial data
trial_data <- data.frame(
  subject_id = 1:100,
  treatment = rep(c("placebo", "drug"), each = 50),
  age = round(rnorm(100, mean = 45, sd = 10)),
  response = rnorm(100, mean = 10, sd = 2)
)

# Summary statistics by treatment
aggregate(response ~ treatment, data = trial_data, FUN = mean)

# ========================================================================
# SUMMARY & KEY TAKEAWAYS
# ========================================================================

cat("\n")
cat("========================================\n")
cat("Key Takeaways: Data Types\n")
cat("========================================\n")
cat("\n")
cat("1. Everything in R is a vector\n")
cat("2. Vectors can only contain one type\n")
cat("3. Use factors for categorical data\n")
cat("4. Lists are flexible containers\n")
cat("5. Data frames are THE structure for data analysis\n")
cat("6. R uses 1-based indexing\n")
cat("7. Vectorized operations are fast and readable\n")
cat("8. NA represents missing values\n")
cat("\n")

# ========================================================================
# EXERCISES
# ========================================================================

# Exercise 1: Create a vector of ages from 18 to 65, increments of 1
# Your answer here:

# Exercise 2: Create a data frame with 5 patients (id, name, age, treatment)
# Your answer here:

# Exercise 3: From the data frame above, extract patients with age > 40
# Your answer here:

# Exercise 4: Calculate the mean age, excluding NA values
ages_with_na <- c(25, 30, NA, 40, 45, NA, 50)
# Your answer here:

# Exercise 5: Create a named vector of 5 genes and their expression values
# Your answer here:

# Solutions in: 01_fundamentals/exercises/solutions_01.R

# ========================================================================
# NEXT STEPS
# ========================================================================

cat("Next: 02_control_flow.R\n")
cat("  Learn if/else, loops, and vectorization\n")
