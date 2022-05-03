# biobricks-ai/clinvar
**url**: https://www.ncbi.nlm.nih.gov/clinvar/

### biobricks install
biobricks-ai/clinvar is a [biobricks.ai brick](https://biobricks.ai) and can be installed with the [biobricks package](https://github.com/biobricks-ai/biobricks-R)
```R
biobricks::install_gh("biobricks-ai/clinvar")

cv <- biobricks::bake("clinvar") # 'bake' data w/ docker
ds <- biobricks::lazy(cv)        # 'lazy' load tables w/ arrow

# var_cit joins variants to pubmed
ds$var_citations |>   # autocomplete on table names
  dplyr::collect() |> # dplyr integration
  head()
```
```
# AlleleID source citation ...
#    <dbl> <chr>  <chr>      
#    15043 PubMed 26123727   
#    15044 PubMed 30723688   
#    15046 PubMed 23553477   
#    15046 PubMed 26633545   
#    15046 PubMed 20818383   
#    15046 PubMed 22072591   
```
