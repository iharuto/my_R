# 📚 Complete Course Index

> **Quick navigation for all modules and files**

---

## 🗺️ Course Navigation Map

```
my_R/
├── 📖 README.md (START HERE!)
├── 📋 COURSE_INDEX.md (This file)
│
├── 00_setup/
│   ├── installation_guide.md
│   ├── essential_packages.R
│   └── project_structure.R
│
├── 01_fundamentals/
│   ├── 01_data_types.R
│   ├── 02_control_flow.R
│   ├── 03_functions.R
│   └── exercises/
│
├── 02_data_wrangling/
│   ├── 01_tidyverse_intro.R
│   ├── 02_data_import_export.R
│   ├── 03_string_manipulation.R
│   ├── 04_advanced_dplyr.R
│   └── mini_project/
│
├── 03_visualization/
│   ├── 01_ggplot2_basics.R
│   ├── 02_customization.R
│   ├── 03_advanced_plots.R
│   ├── 04_publication_quality.R
│   └── examples/
│
├── 04_statistical_analysis/
│   ├── 01_descriptive_stats.R
│   ├── 02_hypothesis_testing.R
│   ├── 03_linear_models.R
│   ├── 04_mixed_models.R
│   └── case_studies/
│
├── 05_programming_patterns/
│   ├── 01_functional_programming.R
│   ├── 02_parallel_computing.R
│   ├── 03_error_handling.R
│   ├── 04_code_organization.R
│   └── advanced_examples/
│
├── 06_domain_specific/
│   ├── 01_bioinformatics_intro.R
│   ├── 02_web_scraping.R
│   ├── 03_api_interaction.R
│   └── 04_workflow_automation.R
│
├── 07_advanced_topics/
│   ├── 01_package_development.R
│   ├── 02_profiling_optimization.R
│   ├── 03_custom_visualizations.R
│   └── 04_production_code.R
│
└── 08_capstone_projects/
    ├── README.md
    ├── project1_data_pipeline/
    ├── project2_visualization/
    └── project3_research_workflow/
```

---

## 📊 Module Difficulty & Time Estimates

| Module | Difficulty | Time | Prerequisites |
|--------|-----------|------|---------------|
| 00 - Setup | Beginner | 2h | None |
| 01 - Fundamentals | Beginner | 10h | Module 00 |
| 02 - Data Wrangling | Intermediate | 15h | Module 01 |
| 03 - Visualization | Intermediate | 12h | Modules 01-02 |
| 04 - Statistics | Advanced | 15h | Modules 01-03 |
| 05 - Programming | Advanced | 10h | Modules 01-04 |
| 06 - Domain-Specific | Advanced | 12h | Modules 01-05 |
| 07 - Advanced Topics | Expert | 10h | All previous |
| 08 - Capstone | Expert | 20h | All previous |

**Total Course Time: ~96 hours** (full mastery)

---

## 🎯 Learning Paths

### Path 1: Beginner Track (40 hours)
For students new to R or programming

```
00_setup → 01_fundamentals → 02_data_wrangling → 03_visualization
```

**Outcome**: Can perform basic data analysis and create visualizations

---

### Path 2: Data Analyst Track (60 hours)
For students with basic R knowledge

```
00_setup (review) → 02_data_wrangling → 03_visualization →
04_statistical_analysis → 08_capstone (Project 1 or 2)
```

**Outcome**: Can conduct complete data analysis projects

---

### Path 3: Research Scientist Track (Full Course, 96 hours)
For advanced students aiming for research positions

```
All modules 00 → 01 → 02 → 03 → 04 → 05 → 06 → 07 → 08
```

**Outcome**: Publication-quality analysis and professional-level code

---

### Path 4: Bioinformatics Track (70 hours)
For students interested in computational biology

```
00 → 01 → 02 → 03 → 04_mixed_models → 06_domain_specific → 08_capstone (Project 3)
```

**Outcome**: Can analyze genomics/transcriptomics data

---

## 📂 File-by-File Guide

### Module 00: Setup & Environment

#### `installation_guide.md`
- Installing R, RStudio, packages
- System setup (Linux, macOS, Windows)
- Troubleshooting common issues

#### `essential_packages.R`
- Automated package installation script
- All packages for the course
- Verification tests

#### `project_structure.R`
- Best practices for organizing projects
- Using RStudio Projects
- File naming conventions
- Version control basics

---

### Module 01: R Fundamentals

#### `01_data_types.R`
- **Topics**: Vectors, lists, data frames, factors
- **Key Skills**: Data structures, indexing, type conversion
- **Time**: 2-3 hours

#### `02_control_flow.R` *(To be created)*
- **Topics**: if/else, loops, vectorization
- **Key Skills**: Control structures, avoiding loops
- **Time**: 2-3 hours

#### `03_functions.R` *(To be created)*
- **Topics**: Writing functions, scope, documentation
- **Key Skills**: Function design, arguments, return values
- **Time**: 2-3 hours

---

### Module 02: Data Wrangling

#### `01_tidyverse_intro.R`
- **Topics**: dplyr verbs, pipe operator, grouped operations
- **Key Skills**: filter, select, mutate, summarize
- **Time**: 3-4 hours
- **Key Pattern**: Split-apply-combine

#### `02_data_import_export.R` *(To be created)*
- **Topics**: Reading CSV, Excel, RDS files
- **Key Skills**: Data import, export, format conversion

#### `03_string_manipulation.R` *(To be created)*
- **Topics**: stringr, regex patterns
- **Key Skills**: Text processing, pattern matching

#### `04_advanced_dplyr.R` *(To be created)*
- **Topics**: Joins, pivoting, nested data
- **Key Skills**: Complex transformations

---

### Module 03: Data Visualization

#### `01_ggplot2_basics.R`
- **Topics**: Grammar of Graphics, geoms, aesthetics
- **Key Skills**: scatter, bar, box, violin, line plots
- **Time**: 3-4 hours
- **Showcase**: Volcano plots, faceting

#### `02_customization.R` *(To be created)*
- **Topics**: Themes, scales, colors
- **Key Skills**: Customizing appearance

#### `03_advanced_plots.R` *(To be created)*
- **Topics**: Complex layouts, annotations
- **Key Skills**: Multi-panel figures

#### `04_publication_quality.R` *(To be created)*
- **Topics**: High-resolution outputs, formatting
- **Key Skills**: Publication-ready figures

---

### Module 04: Statistical Analysis

#### `01_descriptive_stats.R` *(To be created)*
- **Topics**: Summary statistics, distributions
- **Key Skills**: Describing data numerically

#### `02_hypothesis_testing.R` *(To be created)*
- **Topics**: t-tests, ANOVA, non-parametric tests
- **Key Skills**: Statistical significance

#### `03_linear_models.R` *(To be created)*
- **Topics**: lm(), glm(), model diagnostics
- **Key Skills**: Regression analysis

#### `04_mixed_models.R`
- **Topics**: LMM, GLMM, random effects
- **Key Skills**: Hierarchical data analysis
- **Time**: 4-5 hours
- **Real Example**: Brain_Blast GLMM workflow

---

### Module 05: Programming Patterns

#### `01_functional_programming.R`
- **Topics**: apply family, purrr, map functions
- **Key Skills**: Avoiding loops, functional style
- **Time**: 3-4 hours
- **Key Pattern**: map, reduce, safely

#### `02_parallel_computing.R` *(To be created)*
- **Topics**: foreach, doParallel, future
- **Key Skills**: Speeding up code

#### `03_error_handling.R` *(To be created)*
- **Topics**: tryCatch, safely, possibly
- **Key Skills**: Robust code

#### `04_code_organization.R` *(To be created)*
- **Topics**: Sourcing, modules, packages
- **Key Skills**: Structuring large projects

---

### Module 06: Domain-Specific Skills

#### `01_bioinformatics_intro.R` *(To be created)*
- **Topics**: Bioconductor basics
- **Key Skills**: Genomics data structures

#### `02_web_scraping.R`
- **Topics**: rvest, httr, GEOquery
- **Key Skills**: Automated data collection
- **Time**: 3-4 hours
- **Real Example**: GEO database scraping

#### `03_api_interaction.R` *(To be created)*
- **Topics**: REST APIs, authentication
- **Key Skills**: Accessing online databases

#### `04_workflow_automation.R` *(To be created)*
- **Topics**: Reproducible pipelines
- **Key Skills**: End-to-end automation

---

### Module 07: Advanced Topics

#### `01_package_development.R` *(To be created)*
- **Topics**: roxygen2, devtools, testing
- **Key Skills**: Creating R packages

#### `02_profiling_optimization.R` *(To be created)*
- **Topics**: Benchmarking, optimization
- **Key Skills**: Making code fast

#### `03_custom_visualizations.R`
- **Topics**: Custom ggplot functions, Sankey diagrams
- **Key Skills**: Reusable visualization systems
- **Time**: 4-5 hours
- **Showcase**: SankeyArrow, multi-panel figures

#### `04_production_code.R` *(To be created)*
- **Topics**: Testing, documentation, best practices
- **Key Skills**: Professional-quality code

---

### Module 08: Capstone Projects

#### `project1_data_pipeline/`
- **Goal**: Automated data collection and analysis
- **Time**: 8-12 hours
- **Skills**: Scraping, cleaning, analysis, reporting

#### `project2_visualization/`
- **Goal**: Publication-quality figure system
- **Time**: 6-10 hours
- **Skills**: Custom plots, themes, multi-panel figures

#### `project3_research_workflow/`
- **Goal**: Complete statistical analysis
- **Time**: 10-15 hours
- **Skills**: GLMM, parallel processing, interpretation

---

## 🔍 Quick Reference: Where to Find Specific Topics

### Data Manipulation
- Basic: `02_data_wrangling/01_tidyverse_intro.R`
- Advanced: `02_data_wrangling/04_advanced_dplyr.R`

### Plotting
- Basics: `03_visualization/01_ggplot2_basics.R`
- Custom: `07_advanced_topics/03_custom_visualizations.R`

### Statistics
- Basic tests: `04_statistical_analysis/02_hypothesis_testing.R`
- Advanced models: `04_statistical_analysis/04_mixed_models.R`

### Programming
- Functions: `01_fundamentals/03_functions.R`
- Functional: `05_programming_patterns/01_functional_programming.R`

### Automation
- Web scraping: `06_domain_specific/02_web_scraping.R`
- Workflows: `06_domain_specific/04_workflow_automation.R`

---

## 📖 Recommended Reading Order

### Week 1: Foundation
1. `00_setup/installation_guide.md`
2. `00_setup/essential_packages.R`
3. `00_setup/project_structure.R`
4. `01_fundamentals/01_data_types.R`

### Week 2: Core Skills
5. `01_fundamentals/02_control_flow.R`
6. `01_fundamentals/03_functions.R`
7. `02_data_wrangling/01_tidyverse_intro.R`

### Week 3: Visualization
8. `02_data_wrangling/02_data_import_export.R`
9. `03_visualization/01_ggplot2_basics.R`
10. `03_visualization/02_customization.R`

### Week 4-6: Advanced Skills
Continue through modules 04-07 based on your interests

### Week 7-8: Capstone
Choose and complete one capstone project

---

## 🎓 Certification Criteria

To demonstrate mastery of this course:

- [ ] Complete all files in modules 00-03
- [ ] Complete at least 2 files from modules 04-07
- [ ] Complete 1 capstone project
- [ ] Code follows style guide
- [ ] All exercises completed
- [ ] Can explain concepts to others

---

## 📝 Notes for Instructors

### Course Delivery Options

**Option 1: Full Semester (12-15 weeks)**
- 1 module per 1-2 weeks
- Weekly assignments
- Mid-term project (any module 04-07 topic)
- Final capstone project

**Option 2: Intensive Workshop (5 days)**
- Day 1: Modules 00-01
- Day 2: Module 02
- Day 3: Module 03
- Day 4: Module 04 or 06
- Day 5: Mini capstone

**Option 3: Self-Paced Online**
- Students work through at their own pace
- Discussion forums for questions
- Submit capstone for review

### Assessment Suggestions
- Weekly quizzes on key concepts
- Code reviews of exercises
- Peer review of capstone projects
- Final presentation of capstone

---

## 🚀 Next Steps After Course Completion

1. **Build Portfolio**: Showcase capstone projects on GitHub
2. **Contribute to Open Source**: Find R packages to contribute to
3. **Start Own Project**: Apply skills to research questions
4. **Teach Others**: Best way to solidify knowledge
5. **Advanced Topics**: Shiny apps, package development, C++ integration

---

## 📬 Support & Community

- Review previous modules for concepts
- Check exercises/solutions for examples
- Google error messages (seriously!)
- Stack Overflow for specific questions
- R documentation (`?function_name`)

---

**Happy Learning!** 🎉

*This course represents professional R programming practices from real research projects in neuroscience and bioinformatics.*
