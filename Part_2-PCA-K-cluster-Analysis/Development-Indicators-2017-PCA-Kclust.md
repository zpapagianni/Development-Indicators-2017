Development Indicators 2017-Part 2
================

# Clustering

The observations within our data are categorised by income and the
region they belong to. The observations belonging to the same categories
seem to present similar patterns and share a similar marginal
distribution, apart from access to Electricity. To identify the possible
set of subgroups, we’re going to reduce the dimension of our dataset to
assist in finding any clustering behaviour that is less apparent in high
dimensions. Moreover, we’re going to test K-means clustering, which is
another method often used for splitting a dataset into a set of n
groups.

First, we’re going to generate a two-dimensional visualization using
generalised pairs plot for our data and density estimation using contour
plots. We can’t see any apparent subgroups from the output.
<img src="Development-Indicators-2017-PCA-Kclust_files/figure-gfm/Fig23-1.png" title="\label{fig:fig23} Income Categories" alt="\label{fig:fig23} Income Categories" style="display: block; margin: auto;" />
\## Principal Compoment Analysis As a first step, we standardize the
data scale, implement PCA, and get the corresponding eigenvalues of each
PC. If our data is well suited for PCA we should be able to discard
these components while retaining at least 80% of the cumulative
variance. The cumulative variance of the two first principals is equal
to 61.4%, as shown in the results below.

``` r
# Compute data with principal components ------------------
pca_devinc <- prcomp(num.data, center = TRUE, scale. = TRUE)  # compute principal components
#Create dataframe with the two first principal components 
df_pc<-data.frame(PC1=pca_devinc$x[,1],PC2=pca_devinc$x[,2],income=dev.inc$income,region=dev.inc$region)
#Create dataframe with the 4 first principal components to use for k-clustering
pc_clust<-data.frame(PC1=pca_devinc$x[,1],PC2=pca_devinc$x[,2],PC3=pca_devinc$x[,3],PC4=pca_devinc$x[,4])
#Cumulative proportion
cumsum_evalues <- cumsum(pca_devinc$sdev^2)
sum_evalues <- sum(pca_devinc$sdev^2)
#Print results
cat("Proportion of variance across top k PCs:",cumsum_evalues/sum_evalues,"\n")
```

    ## Proportion of variance across top k PCs: 0.4338089 0.6137969 0.7534622 0.8520074 0.9078906 0.9602236 0.9793526 0.9903847 0.9977952 1

Next we’re going to visualise the results.The scree plot in the center
shows that the first 4 components explain more than 0.1 of the
variances. As a result, if we want to reduce dimensionality by losing
only a small proportion of variance, we should choose the first 4 PCs,
which account for 85.2% of the proportion of variance.
<img src="Development-Indicators-2017-PCA-Kclust_files/figure-gfm/Fig24-1.png" title="\label{fig:fig24} Income Categories" alt="\label{fig:fig24} Income Categories" style="display: block; margin: auto;" /><img src="Development-Indicators-2017-PCA-Kclust_files/figure-gfm/Fig24-2.png" title="\label{fig:fig24} Income Categories" alt="\label{fig:fig24} Income Categories" style="display: block; margin: auto;" />
The below graph depicts the projection in two dimensions and groupings
based on the income category provided in the original dataset. The graph
on the left is organized by region, and we can see there are no
subgroups within the observations. The graph on the right is organized
by income. We can see that the upper middle income and high-income
categories are overlapping, and thus we can distinguish only two
subgroups. We may need to use more principal components in order to
achieve better clustering since the first two PCs account for a small
portion of the variance.
<img src="Development-Indicators-2017-PCA-Kclust_files/figure-gfm/Fig25-1.png" title="\label{fig:fig25} Income Categories" alt="\label{fig:fig25} Income Categories" style="display: block; margin: auto;" /><img src="Development-Indicators-2017-PCA-Kclust_files/figure-gfm/Fig25-2.png" title="\label{fig:fig25} Income Categories" alt="\label{fig:fig25} Income Categories" style="display: block; margin: auto;" /><img src="Development-Indicators-2017-PCA-Kclust_files/figure-gfm/Fig25-3.png" title="\label{fig:fig25} Income Categories" alt="\label{fig:fig25} Income Categories" style="display: block; margin: auto;" />

## K-means Clustering

Next we will perform k-means clustering on the original data set. In
order to determine the number of clusters, we run the algorithm with for
different number of them. Then, we determine the Within Cluster Sum of
Squares or WCSS and for each solution. Based on the values of the WCSS
and an approach known as the Elbow method, we determine how many
clusters we’d like to keep.In this instance, the WSS shows a clear elbow
at k=2.

``` r
#Best method
wss<-fviz_nbclust(num.data, kmeans, method = "wss")
wss
```

<img src="Development-Indicators-2017-PCA-Kclust_files/figure-gfm/unnamed-chunk-2-1.png" style="display: block; margin: auto;" />
As a result we conclude that the optimum number of clusters is equal to
2 but out of interest we’re going to visualize the results for 2,3 and
for clusters. Tables 1–3 show which points from each category are
assigned to which clusters.
<img src="Development-Indicators-2017-PCA-Kclust_files/figure-gfm/Fig27-1.png" title="\label{fig:fig27} Income Categories" alt="\label{fig:fig27} Income Categories" style="display: block; margin: auto;" />
The tables below show which points from each category are assigned to
which clusters.
<table>
<thead>
<tr>
<th style="text-align:right;">
High income
</th>
<th style="text-align:right;">
Lower middle income
</th>
<th style="text-align:right;">
Upper middle income
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">
15
</td>
<td style="text-align:right;">
15
</td>
<td style="text-align:right;">
20
</td>
</tr>
<tr>
<td style="text-align:right;">
18
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0
</td>
</tr>
</tbody>
</table>
<table>
<thead>
<tr>
<th style="text-align:right;">
High income
</th>
<th style="text-align:right;">
Lower middle income
</th>
<th style="text-align:right;">
Upper middle income
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">
11
</td>
<td style="text-align:right;">
15
</td>
<td style="text-align:right;">
20
</td>
</tr>
<tr>
<td style="text-align:right;">
7
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0
</td>
</tr>
<tr>
<td style="text-align:right;">
15
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0
</td>
</tr>
</tbody>
</table>
<table>
<thead>
<tr>
<th style="text-align:right;">
High income
</th>
<th style="text-align:right;">
Lower middle income
</th>
<th style="text-align:right;">
Upper middle income
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">
15
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
2
</td>
</tr>
<tr>
<td style="text-align:right;">
4
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0
</td>
</tr>
<tr>
<td style="text-align:right;">
14
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0
</td>
</tr>
<tr>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
15
</td>
<td style="text-align:right;">
18
</td>
</tr>
</tbody>
</table>

As we can see when k=2, all points are in the first cluster apart from
18 from the high-income category. The same happens when k=3, where again
some points from high income are being put in wrong clusters. Finally,
we observe that even when k=4, the observations are not grouped
correctly. We conclude that there are possibly two cluster in which we
can group our observations which is not determined by the income
category or region.

## K-means Clustering on PCA data

In this istance we combine PCA and K-means to segment our data, where we
use the scores obtained by the PCA for the fit. First, we need to
determine the optimal number of clusters.
<img src="Development-Indicators-2017-PCA-Kclust_files/figure-gfm/unnamed-chunk-4-1.png" style="display: block; margin: auto;" />
In this instance, it seems like the optimal number of clusters is 3.

<img src="Development-Indicators-2017-PCA-Kclust_files/figure-gfm/unnamed-chunk-5-1.png" style="display: block; margin: auto;" />
The green cluster is clearly visually separated from the rest. The
remaining two clusters are slightly overlapping. The spots where the two
overlap are ultimately determined by the third and fourth component,
which is not available on this graph.
