# ========================================================================
# Module 04: Statistical Analysis - Mixed-Effects Models (GLMM)
# ========================================================================
#
# Learning Objectives:
#   - Understand when to use mixed-effects models
#   - Implement linear mixed models (LMM) with lme4
#   - Implement generalized linear mixed models (GLMM) with glmmTMB
#   - Interpret random and fixed effects
#   - Apply to real research scenarios (inspired by Brain_Blast project)
#
# Estimated time: 4-5 hours
# Difficulty: Advanced
#
# ========================================================================

library(tidyverse)
library(lme4)        # Linear mixed models
library(glmmTMB)     # Generalized linear mixed models
library(broom.mixed) # Tidy model outputs
library(performance) # Model diagnostics

# ========================================================================
# 1. WHY MIXED-EFFECTS MODELS?
# ========================================================================

# Mixed models are essential when you have:
#   - Repeated measurements (same subject measured multiple times)
#   - Hierarchical/nested data (cells within samples within patients)
#   - Grouping structures (multiple observations per group)
#   - Need to account for random variation between groups

# Example scenarios:
#   - Gene expression across multiple patients (patient is random effect)
#   - Cell counts from multiple tissue samples
#   - Longitudinal studies with repeated measures
#   - Multi-site studies with site-specific variation

# ========================================================================
# 2. SIMULATE REALISTIC DATA
# ========================================================================

# Scenario: Single-cell RNA-seq pseudobulk analysis
# Similar to the Brain_Blast GLMM analysis pattern

set.seed(123)
n_genes <- 50
n_samples <- 60

# Create sample metadata
metadata <- expand_grid(
  patient_id = paste0("P", 1:10),
  condition = c("Control", "Disease")
) %>%
  mutate(
    age = rnorm(n(), mean = 50, sd = 10),
    age_scaled = scale(age)[, 1],
    batch = rep(c("Batch1", "Batch2"), length.out = n())
  )

# Simulate gene expression (log-normalized counts)
simulate_gene_expression <- function(gene_id, metadata) {
  # Patient-specific random effects
  patient_effects <- rnorm(n_distinct(metadata$patient_id), 0, 0.5)
  names(patient_effects) <- unique(metadata$patient_id)

  # Fixed effects: condition + age
  metadata %>%
    mutate(
      expression =
        5 +  # Baseline
        ifelse(condition == "Disease", 0.8, 0) +  # Disease effect
        age_scaled * 0.3 +  # Age effect
        patient_effects[patient_id] +  # Patient random effect
        rnorm(n(), 0, 0.5),  # Residual noise
      gene_id = gene_id
    )
}

# Generate data for multiple genes
expr_data <- map_dfr(
  paste0("GENE_", 1:n_genes),
  ~simulate_gene_expression(.x, metadata)
)

# ========================================================================
# 3. LINEAR MIXED MODEL (LMM) - Continuous Outcome
# ========================================================================

# Research question: Does disease condition affect gene expression,
#                    accounting for patient-specific variation?

# Fit LMM for a single gene
gene1_data <- expr_data %>% filter(gene_id == "GENE_1")

# Model: expression ~ condition + age + (1|patient_id)
# Fixed effects: condition, age
# Random effect: patient_id (random intercept)

lmm_model <- lmer(
  expression ~ condition + age_scaled + (1 | patient_id),
  data = gene1_data
)

# View results
summary(lmm_model)

# Tidy output
tidy(lmm_model, effects = "fixed")

# Extract confidence intervals
confint(lmm_model, method = "Wald")

# ========================================================================
# 4. GENERALIZED LINEAR MIXED MODEL (GLMM)
# ========================================================================

# For count data or non-normal distributions, use GLMM

# Simulate count data (similar to cell counts)
count_data <- metadata %>%
  mutate(
    # Negative binomial counts
    cell_count = rnbinom(
      n(),
      mu = exp(3 + ifelse(condition == "Disease", 0.5, 0) + rnorm(n(), 0, 0.3)),
      size = 10
    )
  )

# Fit negative binomial GLMM (common for RNA-seq)
glmm_model <- glmmTMB(
  cell_count ~ condition + age_scaled + (1 | patient_id),
  data = count_data,
  family = nbinom2  # Negative binomial
)

summary(glmm_model)

# Extract coefficients
tidy(glmm_model)

# ========================================================================
# 5. ADVANCED: BATCH ANALYSIS OF MULTIPLE GENES
# ========================================================================

# This pattern is from the Brain_Blast project!
# Analyze all genes in parallel

perform_glmm_analysis <- function(data, gene) {
  # Subset data for this gene
  gene_data <- data %>% filter(gene_id == gene)

  # Fit model
  tryCatch({
    model <- lmer(
      expression ~ condition + age_scaled + (1 | patient_id),
      data = gene_data,
      REML = FALSE  # Use ML for model comparison
    )

    # Extract results
    results <- tidy(model, effects = "fixed") %>%
      mutate(gene_id = gene)

    return(results)
  }, error = function(e) {
    # Return NA if model fails
    return(NULL)
  })
}

# Analyze all genes
all_results <- map_dfr(
  unique(expr_data$gene_id),
  ~perform_glmm_analysis(expr_data, .x)
)

# Identify significant genes
significant_genes <- all_results %>%
  filter(term == "conditionDisease") %>%
  mutate(
    p_adj = p.adjust(p.value, method = "fdr")
  ) %>%
  filter(p_adj < 0.05) %>%
  arrange(p_adj)

cat(sprintf("Found %d significant genes (FDR < 0.05)\n", nrow(significant_genes)))
head(significant_genes)

# ========================================================================
# 6. PARALLEL PROCESSING FOR SPEED
# ========================================================================

# For large-scale analysis (like Brain_Blast project)
library(foreach)
library(doParallel)

# Setup parallel backend
n_cores <- 4  # Adjust based on your system
cl <- makeCluster(n_cores)
registerDoParallel(cl)

# Run in parallel
parallel_results <- foreach(
  gene = unique(expr_data$gene_id),
  .combine = rbind,
  .packages = c("lme4", "dplyr", "broom.mixed")
) %dopar% {
  perform_glmm_analysis(expr_data, gene)
}

# Stop cluster
stopCluster(cl)

# ========================================================================
# 7. MODEL DIAGNOSTICS
# ========================================================================

# Check model assumptions

# 7.1 Residual plots
plot(lmm_model)

# 7.2 Q-Q plot (normality of residuals)
qqnorm(resid(lmm_model))
qqline(resid(lmm_model))

# 7.3 Random effects
ranef(lmm_model)

# 7.4 Model performance
check_model(lmm_model)

# ========================================================================
# 8. PUBLICATION-READY RESULTS TABLE
# ========================================================================

create_results_table <- function(model_results) {
  model_results %>%
    filter(term == "conditionDisease") %>%
    mutate(
      p_adj = p.adjust(p.value, method = "fdr"),
      significant = p_adj < 0.05,
      regulation = ifelse(estimate > 0, "Up", "Down")
    ) %>%
    arrange(p_adj) %>%
    select(gene_id, estimate, std.error, p.value, p_adj, regulation)
}

results_table <- create_results_table(all_results)
head(results_table, 10)

# Save results
# write_csv(results_table, "output/glmm_results.csv")

# ========================================================================
# 9. VISUALIZATION OF RESULTS
# ========================================================================

# Volcano plot of GLMM results
volcano_data <- all_results %>%
  filter(term == "conditionDisease") %>%
  mutate(
    p_adj = p.adjust(p.value, method = "fdr"),
    significant = p_adj < 0.05 & abs(estimate) > 0.5
  )

ggplot(volcano_data, aes(x = estimate, y = -log10(p.value))) +
  geom_point(aes(color = significant), alpha = 0.6, size = 2) +
  scale_color_manual(values = c("grey50", "red")) +
  geom_hline(yintercept = -log10(0.05), linetype = "dashed") +
  geom_vline(xintercept = c(-0.5, 0.5), linetype = "dashed") +
  labs(
    title = "GLMM Results: Disease vs Control",
    x = "Coefficient Estimate",
    y = "-Log10 P-value"
  ) +
  theme_minimal()

# ========================================================================
# REAL-WORLD EXAMPLE: Multi-level Hierarchical Model
# ========================================================================

# Scenario: Cells nested within samples nested within patients
# (Very common in single-cell analysis)

hierarchical_data <- expand_grid(
  patient_id = paste0("P", 1:5),
  sample_id = paste0("S", 1:2),
  cell_type = c("TypeA", "TypeB")
) %>%
  mutate(
    sample_full_id = paste(patient_id, sample_id, sep = "_"),
    expression = rnorm(n(), mean = 5, sd = 1)
  )

# Nested random effects
nested_model <- lmer(
  expression ~ cell_type + (1 | patient_id/sample_full_id),
  data = hierarchical_data
)

summary(nested_model)

# ========================================================================
# KEY TAKEAWAYS
# ========================================================================

cat("\n")
cat("========================================\n")
cat("Key Takeaways: Mixed Models\n")
cat("========================================\n")
cat("\n")
cat("1. Use mixed models for grouped/hierarchical data\n")
cat("2. Random effects capture group-specific variation\n")
cat("3. Fixed effects are your main predictors of interest\n")
cat("4. Use glmmTMB for non-normal data (counts, binary)\n")
cat("5. Parallelize for analyzing many genes/features\n")
cat("6. Always check model diagnostics\n")
cat("7. Adjust p-values for multiple testing (FDR)\n")
cat("\n")
cat("This approach is used in real research projects like\n")
cat("the Brain_Blast single-cell analysis!\n")
cat("\n")

# ========================================================================
# EXERCISES
# ========================================================================

# Exercise 1: Fit a mixed model with age as random slope (not just intercept)
# Hint: (1 + age_scaled | patient_id)
# Your answer:

# Exercise 2: Compare models with and without the age predictor using AIC
# Your answer:

# Exercise 3: Extract and plot random effects for each patient
# Your answer:

# Solutions: 04_statistical_analysis/case_studies/mixed_models_solutions.R
