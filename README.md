# 🎓 R Programming: From Fundamentals to Research-Level Data Science

---

## 📖 Course Overview

This comprehensive R programming course is structured to develop your skills progressively, from fundamental concepts to advanced research workflows. Each module builds on previous knowledge and includes practical examples from real-world research projects.

### 🎯 Learning Objectives

By the end of this course, you will be able to:
- Write clean, efficient, and well-documented R code
- Perform complex data manipulation and transformation
- Create publication-quality visualizations
- Apply advanced statistical modeling techniques
- Develop reproducible research workflows
- Handle large-scale data processing tasks
- Build custom functions and workflows for research

---

## 🗺️ Course Structure

### **Module 00: Setup & Environment** 📦
**Time**: ~2 hours
**Prerequisites**: None

Learn to set up your R environment, install essential packages, and organize projects professionally.

- Installation guide (R, RStudio, essential packages)
- Project structure best practices
- Version control basics
- Package management

---

### **Module 01: R Fundamentals** 🔤
**Time**: ~10 hours
**Prerequisites**: Basic programming concepts

Master the core R programming concepts that form the foundation of all data analysis.

- Data types and structures (vectors, lists, data frames)
- Control flow (if/else, loops, vectorization)
- Function writing and documentation
- Scope and environments
- **🎯 Exercises included**

---

### **Module 02: Data Wrangling** 🔧
**Time**: ~15 hours
**Prerequisites**: Module 01

Learn to efficiently manipulate and transform data using modern tidyverse tools.

- Tidyverse ecosystem (dplyr, tidyr, purrr)
- Data import/export (CSV, Excel, RDS)
- String manipulation and regex
- Advanced grouping and summarization
- **🏗️ Mini-project: Real dataset analysis**

---

### **Module 03: Data Visualization** 📊
**Time**: ~12 hours
**Prerequisites**: Modules 01-02

Create stunning, publication-quality visualizations using ggplot2 and advanced plotting techniques.

- Grammar of Graphics (ggplot2 basics)
- Customization (themes, colors, scales)
- Advanced plots (facets, complex layouts)
- Publication-ready figures
- **🎨 Gallery: Professional plot examples**

---

### **Module 04: Statistical Analysis** 📈
**Time**: ~15 hours
**Prerequisites**: Modules 01-03 + basic statistics knowledge

Apply statistical methods for hypothesis testing and modeling in research contexts.

- Descriptive statistics and distributions
- Hypothesis testing (t-tests, ANOVA, non-parametric)
- Linear and generalized linear models
- **Mixed-effects models (GLMM)** - Advanced!
- **📚 Case studies with real research scenarios**

---

### **Module 05: Programming Patterns** 💡
**Time**: ~10 hours
**Prerequisites**: Modules 01-04

Master advanced programming techniques for efficient, scalable code.

- Functional programming (lapply, map, purrr)
- Parallel computing (foreach, doParallel)
- Error handling and debugging
- Code organization and modularity
- **🚀 Performance optimization tips**

---

### **Module 06: Domain-Specific Skills** 🧬
**Time**: ~12 hours
**Prerequisites**: Modules 01-05

Apply R to specialized domains like bioinformatics and web scraping.

- Bioconductor basics
- Web scraping (rvest, httr)
- API interaction (GEOquery, public databases)
- Workflow automation
- **🔬 Real examples from bioinformatics projects**

---

### **Module 07: Advanced Topics** 🎓
**Time**: ~10 hours
**Prerequisites**: All previous modules

Push your skills to expert level with production-quality code practices.

- Package development (roxygen2, devtools)
- Code profiling and optimization
- Custom visualization systems
- Production-ready code patterns
- **⚡ Advanced techniques from real projects**

---

### **Module 08: Capstone Projects** 🏆
**Time**: ~20 hours
**Prerequisites**: All previous modules

Apply everything you've learned to complete real-world research projects.

- **Project 1**: End-to-end data pipeline (web scraping → analysis → report)
- **Project 2**: Complex visualization system (publication figures)
- **Project 3**: Research workflow (hypothesis → analysis → interpretation)

---

## 🚀 Getting Started

### Quick Start (3 steps)

1. **Install R and RStudio**
   ```bash
   # See 00_setup/installation_guide.md for detailed instructions
   ```

2. **Clone/download this repository**
   ```bash
   cd ~/Projects
   # The my_R folder should be in your Projects directory
   ```

3. **Start with Module 00**
   ```r
   # Open 00_setup/essential_packages.R
   # Run the script to install all required packages
   ```

---

## 📚 Recommended Learning Path

### **For Absolute Beginners**
`00 → 01 → 02 → 03 → 04`

Start from the beginning and work through sequentially. Focus on exercises and mini-projects.

### **For Intermediate Programmers** (know basics of R)
`00 (review) → 02 → 03 → 04 → 05 → 06`

Skip or skim Module 01, focus on data wrangling and visualization.

### **For Advanced Users** (want to level up)
`05 → 06 → 07 → 08`

Focus on advanced programming patterns and domain-specific skills.

### **For Specific Goals**

| Goal | Path |
|------|------|
| **Data Analysis** | 01 → 02 → 03 → 04 |
| **Visualization** | 01 → 02 → 03 → 07 (custom viz) |
| **Bioinformatics** | 01 → 02 → 04 → 06 |
| **Production Code** | 05 → 07 |
| **Research Workflow** | 02 → 03 → 04 → 06 → 08 |

---

## 💻 Code Philosophy

This course emphasizes:

- ✅ **Clarity over cleverness** - Code should be readable
- ✅ **Reproducibility** - Scripts should run anywhere
- ✅ **Efficiency** - Use vectorization, avoid unnecessary loops
- ✅ **Documentation** - Comment the "why", not just the "what"
- ✅ **Best practices** - Follow tidyverse style guide
- ✅ **Real-world relevance** - Examples from actual research

---

## 🛠️ Required Software

- **R** (≥ 4.0.0) - [Download](https://cran.r-project.org/)
- **RStudio** (≥ 2023.06) - [Download](https://posit.co/download/rstudio-desktop/)
- **Essential packages**: See `00_setup/essential_packages.R`

### Optional but Recommended
- **Git** - Version control
- **Miniconda** - Environment management (if using Python integration)
- **LaTeX** - For PDF report generation

---

## 📦 Key Packages Used

```r
# Data manipulation
tidyverse, dplyr, tidyr, purrr, stringr, readr

# Visualization
ggplot2, patchwork, viridis, ggforce

# Statistics
lme4, glmmTMB, broom

# Bioinformatics
Bioconductor, GEOquery, Seurat

# Web & APIs
httr, rvest, xml2

# Utilities
foreach, doParallel, progress
```

---

## 📝 Assessment & Exercises

Each module includes:

- **📖 Concept explanations** with annotated code
- **💡 Common mistakes** and how to avoid them
- **✏️ Exercises** with solutions (in separate files)
- **🎯 Mini-projects** to apply learned skills
- **🔗 Further reading** for deeper exploration

---

## 🤝 How to Use This Course

### Self-Study
Work through modules at your own pace. Run all examples, complete exercises, and experiment with variations.

### Instructor-Led
Instructors can use this as a semester-long course (12-15 weeks) or intensive workshop (3-5 days).

### Reference
Use as a reference for specific techniques. All code is self-contained and commented.

---

## 🌟 Showcase Projects

Throughout this course, you'll see examples and patterns from real research projects:

- **Single-cell RNA-seq analysis** (Brain_Blast project)
- **EEG data processing** (EEG_analysis project)
- **Web scraping GEO database** (Dataset curation)
- **Mixed-effects modeling** (GLMM for neuroscience)
- **Custom visualizations** (Sankey diagrams, network plots)

---

## 🎓 About the Instructor

This course reflects professional R programming practices used in cutting-edge neuroscience and bioinformatics research, including:

- Large-scale single-cell transcriptomics analysis
- Automated dataset curation and quality control
- Advanced statistical modeling (GLMM, pseudobulk analysis)
- Publication-quality visualization systems
- Reproducible research workflows

---

## 📬 Support & Feedback

- **Questions**: See FAQ in each module
- **Issues**: Check troubleshooting guides
- **Suggestions**: Students are encouraged to ask questions during sessions

---

## 🚦 Before You Begin

**Check your readiness:**

- [ ] R and RStudio installed
- [ ] Basic understanding of programming concepts
- [ ] Willingness to experiment and learn from errors
- [ ] Time commitment: ~96 hours for full course

**Remember**: Programming is learned by doing. Run the code, break it, fix it, and experiment!

---

## 📖 Next Steps

👉 **Start here**: [Module 00: Setup & Environment](00_setup/)

---

*Last updated: 2026-01-05*
*Course version: 1.0*
*License: Educational use - feel free to learn and adapt*
