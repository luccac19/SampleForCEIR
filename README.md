# Sample Code
---
This repository contains selected code from my work on turnout in tribal elections. It largely omits the code that was used to construct a dataframe of tribal characteristics, as all that was required was largely a series of joins and some manual data entry. Rather, it includes code for building apps to explore data quickly, processing collected election results, conducting statistical modeling, and creating some basic visualizations. 

## 📁 Contents

1. [Constitution Search App](./ConstitutionSearchApp.R)
  contains code for a shiny app I developed that allows a user to search the text of 97 tribal constitutions from *Measuring institutional variation across American Indian constitutions using automated content analysis* (2020). This tool allows for quick coding of a variety of tribal constitutional institutions including voting age, residency requirements, and blood quantum. However, there are many tribal constitutions now available online that are not included in this dataset.

3. [Pre-processing](./Pre-Processing.Rmd) contains the code to process collected election results and merge tribal characteristics data with election results.

4. [Displacement](./AddingDisplacement.Rmd) contains the code to calculate distances of displacement using data from Farrell et al. 2021.

5. [Analysis](./CEIRSample.Rmd)  
   contains the code to create the analysis tables used in the write-up.

6. [Subheading 5](./file5.md)  
   Brief description of what this file contains
