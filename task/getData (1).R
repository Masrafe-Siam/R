library(TCGAbiolinks)
library(SummarizedExperiment)
library(dplyr)
library(tidyverse)
library(pheatmap)
library(maftools)


#geta a list of project
gdcproject <- getGDCprojects()
getProjectSummary('TCGA-BRCA')

#build a query to retrieve gene expression
query.TCGA <- GDCquery(project = c('TCGA-BRCA'), 
                       data.category = 'Transcriptome Profiling',
                       experimental.strategy = 'RNA-Seq',
                       workflow.type = 'STAR - Counts',
                       access = 'open',
                       barcode = c('TCGA-OL-A5D6-01A-21R-A27Q-07', 
                                   'TCGA-AN-A0FT-01A-11R-A034-07', 
                                   'TCGA-B6-A0RH-01A-21R-A115-07'))
getResults(query.TCGA)

#download data GDCdownloads

GDCdownload(query.TCGA)

dataExpression <- GDCprepare(query.TCGA)

clinicalData <- as.data.frame(colData(dataExpression))
expData <- as.data.frame(assay(dataExpression))
annotData <- as.data.frame(rowRanges(dataExpression))

write.csv(annotData, './Data/annotations.csv')
write.csv(expData, "./Data/expression.csv")



























