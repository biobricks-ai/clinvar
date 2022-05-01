library(purrr)
library(rvest)
library(fs)

options(timeout=1800) # download timeout

clinvar <- 'https://ftp.ncbi.nlm.nih.gov/pub/clinvar/tab_delimited'
href    <- read_html(clinvar) |> html_elements("a") |> html_attr("href")
tbls    <- href |> keep(~ path_ext(.) %in% c("tsv","txt","gz")) 
urls    <- path(clinvar,tbls)

# OUTS ====================================================================
files <- dir_create("download") |> fs::path(tbls)
walk2(urls,files,download.file)
