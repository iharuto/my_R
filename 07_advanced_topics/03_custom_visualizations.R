# ========================================================================
# Module 07: Advanced Topics - Custom Visualization Systems
# ========================================================================
#
# Learning Objectives:
#   - Build custom ggplot2 functions
#   - Create complex multi-panel figures
#   - Design Sankey diagrams and flow visualizations
#   - Develop reusable visualization systems
#
# Estimated time: 4-5 hours
# Difficulty: Advanced
#
# NOTE: This module showcases techniques from the Plot_catalogue
#       and Brain_Blast visualization functions
#
# ========================================================================

library(tidyverse)
library(patchwork)  # Combine plots
library(viridis)
library(ggforce)    # Extended ggplot2

# ========================================================================
# 1. CREATING CUSTOM PLOT FUNCTIONS
# ========================================================================

# Why create custom functions?
#   - Ensure consistency across publications
#   - Save time on repetitive plots
#   - Make complex plots reusable
#   - Easy to update style across all figures

# Basic template for custom plot function
create_volcano_plot <- function(data,
                                 x_col,
                                 y_col,
                                 label_col = NULL,
                                 title = "Volcano Plot",
                                 fc_threshold = 1,
                                 p_threshold = 0.05) {

  # Calculate significance
  plot_data <- data %>%
    mutate(
      significant = abs(.data[[x_col]]) > fc_threshold &
                    .data[[y_col]] < p_threshold,
      neg_log_p = -log10(.data[[y_col]])
    )

  # Create base plot
  p <- ggplot(plot_data, aes(x = .data[[x_col]], y = neg_log_p)) +
    geom_point(aes(color = significant), size = 2, alpha = 0.6) +
    scale_color_manual(
      values = c("grey50", "#d73027"),
      labels = c("NS", "Significant")
    ) +
    geom_hline(yintercept = -log10(p_threshold),
               linetype = "dashed", color = "blue") +
    geom_vline(xintercept = c(-fc_threshold, fc_threshold),
               linetype = "dashed", color = "blue") +
    labs(
      title = title,
      x = "Log2 Fold Change",
      y = "-Log10 P-value"
    ) +
    theme_minimal(base_size = 12) +
    theme(
      plot.title = element_text(hjust = 0.5, face = "bold"),
      legend.position = "top"
    )

  # Add labels if specified
  if (!is.null(label_col)) {
    top_genes <- plot_data %>%
      filter(significant) %>%
      arrange(desc(abs(.data[[x_col]]))) %>%
      head(10)

    p <- p +
      ggrepel::geom_text_repel(
        data = top_genes,
        aes(label = .data[[label_col]]),
        size = 3,
        max.overlaps = 15
      )
  }

  return(p)
}

# Example usage:
# demo_data <- data.frame(
#   gene = paste0("GENE_", 1:100),
#   log2fc = rnorm(100, 0, 2),
#   pvalue = runif(100, 0, 0.1)
# )
# create_volcano_plot(demo_data, "log2fc", "pvalue", "gene")

# ========================================================================
# 2. SANKEY DIAGRAM (ADVANCED FLOW VISUALIZATION)
# ========================================================================

# This is adapted from your SankeyArrow function!
# Used for showing data flow/filtering processes

SankeyArrow <- function(values, labels, gap = 0.05, size = 4) {

  # Validate inputs
  if (length(values) != length(labels)) {
    stop("Values and labels must have same length")
  }

  # Create label text with counts
  label_text <- paste0(labels, " \n(", values, ")")

  # Calculate proportions
  input <- values[1]
  outputs <- values[-1]

  # Normalize if needed
  if (sum(outputs) != input) {
    outputs <- outputs * (input / sum(outputs))
    values <- c(input, outputs)
  }

  # Calculate positions
  proportions <- outputs / input
  cumsum_props <- c(0, cumsum(proportions))

  # Build plot layer by layer
  p <- ggplot() +
    # Input funnel
    geom_segment(aes(x = -0.4, y = 0, xend = -0.32, yend = 0.5)) +
    geom_segment(aes(x = -0.4, y = 1, xend = -0.32, yend = 0.5)) +
    # Reference line
    geom_segment(aes(x = -0.2, y = 1, xend = -0.2, yend = 0),
                 linetype = "dashed", color = "grey50")

  # Add output streams
  x_positions <- seq(0, 1.5, length.out = length(outputs) + 1)

  for (i in seq_along(outputs)) {
    # Calculate stream endpoints
    y_bottom <- cumsum_props[i]
    y_top <- cumsum_props[i + 1]
    y_mid <- (y_bottom + y_top) / 2

    x_start <- x_positions[i]
    x_end <- x_positions[i + 1]

    # Draw stream (simplified version)
    stream_data <- data.frame(
      x = c(x_start, x_end),
      y_bottom = c(y_bottom, y_bottom),
      y_top = c(y_top, y_top)
    )

    p <- p +
      geom_ribbon(data = stream_data,
                  aes(x = x, ymin = y_bottom, ymax = y_top),
                  fill = viridis(length(outputs))[i],
                  alpha = 0.6)
  }

  # Add labels
  label_positions <- data.frame(
    x = c(-0.32 - gap, x_positions[-1] + gap),
    y = c(0.5, (cumsum_props[-1] + cumsum_props[-length(cumsum_props)]) / 2),
    label = label_text
  )

  p <- p +
    geom_text(data = label_positions,
              aes(x = x, y = y, label = label),
              size = size, hjust = 0) +
    coord_fixed(ratio = 1) +
    theme_void() +
    scale_x_continuous(limits = c(-1, max(x_positions) + 0.8)) +
    scale_y_continuous(limits = c(-0.1, 1.1))

  return(p)
}

# Example: Show data filtering process
# values <- c(1000, 300, 250, 200, 150)
# labels <- c("Raw Data", "QC Pass", "Filtered", "Analyzed", "Significant")
# SankeyArrow(values, labels)

# ========================================================================
# 3. MULTI-PANEL FIGURES WITH PATCHWORK
# ========================================================================

# Create publication-quality multi-panel figures

# Example data
demo_data <- data.frame(
  x = rnorm(100),
  y = rnorm(100),
  group = rep(c("A", "B"), each = 50)
)

# Create individual panels
p1 <- ggplot(demo_data, aes(x = x, y = y, color = group)) +
  geom_point() +
  labs(title = "A) Scatter Plot") +
  theme_minimal()

p2 <- ggplot(demo_data, aes(x = group, y = x, fill = group)) +
  geom_boxplot() +
  labs(title = "B) Distribution") +
  theme_minimal()

p3 <- ggplot(demo_data, aes(x = x)) +
  geom_histogram(bins = 30, fill = "steelblue") +
  labs(title = "C) Histogram") +
  theme_minimal()

p4 <- ggplot(demo_data, aes(x = x, y = y)) +
  geom_density_2d_filled() +
  labs(title = "D) Density") +
  theme_minimal()

# Combine with patchwork
combined_figure <- (p1 | p2) / (p3 | p4) +
  plot_annotation(
    title = "Multi-panel Figure",
    tag_levels = "A"
  )

print(combined_figure)

# Save high-resolution figure
# ggsave("figure.png", combined_figure, width = 12, height = 10, dpi = 300)

# ========================================================================
# 4. THEME CUSTOMIZATION
# ========================================================================

# Create custom theme for consistency

theme_publication <- function(base_size = 11, base_family = "") {
  theme_minimal(base_size = base_size, base_family = base_family) +
    theme(
      # Text
      plot.title = element_text(face = "bold", size = rel(1.2), hjust = 0.5),
      plot.subtitle = element_text(size = rel(1), hjust = 0.5),

      # Axes
      axis.title = element_text(face = "bold", size = rel(1)),
      axis.text = element_text(size = rel(0.9)),
      axis.line = element_line(color = "black", size = 0.5),

      # Legend
      legend.position = "top",
      legend.title = element_text(face = "bold", size = rel(1)),
      legend.text = element_text(size = rel(0.9)),

      # Panel
      panel.grid.major = element_line(color = "grey90"),
      panel.grid.minor = element_blank(),
      panel.border = element_rect(color = "black", fill = NA, size = 0.5),

      # Strip (for facets)
      strip.background = element_rect(fill = "grey90", color = "black"),
      strip.text = element_text(face = "bold", size = rel(1))
    )
}

# Apply custom theme
p1 + theme_publication()

# ========================================================================
# 5. HEATMAP WITH ANNOTATIONS
# ========================================================================

# Create annotated heatmap (common in genomics)

create_annotated_heatmap <- function(matrix_data,
                                      row_labels = NULL,
                                      col_labels = NULL,
                                      title = "Heatmap") {

  # Convert to long format
  heatmap_data <- as.data.frame(matrix_data) %>%
    rownames_to_column("row") %>%
    pivot_longer(-row, names_to = "col", values_to = "value")

  # Create heatmap
  p <- ggplot(heatmap_data, aes(x = col, y = row, fill = value)) +
    geom_tile(color = "white", size = 0.5) +
    scale_fill_viridis(option = "inferno") +
    labs(title = title, x = "", y = "") +
    theme_minimal() +
    theme(
      axis.text.x = element_text(angle = 45, hjust = 1),
      plot.title = element_text(hjust = 0.5, face = "bold")
    )

  return(p)
}

# Example:
# mat <- matrix(rnorm(100), nrow = 10, ncol = 10)
# rownames(mat) <- paste0("Gene_", 1:10)
# colnames(mat) <- paste0("Sample_", 1:10)
# create_annotated_heatmap(mat)

# ========================================================================
# KEY TAKEAWAYS
# ========================================================================

cat("\n")
cat("========================================\n")
cat("Key Takeaways: Custom Visualizations\n")
cat("========================================\n")
cat("\n")
cat("1. Create reusable plot functions for consistency\n")
cat("2. Use patchwork for multi-panel figures\n")
cat("3. Develop custom themes for publication style\n")
cat("4. Complex plots (Sankey) show data flow\n")
cat("5. Save high-resolution outputs (300+ DPI)\n")
cat("6. Document function parameters clearly\n")
cat("\n")

# ========================================================================
# EXERCISES
# ========================================================================

# Exercise 1: Create a custom function for MA plots
# (log fold change vs mean expression)
# Your answer:

# Exercise 2: Build a 4-panel figure using patchwork with custom layout
# Your answer:

# Exercise 3: Adapt the SankeyArrow function to show your own workflow
# Your answer:

# Solutions: 07_advanced_topics/exercises/solutions_03.R
