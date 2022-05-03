---
title: clinvar
namespace: clinvar
description: ClinVar aggregates information about genomic variation and its relationship to human health.
dependencies: 
  - name: clinvar
    url: https://www.ncbi.nlm.nih.gov/clinvar/
---

## Description
 - This directory contains data obtained from Clinvar. 
 - The data is stored in parquet format. Descriptions for columns for each of the clinvar data tables are listed below. Each data table has unique column names. 
 - The data was obtained from the following link https://ftp.ncbi.nlm.nih.gov/pub/clinvar/tab_delimited/special_requests/clinical_significance_updates.txt
 
#### Data Table List:
- `allele_gene.parquet`
- `organization_summary.parquet`
- `variant_summary.parquet`
- `cross_references.parquet`
- `submission_summary.parquet`
- `variation_allele.parquet`
- `gene_specific_summary.parquet`
- `summary_of_conflicting_interpretations.parquet`
- `hgvs4variation.parquet`
- `var_citations.parquet`

### Allele_gene
- AlleleID: the integer identifier assigned by ClinVar to each simple allele
- GeneID: integer, GeneID in NCBI's Gene database  
- Symbol: character, Symbol preferred in NCBI's Gene database. Is the symbol from HGNC when available
- Name: character, full name of the gene
- GenesPerAlleleID: integer, number of genes related to the allele
- Category: character, type of allele-gene relationship
- Source: character, was the relationship submitted or calculated?

### gene_specific_summary
Shows the gene list,the number of submissions and the different alleles  
- *Symbol*: Gene symbol (if officially named, from HGNC, else from NCBI's Gene database)
- *Total_submissions*: Total submissions to ClinVar with variants in/overlapping this gene
- *GeneID*: Unique identifier from  NCBI's Gene database
- *Total_alleles* : Number of alleles submitted to ClinVar for this gene
- *Submissions_reporting_this_gene*: Subset of the total submissions that also reported the gene
- *Alleles_reported_Pathogenic_Likely_pathogenic*: Number of variants reported as pathogenic or likely pathogenic. Excludes structural variants that may overlap a gene
- *Gene_MIM_Number*:  The MIM number for this gene
- *Number_Uncertain*: Submissions with an interpretation of 'Uncertain significance'
- *Number_with_conflicts*:  Number of VariationIDs for this gene with conflicting interpretations
### variant_summary ( Located in ``data/variant_summary/``
*Note: These files are split into file chunks due to size*. Files are named with prefix ``combined_variant_``
* Contains variant information and the genomic position for each variant submitted to clinvar.
* Variants have coordinates listed for hg19 and hg38
* VariationID and AlleleID information per variant can be found in the ``data/clinvar_variant_data/`` and ``data/clinvar_hgvs_data``
* This data is split into ~ 3 file chunks due to size. Each separate file has it's own header

### cross_references
* **Overview** Generated on a weekly basis and indicates supports for clinical significance of variants located in other databases. 
* *AlleleID*:  integer value as stored in the AlleleID field in ClinVar  (//Measure/@ID in the XML)
* *Database*:  name of the database
* *ID* : identifier used by that database
* *last_updated*:  date the identifier /AlleleID relationship was created or last updated

### var_citations
 * Weekly generated report of citations associated with data in clinvar
AlleleID integer value as stored in the AlleleID field in ClinVar  (//Measure/@ID in the XML)
 * *VariationID*:  The identifier ClinVar uses to anchor its default display. (in the XML,  //MeasureSet/@ID)
 * *rs*: rs identifier from dbSNP, null if missing
 * *nsv*:  nsv identifier from dbVar, null if missing
 * *citation_source*:  The source of the citation, either PubMed, PubMedCentral, or the NCBI Bookshelf
 * *citation_id*:  The identifier used by that source

### summary_of_conflicting_interpretations.txt
* Reports conflicting interpretations with respect to the variant. Doesn't report conflicting interpretations with respect to the phenotype.
* *Gene_Symbol*:  If in a gene, its symbol
* *NCBI_Variation_ID*: The identifier ClinVar uses to anchor its default display. (in the XML,  //MeasureSet/@ID)
* *ClinVar_Preferred*  The preferred description ClinVar uses for this VariationID │
* *Submitter1* Name of this submitter 
* *Submitter1_SCV* Accession assigned to this submission
* *Submitter1_ClinSig* Clinical signficance asserted by this submitter 
* *Submitter1_LastEval*  Date last evaluated by this submitter 
* *Submitter1_ReviewStatus* : Review status of this submission 
* *Submitter1_Sub_Condition*: Submitted name of condition 
* *Submitter1_Description*: Description of the interpretation
* *Submitter2*: Name of this submitter 
* *Submitter2_SCV*: Accession assigned to this submission
* *Submitter2_ClinSig*: Clinical significance asserted by this submitter
* *Submitter2_LastEval*:  Date last evaluated by this submitter
* *Submitter2_ReviewStatus*:  Review status of this submission
* *Submitter2_Sub_Condition*: Submitted name of condition
* *Submitter2_Description*: Description of the interpretation
* *Rank_diff*:  Rank value assigned to the differences in interpretation: -1: one of the interpretations is not in the set of Pathogenic; Pathogenic, low penetrance; Established risk allele;Likely pathogenic; Likely pathogenic, low penetrance; Likely risk allele; Uncertain significance; Uncertain risk allele; Likely benign; Benign 1-4, difference when both interpretations are in the set of Pathogenic; Pathogenic, low penetrance; Established risk allele; Likely pathogenic; Likely pathogenic, low penetrance; Likely risk allele; Uncertain significance;Uncertain risk allele; Likely benign; Benign
* *Conflict_Reported*:  yes or no.  Useful to supplement the Rank_diff column when Rank_diff = 1 but a conflict is still reported.
* *Variant_Type*: the type of variant being described
* *Submitter1_Method*:  the collection method(s) reported by this submitter
* *Submitter2_Method*:  the collection method(s) reported by this submitter

### hgvs4variation.txt.gz
* hgvs expressions reported by ClinVar based on variation and allele IDs
* Column information is included in the file header
* *GeneSymbol*: the offical symbol from HGNC for the gene in which this allele is found.  Will be null if the variant is intergenic or spans multiple genes.
* *GeneID*: NCBI's identfier for the gene in which this allele is found.  Will be null if the variant is intergenic or spans multiple genes.
* *VariationID*:  the identifier assigned by ClinVar and used to build the URL, namely https://ncbi.nlm.nih.gov/clinvar/VariantID
* *AlleleID*: the identifier assigned by ClinVar to the simple allele. Will be null if the allele is complex.
* *Type*:  the type of HGVS expression
* *Assembly*:  reported only for assembly-specific HGVS expressions
* *NucleotideExpression*:  an HGVS expression based on a nucleotide sequence; may be null if the allele is defined only by a protein change
* *NucleotideChange*:  the subset of the NucleotideExpression in the previous column representing the sequence change
* *ProteinExpression*: an HGVS expression based on a protein sequence; if NucleotideExpression is provided, then represents the translation of nucleotide change
* *ProteinChange*: the subset of the ProteinExpression in the previous column representing the sequence change
* *UsedForNaming*: the accession in this HGVS expression is used to report a name in ClinVar. Values are Yes or No.
* *Submitted*: this HGVS expression was used by a submitter. Values are Current or Previous (provided in a previous version of a submission (SCV accession) but not in a current SCV or current version of an SCV)
* *OnRefSeqGene* : the accession in this HGVS expression is annotated on a RefSeqGene

### Submission_summary
* Overview of phenotypes, observations and interpretations
* Table includes VariationID and ClinicalSignificance
1.  *VariationID*:  the identifier assigned by ClinVar and used to build the URL, namely https://ncbi.nlm.nih.gov/clinvar/VariationID
2.  *ClinicalSignificance*: interpretation of the variation-condition relationship
3.  *DateLastEvaluated*:  the last date the variation-condition relationship was evaluated by this submitter
4.  *Description*:  an optional free text description of the basis of the interpretation
5.  *SubmittedPhenotypeInfo*: the name(s) or identifier(s)  submitted for the condition that was interpreted relative to the variant
6.  *ReportedPhenotypeInfo*:  the MedGen identifier/name combinations ClinVar uses to report the condition that was interpreted.'na' means there is no public identifier in MedGen for the condition.
7.  *ReviewStatus*: the level of review for this submission, namely http://www.ncbi.nlm.nih.gov/clinvar/docs/variation_report/#review_status
8.  *CollectionMethod*: the method by which the submitter obtained the information provided
9.  *OriginCounts*: the reported origin and the number of observations for each origin
10. *Submitter*:  the submitter of this record
11. *SCV*:  the accession and current version assigned by ClinVar to the submitted interpretation of the variation-condition relationship
12. *SubmittedGeneSymbol*:  the symbol provided by the submitter for the gene affected by the variant. May be null.
13. *ExplanationOfInterpretation*:  the submitter's preferred term for the interpretation when ClinicalSignificance is submitted as 'other' or 'drug response'. May be null.

### Organization_summary
organization : the name of the lab and the institution of which it is part	
organization ID: the id used in ClinVar and GTR; often reported as OrgID; append to https://www.ncbi.nlm.nih.gov/clinvar/submitters to review more details
institution type: type of organization
street address: street address
country: country
number of ClinVar submissions: number of submission to ClinVar
date last submitted: last date on a public submission from this organization
maximum review status: the 'most stars' valid for any submission from this organization
collection methods: comma-delimited list of methods used to determine information for the submission
novel and updates :values are novel, novel and updates.  The latter indicates the submitter has provided updates.
clinical significance categories submitted:  list of types of interpretations from this organization
number of submissions from clinical testing: number of submissions for the list of categories in 'collection methods'
number of submissions from research: number of submissions for the list of categories in 'collection methods'
number of submissions from literature only: number of submissions for the list of categories in 'collection methods'
number of submissions from curation: number of submissions for the list of categories in 'collection methods'
number of submissions from phenotyping: number of submissions for the list of categories in 'collection methods'
### variation_allele
Mapping of ClinVar's VariationID (used to build the URL on the web site) and the AlleleIDs assigned to each simple variant.
1. VariationID: the identifier assigned by ClinVar and used to build the URL, namely https://ncbi.nlm.nih.gov/clinvar/VariationID
2. Type: Types of VariationID include Variant (simple variant), Haplotype, CompoundHeterozygote, Complex, Phase unknown, Distinct chromosomes
3. AlleleID: the integer identifier assigned by ClinVar to each simple allele
4. Interpreted: yes_ indicates an interpretation was submitted about the VariationID specifically, _no_ indicates that information about the VariationID was submitted as a component of a different record.
### HGVS_summary
 - A tab-delimited file of HGVS transcript expressions based on RefSeqs
 - *NCBI*: GeneID
 - *HGNC*: Gene symbol
 - *ClinVar VariationID*:  (What is used to build the URL)
 - *ClinVar AlleleID* : (The identifier for a simple variant)
 - *HGVS coding*
 - *coding change*
 - *HGVS protein*
 - *protein change*
### clinical_significance_updates
mset_id: set ID
variant_name: Based on RefSeq and variant coordinates	
previous_value: Indicates previous prediction of level of pathogenicity/benign/Uncertain significance	
current_value: Indicates current prediction of level of pathogenicity/benign/Uncertain significance
date_modified
### molecular_consequences
This file contains the HGVS expression, the Sequence Ontology identifier, and the value calculated for the molecular consequence of that HGVS expression.
## Data Retrieval
* Data on the ftp website are updated on a weekly/monthly basis. 
https://ftp.ncbi.nlm.nih.gov/pub/clinvar/tab_delimited

### Data stored in Parquet files
* Data can be downloaded using the following commands. To retrieve the data, make sure that dvc is downloaded

**Retrieving a single file**
```
dvc get git@github.com:insilica/oncindex-bricks.git bricks/clinvar/data/allele_gene.txt.parquet -o data/allele_gene.txt.parquet
```
**Retrieving a folder**
```
dvc get git@github.com:insilica/oncindex-bricks.git bricks/clinvar/data/variant_summary -o data/variant_summary
```
**It is advised to import files into a project so that you will be able to track changes in the data set**
```
dvc import git@github.com:insilica/oncindex-bricks.git bricks/clinvar/data/variant_summary -o data/variant_summary
```
