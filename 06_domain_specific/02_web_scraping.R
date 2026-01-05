# ========================================================================
# Module 06: Domain-Specific Skills - Web Scraping for Research Data
# ========================================================================
#
# Learning Objectives:
#   - Scrape data from web pages using rvest
#   - Make API requests with httr
#   - Query biological databases (GEO)
#   - Automate data collection workflows
#   - Handle rate limiting and errors gracefully
#
# Estimated time: 3-4 hours
# Difficulty: Advanced
#
# NOTE: This module is inspired by the GEO scraping workflow
#       from the Brain_Blast dataset curation project
#
# ========================================================================

library(tidyverse)
library(rvest)      # Web scraping
library(httr)       # HTTP requests
library(xml2)       # XML parsing
library(progress)   # Progress bars

# ========================================================================
# 1. WEB SCRAPING BASICS WITH RVEST
# ========================================================================

# Scraping workflow:
#   1. Read HTML
#   2. Select elements (CSS selectors or XPath)
#   3. Extract data
#   4. Clean and structure

# Example: Scrape a simple table (hypothetical)
scrape_example_table <- function(url) {
  tryCatch({
    # Read HTML
    page <- read_html(url)

    # Extract table
    table <- page %>%
      html_element("table") %>%
      html_table()

    return(table)
  }, error = function(e) {
    message("Error scraping: ", e$message)
    return(NULL)
  })
}

# ========================================================================
# 2. CSS SELECTORS
# ========================================================================

# Common CSS selectors:
#   tag           - Select by tag name (e.g., "div", "table")
#   .class        - Select by class
#   #id           - Select by ID
#   [attribute]   - Select by attribute
#   parent child  - Descendant selector

# Example: Extract specific elements
extract_metadata <- function(html) {
  # Title
  title <- html %>%
    html_element("h1.title") %>%
    html_text()

  # Links
  links <- html %>%
    html_elements("a") %>%
    html_attr("href")

  # Table data
  data <- html %>%
    html_elements("table.data tr") %>%
    html_text()

  list(title = title, links = links, data = data)
}

# ========================================================================
# 3. SCRAPING GEO DATABASE (REAL RESEARCH EXAMPLE)
# ========================================================================

# This pattern is from the Brain_Blast project!
# NCBI GEO (Gene Expression Omnibus) is a public repository

# Function to scrape GEO series information
scrape_geo_series <- function(gse_id) {
  # Construct URL
  url <- sprintf("https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=%s", gse_id)

  tryCatch({
    # Read page
    page <- read_html(url)

    # Extract metadata
    title <- page %>%
      html_element("td:contains('Title')") %>%
      html_text(trim = TRUE)

    summary <- page %>%
      html_element("td:contains('Summary')") %>%
      html_text(trim = TRUE)

    organism <- page %>%
      html_element("td:contains('Organism')") %>%
      html_text(trim = TRUE)

    # Create structured result
    result <- data.frame(
      gse_id = gse_id,
      title = title,
      summary = summary,
      organism = organism,
      stringsAsFactors = FALSE
    )

    return(result)

  }, error = function(e) {
    warning(sprintf("Failed to scrape %s: %s", gse_id, e$message))
    return(NULL)
  })
}

# Example usage (commented out to avoid actual web requests)
# scrape_geo_series("GSE12345")

# ========================================================================
# 4. BATCH SCRAPING WITH PROGRESS TRACKING
# ========================================================================

# Scrape multiple GEO series with progress bar
# This is the pattern used in Brain_Blast for dataset curation!

scrape_multiple_geo <- function(gse_ids, delay = 1) {
  # Create progress bar
  pb <- progress_bar$new(
    format = "[:bar] :percent :current/:total ETA: :eta",
    total = length(gse_ids)
  )

  results <- list()

  for (i in seq_along(gse_ids)) {
    gse <- gse_ids[i]

    # Scrape data
    result <- scrape_geo_series(gse)
    results[[gse]] <- result

    # Update progress
    pb$tick()

    # Respectful delay (avoid overwhelming server)
    Sys.sleep(delay)
  }

  # Combine results
  bind_rows(results)
}

# Example: Scrape multiple datasets
# gse_list <- c("GSE12345", "GSE12346", "GSE12347")
# geo_data <- scrape_multiple_geo(gse_list, delay = 2)

# ========================================================================
# 5. API REQUESTS WITH HTTR
# ========================================================================

# Many databases provide APIs (better than scraping!)

# Basic GET request
make_api_request <- function(url) {
  response <- GET(url)

  # Check status
  if (status_code(response) == 200) {
    # Parse JSON response
    content <- content(response, as = "parsed")
    return(content)
  } else {
    stop(sprintf("Request failed with status: %d", status_code(response)))
  }
}

# Example: NCBI E-utilities API
query_ncbi_esearch <- function(term, database = "gds", retmax = 100) {
  base_url <- "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi"

  response <- GET(
    base_url,
    query = list(
      db = database,
      term = term,
      retmax = retmax,
      retmode = "json"
    )
  )

  if (status_code(response) == 200) {
    content(response, as = "parsed")
  } else {
    NULL
  }
}

# ========================================================================
# 6. HANDLING RATE LIMITS
# ========================================================================

# Implement exponential backoff for rate limiting

api_request_with_retry <- function(url, max_attempts = 3) {
  attempt <- 1
  delay <- 1

  while (attempt <= max_attempts) {
    response <- GET(url)

    if (status_code(response) == 200) {
      return(content(response, as = "parsed"))
    } else if (status_code(response) == 429) {
      # Rate limited
      message(sprintf("Rate limited. Waiting %d seconds...", delay))
      Sys.sleep(delay)
      delay <- delay * 2  # Exponential backoff
      attempt <- attempt + 1
    } else {
      stop(sprintf("Request failed: %d", status_code(response)))
    }
  }

  stop("Max retry attempts reached")
}

# ========================================================================
# 7. GEOQUERY: SPECIALIZED PACKAGE FOR GEO
# ========================================================================

# For real GEO data, use the GEOquery package!
# This is much more reliable than scraping

library(GEOquery)  # Bioconductor package

# Example function using GEOquery (from Brain_Blast pattern)
collect_geo_metadata <- function(gse_ids) {
  results <- map_dfr(gse_ids, ~{
    tryCatch({
      # Download GEO metadata
      gse <- getGEO(.x, GSEMatrix = FALSE)

      # Extract metadata
      data.frame(
        gse_id = .x,
        title = Meta(gse)$title,
        summary = Meta(gse)$summary,
        organism = Meta(gse)$organism,
        n_samples = length(GSMList(gse)),
        stringsAsFactors = FALSE
      )
    }, error = function(e) {
      NULL
    })
  })

  return(results)
}

# ========================================================================
# 8. COMPLETE WORKFLOW: AUTOMATED DATA COLLECTION
# ========================================================================

# Real-world pattern from Brain_Blast dataset curation

collect_scRNA_seq_data_information <- function(
  search_terms,
  organism = "Mus musculus",
  from_year = "2020",
  max_datasets = 1000
) {

  cat("Step 1: Searching NCBI GEO...\n")

  # Build search query
  query <- paste(
    search_terms,
    sprintf("AND \"%s\"[Organism]", organism),
    sprintf("AND %s:3000[Publication Date]", from_year),
    "AND \"Expression profiling by high throughput sequencing\"[DataSet Type]"
  )

  # Search via API
  search_results <- query_ncbi_esearch(query, retmax = max_datasets)

  if (is.null(search_results)) {
    stop("Search failed")
  }

  gse_ids <- search_results$esearchresult$idlist

  cat(sprintf("Found %d datasets\n", length(gse_ids)))
  cat("Step 2: Collecting metadata...\n")

  # Collect metadata for each dataset
  metadata <- collect_geo_metadata(gse_ids)

  cat(sprintf("Successfully collected %d datasets\n", nrow(metadata)))

  return(metadata)
}

# Example usage (commented out):
# data <- collect_scRNA_seq_data_information(
#   search_terms = "single cell RNA-seq hippocampus",
#   organism = "Mus musculus",
#   from_year = "2020"
# )

# ========================================================================
# 9. DATA CLEANING AFTER SCRAPING
# ========================================================================

# Scraped data is often messy - clean it!

clean_scraped_data <- function(raw_data) {
  raw_data %>%
    mutate(
      # Remove extra whitespace
      title = str_trim(title),
      # Clean organism names
      organism = str_replace(organism, "\\s+", " "),
      # Extract year from date
      year = as.numeric(str_extract(publication_date, "\\d{4}")),
      # Convert to factors
      organism = as.factor(organism)
    ) %>%
    # Remove duplicates
    distinct(gse_id, .keep_all = TRUE) %>%
    # Remove NA rows
    filter(!is.na(title))
}

# ========================================================================
# 10. ETHICAL CONSIDERATIONS
# ========================================================================

# When scraping:
#   ✓ Check robots.txt
#   ✓ Use appropriate delays (1-2 seconds)
#   ✓ Use official APIs when available
#   ✓ Cache results to avoid repeated requests
#   ✓ Identify yourself with User-Agent
#   ✓ Respect rate limits

# Set user agent
my_user_agent <- user_agent("MyResearchProject/1.0 (contact@email.com)")

polite_get <- function(url) {
  Sys.sleep(1)  # Respectful delay
  GET(url, my_user_agent)
}

# ========================================================================
# KEY TAKEAWAYS
# ========================================================================

cat("\n")
cat("========================================\n")
cat("Key Takeaways: Web Scraping\n")
cat("========================================\n")
cat("\n")
cat("1. Use rvest for HTML scraping\n")
cat("2. Use httr for API requests\n")
cat("3. Prefer official APIs over scraping\n")
cat("4. Always add delays between requests\n")
cat("5. Handle errors gracefully with tryCatch()\n")
cat("6. Use progress bars for long operations\n")
cat("7. Clean scraped data before analysis\n")
cat("8. Be respectful of server resources\n")
cat("\n")
cat("This workflow is used in the Brain_Blast project\n")
cat("for automated dataset curation from GEO!\n")
cat("\n")

# ========================================================================
# EXERCISES
# ========================================================================

# Exercise 1: Write a function to scrape a public dataset repository
# Include error handling and rate limiting
# Your answer:

# Exercise 2: Create a progress bar for batch processing
# Process 10 items with a 1-second delay between each
# Your answer:

# Exercise 3: Use GEOquery to download metadata for 5 GEO series
# Extract title, organism, and number of samples
# Your answer:

# Solutions: 06_domain_specific/exercises/solutions_02.R
