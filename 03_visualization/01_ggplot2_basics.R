# ========================================================================
# Module 03: Data Visualization - ggplot2 Basics
# ========================================================================
#
# Learning Objectives:
#   - Understand the Grammar of Graphics
#   - Master basic plot types (scatter, bar, line, box, violin)
#   - Customize aesthetics (color, size, shape)
#   - Add layers and facets
#
# Estimated time: 3-4 hours
# Difficulty: Intermediate
#
# ========================================================================

library(tidyverse)
library(viridis)  # Color scales

# ========================================================================
# 1. GRAMMAR OF GRAPHICS: The ggplot2 Philosophy
# ========================================================================

# Every ggplot has 3 essential components:
#   1. Data
#   2. Aesthetic mappings (aes)
#   3. Geometric objects (geoms)

# Basic template:
# ggplot(data = <DATA>, aes(x = <X>, y = <Y>)) +
#   geom_<TYPE>()

# ========================================================================
# 2. SCATTER PLOTS
# ========================================================================

# Example data
gene_expr <- data.frame(
  gene_id = paste0("GENE_", 1:100),
  log2_fold_change = rnorm(100, 0, 2),
  p_value = runif(100, 0, 0.1),
  condition = sample(c("TypeA", "TypeB"), 100, replace = TRUE)
)

# Basic scatter plot
ggplot(gene_expr, aes(x = log2_fold_change, y = -log10(p_value))) +
  geom_point()

# Add color by condition
ggplot(gene_expr, aes(x = log2_fold_change, y = -log10(p_value), color = condition)) +
  geom_point(size = 3, alpha = 0.7)

# Volcano plot (publication-quality)
volcano_plot <- ggplot(gene_expr, aes(x = log2_fold_change, y = -log10(p_value))) +
  geom_point(aes(color = p_value < 0.05 & abs(log2_fold_change) > 1),
             size = 2, alpha = 0.6) +
  scale_color_manual(values = c("grey50", "red"),
                     labels = c("Not significant", "Significant"),
                     name = "Regulation") +
  geom_hline(yintercept = -log10(0.05), linetype = "dashed", color = "blue") +
  geom_vline(xintercept = c(-1, 1), linetype = "dashed", color = "blue") +
  labs(
    title = "Volcano Plot: Gene Expression",
    x = "Log2 Fold Change",
    y = "-Log10 P-value"
  ) +
  theme_minimal()

print(volcano_plot)

# ========================================================================
# 3. BAR PLOTS
# ========================================================================

# Count data
cell_counts <- data.frame(
  cell_type = c("Neuron", "Astrocyte", "Microglia", "Oligodendrocyte"),
  count = c(450, 320, 180, 250),
  condition = rep(c("Control", "Disease"), each = 2)
)

# Basic bar plot
ggplot(cell_counts, aes(x = cell_type, y = count)) +
  geom_col(fill = "steelblue")

# Grouped bar plot
ggplot(cell_counts, aes(x = cell_type, y = count, fill = condition)) +
  geom_col(position = "dodge") +
  scale_fill_viridis(discrete = TRUE) +
  theme_minimal() +
  labs(title = "Cell Type Distribution", y = "Count")

# ========================================================================
# 4. BOX PLOTS & VIOLIN PLOTS
# ========================================================================

# Generate sample data
expression_data <- data.frame(
  gene = rep(c("BRCA1", "TP53", "MYC", "EGFR"), each = 30),
  expression = c(
    rnorm(30, 5, 1),
    rnorm(30, 8, 1.5),
    rnorm(30, 3, 0.8),
    rnorm(30, 6, 1.2)
  ),
  condition = rep(c("Control", "Treated"), 60)
)

# Box plot
ggplot(expression_data, aes(x = gene, y = expression, fill = condition)) +
  geom_boxplot() +
  theme_minimal()

# Violin plot (shows distribution better)
ggplot(expression_data, aes(x = gene, y = expression, fill = condition)) +
  geom_violin(alpha = 0.7) +
  geom_boxplot(width = 0.2, fill = "white", alpha = 0.5) +
  scale_fill_viridis(discrete = TRUE) +
  theme_minimal() +
  labs(title = "Gene Expression Distribution", y = "Expression Level")

# ========================================================================
# 5. LINE PLOTS
# ========================================================================

# Time course data
time_course <- data.frame(
  time = rep(0:10, 3),
  expression = c(
    exp(-0:10 / 3) * 10,  # Gene A
    (0:10) * 0.5,         # Gene B
    sin(0:10 / 2) * 5 + 5 # Gene C
  ),
  gene = rep(c("Gene_A", "Gene_B", "Gene_C"), each = 11)
)

ggplot(time_course, aes(x = time, y = expression, color = gene)) +
  geom_line(size = 1.2) +
  geom_point(size = 2) +
  scale_color_viridis(discrete = TRUE) +
  labs(
    title = "Gene Expression Time Course",
    x = "Time (hours)",
    y = "Expression Level"
  ) +
  theme_minimal()

# ========================================================================
# 6. FACETING: Small Multiples
# ========================================================================

# Facet wrap (one variable)
ggplot(expression_data, aes(x = gene, y = expression, fill = gene)) +
  geom_violin(show.legend = FALSE) +
  facet_wrap(~condition) +
  theme_minimal()

# Facet grid (two variables)
ggplot(expression_data, aes(x = condition, y = expression, fill = condition)) +
  geom_boxplot(show.legend = FALSE) +
  facet_grid(~gene) +
  theme_minimal()

# ========================================================================
# 7. CUSTOMIZATION EXAMPLE (Inspired by your advanced plots)
# ========================================================================

# Create a publication-quality plot
publication_plot <- expression_data %>%
  group_by(gene, condition) %>%
  summarize(
    mean = mean(expression),
    se = sd(expression) / sqrt(n()),
    .groups = "drop"
  ) %>%
  ggplot(aes(x = gene, y = mean, fill = condition)) +
  geom_col(position = position_dodge(0.9), width = 0.8) +
  geom_errorbar(
    aes(ymin = mean - se, ymax = mean + se),
    position = position_dodge(0.9),
    width = 0.25
  ) +
  scale_fill_manual(
    values = c("Control" = "#4575b4", "Treated" = "#d73027"),
    name = "Condition"
  ) +
  labs(
    title = "Mean Gene Expression by Condition",
    subtitle = "Error bars represent standard error",
    x = "Gene",
    y = "Expression Level (normalized)"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5, color = "gray40"),
    panel.grid.major.x = element_blank(),
    legend.position = "top"
  )

print(publication_plot)

# Save plot
# ggsave("output/publication_plot.png", publication_plot,
#        width = 8, height = 6, dpi = 300)

# ========================================================================
# EXERCISES
# ========================================================================

# Exercise 1: Create a scatter plot showing the relationship between
#             gene expression and fold change, colored by significance
# Your answer:

# Exercise 2: Create a grouped bar plot showing cell counts by type and condition
# Your answer:

# Exercise 3: Create faceted violin plots for multiple genes
# Your answer:

# ========================================================================
# KEY TAKEAWAYS
# ========================================================================

cat("\n")
cat("========================================\n")
cat("Key Takeaways: ggplot2 Basics\n")
cat("========================================\n")
cat("\n")
cat("1. ggplot2 uses Grammar of Graphics (layers)\n")
cat("2. Map data to aesthetics with aes()\n")
cat("3. Choose appropriate geom for your data\n")
cat("4. Use faceting for small multiples\n")
cat("5. Customize with themes and scales\n")
cat("6. Save publication-quality figures\n")
cat("\n")

# Next: 02_customization.R
