Development Indicators 2017-Part 1
================

-   <a href="#introduction" id="toc-introduction">Introduction</a>
-   <a href="#exploratory-data-analysis"
    id="toc-exploratory-data-analysis">Exploratory data analysis</a>
    -   <a href="#structure" id="toc-structure">Structure</a>
    -   <a href="#qualtity-of-data" id="toc-qualtity-of-data">Qualtity of
        Data</a>
        -   <a href="#missing-values" id="toc-missing-values">Missing Values</a>
        -   <a href="#outliers-and-errors" id="toc-outliers-and-errors">Outliers and
            Errors</a>
    -   <a href="#univariate-analysis" id="toc-univariate-analysis">Univariate
        Analysis</a>
        -   <a href="#income-categories" id="toc-income-categories">Income
            Categories</a>
        -   <a href="#unemployement-by-gender"
            id="toc-unemployement-by-gender">Unemployement by gender</a>
        -   <a href="#mortality" id="toc-mortality">Mortality</a>
        -   <a href="#access-to-electricity-map"
            id="toc-access-to-electricity-map">Access to electricity Map</a>
        -   <a href="#arable-land-map" id="toc-arable-land-map">Arable Land Map</a>

# Introduction

This project sets out to explore the data published by the World Bank at
<https://data.worldbank.org/1>, which contains the 2017 values of a
selection of ‘global development indicators’ for 68 countries. Each
observation in this dataset corresponds to a single country, and most of
the variables correspond to a development indicator. In particular, the
data contains 14 variables:

-   `country` : Name of country.
-   `region` : Geographical region.
-   `income` : Income category, as specified by the World Bank.
-   `GDP.percap` : GDP per capita (current USD).
-   `Market.Cap.pcntGDP` : Market capitalization of domestic listed
    companies (% of GDP).
-   `Unemployment.female` : Unemployment, female (% of female labour
    force) .
-   `Unemployment.male` : Unemployment, male (% of male labour force).
-   `Education.Expend` : Government expenditure on education, total (%
    of GDP).
-   `Arable.Land.pcnt` : Arable Land (% of land area).
-   `Life.Expect.female` : Life expectancy at birth.
-   `Life.Expect.male` : Life expectancy at birth, male (years).
-   `Mortality.u5` : The number of children who die by the age of 5
    years, per 1000 live births.
-   `CO2.emiss.mtpercap` : CO2 emissions (metric tons per capita).
-   `Access2Elec.pcnt` : Access to electricity (% of population).

# Exploratory data analysis

## Structure

Our dataset has 68 observations and 14 variables as mentioned above. The
first three variables are characters while the rest of the variables are
continuous numeric values.

``` r
#High-level information
str(dev.inc)
```

    ## spec_tbl_df [68 × 14] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
    ##  $ country            : chr [1:68] "United Arab Emirates" "Argentina" "Austria" "Australia" ...
    ##  $ region             : chr [1:68] "Middle East & North Africa" "Latin America & Caribbean" "Europe & Central Asia" "East Asia & Pacific" ...
    ##  $ income             : chr [1:68] "High income" "Upper middle income" "High income" "High income" ...
    ##  $ GDP.percap         : num [1:68] 40645 14613 47312 53934 17392 ...
    ##  $ Market.Cap.pcntGDP : num [1:68] 60.2 16.9 36.2 113.7 67.3 ...
    ##  $ Unemployment.female: num [1:68] 7.11 9.47 5.03 5.67 8.78 ...
    ##  $ Unemployment.male  : num [1:68] 1.47 7.53 5.91 5.52 8.47 ...
    ##  $ Education.Expend   : num [1:68] NA 5.45 5.37 5.13 4.37 ...
    ##  $ Arable.Land.pcnt   : num [1:68] 0.627 14.324 16.104 3.998 16.279 ...
    ##  $ Life.Expect.female : num [1:68] 79 79.7 84 84.6 80.3 ...
    ##  $ Life.Expect.male   : num [1:68] 77 72.9 79.4 80.5 77.6 ...
    ##  $ Mortality.u5       : num [1:68] 7.2 10.3 3.6 3.8 13.4 34.2 4.1 7.3 15.4 5.2 ...
    ##  $ CO2.emiss.mtpercap : num [1:68] 21.95 4.09 7.48 15.74 4.19 ...
    ##  $ Access2Elec.pcnt   : num [1:68] 100 100 100 100 100 88 100 100 99.8 100 ...
    ##  - attr(*, "spec")=
    ##   .. cols(
    ##   ..   country = col_character(),
    ##   ..   region = col_character(),
    ##   ..   income = col_character(),
    ##   ..   GDP.percap = col_double(),
    ##   ..   Market.Cap.pcntGDP = col_double(),
    ##   ..   Unemployment.female = col_double(),
    ##   ..   Unemployment.male = col_double(),
    ##   ..   Education.Expend = col_double(),
    ##   ..   Arable.Land.pcnt = col_double(),
    ##   ..   Life.Expect.female = col_double(),
    ##   ..   Life.Expect.male = col_double(),
    ##   ..   Mortality.u5 = col_double(),
    ##   ..   CO2.emiss.mtpercap = col_double(),
    ##   ..   Access2Elec.pcnt = col_double()
    ##   .. )
    ##  - attr(*, "problems")=<externalptr>

The variables `region` and `income` are categorical and they take only
predefined values. Those variables are saved as characters and hence we
convert them to factors. We observe that region has 7 levels and income
has 3. However the variable `income` is in random order and in order to
facilitate our analysis we reorder the levels.  
<table>
<thead>
<tr>
<th style="text-align:left;">
x
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
East Asia & Pacific
</td>
</tr>
<tr>
<td style="text-align:left;">
Europe & Central Asia
</td>
</tr>
<tr>
<td style="text-align:left;">
Latin America & Caribbean
</td>
</tr>
<tr>
<td style="text-align:left;">
Middle East & North Africa
</td>
</tr>
<tr>
<td style="text-align:left;">
North America
</td>
</tr>
<tr>
<td style="text-align:left;">
South Asia
</td>
</tr>
<tr>
<td style="text-align:left;">
Sub-Saharan Africa
</td>
</tr>
</tbody>
</table>
<table>
<thead>
<tr>
<th style="text-align:left;">
x
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
High income
</td>
</tr>
<tr>
<td style="text-align:left;">
Lower middle income
</td>
</tr>
<tr>
<td style="text-align:left;">
Upper middle income
</td>
</tr>
</tbody>
</table>

## Qualtity of Data

The data set, as previously stated, contains 68 observations and 14
variables. The first variable specifies the country to which the
observation belongs. The second and third variables are categorical, and
they describe each country’s region and income category as classified by
the World Bank in 2017. This section examines the data for missing
values, and/or outliers.

### Missing Values

This section sets out to investigate the existence of missing values and
identify any features that contain a lot of them. In Figure 1, the right
graph shows the proportion and position of missing values for each
feature in black. These values account for 1.3 percent of the total and
are all in the `Education.Expend.` There are 12 missing observations out
of 68 for this specific feature, accounting for 18% of the total. At
first glance, there doesn’t appear to be any pattern in the missingness.
We plot the variable Education.Expend against categorical variables
`income` and `region`, as well as continuous variables, `GDP.precap` and
`Market.Cap.pcntGDP`, to identify the type of missingness in the data
and visualize any existing relationships.

``` r
vis_miss(dev.inc)
```

<img src="Development-Indicators-2017-Visualisation-Report_files/figure-gfm/Fig1-1.png" title="\label{fig:fig1}Missing Values" alt="\label{fig:fig1}Missing Values" style="display: block; margin: auto;" />

``` r
sum(is.na(dev.inc))
```

    ## [1] 12

The figure below shows the percentage of missing values per region and
income category. Looking at the first row we observe that 100% of the
data is missing from North America and around 75% from South Asia and
25% from Middle East and North Africa. Regarding the second row, we
observe that 40% of the data is missing from lower income countries and
less than 20% from High income countries.

<img src="Development-Indicators-2017-Visualisation-Report_files/figure-gfm/Fig2-1.png" title="\label{fig:fig2} Income Categories" alt="\label{fig:fig2} Income Categories" width="50%" style="display: block; margin: auto;" /><img src="Development-Indicators-2017-Visualisation-Report_files/figure-gfm/Fig2-2.png" title="\label{fig:fig2} Income Categories" alt="\label{fig:fig2} Income Categories" width="50%" style="display: block; margin: auto;" />

The graph below shows the variable `Education.Expend` plotted againts
`GDP.precap` and `Market.Cap.pcntGDP` by region and income.The missing
values are shown as red dots near the bottom of each panel. We can see
that the missing values exist across the whole range in both of the
graphs and the distribution is similar to the one of the none missing
observations .In particular, in the first graph it can be seen that some
values are clustered in the lower range of GDP. In the second graph, the
missing values are uniformly distributed acrros the x-axis.

<img src="Development-Indicators-2017-Visualisation-Report_files/figure-gfm/Fig3-1.png" title="\label{fig:fig3} Missing Values" alt="\label{fig:fig3} Missing Values" style="display: block; margin: auto;" /><img src="Development-Indicators-2017-Visualisation-Report_files/figure-gfm/Fig3-2.png" title="\label{fig:fig3} Missing Values" alt="\label{fig:fig3} Missing Values" style="display: block; margin: auto;" />

The table below illustrates the missing values grouped per region. The
first column shows the region, the second column shows the missing
variable the third column show the number of missing values and the last
column shows the percentages of missing values per region. We can see
that there isn’t any data about education expenditure for North America,
while 1/3 of the data is missing for South Asia. In addition, 36% and 20
% of values are missing for the Middle East & North Africa and
Sub-Saharan Africa respectfully.
<table>
<thead>
<tr>
<th style="text-align:left;">
region
</th>
<th style="text-align:left;">
variable
</th>
<th style="text-align:right;">
n_miss
</th>
<th style="text-align:right;">
pct_miss
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
Middle East & North Africa
</td>
<td style="text-align:left;">
Education.Expend
</td>
<td style="text-align:right;">
5
</td>
<td style="text-align:right;">
35.714286
</td>
</tr>
<tr>
<td style="text-align:left;">
Latin America & Caribbean
</td>
<td style="text-align:left;">
Education.Expend
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0.000000
</td>
</tr>
<tr>
<td style="text-align:left;">
Europe & Central Asia
</td>
<td style="text-align:left;">
Education.Expend
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
4.545454
</td>
</tr>
<tr>
<td style="text-align:left;">
East Asia & Pacific
</td>
<td style="text-align:left;">
Education.Expend
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
8.333333
</td>
</tr>
<tr>
<td style="text-align:left;">
South Asia
</td>
<td style="text-align:left;">
Education.Expend
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:right;">
66.666667
</td>
</tr>
<tr>
<td style="text-align:left;">
North America
</td>
<td style="text-align:left;">
Education.Expend
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:right;">
100.000000
</td>
</tr>
<tr>
<td style="text-align:left;">
Sub-Saharan Africa
</td>
<td style="text-align:left;">
Education.Expend
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
20.000000
</td>
</tr>
</tbody>
</table>

Similarly, the table below shows the missing values grouped per income
category.The table is similar to the above with the difference that the
first column shows the income. We observe that approximately the same
number of data is missing from low income and high income countries,
however the number of countries in the low income category is smaller
than the high income and as a result the proportion of missing values is
bigger.

<table>
<thead>
<tr>
<th style="text-align:left;">
income
</th>
<th style="text-align:left;">
variable
</th>
<th style="text-align:right;">
n_miss
</th>
<th style="text-align:right;">
pct_miss
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
High income
</td>
<td style="text-align:left;">
Education.Expend
</td>
<td style="text-align:right;">
5
</td>
<td style="text-align:right;">
15.15152
</td>
</tr>
<tr>
<td style="text-align:left;">
Upper middle income
</td>
<td style="text-align:left;">
Education.Expend
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
5.00000
</td>
</tr>
<tr>
<td style="text-align:left;">
Lower middle income
</td>
<td style="text-align:left;">
Education.Expend
</td>
<td style="text-align:right;">
6
</td>
<td style="text-align:right;">
40.00000
</td>
</tr>
</tbody>
</table>

Those observations indicate that MCAR (Missing completely at random)
does not apply to this variable, and we would need to consider the
missing data to be either MAR or MNAR. MAR (Missing at random) assumes
that we can predict the missing value based on the rest of the data.By
conditioning on income, we can find that the resulting univariate
distributions (for each of the other variables) appear similar for those
observations for which ed.exp is missing as for those for which it is
not. Hence, missingness appears to be explained by an observed variable
(income), and not an unobserved variable. This suggests MAR more
appropriate than MNAR.

We chose to drop the column Education Expenditure, as we lack all data
for North America and a significant proportion of South Asia.

``` r
#Select Education.Expend and remove rows containing NA
ed.exp<-dev.inc %>%select(country,Education.Expend) %>% na.omit
#Remove Education Expenditure
dev.inc<-dev.inc %>%select(-Education.Expend)
#Select Numeric Data
num.data<-dev.inc %>% 
  select_if(is.numeric)
```

### Outliers and Errors

Next, we move on finding outliers.The below figure shows the box plots
for each numeric variable in the data set. The red points are the
outliers. We can see that all the variables have some observations that
deviate from the rest, but they are not out of bounds (for example
negative or above a normal range) and they make logical sense. This is
expected as those variables describe unique development indicators in
which some countries perform worse or better.

Note: Boxplots aren’t always appropriate for detecting outliers,
particularly if the variables distribution is higly skewed.If we had
noticed some anomalous data we would be worth to choose to investigate
further by visualizing histograms and parfoming the IQR method.
<img src="Development-Indicators-2017-Visualisation-Report_files/figure-gfm/Fig4-1.png" title="\label{fig:fig4} Boxplots" alt="\label{fig:fig4} Boxplots" style="display: block; margin: auto;" />
\# Exploration of the univariate and multivariate distribution Up until
now we investigate the structure and quality of the data. The following
section presents a brief exploration of the univariate and multivariate
distribution of the data.

## Univariate Analysis

For the univariate analysis we’re to investigate the distribution of the
categorical and numerical variables. The bellow figure shows the number
of variables in each category on the left plot, the violin plots of the
numerical variables on the centre plot, and the histogram of education
expenditure on the right plot. We notice that a lot of countries are
classified as high income, followed by upper middle income. and the
majority are located in Europe and South Asia and the Middle East and
North Africa.

<img src="Development-Indicators-2017-Visualisation-Report_files/figure-gfm/Fig5,-1.png" title="\label{fig:fig5} Distribution of categorical variables" alt="\label{fig:fig5} Distribution of categorical variables" style="display: block; margin: auto;" />
The next table shows the summary statistics of each variable. It’s
interesting to note that for the variable GPD per capital, the
difference between the mean and the median is quite significant. This
caused by the countries with the highest GDPs.

    ##    GDP.percap     Market.Cap.pcntGDP Unemployment.female Unemployment.male
    ##  Min.   :  1564   Min.   :  0.2076   Min.   : 0.639      Min.   : 0.062   
    ##  1st Qu.:  5482   1st Qu.: 24.1902   1st Qu.: 4.198      1st Qu.: 3.708   
    ##  Median : 13747   Median : 46.6438   Median : 6.069      Median : 5.359   
    ##  Mean   : 22719   Mean   : 64.3540   Mean   : 8.844      Mean   : 6.556   
    ##  3rd Qu.: 38737   3rd Qu.: 82.6290   3rd Qu.:10.940      3rd Qu.: 8.414   
    ##  Max.   :109921   Max.   :322.7110   Max.   :29.283      Max.   :25.220   
    ##  Arable.Land.pcnt  Life.Expect.female Life.Expect.male  Mortality.u5    
    ##  Min.   : 0.2239   Min.   :54.84      Min.   :53.09    Min.   :  2.400  
    ##  1st Qu.: 4.2209   1st Qu.:77.59      1st Qu.:71.99    1st Qu.:  4.275  
    ##  Median :11.8564   Median :79.94      Median :75.00    Median :  8.000  
    ##  Mean   :15.8681   Mean   :79.23      Mean   :74.29    Mean   : 14.359  
    ##  3rd Qu.:23.0358   3rd Qu.:83.90      3rd Qu.:78.92    3rd Qu.: 15.250  
    ##  Max.   :59.5938   Max.   :87.26      Max.   :81.60    Max.   :122.500  
    ##  CO2.emiss.mtpercap Access2Elec.pcnt
    ##  Min.   : 0.4248    Min.   : 52.50  
    ##  1st Qu.: 2.4907    1st Qu.: 99.68  
    ##  Median : 4.7417    Median :100.00  
    ##  Mean   : 6.6313    Mean   : 96.52  
    ##  3rd Qu.: 8.1760    3rd Qu.:100.00  
    ##  Max.   :32.1794    Max.   :100.00

Next,the figure below shows the violin plots for the numeric variables.
Except for the variables describing life expectancy, all of the numeric
variable distributions are positively skewed. Life expectancy appears to
have a bimodal distribution, as evidenced by the presence of two peaks.
Most of the observations for the variable Access to Electricity Access
to Electricity are gathered around 100%, with a portion of them ranging
between 50% and 100%. Finally, the distribution of Education Expenditure
is nearly normal, with two outliers on the right.
<img src="Development-Indicators-2017-Visualisation-Report_files/figure-gfm/Fig6-1.png" title="\label{fig:fig6} Distribution of numerical variables" alt="\label{fig:fig6} Distribution of numerical variables" style="display: block; margin: auto;" />
Finally we’re going to look into the distribution of Education
Expenditure.%. The distribution is close to normal, and there are two
outliers on the right.
<img src="Development-Indicators-2017-Visualisation-Report_files/figure-gfm/Fig7-1.png" title="\label{fig:fig6} Distribution of numerical variables" alt="\label{fig:fig6} Distribution of numerical variables" style="display: block; margin: auto;" />
\## Multivariate Analysis The figure below is visual representation of
the multivariate correlation structure and their significance levels.
The heatmap shows the pairwise Pearson correlation coefficients between
the variables. The variables which do not have a significant correlation
are left blank. We observe that:

-   Mortality has a very high negative correlation with access to
    electricity and lives expectancy of both genders.
-   Arable Land is not strongly correlated with any other variable.
-   Unemployment rate for males and females are strongly correlated with
    each other.
-   CO2 consumption has a moderate positive correlation with GDP per cap
    while GDP per capita has a moderate positive correlation with life
    expectancy.
-   Live expectancy for both genders are very highly positively
    correlated with each other and access to electricity.

<img src="Development-Indicators-2017-Visualisation-Report_files/figure-gfm/Fig8-1.png" title="\label{fig:fig8} Distribution of numerical variables " alt="\label{fig:fig8} Distribution of numerical variables " style="display: block; margin: auto;" />
Based on the observations above, we are going to investigate the
relationship between the variables that display strong correlations. In
particular, we’re going to investigate:

-   Income Categories and the relationship with GDP per capita (current
    USD) and market capitalization of domestic listed companies (% of
    GDP).Moreover we’re going to look at the number of countries in each
    income category for each section and display the maps that show the
    GDP per capita and Market Cap globally for each country.
-   CO2 consumption per capita and the relationship with GDP per capita
    and income categories.
-   Unemployment rate by gender for each country and region. In addition
    we’re going to explore how it’s related to income categories and GDP
    per capita.
-   Life expectancy by gender for each country and region. In addition
    we’re going to explore how it’s related to GDP per capita and Market
    Cap.
-   Mortality and the relationship with female life expectancy and
    access to electricity.
-   Percentage of access to electicity globally for each country.
-   Arable land globally for each country.
-   Education Expenditure globally for each country.

### Income Categories

First, we are going to explore the relationship between income
categories, GDP per capita (current USD) and market capitalization of
domestic listed companies (% of GDP).
<table>
<thead>
<tr>
<th style="text-align:left;">
income
</th>
<th style="text-align:right;">
maxGDP
</th>
<th style="text-align:right;">
minGDP
</th>
<th style="text-align:right;">
maxMarketCap
</th>
<th style="text-align:right;">
minMarketCap
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
Lower middle income
</td>
<td style="text-align:right;">
5520.315
</td>
<td style="text-align:right;">
1563.768
</td>
<td style="text-align:right;">
96.39883
</td>
<td style="text-align:right;">
0.2076133
</td>
</tr>
<tr>
<td style="text-align:left;">
Upper middle income
</td>
<td style="text-align:right;">
15146.409
</td>
<td style="text-align:right;">
4231.518
</td>
<td style="text-align:right;">
322.71098
</td>
<td style="text-align:right;">
4.9751435
</td>
</tr>
<tr>
<td style="text-align:left;">
High income
</td>
<td style="text-align:right;">
109921.031
</td>
<td style="text-align:right;">
13629.290
</td>
<td style="text-align:right;">
239.39652
</td>
<td style="text-align:right;">
12.3405769
</td>
</tr>
</tbody>
</table>
The figure below displays the relationship between GDP per capita and
Market cap for each income category.We observe the relationship is
linear and because of South Africa’s Market Cap the trending line is
curved at the end.
<img src="Development-Indicators-2017-Visualisation-Report_files/figure-gfm/Fig9-1.png" title="\label{fig:fig9} Number of countries in Income Categories" alt="\label{fig:fig9} Number of countries in Income Categories" style="display: block; margin: auto;" />
The figure below provides a breakdown of the number of counties in each
category for each region. We observe that all countries are categorized
as high income in North America and lower middle income in South Asia.It
can be seen that there is there is no country in the high income
category in Sub-Saharan Africa and in contrast there is no country
categorized as lower middle income in Latin America & Caribbean and
North America.Finally, in all the other regions there are countries
categorized in all income levels.The majority of the countries in Europe
and Central Asia are in the high income category whereas there is only 1
country is in the lower middle income, which in the next code section we
find is Ukraine.In addition, in the Middle East & North Africa we see
some inequality as countries are either in the highest or lower category
with only two in the middle. Finally, in East Asia& Pacific, countries
are spread more equally.
<img src="Development-Indicators-2017-Visualisation-Report_files/figure-gfm/Fig10-1.png" title="\label{fig:fig10} Number of countries in Income Categories" alt="\label{fig:fig10} Number of countries in Income Categories" style="display: block; margin: auto;" />
We’re going to filter the data to investigate which country in Europe
and Central Asia is in the lower income category.
<table>
<thead>
<tr>
<th style="text-align:left;">
country
</th>
<th style="text-align:left;">
region
</th>
<th style="text-align:left;">
income
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
Ukraine
</td>
<td style="text-align:left;">
Europe & Central Asia
</td>
<td style="text-align:left;">
Lower middle income
</td>
</tr>
</tbody>
</table>

This map shows the GDP per capita and Market Capitalisations in every
country globally.
<img src="Development-Indicators-2017-Visualisation-Report_files/figure-gfm/Fig11-1.png" style="display: block; margin: auto;" /><img src="Development-Indicators-2017-Visualisation-Report_files/figure-gfm/Fig11-2.png" style="display: block; margin: auto;" />
\### CO2 and income

The first plot shows a violin plot of CO2 emissions per income category.
We can see that the mean CO2 consumption doesn’t differ a lot between
different categories, but as we move up the categories, the range of the
distirbution increases. The second graph shows the relationship between
CO2, GDP per capita, and income category. The coloured dashed lines show
the mean value of CO2 emissions for each income category. The countries
in the high-income category produce the most CO2 emissions. There are
nine countries producing more than 15 metric tons per capita, whilst
most of the countries’ emissions stay below 10 tons per capita. These
graphs also give us the opportunity to see how GDP per capita is
distributed in each income category. While the observations in the upper
and lower income categories cover a narrow range and are gathered below
20,000 dollars, the values in the high-income category are more
dispersed and cover a range that is more than triple that of the other
two categories.The curve increases gradually until about 12 tons/capita
and shows that as GPD increases, CO2 emissions increase at a slower
rate.
<img src="Development-Indicators-2017-Visualisation-Report_files/figure-gfm/unnamed-chunk-10-1.png" style="display: block; margin: auto;" />

    ## `geom_smooth()` using formula 'y ~ x'

<img src="Development-Indicators-2017-Visualisation-Report_files/figure-gfm/unnamed-chunk-10-2.png" style="display: block; margin: auto;" />

### Unemployement by gender

The following graphs show the unemployment rates for each gender in each
country and region. In some countries, we observe a high inequality
between genders, especially in United Arab Emirates, Saudi Arabia, and
Bahrain etc. In general, unemployment rates for women are higher than
those for men. The second graph, confirms that indeed, in the Middle
East & North Africa, unemployment rate for females is significantly
higher than it is for men. In addition, in Europe and Central Asia,
there is some inequality between the two genders favouring the males. In
East Asia and the Pacific, the rates for each gender are almost the
same. In all regions, the female unemployment rate is higher except for
North America where it seems the opposite is happening.
<img src="Development-Indicators-2017-Visualisation-Report_files/figure-gfm/Fig12-1.png" title="\label{fig:fig12} Unemployement by gender for each countiry and region" alt="\label{fig:fig12} Unemployement by gender for each countiry and region" style="display: block; margin: auto;" /><img src="Development-Indicators-2017-Visualisation-Report_files/figure-gfm/Fig12-2.png" title="\label{fig:fig12} Unemployement by gender for each countiry and region" alt="\label{fig:fig12} Unemployement by gender for each countiry and region" style="display: block; margin: auto;" />
The maps show the unemployment rate by gender globally, for each
country.
<img src="Development-Indicators-2017-Visualisation-Report_files/figure-gfm/Fig13-1.png" style="display: block; margin: auto;" /><img src="Development-Indicators-2017-Visualisation-Report_files/figure-gfm/Fig13-2.png" style="display: block; margin: auto;" />
The figure below shows the unemployment rate by gender for each income
category. For all income categories, the unemployment rate for females
is higher than for males. The highest difference can be observed in
countries classified as lower middle income and the lowest difference
can be seen in the upper-middle-income category.
<img src="Development-Indicators-2017-Visualisation-Report_files/figure-gfm/Fig14-1.png" title="\label{fig:fig14} Unemployement by gender for each income category" alt="\label{fig:fig14} Unemployement by gender for each income category" style="display: block; margin: auto;" />

The figure below shows the relationship between the unemployment rate
for each gender and GDP per capita for each income category. The colour
of each point describes the income category, and the black dashed line
shows the mean value of the unemployment rate for each gender. What
stands out first in this graph, is the difference in mean values, where
the mean unemployment rate for females is higher than for males. We can
also see that the two trending lines follow the same trend for both
genders, suggesting that as GDP increases, the rate decreases. However,
the employment rate for males doesn’t seem to be affected by GDP per
capita as much since it’s almost straight. Moreover, the trend line in
the plot that represents females displays an increase, but the points
seem to be in the same range. Finally, countries in the upper and
lower-middle categories, with some exceptions, have the highest
unemployment rates. It is surprising to see that some counties in the
higher income category have the same unemployment rate as countries in
the upper and lower-middle categories.

    ## `geom_smooth()` using formula 'y ~ x'

<img src="Development-Indicators-2017-Visualisation-Report_files/figure-gfm/Fig15-1.png" title="\label{fig:fig15} Unemployement by gender for each income category and GDP" alt="\label{fig:fig15} Unemployement by gender for each income category and GDP" style="display: block; margin: auto;" />
\### Life expectancy by gender

The first graph below shows life expectancy by gender for each country.
It can be seen that for the majority of countries, life expectancy for
both genders is above 50 years. The second graph shows life expectancy
by gender for each region. We can observe that the life expectancy for
males is higher than 75, apart from in Sub-Saharan Africa and South
Asia, where it’s close to 65. In almost all regions, female life
expectancy is higher than males . Finally, the last graph shows life
expectancy by gender for each income category. There isn’t a significant
difference between the categories, and again, life expectancy is higher
for females.
<table>
<thead>
<tr>
<th style="text-align:left;">
</th>
<th style="text-align:left;">
Life.Expect.female
</th>
<th style="text-align:left;">
Life.Expect.male
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
Min. :54.84
</td>
<td style="text-align:left;">
Min. :53.09
</td>
</tr>
<tr>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
1st Qu.:77.59
</td>
<td style="text-align:left;">
1st Qu.:71.99
</td>
</tr>
<tr>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
Median :79.94
</td>
<td style="text-align:left;">
Median :75.00
</td>
</tr>
<tr>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
Mean :79.23
</td>
<td style="text-align:left;">
Mean :74.29
</td>
</tr>
<tr>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
3rd Qu.:83.90
</td>
<td style="text-align:left;">
3rd Qu.:78.92
</td>
</tr>
<tr>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
Max. :87.26
</td>
<td style="text-align:left;">
Max. :81.60
</td>
</tr>
</tbody>
</table>

<img src="Development-Indicators-2017-Visualisation-Report_files/figure-gfm/Fig16-1.png" title="\label{fig:fig16} Life expectancy by gender" alt="\label{fig:fig16} Life expectancy by gender" style="display: block; margin: auto;" /><img src="Development-Indicators-2017-Visualisation-Report_files/figure-gfm/Fig16-2.png" title="\label{fig:fig16} Life expectancy by gender" alt="\label{fig:fig16} Life expectancy by gender" style="display: block; margin: auto;" /><img src="Development-Indicators-2017-Visualisation-Report_files/figure-gfm/Fig16-3.png" title="\label{fig:fig16} Life expectancy by gender" alt="\label{fig:fig16} Life expectancy by gender" style="display: block; margin: auto;" />

The graph shows the relationship between life expectancy for each gender
and GDP per capita. The colour of each point depends on the market
capitalisation percentage, and the two black dashed lines indicate the
mean life expectancy of each gender. We observe that the two variables
have a curvilinear relationship where when GDP per capita increases,
life expectancy also increases, but at a different rate. In the
beginning, it rises at a rapid rate, and then, beyond a point, the line
flattens out. Life expectancy for males is lower in almost all countries
than it is for women, which is shown by the lower mean value as well. We
can also see that life expectancy increases in accordance with market
capitalisation. The only exception is South Africa, where market
capitalisation reached 300%. The life expectancy for women and men is
approximately 68 and 60, respectively.

    ## `geom_smooth()` using formula 'y ~ x'

<img src="Development-Indicators-2017-Visualisation-Report_files/figure-gfm/Fig17-1.png" title="\label{fig:fig17} GDP and Life expevtancy for women " alt="\label{fig:fig17} GDP and Life expevtancy for women " style="display: block; margin: auto;" />

### Mortality

The graph shows the relationship between female life expectancy, the
mortality rate, and access to electricity. The colour of the points
indicates the electricity access percentage, and the two dashed lines
show the mean value of life expectancy and mortality. As we mentioned
above, those variables are highly correlated and, indeed, we can observe
an almost negative linear relationship. Most of the countries are
gathered around the top left of the graph, and only a few points are
scattered away. Thus, the mean value for female expectancy is around 80
years old, and the mean mortality is equal to 13 deaths per 1000 live
births. We can also see that as the mortality rate increases, access to
electricity decreases steadily.

    ## `geom_smooth()` using formula 'y ~ x'

<img src="Development-Indicators-2017-Visualisation-Report_files/figure-gfm/Fig18-1.png" title="\label{fig:fig18} Moratlity rate" alt="\label{fig:fig18} Moratlity rate" style="display: block; margin: auto;" />
The next map shows the mortality rate which is the deaths under 5 years
per 1000 live births in each country.

<img src="Development-Indicators-2017-Visualisation-Report_files/figure-gfm/Fig19-1.png" style="display: block; margin: auto;" />

### Access to electricity Map

    ## Warning in mypalette_elec(join.coord$Access2Elec.pcnt): Some values were outside
    ## the color scale and will be treated as NA

<img src="Development-Indicators-2017-Visualisation-Report_files/figure-gfm/Fig20-1.png" style="display: block; margin: auto;" />
The plot below shows only countries with Access to Electricity less than
100%.We can see that all countries are categorised as either lower or
upper middle income.

``` r
dev.inc %>% 
  select(country,income,GDP.percap,Access2Elec.pcnt) %>% 
  filter(Access2Elec.pcnt<99) %>% 
  ggplot(aes(x=GDP.percap,y=Access2Elec.pcnt,color=income))+
  geom_point(alpha=0.8)+
  geom_text_repel(aes(label= ifelse(Access2Elec.pcnt < 99,
                                    as.character(country),'')),hjust=0,vjust=0.5,size=2.5)+
  #Theme customization
  theme_bw()+
  theme(legend.position =c(0.8,0.15),
        axis.line = element_line(colour = "black",size = 0.25),
        text = element_text(size = 8))+
  scale_color_brewer(palette = 'Set1')+
  scale_x_continuous(labels = function(x) paste0(x,"$"),breaks =seq (0,15000,2500))+
  scale_y_continuous(labels = function(x) paste0(x,"%"))+
  xlab("GDP per capita")+
  ylab("Access to electricity")+
  ggtitle("Access to Electricity and GDP per capita")
```

<img src="Development-Indicators-2017-Visualisation-Report_files/figure-gfm/unnamed-chunk-11-1.png" style="display: block; margin: auto;" />

### Arable Land Map

<img src="Development-Indicators-2017-Visualisation-Report_files/figure-gfm/Fig21-1.png" style="display: block; margin: auto;" />
\### Education expenditure Map

<img src="Development-Indicators-2017-Visualisation-Report_files/figure-gfm/Fig22-1.png" style="display: block; margin: auto;" />
