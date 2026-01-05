# 🏆 Capstone Projects: Apply Everything You've Learned

> **Goal**: Complete real-world research projects that integrate all skills from Modules 01-07

---

## Overview

These capstone projects simulate actual research workflows you'd encounter in data science and bioinformatics. Each project requires you to combine multiple skills:

- Data wrangling
- Statistical analysis
- Visualization
- Programming patterns
- Domain-specific techniques

---

## Project 1: Automated Data Pipeline

**Difficulty**: Advanced
**Time**: 8-12 hours
**Skills**: Web scraping, data cleaning, analysis automation, visualization

### Objective

Build an end-to-end pipeline to:
1. Scrape dataset metadata from a public repository (simulated GEO)
2. Filter and clean the data based on quality criteria
3. Perform exploratory data analysis
4. Generate automated report with visualizations

### Deliverables

- [ ] Web scraping script with error handling
- [ ] Data cleaning and QC functions
- [ ] Statistical summary of collected datasets
- [ ] Publication-quality figures
- [ ] R Markdown report documenting entire workflow

### Files

- `01_scrape_metadata.R` - Web scraping functions
- `02_clean_data.R` - Data cleaning pipeline
- `03_analyze_data.R` - Statistical analysis
- `04_visualize_results.R` - Create figures
- `project1_report.Rmd` - Final report

### Example Research Question

*"Identify trends in single-cell RNA-seq studies published in 2020-2025: Which tissues and organisms are most studied?"*

---

## Project 2: Publication-Quality Visualization System

**Difficulty**: Advanced
**Time**: 6-10 hours
**Skills**: ggplot2, custom functions, multi-panel figures, themes

### Objective

Develop a reusable visualization system for a research paper, including:
1. Custom ggplot2 functions for common plot types
2. Consistent theme across all figures
3. Multi-panel figures with patchwork
4. Complex visualizations (Sankey, heatmaps)

### Deliverables

- [ ] Library of custom plot functions
- [ ] Custom theme for publication
- [ ] 5 different plot types (volcano, heatmap, box, etc.)
- [ ] 2 multi-panel figures combining 4+ plots
- [ ] Documentation for each function

### Files

- `visualization_library.R` - Custom plot functions
- `custom_theme.R` - Publication theme
- `example_figures.R` - Demonstrate all functions
- `figure_1_multi_panel.R` - Main figure
- `supplementary_figures.R` - Additional figures

### Example Goal

*"Create a complete figure panel for a differential expression analysis paper, showing volcano plot, MA plot, heatmap, and pathway enrichment."*

---

## Project 3: Statistical Analysis Workflow

**Difficulty**: Expert
**Time**: 10-15 hours
**Skills**: Mixed models, parallel computing, data wrangling, visualization

### Objective

Conduct a complete statistical analysis mimicking a research study:
1. Simulate or load pseudobulk gene expression data
2. Perform quality control and filtering
3. Implement mixed-effects models (GLMM) for multiple genes
4. Correct for multiple testing
5. Visualize and interpret results

### Deliverables

- [ ] Data simulation/loading functions
- [ ] QC and filtering pipeline
- [ ] GLMM analysis with parallel processing
- [ ] Results summary tables
- [ ] Comprehensive visualization of findings
- [ ] Full R Markdown report with interpretation

### Files

- `01_setup_data.R` - Data preparation
- `02_quality_control.R` - QC functions
- `03_statistical_models.R` - GLMM implementation
- `04_summarize_results.R` - Create results tables
- `05_visualize_findings.R` - Plots
- `project3_analysis_report.Rmd` - Complete report

### Example Research Question

*"Do gene expression patterns differ between disease and control conditions after accounting for patient-specific variation and age?"*

---

## Getting Started

### Prerequisites

- Completed Modules 01-07
- All required packages installed
- Understanding of research workflows

### Choose Your Project

1. **Project 1** - Best for those interested in data engineering and automation
2. **Project 2** - Best for those focused on data visualization
3. **Project 3** - Best for those interested in statistical modeling

### Project Structure Template

```
project_name/
├── data/
│   ├── raw/
│   └── processed/
├── scripts/
│   ├── 01_step1.R
│   ├── 02_step2.R
│   └── functions/
│       └── helper_functions.R
├── output/
│   ├── figures/
│   └── tables/
└── report.Rmd
```

---

## Evaluation Criteria

Your project will be evaluated on:

### Code Quality (30%)
- [ ] Clean, readable code with comments
- [ ] Proper function documentation
- [ ] Error handling implemented
- [ ] Follows style guide

### Technical Skills (40%)
- [ ] Correct implementation of methods
- [ ] Efficient code (vectorization, avoid unnecessary loops)
- [ ] Proper data structures used
- [ ] Reproducible workflow

### Analysis & Interpretation (20%)
- [ ] Appropriate statistical methods
- [ ] Results correctly interpreted
- [ ] Limitations acknowledged
- [ ] Conclusions supported by data

### Presentation (10%)
- [ ] Clear visualizations
- [ ] Well-structured report
- [ ] Professional formatting
- [ ] Complete documentation

---

## Tips for Success

1. **Start with pseudocode**: Plan your workflow before coding
2. **Test incrementally**: Don't write everything at once
3. **Use version control**: Commit frequently with git
4. **Document as you go**: Write comments while coding, not after
5. **Modularize**: Break complex tasks into functions
6. **Validate results**: Check intermediate outputs make sense
7. **Ask for help**: Review example code from previous modules

---

## Example Timeline (2-3 weeks)

### Week 1: Planning & Data
- Day 1-2: Choose project and plan workflow
- Day 3-5: Set up data collection/simulation
- Day 6-7: Implement data cleaning and QC

### Week 2: Analysis & Visualization
- Day 1-3: Core analysis implementation
- Day 4-5: Create visualizations
- Day 6-7: Optimize and refactor code

### Week 3: Finalization
- Day 1-2: Complete analysis and verify results
- Day 3-4: Write report and documentation
- Day 5: Final review and submission preparation

---

## Submission Checklist

Before considering your project complete:

- [ ] All scripts run without errors
- [ ] Code is well-commented
- [ ] Functions have documentation
- [ ] README explains project structure
- [ ] Outputs are in correct directories
- [ ] R Markdown report knits successfully
- [ ] All figures are high resolution (300 DPI)
- [ ] Session info included for reproducibility
- [ ] Git repository is organized and clean

---

## Going Further

After completing your capstone:

1. **Share your work**: GitHub, personal website, or portfolio
2. **Refine and extend**: Add more features or analyses
3. **Apply to real data**: Use actual datasets from your research
4. **Teach others**: Explain your workflow to peers
5. **Build a package**: Convert your functions into an R package

---

## Resources

- All previous modules (00-07)
- Example code from Brain_Blast and EEG_analysis projects
- R documentation and package vignettes
- Stack Overflow and R community forums

---

## Showcase Your Skills

Your capstone projects demonstrate:

✅ **Technical proficiency** in R programming
✅ **Statistical literacy** for research
✅ **Data visualization** skills
✅ **Workflow automation** abilities
✅ **Professional coding** practices

These are exactly the skills employers and PhD programs look for!

---

**Ready to begin?** Choose your project and create your first script!

*Remember: The goal is learning, not perfection. Start coding, iterate, and improve!*
