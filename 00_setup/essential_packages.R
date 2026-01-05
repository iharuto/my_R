# ========================================================================
# Essential Packages Installation Script
# ========================================================================
#
# Purpose: Install all packages required for the R Programming Course
# Author: Advanced R Course
# Last updated: 2026-01-05
# Estimated time: 10-30 minutes (depends on internet speed)
#
# ========================================================================

# Print welcome message
cat("\n")
cat("========================================\n")
cat("📦 Installing Essential R Packages\n")
cat("========================================\n")
cat("\n")
cat("This script will install packages for:\n")
cat("  ✓ Data manipulation (tidyverse)\n")
cat("  ✓ Visualization (ggplot2, patchwork)\n")
cat("  ✓ Statistics (lme4, glmmTMB)\n")
cat("  ✓ Bioinformatics (Bioconductor packages)\n")
cat("  ✓ Web scraping (rvest, httr)\n")
cat("  ✓ Utilities (here, janitor, progress)\n")
cat("\n")
cat("Estimated time: 10-30 minutes\n")
cat("\n")

# Ask for confirmation
readline(prompt = "Press [Enter] to continue or [Ctrl+C] to cancel: ")

# ========================================================================
# Helper Functions
# ========================================================================

# Function to install packages with progress tracking
install_packages_safe <- function(packages, repo = "CRAN") {
  cat(sprintf("\n📦 Installing %s packages...\n", repo))

  total <- length(packages)
  success <- 0
  failed <- c()

  for (i in seq_along(packages)) {
    pkg <- packages[i]
    cat(sprintf("[%d/%d] Installing %s...", i, total, pkg))

    tryCatch({
      if (!require(pkg, character.only = TRUE, quietly = TRUE)) {
        install.packages(pkg, dependencies = TRUE, quiet = TRUE)
        cat(" ✓\n")
        success <- success + 1
      } else {
        cat(" (already installed) ✓\n")
        success <- success + 1
      }
    }, error = function(e) {
      cat(" ✗\n")
      failed <- c(failed, pkg)
    })
  }

  cat(sprintf("\nSummary: %d/%d packages installed successfully\n", success, total))
  if (length(failed) > 0) {
    cat("⚠️  Failed packages:", paste(failed, collapse = ", "), "\n")
  }

  return(list(success = success, failed = failed))
}

# ========================================================================
# 1. CRAN Packages - Core Data Science
# ========================================================================

cat("\n")
cat("========================================\n")
cat("Part 1: Core Data Science Packages\n")
cat("========================================\n")

core_packages <- c(
  "tidyverse",      # Meta-package: dplyr, ggplot2, tidyr, readr, purrr, etc.
  "dplyr",          # Data manipulation
  "tidyr",          # Data tidying
  "readr",          # Fast data reading
  "purrr",          # Functional programming
  "stringr",        # String manipulation
  "forcats",        # Factor handling
  "tibble"          # Modern data frames
)

result_core <- install_packages_safe(core_packages, "Core")

# ========================================================================
# 2. CRAN Packages - Visualization
# ========================================================================

cat("\n")
cat("========================================\n")
cat("Part 2: Visualization Packages\n")
cat("========================================\n")

viz_packages <- c(
  "ggplot2",        # Grammar of graphics
  "patchwork",      # Combine multiple plots
  "viridis",        # Color scales
  "ggforce",        # Extended ggplot2 functionality
  "scales",         # Scale functions for visualization
  "RColorBrewer",   # Color palettes
  "cowplot",        # Publication-ready plots
  "ggrepel"         # Non-overlapping text labels
)

result_viz <- install_packages_safe(viz_packages, "Visualization")

# ========================================================================
# 3. CRAN Packages - Statistics & Modeling
# ========================================================================

cat("\n")
cat("========================================\n")
cat("Part 3: Statistics & Modeling\n")
cat("========================================\n")

stats_packages <- c(
  "lme4",           # Linear mixed-effects models
  "glmmTMB",        # Generalized linear mixed models
  "broom",          # Tidy model outputs
  "broom.mixed",    # Tidy mixed model outputs
  "emmeans",        # Estimated marginal means
  "car",            # Companion to Applied Regression
  "performance",    # Model quality assessment
  "DHARMa"          # Residual diagnostics for GLMMs
)

result_stats <- install_packages_safe(stats_packages, "Statistics")

# ========================================================================
# 4. CRAN Packages - Data Import/Export
# ========================================================================

cat("\n")
cat("========================================\n")
cat("Part 4: Data Import/Export\n")
cat("========================================\n")

io_packages <- c(
  "readxl",         # Read Excel files
  "writexl",        # Write Excel files
  "openxlsx",       # Advanced Excel operations
  "haven",          # SPSS, Stata, SAS files
  "jsonlite",       # JSON files
  "data.table"      # Fast data manipulation
)

result_io <- install_packages_safe(io_packages, "I/O")

# ========================================================================
# 5. CRAN Packages - Web & APIs
# ========================================================================

cat("\n")
cat("========================================\n")
cat("Part 5: Web Scraping & APIs\n")
cat("========================================\n")

web_packages <- c(
  "httr",           # HTTP requests
  "rvest",          # Web scraping
  "xml2",           # XML parsing
  "jsonlite",       # JSON parsing (if not already installed)
  "curl"            # Modern HTTP client
)

result_web <- install_packages_safe(web_packages, "Web")

# ========================================================================
# 6. CRAN Packages - Parallel Computing
# ========================================================================

cat("\n")
cat("========================================\n")
cat("Part 6: Parallel Computing\n")
cat("========================================\n")

parallel_packages <- c(
  "foreach",        # Parallel loops
  "doParallel",     # Parallel backend
  "future",         # Future promises
  "furrr",          # Parallel purrr
  "parallel"        # Base R parallel (usually included)
)

result_parallel <- install_packages_safe(parallel_packages, "Parallel")

# ========================================================================
# 7. CRAN Packages - Utilities
# ========================================================================

cat("\n")
cat("========================================\n")
cat("Part 7: Utility Packages\n")
cat("========================================\n")

util_packages <- c(
  "here",           # Project-relative paths
  "janitor",        # Data cleaning
  "skimr",          # Data summary
  "progress",       # Progress bars
  "tictoc",         # Timing code
  "devtools",       # Package development tools
  "roxygen2",       # Documentation generation
  "usethis"         # Workflow automation
)

result_util <- install_packages_safe(util_packages, "Utilities")

# ========================================================================
# 8. Bioconductor Packages
# ========================================================================

cat("\n")
cat("========================================\n")
cat("Part 8: Bioconductor Packages\n")
cat("========================================\n")

cat("Installing BiocManager...\n")
if (!require("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}

cat("📦 Installing Bioconductor packages...\n")

bioc_packages <- c(
  "Biobase",        # Base classes for Bioconductor
  "GEOquery",       # Query GEO database
  "limma",          # Linear models for microarray/RNA-seq
  "edgeR",          # Differential expression for RNA-seq
  "DESeq2"          # Differential expression analysis
)

bioc_success <- 0
bioc_failed <- c()

for (i in seq_along(bioc_packages)) {
  pkg <- bioc_packages[i]
  cat(sprintf("[%d/%d] Installing %s...", i, length(bioc_packages), pkg))

  tryCatch({
    if (!require(pkg, character.only = TRUE, quietly = TRUE)) {
      BiocManager::install(pkg, update = FALSE, ask = FALSE)
      cat(" ✓\n")
      bioc_success <- bioc_success + 1
    } else {
      cat(" (already installed) ✓\n")
      bioc_success <- bioc_success + 1
    }
  }, error = function(e) {
    cat(" ✗\n")
    bioc_failed <- c(bioc_failed, pkg)
  })
}

cat(sprintf("\nSummary: %d/%d Bioconductor packages installed\n",
            bioc_success, length(bioc_packages)))

# ========================================================================
# 9. Optional Specialized Packages
# ========================================================================

cat("\n")
cat("========================================\n")
cat("Part 9: Optional Specialized Packages\n")
cat("========================================\n")

cat("\nThese packages are optional but useful for specific tasks.\n")
response <- readline(prompt = "Install optional packages? (y/n): ")

if (tolower(response) == "y") {
  optional_packages <- c(
    "Seurat",         # Single-cell RNA-seq (large package!)
    "tidygraph",      # Tidy graph data structures
    "ggraph",         # Graph visualization
    "igraph",         # Network analysis
    "survminer",      # Survival analysis visualization
    "survival",       # Survival analysis
    "rmarkdown",      # R Markdown documents
    "knitr",          # Dynamic report generation
    "DT",             # Interactive tables
    "plotly",         # Interactive plots
    "shiny"           # Web applications
  )

  result_optional <- install_packages_safe(optional_packages, "Optional")
} else {
  cat("Skipping optional packages.\n")
}

# ========================================================================
# Installation Summary
# ========================================================================

cat("\n\n")
cat("========================================\n")
cat("📊 Installation Summary\n")
cat("========================================\n")
cat("\n")

total_success <- (
  result_core$success +
  result_viz$success +
  result_stats$success +
  result_io$success +
  result_web$success +
  result_parallel$success +
  result_util$success +
  bioc_success
)

total_packages <- (
  length(core_packages) +
  length(viz_packages) +
  length(stats_packages) +
  length(io_packages) +
  length(web_packages) +
  length(parallel_packages) +
  length(util_packages) +
  length(bioc_packages)
)

cat(sprintf("✓ Successfully installed: %d/%d packages\n", total_success, total_packages))

all_failed <- c(
  result_core$failed,
  result_viz$failed,
  result_stats$failed,
  result_io$failed,
  result_web$failed,
  result_parallel$failed,
  result_util$failed,
  bioc_failed
)

if (length(all_failed) > 0) {
  cat("\n⚠️  Failed packages:\n")
  cat(paste("  -", all_failed, collapse = "\n"), "\n")
  cat("\nTo manually install failed packages:\n")
  cat("install.packages(c(\"", paste(all_failed, collapse = "\", \""), "\"))\n", sep = "")
}

# ========================================================================
# Verification
# ========================================================================

cat("\n")
cat("========================================\n")
cat("🧪 Verifying Key Packages\n")
cat("========================================\n")
cat("\n")

verify_packages <- c(
  "tidyverse",
  "ggplot2",
  "dplyr",
  "glmmTMB",
  "httr",
  "BiocManager"
)

cat("Testing if key packages can be loaded...\n\n")

for (pkg in verify_packages) {
  cat(sprintf("  Testing %s...", pkg))
  if (require(pkg, character.only = TRUE, quietly = TRUE)) {
    cat(" ✓\n")
  } else {
    cat(" ✗ (not installed)\n")
  }
}

# ========================================================================
# Final Instructions
# ========================================================================

cat("\n\n")
cat("========================================\n")
cat("🎉 Installation Complete!\n")
cat("========================================\n")
cat("\n")
cat("Next steps:\n")
cat("  1. Read 'project_structure.R' to learn best practices\n")
cat("  2. Test your installation with a simple plot:\n")
cat("     library(ggplot2)\n")
cat("     ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point()\n")
cat("  3. Proceed to Module 01: R Fundamentals\n")
cat("\n")
cat("📚 All packages are now ready for the course!\n")
cat("\n")

# ========================================================================
# Session Info for Troubleshooting
# ========================================================================

cat("\n")
cat("========================================\n")
cat("📋 Session Information\n")
cat("========================================\n")
cat("\n")

print(sessionInfo())

cat("\n")
cat("💾 Save this session info for troubleshooting.\n")
cat("\n")

# Optional: Save session info to file
session_file <- "00_setup/session_info.txt"
sink(session_file)
print(sessionInfo())
sink()
cat(sprintf("Session info saved to: %s\n", session_file))

# Clean up
rm(list = ls())
gc()

cat("\n🎓 Ready to start learning R!\n\n")
