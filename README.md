<a href="https://github.com/biobricks-ai/clinvar/actions"><img src="https://github.com/biobricks-ai/clinvar/actions/workflows/bricktools-check.yaml/badge.svg?branch=master"/></a>

# biobricks-ai/clinvar
**url**: https://www.ncbi.nlm.nih.gov/clinvar/

### biobricks install
biobricks-ai/clinvar is a [biobricks.ai brick](https://biobricks.ai) and can be installed with the [biobricks package](https://github.com/biobricks-ai/biobricks-R)
```R
biobricks::install_gh("biobricks-ai/clinvar")

cv <- biobricks::bake("clinvar") # 'bake' data w/ docker
ds <- biobricks::lazy(cv)        # 'lazy' load tables w/ arrow

# `ds` is a list with all the clinvar tables
# `var_citations` is a table mapping variants to pubmed
# `dplyr::collect` collects the table into ram
head(ds$var_citations) |> dplyr::collect()
```
```
# AlleleID source citation ...
#    <dbl> <chr>  <chr>      
#    15043 PubMed 26123727   
#    15044 PubMed 30723688   
...
```
