# Code Availability for Canine Mammary Tumor Publication


## Overview  
The code required to generate the profile metrics statistics is available in vignettes/canseq_prep.Rmd.  
To quickly view the expression profile for a homologous human gene you can use the plotSymbol() function. Ex:
```
library(CanineMammaryTumor)
plotSymbol('BRCA1')
```

You can enable this functionality by building the package or using devtools:

```
if (!require('devtools')) install.packages('devtools')
devtools::install_github('https://github.com/dimagor/CanineMammaryTumor')
```
