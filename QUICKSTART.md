# 🚀 Quick Start Guide

> **Get started with the R Programming Course in 10 minutes**

---

## ⚡ Fast Track Setup

### 1. Check Your Installation (2 minutes)

Open RStudio and run:

```r
# Check R version (should be ≥ 4.0)
R.version.string

# Test basic functionality
2 + 2  # Should return 4

# Load tidyverse (if installed)
library(tidyverse)
```

**If any errors occur**, see `00_setup/installation_guide.md`

---

### 2. Install Essential Packages (10-15 minutes)

```r
# Run the automated installation script
source("00_setup/essential_packages.R")
```

This will install all packages needed for the course. Go get coffee while it runs! ☕

---

### 3. Choose Your Learning Path (1 minute)

Pick the path that matches your goals:

#### 🌱 **Path A: Complete Beginner**
*"I'm new to R and programming"*

```
Start → 00_setup → 01_fundamentals → 02_data_wrangling → 03_visualization
```

**Time**: ~40 hours | **Goal**: Basic data analysis

---

#### 📊 **Path B: Data Analyst**
*"I know some R, want to level up"*

```
Start → 02_data_wrangling → 03_visualization → 04_statistical_analysis
```

**Time**: ~40 hours | **Goal**: Professional data analysis

---

#### 🧬 **Path C: Bioinformatics**
*"I want to analyze genomics data"*

```
Start → 02_data_wrangling → 04_mixed_models → 06_domain_specific → 08_capstone
```

**Time**: ~50 hours | **Goal**: Research-level analysis

---

#### 🚀 **Path D: Full Mastery**
*"I want to be an expert R programmer"*

```
Start → Complete all modules 00-08 in order
```

**Time**: ~96 hours | **Goal**: Publication-quality code & analysis

---

### 4. Start Learning! (Right now)

Open your first file based on your path:

```r
# In RStudio:
# File → Open File → Navigate to my_R/

# Beginners start here:
file.edit("00_setup/installation_guide.md")
file.edit("01_fundamentals/01_data_types.R")

# Intermediate start here:
file.edit("02_data_wrangling/01_tidyverse_intro.R")

# Advanced start here:
file.edit("04_statistical_analysis/04_mixed_models.R")
```

---

## 📖 How to Use Each File

Every `.R` file follows this structure:

```r
# ========================================================================
# Module Title - Topic
# ========================================================================
#
# Learning Objectives: What you'll learn
# Estimated time: How long it takes
#
# ========================================================================

# 1. CONCEPT EXPLANATION
# Clear explanation of the concept

# Example code (runnable)
x <- 1:10
mean(x)

# 2. MORE CONCEPTS...

# EXERCISES at the end
# Try them yourself!

# KEY TAKEAWAYS
# Summary of important points
```

### How to Work Through a File:

1. **Read the header** - Know what you'll learn
2. **Run the code** - Execute line by line (Ctrl/Cmd + Enter)
3. **Experiment** - Modify values, see what happens
4. **Do exercises** - Practice makes perfect
5. **Review key takeaways** - Reinforce learning

---

## 🎯 Today's Goals (2-3 hours)

### Beginner Track
- [ ] Read `00_setup/installation_guide.md`
- [ ] Run `00_setup/essential_packages.R`
- [ ] Start `01_fundamentals/01_data_types.R`
- [ ] Complete first 3 sections

### Intermediate Track
- [ ] Review `00_setup/project_structure.R`
- [ ] Complete `02_data_wrangling/01_tidyverse_intro.R`
- [ ] Try exercises

### Advanced Track
- [ ] Skim review materials
- [ ] Jump to `04_statistical_analysis/04_mixed_models.R`
- [ ] Understand GLMM workflow

---

## 💡 Pro Tips

### Learning Strategy
1. **Don't rush** - Understanding > speed
2. **Type code yourself** - Don't just read
3. **Break things** - Errors teach you
4. **Ask questions** - No question is dumb
5. **Practice daily** - 30 minutes > 4 hours once

### When You're Stuck
1. Read the error message carefully
2. Check the examples above in the file
3. Google the error (seriously!)
4. Look at solutions in `exercises/` folders
5. Review previous modules

### Keyboard Shortcuts (RStudio)
- `Ctrl/Cmd + Enter` - Run current line
- `Ctrl/Cmd + Shift + M` - Insert `%>%` (pipe)
- `Alt + -` - Insert `<-` (assignment)
- `Ctrl/Cmd + Shift + C` - Comment/uncomment
- `Tab` - Auto-complete

---

## 📁 Project Setup (Optional but Recommended)

Create a practice directory:

```r
# Run in R:
dir.create("~/R_practice")
setwd("~/R_practice")

# Create first script
file.create("my_first_analysis.R")
```

Or use the automated function:

```r
source("00_setup/project_structure.R")
create_project_structure("my_practice_project")
```

---

## 📊 Track Your Progress

Create a learning log:

```
Day 1: Completed 01_data_types.R - Learned about vectors and data frames
Day 2: Started 02_tidyverse_intro.R - pipe operator is cool!
Day 3: Made first plot with ggplot2!
...
```

Use the checklist in `README.md` to track module completion.

---

## 🎓 What Success Looks Like

After completing this course, you should be able to:

✅ Write clean, readable R code
✅ Manipulate and transform data efficiently
✅ Create publication-quality visualizations
✅ Perform statistical analyses
✅ Automate workflows
✅ Build reproducible research pipelines

---

## 📚 Essential Resources Bookmarks

Add these to your browser:

1. **R Documentation**: https://www.rdocumentation.org/
2. **RStudio Cheatsheets**: https://posit.co/resources/cheatsheets/
3. **R for Data Science**: https://r4ds.had.co.nz/
4. **Stack Overflow [R]**: https://stackoverflow.com/questions/tagged/r
5. **This course index**: `COURSE_INDEX.md`

---

## 🔥 Challenge: First Analysis in 30 Minutes

Can you do this in 30 minutes after setup?

```r
# Load packages
library(tidyverse)

# Load built-in data
data(mtcars)

# Explore data
head(mtcars)
summary(mtcars)

# Transform data
mtcars_summary <- mtcars %>%
  group_by(cyl) %>%
  summarize(
    mean_mpg = mean(mpg),
    mean_hp = mean(hp)
  )

# Visualize
ggplot(mtcars, aes(x = wt, y = mpg, color = factor(cyl))) +
  geom_point(size = 3) +
  labs(title = "My First R Plot!",
       x = "Weight", y = "MPG",
       color = "Cylinders") +
  theme_minimal()
```

If you can understand this code, you're ready for Module 02!
If not, start with Module 01.

---

## ⏭️ Next Steps

1. **Complete setup** (if not done)
2. **Choose your learning path**
3. **Open your first file**
4. **Start coding!**

---

## 🆘 Need Help?

- Check `COURSE_INDEX.md` for navigation
- Review `README.md` for overview
- Look at exercise solutions
- Google error messages
- Re-read sections

---

**You got this!** 💪

Every expert was once a beginner. Start with line 1, run the code, and learn by doing.

---

*Course created from real research projects in neuroscience and bioinformatics*
*by a researcher who knows the struggle of learning R*

**Now stop reading and start coding!** 🚀
