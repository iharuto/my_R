# ========================================================================
# Project Structure Best Practices
# ========================================================================
#
# Purpose: Learn how to organize R projects professionally
# Difficulty: Beginner
# Estimated time: 20 minutes
#
# Learning objectives:
#   - Understand why project organization matters
#   - Learn standard R project structure
#   - Use RStudio Projects effectively
#   - Implement reproducible workflows
#
# ========================================================================

# ========================================================================
# WHY PROJECT STRUCTURE MATTERS
# ========================================================================

# Good project structure:
#   ✓ Makes code reproducible
#   ✓ Easier to collaborate
#   ✓ Simpler to maintain long-term
#   ✓ Reduces bugs from file path issues
#   ✓ Professional and impressive

# Bad project structure leads to:
#   ✗ "Works on my machine" problems
#   ✗ Lost files and code
#   ✗ Inability to reproduce results
#   ✗ Wasted time searching for files

# ========================================================================
# STANDARD PROJECT STRUCTURE
# ========================================================================

# Recommended directory structure for data analysis projects:
#
# project_name/
# ├── project_name.Rproj          # RStudio project file
# ├── README.md                    # Project description
# ├── .gitignore                   # Git ignore file
# ├── data/
# │   ├── raw/                     # Original, immutable data
# │   ├── processed/               # Cleaned, transformed data
# │   └── metadata/                # Data documentation
# ├── scripts/
# │   ├── 01_data_cleaning.R       # Numbered for order
# │   ├── 02_analysis.R
# │   ├── 03_visualization.R
# │   └── functions/               # Custom functions
# │       └── helper_functions.R
# ├── output/
# │   ├── figures/                 # Plots and images
# │   ├── tables/                  # Results tables
# │   └── models/                  # Saved model objects
# ├── reports/
# │   ├── manuscript.Rmd           # R Markdown documents
# │   └── presentation.Rmd
# └── docs/
#     └── analysis_notes.md        # Documentation

# ========================================================================
# CREATING PROJECT STRUCTURE PROGRAMMATICALLY
# ========================================================================

# Function to create standard project structure
create_project_structure <- function(project_name, base_path = "~/Projects") {

  cat("Creating project structure for:", project_name, "\n")

  # Full project path
  project_path <- file.path(base_path, project_name)

  # Check if project already exists
  if (dir.exists(project_path)) {
    stop("Project directory already exists: ", project_path)
  }

  # Create main directory
  dir.create(project_path, recursive = TRUE)

  # Create subdirectories
  dirs <- c(
    "data/raw",
    "data/processed",
    "data/metadata",
    "scripts/functions",
    "output/figures",
    "output/tables",
    "output/models",
    "reports",
    "docs"
  )

  for (d in dirs) {
    dir.create(file.path(project_path, d), recursive = TRUE)
    cat("  Created:", d, "\n")
  }

  # Create README.md
  readme_content <- sprintf(
"# %s

## Project Overview
[Brief description of the project]

## Directory Structure
- `data/`: All data files
  - `raw/`: Original data (never modify!)
  - `processed/`: Cleaned data
  - `metadata/`: Data documentation
- `scripts/`: Analysis scripts
- `output/`: Results (figures, tables, models)
- `reports/`: R Markdown reports
- `docs/`: Documentation

## Getting Started
1. Place raw data in `data/raw/`
2. Run scripts in order: `01_`, `02_`, etc.
3. Check outputs in `output/`

## Author
[Your name]

## Date Created
%s
", project_name, Sys.Date())

  writeLines(readme_content, file.path(project_path, "README.md"))
  cat("  Created: README.md\n")

  # Create .gitignore
  gitignore_content <- "# R files
.Rproj.user
.Rhistory
.RData
.Ruserdata
*.Rproj

# Data files (keep raw data in version control, but not large processed files)
data/processed/*.rds
data/processed/*.csv
*.rds

# Output files
output/
*.html
*.pdf

# System files
.DS_Store
Thumbs.db
*~
"

  writeLines(gitignore_content, file.path(project_path, ".gitignore"))
  cat("  Created: .gitignore\n")

  # Create a template script
  template_script <- "# ========================================================================
# Analysis Script Template
# ========================================================================
#
# Project: %s
# Author: [Your name]
# Date: %s
# Purpose: [Describe what this script does]
#
# ========================================================================

# Setup ----
library(tidyverse)
library(here)

# Load data ----
# Use here() for robust file paths
# data <- read_csv(here(\"data\", \"raw\", \"your_data.csv\"))

# Analysis ----
# Your analysis code here

# Visualization ----
# Create plots

# Save results ----
# ggsave(here(\"output\", \"figures\", \"plot.png\"))

# ========================================================================
# Session info for reproducibility
sessionInfo()
"

  writeLines(
    sprintf(template_script, project_name, Sys.Date()),
    file.path(project_path, "scripts", "01_template.R")
  )
  cat("  Created: scripts/01_template.R\n")

  cat("\n✓ Project structure created successfully!\n")
  cat("  Location:", project_path, "\n")
  cat("\nNext steps:\n")
  cat("  1. Open RStudio\n")
  cat("  2. File → New Project → Existing Directory\n")
  cat("  3. Select:", project_path, "\n")

  return(project_path)
}

# Example usage (commented out - uncomment to use):
# create_project_structure("my_analysis_project")

# ========================================================================
# USING RStudio PROJECTS
# ========================================================================

# Why use RStudio Projects?
#   ✓ Automatic working directory management
#   ✓ Separate R sessions for each project
#   ✓ Integration with version control (Git)
#   ✓ Project-specific settings

# How to create an RStudio Project:
#   1. File → New Project
#   2. Choose:
#      - New Directory (new project)
#      - Existing Directory (existing folder)
#      - Version Control (from Git repo)
#   3. Name your project
#   4. Create project

# Once created:
#   - Double-click .Rproj file to open project
#   - Files pane shows project directory
#   - Working directory is automatically set

# ========================================================================
# FILE PATH BEST PRACTICES
# ========================================================================

# ❌ BAD: Absolute paths (not reproducible)
# data <- read.csv("/Users/yourname/Documents/data.csv")

# ❌ BAD: setwd() (breaks on other computers)
# setwd("/Users/yourname/Documents/project")
# data <- read.csv("data.csv")

# ✓ GOOD: Relative paths with here()
library(here)
# data <- read.csv(here("data", "raw", "data.csv"))

# ✓ GOOD: file.path() for cross-platform compatibility
# data_path <- file.path("data", "raw", "data.csv")
# data <- read.csv(data_path)

# The here package automatically finds project root
here::here()  # Shows project root directory

# Build paths relative to project root
here::here("data", "raw", "example.csv")
here::here("output", "figures", "plot.png")

# ========================================================================
# SCRIPT ORGANIZATION PATTERNS
# ========================================================================

# Pattern 1: Numbered scripts (for sequential workflow)
# scripts/
# ├── 01_import_data.R
# ├── 02_clean_data.R
# ├── 03_exploratory_analysis.R
# ├── 04_statistical_models.R
# ├── 05_create_figures.R
# └── 06_generate_report.R

# Pattern 2: Functional organization
# scripts/
# ├── data_processing/
# │   ├── import.R
# │   └── clean.R
# ├── analysis/
# │   ├── descriptive.R
# │   └── models.R
# └── visualization/
#     └── plots.R

# Pattern 3: Source helper functions
# scripts/
# ├── functions/
# │   ├── data_utils.R
# │   ├── plotting_utils.R
# │   └── stats_utils.R
# └── main_analysis.R

# In main_analysis.R:
# source(here("scripts", "functions", "data_utils.R"))
# source(here("scripts", "functions", "plotting_utils.R"))

# ========================================================================
# SCRIPT STRUCTURE TEMPLATE
# ========================================================================

# Every script should have this basic structure:

template_structure <- function() {

  # ============================================================
  # HEADER: Document what this script does
  # ============================================================
  # Project: Analysis of X
  # Author: Your Name
  # Date: 2026-01-05
  # Purpose: Clean raw data and prepare for analysis
  # Input: data/raw/survey_data.csv
  # Output: data/processed/clean_data.rds
  # ============================================================

  # ============================================================
  # 1. SETUP & LOAD PACKAGES
  # ============================================================
  library(tidyverse)
  library(here)

  # Optional: Set options
  options(stringsAsFactors = FALSE)

  # ============================================================
  # 2. LOAD DATA
  # ============================================================
  # raw_data <- read_csv(here("data", "raw", "survey_data.csv"))

  # ============================================================
  # 3. DATA PROCESSING
  # ============================================================
  # clean_data <- raw_data %>%
  #   filter(!is.na(response)) %>%
  #   mutate(response = as.factor(response))

  # ============================================================
  # 4. SAVE PROCESSED DATA
  # ============================================================
  # saveRDS(clean_data, here("data", "processed", "clean_data.rds"))

  # ============================================================
  # 5. SESSION INFO (for reproducibility)
  # ============================================================
  sessionInfo()
}

# ========================================================================
# NAMING CONVENTIONS
# ========================================================================

# File names:
#   ✓ Use lowercase
#   ✓ Use underscores, not spaces
#   ✓ Be descriptive
#   ✓ Include dates for versions (optional)

# Examples:
# ✓ clean_survey_data.R
# ✓ 01_import_data.R
# ✓ helper_functions.R
# ✓ analysis_2026_01_05.R

# ❌ Avoid:
# ❌ Untitled.R
# ❌ script final FINAL v3.R
# ❌ data analysis.R (space!)

# Variable names:
#   ✓ Use snake_case (recommended in R)
#   ✓ Be descriptive

# Examples:
patient_age <- 45          # ✓
mean_reaction_time <- 0.5  # ✓
n_participants <- 100      # ✓

# Avoid:
# x <- 45                  # ❌ not descriptive
# PatientAge <- 45         # ❌ camelCase (use snake_case)
# patient.age <- 45        # ❌ dots are okay but underscores preferred

# ========================================================================
# DATA STORAGE BEST PRACTICES
# ========================================================================

# Raw data rules:
#   1. NEVER modify original data files
#   2. Keep raw data in data/raw/
#   3. Document data source in metadata/
#   4. Use version control for small data (<100MB)

# Processed data:
#   1. Save cleaned data in data/processed/
#   2. Use efficient formats:
#      - .rds for R objects (fast, compressed)
#      - .csv for sharing (human-readable)
#      - .parquet for very large data (efficient)

# Example workflow:
save_processed_data <- function() {
  # Load raw
  # raw <- read_csv(here("data", "raw", "measurements.csv"))

  # Process
  # clean <- raw %>%
  #   filter(!is.na(value)) %>%
  #   mutate(value = as.numeric(value))

  # Save processed
  # saveRDS(clean, here("data", "processed", "clean_measurements.rds"))

  # Also save as CSV for sharing
  # write_csv(clean, here("data", "processed", "clean_measurements.csv"))
}

# ========================================================================
# VERSION CONTROL WITH GIT
# ========================================================================

# Initialize Git in your project:
# 1. In terminal: cd ~/Projects/your_project
# 2. git init
# 3. git add .
# 4. git commit -m "Initial commit"

# Basic Git workflow:
# 1. Make changes to files
# 2. git add file.R                    # Stage changes
# 3. git commit -m "Add analysis"      # Commit with message
# 4. git push                          # Push to remote (GitHub)

# What to commit:
#   ✓ All scripts (.R, .Rmd)
#   ✓ README and documentation
#   ✓ Small data files (<100MB)
#   ✓ .gitignore file

# What NOT to commit:
#   ✗ Large data files (>100MB)
#   ✗ Sensitive data (passwords, personal info)
#   ✗ Output files (can be regenerated)
#   ✗ .Rproj.user, .Rhistory, .RData

# ========================================================================
# REPRODUCIBILITY CHECKLIST
# ========================================================================

reproducibility_checklist <- function() {
  checklist <- c(
    "[ ] Project uses RStudio Project (.Rproj file)",
    "[ ] Clear directory structure (data/, scripts/, output/)",
    "[ ] Raw data is separate from processed data",
    "[ ] Scripts use relative paths (here() package)",
    "[ ] Scripts are numbered or clearly organized",
    "[ ] Each script has header documentation",
    "[ ] README.md explains project structure",
    "[ ] .gitignore excludes large/sensitive files",
    "[ ] Package versions documented (renv or sessionInfo())",
    "[ ] Can run entire analysis from scratch"
  )

  cat("Reproducibility Checklist:\n\n")
  cat(paste(checklist, collapse = "\n"), "\n")
}

# Run the checklist:
reproducibility_checklist()

# ========================================================================
# ADVANCED: Using {renv} for Package Management
# ========================================================================

# The {renv} package creates project-specific package libraries
# This ensures your analysis uses the same package versions forever

# Setup renv in a project:
# install.packages("renv")
# renv::init()  # Creates renv/ directory and renv.lock file

# Workflow with renv:
# 1. Install packages as usual: install.packages("dplyr")
# 2. Snapshot packages: renv::snapshot()
# 3. Share project (renv.lock records versions)
# 4. Others restore packages: renv::restore()

# ========================================================================
# EXAMPLE: Complete Project Setup
# ========================================================================

setup_complete_project <- function(project_name) {
  cat("Setting up complete project:", project_name, "\n\n")

  # 1. Create directory structure
  cat("Step 1: Creating directories...\n")
  path <- create_project_structure(project_name)

  # 2. Instructions for next steps
  cat("\nStep 2: Initialize Git (optional)\n")
  cat("  Run in terminal:\n")
  cat("    cd", path, "\n")
  cat("    git init\n")
  cat("    git add .\n")
  cat("    git commit -m 'Initial project structure'\n\n")

  cat("Step 3: Create RStudio Project\n")
  cat("  In RStudio:\n")
  cat("    File → New Project → Existing Directory\n")
  cat("    Navigate to:", path, "\n\n")

  cat("Step 4: Initialize renv (optional)\n")
  cat("  In R:\n")
  cat("    renv::init()\n\n")

  cat("✓ Project setup complete!\n")
}

# Example usage:
# setup_complete_project("my_research_project")

# ========================================================================
# SUMMARY & KEY TAKEAWAYS
# ========================================================================

cat("\n")
cat("========================================\n")
cat("Key Takeaways: Project Structure\n")
cat("========================================\n")
cat("\n")
cat("1. Always use RStudio Projects (.Rproj)\n")
cat("2. Organize with standard directories (data/, scripts/, output/)\n")
cat("3. Never modify raw data - keep original files intact\n")
cat("4. Use relative paths with here() package\n")
cat("5. Number scripts for sequential workflows\n")
cat("6. Document everything (README, script headers)\n")
cat("7. Use version control (Git)\n")
cat("8. Make your work reproducible!\n")
cat("\n")
cat("Ready to start organizing your projects professionally!\n")
cat("\n")

# ========================================================================
# EXERCISES
# ========================================================================

# Exercise 1: Create a project structure for a hypothetical analysis
#   Task: Create a project called "iris_analysis"
#   Hint: Use create_project_structure("iris_analysis")

# Exercise 2: Write file paths using here()
#   Task: Write the path to data/processed/clean_data.rds using here()
#   Answer: here("data", "processed", "clean_data.rds")

# Exercise 3: Create a properly structured script
#   Task: Create a script with header, sections, and sessionInfo()
#   Hint: Use the template_structure() as a guide

# Solutions are in 00_setup/exercises/solutions.R

# ========================================================================
# NEXT STEPS
# ========================================================================

cat("\n")
cat("Next: Move to Module 01 - R Fundamentals\n")
cat("  Learn the core R concepts you'll use in every project!\n")
cat("\n")
