# Development Indicators 2017
### Principal Compoment Analysis and K-Clustering

## Description

The purpose of this project is to delve into the World Bank's data,available at [https://data.worldbank.org/1], which contains the 2017 values of a selection of 'global development indicators' for 68 countries.The goal of this study is to assess and compare the development indicators of each country, investigate correlations between different indicators, and identify possible homogeneity between countries. This report begins by assessing the data's quality before proceeding to a univariate and multivariate analysis. This will be used to aid in determining any clustering behaviour, which will then be investigated further using various dimension reduction and clustering methods.

The project is divided into two sections:
* Exploratory data analysis
  Structure
  Qualtity of Data
*Exploration of the univariate and multivariate distribution
_Univariate Analysis
_Multivariate Analysis
* Cluster Analysis.
_ Correlation Analysis.
_ Principal Compoment Analysis.
_ K-means Clustering.
_ K-means Clustering on PCA data.

Here are the important files (the remaining files should be ignored):
* [Development-Indicators-2017-Visualisation-Report.md](./Part_1-EDA-Visualisation//Development-Indicators-2017-Visualisation-Report.md:: The github markdown document which contain the detailed step of the above analysis.
* [Development-Indicators-2017-Visualisation-Report.Rmd](./Part_1-EDA-Visualisation/Development-Indicators-2017-Visualisation.Rmd):The rmarkdown file that contains the detailed step of the explaratory analysis and visualisation.
* [Development-Indicators-2017-PCA-Kclust.Rmd](./Part_2-PCA-K-cluster Analysis/Development-Indicators-2017-PCA-Kclust.Rmd):The rmarkdown file that contains the detailed steps followed in the  principal compoments and cluster analysis.
* [Development-Indicators-2017-PCA-Kclust.md](./Part_2-PCA-K-cluster Analysis/Development-Indicators-2017-PCA-Kclust.md:: The github friendly document which contain the detailed step of the above analysis.
* [Development-Indicators-2017.R](./Development-Indicators-2017.R): Contains the code that was used for the analysis.
* [data.csv](./data.csv): Input data.

## Environment

* [Rstudio]([https://www.rstudio.com/])

## Requirements

* [R version 4.1.1 (2021-08-10)](https://www.r-project.org/)

## Dependencies

Choose the latest versions of any of the dependencies below:
* dplyr
* ggplot2
* tidyverse
* tseries
* irlba
* RColorBrewer
* randomForest
* ggcorrplot
* corrplot
* PerformanceAnalytics
* gbm
* leaflet
* stats

## License

MIT. See the LICENSE file for the copyright notice.
