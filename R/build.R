library(purrr)
library(fs)
library(arrow)
library(readr)
library(dplyr)

tsub <- \(p,r){partial(gsub,pattern=p,replacement=r,ignore.case=T)}

deps <- dir_ls("download")
out  <- dir_create("data")
outs <- path(out,path_file(deps)) |> tsub("\\..*",".parquet")()

parse <- function(file){
  front <- readr::read_lines(file,n_max=100) |> head_while(~ grepl("^#",.))
  cols  <- dplyr::last(front) |> strsplit("\t") |> pluck(1) |> tsub("#","")()
  read_tsv(file,comment="#",col_names=F) |> `colnames<-`(cols)
}

# WRITE OUTS ===================================================================
fs::dir_ls(out) |> fs::file_delete() # delete old files
walk2(deps,outs, ~ parse(.x) |> write_parquet(.y))

# TESTS ========================================================================
map(dir_ls("data"),read_parquet) |> walk(~ if(ncol(.)<2){stop("parse failure")})
