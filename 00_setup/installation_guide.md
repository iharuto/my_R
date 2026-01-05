# 📦 Installation Guide: Setting Up Your R Environment

> **Estimated time**: 30-60 minutes
> **Difficulty**: Beginner
> **Last updated**: 2026-01-05

---

## 🎯 What You'll Install

1. **R** - The programming language
2. **RStudio** - Integrated development environment (IDE)
3. **Essential R packages** - Tools for data science
4. **(Optional)** Git - Version control
5. **(Optional)** Miniconda - Environment management

---

## 🖥️ Installation by Operating System

### **Linux (Ubuntu/Debian)**

#### 1. Install R

```bash
# Update package list
sudo apt update

# Install dependencies
sudo apt install -y --no-install-recommends software-properties-common dirmngr

# Add CRAN repository
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc

# Add repository (for Ubuntu 22.04 - adjust if different)
sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"

# Install R
sudo apt install -y r-base r-base-dev

# Verify installation
R --version
```

#### 2. Install RStudio

```bash
# Download RStudio (check for latest version)
wget https://download1.rstudio.org/electron/jammy/amd64/rstudio-2024.12.0-467-amd64.deb

# Install
sudo dpkg -i rstudio-2024.12.0-467-amd64.deb

# Fix dependencies if needed
sudo apt-get install -f

# Launch RStudio
rstudio &
```

#### 3. Install System Dependencies for R Packages

```bash
# Essential libraries for common R packages
sudo apt install -y \
  libcurl4-openssl-dev \
  libssl-dev \
  libxml2-dev \
  libfontconfig1-dev \
  libharfbuzz-dev \
  libfribidi-dev \
  libfreetype6-dev \
  libpng-dev \
  libtiff5-dev \
  libjpeg-dev \
  libgit2-dev \
  libgsl-dev
```

---

### **macOS**

#### 1. Install R

**Option A: Direct download**
1. Go to https://cran.r-project.org/bin/macosx/
2. Download the latest `.pkg` file (e.g., R-4.3.2.pkg)
3. Open and follow installation wizard

**Option B: Using Homebrew**
```bash
# Install Homebrew if not installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install R
brew install r

# Verify
R --version
```

#### 2. Install RStudio

1. Go to https://posit.co/download/rstudio-desktop/
2. Download RStudio for macOS
3. Open `.dmg` file and drag RStudio to Applications

#### 3. Install Xcode Command Line Tools (for compiling packages)

```bash
xcode-select --install
```

---

### **Windows**

#### 1. Install R

1. Go to https://cran.r-project.org/bin/windows/base/
2. Click "Download R X.X.X for Windows"
3. Run the `.exe` installer
4. Follow installation wizard (default settings are fine)
5. Add R to PATH (check option during installation)

#### 2. Install RStudio

1. Go to https://posit.co/download/rstudio-desktop/
2. Download RStudio for Windows
3. Run the `.exe` installer
4. Follow installation wizard

#### 3. Install Rtools (for compiling packages)

1. Go to https://cran.r-project.org/bin/windows/Rtools/
2. Download Rtools (matching your R version)
3. Install with default settings
4. Verify in R:
   ```r
   Sys.which("make")
   # Should show path to make.exe
   ```

---

## 📚 Installing R Packages

### Method 1: Using the R Console

Open R or RStudio and run:

```r
# Install a single package
install.packages("tidyverse")

# Install multiple packages
install.packages(c("dplyr", "ggplot2", "readr"))

# Install from Bioconductor
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("GEOquery")
```

### Method 2: Using the provided script

```r
# In RStudio, open and run:
source("00_setup/essential_packages.R")
```

---

## ✅ Verification: Check Your Installation

### Test R Installation

Open R and type:

```r
# Check R version
R.version.string

# Should show something like: "R version 4.3.2 (2023-10-31)"

# Test basic calculation
2 + 2
# Should return: 4

# Test vector operations
x <- 1:10
mean(x)
# Should return: 5.5
```

### Test RStudio

1. Open RStudio
2. You should see 4 panes:
   - **Console** (bottom-left)
   - **Source** (top-left)
   - **Environment** (top-right)
   - **Files/Plots** (bottom-right)

### Test Essential Packages

```r
# Test tidyverse
library(tidyverse)
# Should load without errors and show package versions

# Test ggplot2
ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point()
# Should create a scatter plot

# List installed packages
installed.packages()[, c("Package", "Version")]
```

---

## 🔧 Troubleshooting

### Problem: "Package installation failed"

**Linux:**
```bash
# Install missing system libraries
sudo apt install -y libcurl4-openssl-dev libssl-dev libxml2-dev
```

**macOS:**
```bash
# Install Xcode command line tools
xcode-select --install
```

**Windows:**
- Ensure Rtools is installed
- Run RStudio as Administrator

### Problem: "Cannot load package X"

```r
# Remove and reinstall
remove.packages("package_name")
install.packages("package_name")

# Clear package cache
.libPaths()  # Shows where packages are installed
# Delete the package folder manually, then reinstall
```

### Problem: "Out of memory"

```r
# Check memory usage
memory.limit()  # Windows only

# Increase memory (Windows)
memory.limit(size = 16000)  # 16GB

# Clear workspace
rm(list = ls())
gc()  # Garbage collection
```

### Problem: RStudio won't start

- **Reset RStudio settings**: Delete `~/.rstudio-desktop/` (Linux/Mac) or `%LOCALAPPDATA%\RStudio-Desktop\` (Windows)
- **Check R path**: Tools → Global Options → R General → R version

---

## 🌐 Optional: Installing Git

### Linux
```bash
sudo apt install git
git --version
```

### macOS
```bash
brew install git
# Or: xcode-select --install (includes git)
```

### Windows
Download from: https://git-scm.com/download/win

**Configure Git:**
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

---

## 🐍 Optional: Installing Miniconda (for Python integration)

Useful if you'll work with both R and Python.

### Download and Install

**Linux/macOS:**
```bash
# Download installer
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

# Install
bash Miniconda3-latest-Linux-x86_64.sh

# Activate
source ~/.bashrc
```

**Windows:**
Download from: https://docs.conda.io/en/latest/miniconda.html

### Create R environment with conda

```bash
# Create environment with R
conda create -n r-env r-base r-essentials

# Activate environment
conda activate r-env

# Launch R
R
```

---

## 📂 Setting Up Your Project Directory

Create a clean directory structure:

```bash
mkdir -p ~/Projects/my_R_projects
cd ~/Projects/my_R_projects

# Example project structure
mkdir -p project_name/{data,scripts,output,figures,docs}
```

---

## 🎓 Configure RStudio for Optimal Use

### Recommended Settings

**Tools → Global Options:**

1. **General**
   - ❌ Restore .RData into workspace at startup
   - ❌ Save workspace to .RData on exit
   - ✅ Always save history

2. **Code**
   - ✅ Soft-wrap R source files
   - ✅ Auto-indent code after paste
   - Tab width: 2 spaces
   - ✅ Insert spaces for Tab

3. **Appearance**
   - Choose your favorite theme (I use "Tomorrow Night")
   - Font: "Fira Code" or "Source Code Pro"
   - Font size: 11-13

4. **Pane Layout**
   - Customize to your preference
   - Recommended: Console bottom-left, Source top-left

---

## 📦 Essential Packages Overview

Run `essential_packages.R` to install all at once, or install selectively:

```r
# Data manipulation (MUST HAVE)
install.packages("tidyverse")  # Includes dplyr, ggplot2, tidyr, etc.

# Visualization
install.packages(c("ggplot2", "patchwork", "viridis"))

# Statistics
install.packages(c("lme4", "glmmTMB", "broom"))

# Utilities
install.packages(c("here", "janitor", "skimr"))

# Bioinformatics (optional)
BiocManager::install(c("GEOquery", "Biobase"))
```

---

## ✅ Post-Installation Checklist

- [ ] R installed and working
- [ ] RStudio installed and opens correctly
- [ ] Essential packages installed (run `essential_packages.R`)
- [ ] Can create plots with ggplot2
- [ ] Can load and manipulate data with dplyr
- [ ] (Optional) Git installed and configured
- [ ] Project directory created

---

## 🚀 Next Steps

Once everything is installed:

1. ✅ Run `essential_packages.R` to install all course packages
2. ✅ Read `project_structure.R` to learn project organization
3. ✅ Move to **Module 01: R Fundamentals**

---

## 📚 Additional Resources

- **R Documentation**: https://www.rdocumentation.org/
- **RStudio Cheatsheets**: https://posit.co/resources/cheatsheets/
- **CRAN Task Views**: https://cran.r-project.org/web/views/
- **R for Data Science (book)**: https://r4ds.had.co.nz/
- **Bioconductor**: https://www.bioconductor.org/

---

## 💡 Tips for Success

1. **Start with a clean workspace**: Always start R fresh, don't rely on saved workspaces
2. **Use projects**: RStudio Projects keep everything organized
3. **Learn keyboard shortcuts**:
   - `Ctrl/Cmd + Enter` - Run current line
   - `Ctrl/Cmd + Shift + M` - Pipe operator `%>%`
   - `Alt + -` - Assignment operator `<-`
4. **Read error messages**: They're usually helpful!
5. **Google is your friend**: "R how to..." is a valid search

---

**Installation complete!** 🎉

You're ready to start learning R. Proceed to `essential_packages.R` to install all course dependencies.
