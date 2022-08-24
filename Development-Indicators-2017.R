#Hydrocarbon mixture analysis and predictions
# 27/03/2022
# Load relevant packages -------------------------------------------------------
library(dplyr)
library(irlba)
library(ggplot2)
library(ggpubr)
library(tidyverse)
library(reshape2)
library(caret)
library(Metrics)
library(gridExtra)
library(corrplot)
library(PerformanceAnalytics)
library(ggmap)
library(maps)
library(leaflet)
library(naniar)
library(RColorBrewer)
library(rgdal)
#Set seed to replicate results
set.seed(9)
register_google(key = "AIzaSyA-0NQyKizPR9jdAYCfTiyB5IhVfbdU2xI")
#  Read this shape file with the rgdal library found
#http://thematicmapping.org/downloads/world_borders.php
my_spdf <- readOGR( dsn= "/Users/papagiannizoe/Desktop/MSc-Imperial/Term 2/Data visualisation/Assessments/Assessment_5/TM_WORLD_BORDERS_SIMPL-0.3" , 
                    layer="TM_WORLD_BORDERS_SIMPL-0.3", verbose=FALSE) 
# Load data --------------------------------------------------------------------
dev.inc<- read_csv("data.csv") 
summary(dev.inc)
dev.inc$region<-as.factor(dev.inc$region)
levels(dev.inc$region)
dev.inc$income<-as.factor(dev.inc$income)
levels(dev.inc$income)
dev.inc$income <- factor(dev.inc$income, levels = c("High income", "Upper middle income", "Lower middle income"))


#Missing data
vis_miss(dev.inc,show_perc_col=TRUE)

png(filename = "plots/missingvalues.png", width = 850, height = 1000)
vis_miss(dev.inc)
dev.off()

dev.inc %>%
  group_by(region) %>% # Q3.i
  miss_var_summary() %>% # Q3.ii
  filter(variable == "Education.Expend") 

gg_miss_fct(dev.inc, region)

mis1<-dev.inc %>% select(region,Education.Expend) %>% 
  gg_miss_fct(region)
mis1

mis2<-dev.inc %>% select(Education.Expend,income) %>% 
  gg_miss_fct(income)
mis2

mis1<-ggplotGrob(mis1)
mis2<-ggplotGrob(mis2)
plots<-list(mis1,mis2)

png(filename = "plots/catmissingvalues.png", width = 330, height = 370)
do.call("grid.arrange", c(plots, nrow=2))
dev.off()

#GDP and Market cap
mis3<-ggplot(dev.inc, aes(x = GDP.percap,y = Education.Expend)) + 
  geom_miss_point()+
  #Theme customization
  theme_bw()+
  #Legend position and Axis and fond size customization 
  theme(legend.position = 'none',
        text = element_text(size = 10),
        axis.line = element_line(colour = "black",size = 0.25))+
  #scale customization
  scale_x_continuous(labels=scales::dollar_format())+
  #Title and axes
  xlab('GDP per capita (current USD)')+
  ylab('Educ.Exp. on (% of GDP)')+
  ggtitle("Missing Values")
mis3

mis4<-ggplot(dev.inc, aes(x = Market.Cap.pcntGDP,y = Education.Expend)) + 
  geom_miss_point()+
  #Theme customization
  theme_bw()+
  #Legend position and Axis and fond size customization 
  theme(legend.position = c(0.85, 0.25),
        text = element_text(size = 10),
        axis.line = element_line(colour = "black",size = 0.25))+
  #Title and axes
  xlab('Market Capitalisation (%GDP)')+
  ylab('Educ.Exp. on (% of GDP)')+
  ggtitle("Missing Values")
mis4

grid.arrange(mis3,mis4,nrow=2)

png(filename = "plots/gdpmissingvalues.png", width = 290, height = 370)
grid.arrange(mis3,mis4,nrow=2)
dev.off()


#Outliers
num.data<-dev.inc %>% 
  select_if(is.numeric)

boxplots<-list()
for (i in 1:ncol(num.data)){
    p<-ggplot(data = num.data[i], aes(x = "", y =num.data[[i]])) +
      # Error bars
      stat_boxplot(geom = "errorbar",      
                   width = 0.2) +
      # Box color
      geom_boxplot(fill = "#4271AE",colour = "#1F3552",       
                   outlier.colour = "red", # Outliers color
                   alpha = 0.9) +          # Box color transparency
      #Theme customization
      theme_bw()+
      theme(axis.line = element_line(colour = "black",size = 0.25),
            text = element_text(size = 8))+
      #Axes titles
      xlab(paste(colnames(num.data[i])))+
      ylab('')
      
  #Save plots in list  
  boxplots[[i]] <- ggplotGrob(p)
}

do.call("grid.arrange", c(boxplots, ncol=5))
do.call("grid.arrange", c(boxplots, ncol=10))

png(filename = "plots/boxplots.png", width = 630, height = 370)
do.call("grid.arrange", c(boxplots, ncol=5))
dev.off()


med.data<-apply(num.data,2,median)
out<-data.frame(matrix(ncol=ncol(num.data),nrow=nrow(num.data)))
for (i in 1:ncol(num.data)){
  temp<-abs(num.data[,i] - med.data[i])
  MAD<- median(temp[[1]]) 
  M<-(0.6745/MAD)*(num.data[,i] - med.data[i])
  out[,i] =abs(M)>3.5
}
colnames(out)<-colnames(num.data)
num.out<-data.frame(Outliers=colSums(out))
rownames(num.out)<-colnames(out)
out.data<-num.data[out]

out_values<-data.frame()
for (i in 1:max(na.omit(num.out))){
  temp<-num.data[which(out[,i]),i]
  out_values<-cbin
}

#Exploration of the multivariate distribution of the data
cat.1<-ggplot(dev.inc, aes(x=income)) +
  #Bar color
  geom_bar(fill = "#4271AE",colour = "#1F3552",alpha=0.7)+
  #Label text
  stat_count(geom = "text", colour = "white", size = 3.5,
             aes(label = ..count..),position=position_stack(vjust=0.5))+
  #Theme customization
  theme_bw()+
  #Axis and fond size customisation 
  theme(axis.line = element_line(colour = "black",size = 0.25),
        plot.title = element_text(size=10))+
  #Title
  ggtitle("Observations per\n income category")+
  #X-Axis
  xlab('')+
  #Flip coordinates
  coord_flip()+scale_fill_brewer(palette = "Set1")

cat.1

cat.2<-ggplot(dev.inc, aes(x=region)) +
  geom_bar(fill = "#4271AE",colour = "#1F3552",alpha=0.7)+       # Box color
  #Label text
  stat_count(geom = "text", colour = "white", size = 3.5,
             aes(label = ..count..),position=position_stack(vjust=0.5))+
  #Theme customization
  theme_bw()+
  #Axis and fond size customisation 
  theme(axis.line = element_line(colour = "black",size = 0.25), 
        plot.title = element_text(size=10))+
  #Plot Title 
  ggtitle("Observations per\n region")+
  #X-Axis
  xlab('')+
  #Flip coordinates
  coord_flip()
cat.2

grid.arrange(cat.1,cat.2, ncol=2)


png(filename = "plots/catdistribution.png", width = 290, height = 370)
grid.arrange(cat.1,cat.2,nrow=2)
dev.off()

#Distributions
distributions<-list()
for (i in 1:ncol(num.data)){
  den<-density(num.data[[i]])
  p<-ggplot(data = num.data[i], aes(x = "", y =num.data[[i]])) +
    geom_violin(position=position_dodge(1),trim=FALSE,fill = "#4271AE",alpha=0.7)+
    geom_boxplot(colour = "#1F3552",       # Box color
                 outlier.colour = "red", # Outliers color
                 alpha = 0.9,width=0.1)+
    #Theme customization
    theme_bw()+
    theme(axis.line = element_line(colour = "black",size = 0.25),
          text = element_text(size = 8))+
    #Axes titles
    xlab(paste(colnames(num.data[i])))+
    ylab('')
  distributions[[i]] <- ggplotGrob(p)
}

do.call("grid.arrange", c(distributions, ncol=5))

png(filename = "plots/numdistribution.png", width = 570, height = 370)
do.call("grid.arrange", c(distributions, ncol=5))
dev.off()

ggplot(data = num.data[i], 
       aes(x = num.data[[i]], color=num.data[[i]], fill=num.data[[i]]))
scale_color_brewer(palette="Set1") +
  #Plot Type
  geom_density(lwd = 0.7,colour = "#1F3552",
               fill = "#4271AE", alpha = 0.45)+
  #Labels
  geom_vline(aes(xintercept=mean(num.data[[i]])),
             color="black", linetype="dashed", size=0.7)+
  geom_vline(aes(xintercept=median(num.data[[i]])),
             color="blue", linetype="dashed", size=0.7)+

#Exploration of the multivariate distribution of the data
  
# Leave blank on no significant coefficient
ggcorrplot(cor.features,p.mat= cor_pmat(features),
           insig = "blank",
           #Hierarchical clustering
           hc.order = TRUE,
           #Display values
           lab = TRUE,
           lab_size = 3, 
             #Outline color
             outline.col = "white",
             #Method square
             method = 'square', 
             #Title
             title="Correlogram",
             #Theme 
             ggtheme=theme_bw,
             #Colors
             colors = c( "#377EB8", "white","#E41A1C"))

png(filename = "plots/correlaton.png", width = 370, height = 370)
p
dev.off()


region_income<-dev.inc %>% group_by(region,income)%>% count() %>% 
  ggplot(aes(x=n, y=region, fill=income))+
  #Plot Type
  geom_bar(stat="identity", position=position_dodge())+
  #Labels
  geom_text(aes(label=n), hjust=1.6, color="white",
            position = position_dodge(0.9), size=3.5)+
  #Theme and colore
  theme_bw()+
  scale_fill_brewer(palette="Set1")+
  #Title and Axis labels
  theme(legend.position = c(0.8, 0.8))+
  labs(title = "Number of countries in each income category per region",
       fill='Income\n Categories')+
  xlab('Number of countries')+ylab('')+
  #Title size
  theme(plot.title = element_text(size=10),
        text = element_text(size=9))

region_income
png(filename = "region_income.png", width = 630, height = 370)
region_income
dev.off()

gpd<-dev.inc %>% select(GDP.percap)%>% 
  ggplot(aes(x=GDP.percap,color=GDP.percap, fill=GDP.percap))+
  #Plot Type
  geom_density()+
  #Labels
  geom_vline(aes(xintercept=mean(GDP.percap)),
             color="blue", linetype="dashed", size=1)+
  #Theme and colors
  theme_bw()+
  scale_fill_brewer(palette="Set1")+
  #Title and Axis labels
  labs(title = "GDP.percap")+
  xlab('GPD per capita ($)')+
  scale_x_continuous(labels=scales::dollar_format())+
  #Title size
  theme(plot.title = element_text(size=10),
        text = element_text(size=9))
gpd


mapWorld <-map('world',col="grey", fill=TRUE, bg="white", lwd=0.05, mar=rep(0,4),border=0, ylim=c(-80,80) )
data<-dev.inc %>% select(country,Unemployment.female,Unemployment.male,GDP.percap,Market.Cap.pcntGDP,Arable.Land.pcnt,income,Mortality.u5,CO2.emiss.mtpercap)
join.coord<-data %>% left_join(my_spdf@data, by=c('country'='NAME'))
##Unemployment map
mybins_unemployment<-seq(0, 30,5)
mypalette_unemployment <- colorBin( palette="OrRd", domain=join.coord$Unemployment.female, na.color="transparent", 
                                    bins=mybins_unemployment)

##Unemployment map
leaflet(my_spdf) %>% addTiles()  %>% 
  setView(lat=10, lng=0 , zoom=2) %>%
  addPolygons( 
    fillColor = ~mypalette_unemployment(join.coord$Unemployment.female), 
    stroke=TRUE, 
    fillOpacity = 0.9, 
    color="white", 
    weight=0.3) %>% 
  addLegend( 
    pal=mypalette_unemployment, 
    values=~join.coord$Unemployment.female, 
    opacity=0.9, title = "Unemployement (F)",
    labFormat = labelFormat(suffix="%"),
    position = "bottomleft")

mypalette_unemployment <- colorBin( palette="OrRd", domain=join.coord$Unemployment.male, na.color="transparent", 
                                    bins=mybins_unemployment)
##Unemployment map
leaflet(my_spdf) %>% addTiles()  %>% 
  setView(lat=10, lng=0 , zoom=2) %>%
  addPolygons( 
    fillColor = ~mypalette_unemployment(join.coord$Unemployment.male), 
    stroke=TRUE, 
    fillOpacity = 0.9, 
    color="white", 
    weight=0.3) %>% 
  addLegend( 
    pal=mypalette_unemployment, 
    values=~join.coord$Unemployment.male,
    labFormat = labelFormat(suffix="%"),
    opacity=0.9, title = "Unemployement (M)", 
    position = "bottomleft" )

##GDP
mybins.gdp<-seq(0, 110000,13750)
mypalette.gdp <- colorBin( palette="PuBu", domain=join.coord$GDP.percap, na.color="transparent", bins=mybins.gdp)

##GDP per capita
leaflet(my_spdf) %>% addTiles()  %>% 
  setView(lat=10, lng=0 , zoom=2) %>%
  addPolygons( 
    fillColor = ~mypalette.gdp(join.coord$GDP.percap), 
    stroke=TRUE, 
    fillOpacity = 0.9, 
    color="white", 
    weight=0.3) %>% 
  addLegend(pal = mypalette.gdp,
    values=~join.coord$GDP.percap,
    labFormat = labelFormat(prefix="$"),
    opacity=0.9, title = "GDP per Capita(current USD) ", 
    position = "bottomleft")

mybins.marketcap<-seq(0, 325,65)
mypalette.marketcap <- colorBin( palette="BuGn", domain=join.coord$Market.Cap.pcntGDP, na.color="transparent", bins=mybins.marketcap)

##Marketcap per capita
leaflet(my_spdf) %>% addTiles()  %>% 
  setView(lat=10, lng=0 , zoom=2) %>%
  addPolygons( 
    fillColor = ~mypalette.marketcap(join.coord$Market.Cap.pcntGDP), 
    stroke=TRUE, 
    fillOpacity = 0.9, 
    color="white", 
    weight=0.3) %>% 
  addLegend(pal = mypalette.marketcap,
            values=~join.coord$Market.Cap.pcntGDP,
            opacity=0.9, title = "Market capitalisation (% of GDP)", 
            position = "bottomleft")
df<-dev.inc %>% select(income,GDP.percap,Unemployment.female,Unemployment.male,country) %>% 
  melt(id=c('income','GDP.percap','country'))
#Mortality
mybins.mort<-seq(0, 125,25)
mypalette.mort <- colorBin( palette="Greys", domain=join.coord$Mortality.u5, na.color="transparent", bins=mybins.mort)

leaflet(my_spdf) %>% addTiles()  %>% 
  setView(lat=10, lng=0 , zoom=2) %>%
  addPolygons( 
    fillColor = ~mypalette.mort(join.coord$Mortality.u5), 
    stroke=TRUE, 
    fillOpacity = 0.9, 
    color="white", 
    weight=0.3) %>% 
  addLegend(pal = mypalette.mort,
            values=~join.coord$Mortality.u5,
            opacity=0.9, title = "Mortality per 1,000 live births ", 
            position = "bottomleft")


#Arable.Land.pcnt
mybins_arable<-seq(0,60,10)
mypalette_arable <- colorBin( palette="Greens", domain=join.coord$Unemployment.female, na.color="transparent", 
                                    bins=mybins_arable)
##Arable.Land
leaflet(my_spdf) %>% addTiles()  %>% 
  setView(lat=10, lng=0 , zoom=2) %>%
  addPolygons( 
    fillColor = ~mypalette_arable(join.coord$Arable.Land.pcnt), 
    stroke=TRUE, 
    fillOpacity = 0.9, 
    color="white", 
    weight=0.3) %>% 
  addLegend( 
    pal=mypalette_arable, 
    values=~join.coord$Arable.Land.pcnt, 
    opacity=0.9, title = "Arable Land (%)", 
    position = "bottomleft" )


#CO2
mybins_c02<-seq(0,35,5)
mypalette_c02 <- colorBin(palette="RdYlGn",domain=join.coord$CO2.emiss.mtpercap, na.color="transparent", 
                              bins=mybins_c02 ,reverse = TRUE)

##CO2
leaflet(my_spdf) %>% addTiles()  %>% 
  setView(lat=10, lng=0 , zoom=2) %>%
  addPolygons( 
    fillColor = ~mypalette_c02(join.coord$CO2.emiss.mtpercap), 
    stroke=TRUE, 
    fillOpacity = 0.9, 
    color="white", 
    weight=0.3) %>% 
  addLegend( 
    pal=mypalette_c02, 
    values=~join.coord$CO2.emiss.mtpercap, 
    opacity=0.9, title = "CO2 emissions (metric tons per capita)", 
    position = "bottomleft" )


##Unemployment per country per gender
Unemployment.countries<-dev.inc %>% 
  select(country,Unemployment.female,Unemployment.male)
colnames(Unemployment.countries)<-c('country','Female', 'Male')
Unemployment.countries$Male<-Unemployment.countries$Male*-1

Unemployment.countries %>% 
  melt(id='country') %>% 
  ggplot(aes(y = value, x = country, fill = variable)) +   # Fill column
  geom_bar(stat = "identity", width = .6) +   # draw the bars
  scale_y_continuous()+
  coord_flip() +  # Flip axes
  labs(title="Unemployment per country") +
  theme(plot.title = element_text(hjust = .5), 
        axis.ticks = element_blank()) + # Center plot title
  scale_fill_brewer(palette = "Paired")  # Color palette

##Unemployment per region per gender
Unemployment.region<-dev.inc %>% 
  select(region,Unemployment.female,Unemployment.male)
colnames(Unemployment.region)<-c('region','Female', 'Male')

Unemployment.region %>% 
  group_by(region) %>%
  summarise(Female=max(Female),Male=-max(Male)) %>% 
  melt(id='region') %>% 
  ggplot(aes(y = value, x = region, fill = variable)) +   # Fill column
  geom_bar(stat = "identity", width = .6) +   # draw the bars
  scale_y_continuous()+
  coord_flip() +  # Flip axes
  labs(title="Unemployment per country") +
  theme(plot.title = element_text(hjust = .5), 
        axis.ticks = element_blank()) + # Center plot title
  scale_fill_brewer(palette = "Paired")  # Color palette












###Life expectancy per sex

life.exp_countries<-dev.inc %>% 
  select(country,Life.Expect.female,Life.Expect.male)
colnames(life.exp_countries)<-c('country','Female', 'Male')
life.exp_countries$Male<-life.exp_countries$Male*-1

# X Axis Breaks and Labels 
brks <- seq(-90, 90, 10)
lbls = paste0(as.character(c(seq(90, 0, -10), seq(10, 90, 10))))

life.exp_countries %>% 
  melt(id='country') %>% 
  ggplot(aes(y = value, x = country, fill = variable)) +   # Fill column
  geom_bar(stat = "identity", width = .2) + 
  scale_y_continuous(breaks = brks,   # Breaks
                     labels = lbls) + # draw the bars
  coord_flip() +  # Flip axes
  labs(title="Unemployment per country") +
  theme(plot.title = element_text(hjust = .5), 
        axis.ticks = element_blank()) + # Center plot title
  scale_fill_brewer(palette = "Paired")  # Color palette

life.exp_region<-dev.inc %>% 
  select(region,Life.Expect.female,Life.Expect.male)
colnames(life.exp_region)<-c('region','Female', 'Male')

life.exp_region %>% 
  group_by(region) %>%
  summarise(Female=max(Female),Male=-max(Male)) %>% 
  melt(id='region') %>% 
  ggplot(aes(y = value, x = region, fill = variable)) +   # Fill column
  geom_bar(stat = "identity", width = .6) +   # draw the bars
  scale_y_continuous(breaks = brks,   # Breaks
                     labels = lbls) +
  coord_flip() +  # Flip axes
  labs(title="Unemployment per country") +
  theme(plot.title = element_text(hjust = .5), 
        axis.ticks = element_blank()) + # Center plot title
  scale_fill_brewer(palette = "Paired")  # Color palette


###CO2 per Income
# Change violin plot colors by groups
ggplot(dev.inc,aes(y=CO2.emiss.mtpercap,x=income)) +
  geom_violin(position=position_dodge(1),trim=FALSE, fill="gray")+
  geom_boxplot(width=0.1)
  scale_fill_brewer(palette="RdBu") + 
  theme_bw()

ggplot(dev.inc,aes(x=GDP.percap,y=CO2.emiss.mtpercap)) +
  geom_point()+
  geom_smooth(se=FALSE)+
  scale_fill_brewer(palette="RdBu") + 
  theme_bw()+
  #Title and Axis labels
  theme(legend.position = c(0.8, 0.8))

ggplot(dev.inc,aes(x=Market.Cap.pcntGDP,y=CO2.emiss.mtpercap)) +
  geom_point()+
  geom_smooth(se=FALSE)+
  theme_bw()+
  #Title and Axis labels
  theme(legend.position = c(0.8, 0.8))+
  scale_fill_brewer(palette="RdBu") 

#Market cap, Gdp, Income
ggplot(dev.inc,aes(x=Market.Cap.pcntGDP,y=GDP.percap,color=income)) +
  geom_point()+
  geom_smooth(se=FALSE)+
  theme_bw()+
  #Title and Axis labels
  theme(legend.position = c(0.8, 0.8))+
  scale_fill_brewer(palette="RdBu") 

##GDP Unemployment per gender and income category
df<-dev.inc %>% select(income,GDP.percap,Unemployment.female,Unemployment.male) %>% 
  melt(id=c('income','GDP.percap'))

df$variable<-gsub("Unemployment.", "", df$variable)
names(df)[names(df) == 'variable'] <- 'Gender'
names(df)[names(df) == 'value'] <- 'Unemployment'

ggplot(df,aes(x=GDP.percap,y=Unemployment,color=income)) +
  geom_point()+
  theme_bw()+
  #Title and Axis labels
  theme(legend.position = c(0.8, 0.8))+
  scale_fill_brewer(palette="RdBu") +
  facet_wrap(~Gender)

##GDP Life expectancy
df.life<-dev.inc %>% select(income,GDP.percap,Life.Expect.female,Life.Expect.male) %>% 
  melt(id=c('income','GDP.percap'))

df.life$variable<-gsub("Life.Expect.", "", df.life$variable)
names(df.life)[names(df.life) == 'variable'] <- 'Gender'
names(df.life)[names(df.life) == 'value'] <- 'Life.Expectancy'

ggplot(df.life,aes(x=GDP.percap,y=Life.Expectancy,color=income)) +
  geom_point()+
  theme_bw()+
  #Title and Axis labels
  theme(legend.position = c(0.8, 0.8))+
  scale_fill_brewer(palette="RdBu") +
  facet_wrap(~Gender)

#Missing Values
ggplot(dev.inc, aes(x = GDP.percap,y = Education.Expend)) + 
  geom_miss_point()+
  facet_wrap(~income)+
  xlab('GDP per capita (current USD)')+
  ylab('Gov. Expenditure on education(% of GDP)')+
  ggtitle("Missing Values")

ggplot(dev.inc, aes(x = GDP.percap,y = Education.Expend)) + 
  geom_miss_point()+
  facet_wrap(~region)+
  xlab('GDP per capita (current USD)')+
  ylab('Gov. Expenditure on education(% of GDP)')+
  ggtitle("Missing Values")

#Income grouping per GDP
dev.inc %>% select(income,GDP.percap) %>% 
  group_by(income) %>% 
  summarise(max(GDP.percap),min(GDP.percap))

gpd<-ggplot(dev.inc,aes(x=GDP.percap))+
  #Plot Type
  geom_histogram(aes(y = ..density..),color="#1F3552", fill="#4271AE",alpha=0.7) +
  geom_density(lwd = 1,linetype = 2,colour = "black")+
  #Labels
  geom_vline(aes(xintercept=mean(GDP.percap)),
             color="darkblue", linetype="dashed", size=1)+
  #Theme and colors
  theme_bw()+
  scale_fill_brewer(palette="Set1")+
  #Title and Axis labels
  labs(title = "Histogram and Density plot of GDP")+
  xlab('GPD per capita ($)')+
    scale_x_continuous(labels=scales::dollar_format())+
  #Title size
  theme(plot.title = element_text(size=10),
        text = element_text(size=9))
  
gg_miss_fct(dev.inc, income)
gg_miss_fct(dev.inc, region)


#Clustering behaviour indicated by the data, 
#Dimension reduction can aid the discovery of any clusters.
# devtools::install_github("hrbrmstr/ggalt")
library(ggplot2)
library(ggalt)
library(ggfortify)

#Correlation matrices--------------------------------------------------------------------------------------
#Prepare data
features<-dev.inc[,4:14] %>%select(-Education.Expend)
#Find correlation matrix
cor.features<-cor(features)
cor.features<-round(cor.features,2)
#Visualize correlations
plot.cor<-corrplot(cor.features,  method = "color")
pairs(features)

# devtools::install_github("kassambara/ggcorrplot")
library(ggcorrplot)
# Plot
ggcorrplot(cor.features, hc.order = TRUE, 
           type = "lower", 
           lab = TRUE, 
           lab_size = 3, 
           outline.col = "white",
           method = 'square', 
           title="Correlogram", 
           ggtheme=theme_bw)


# explore physical characteristics using ggplots
#GDP, Market cap
dev.inc %>% select(income,GDP.percap,Market.Cap.pcntGDP,Unemployment.female,Unemployment.male) %>% 
ggpairs(mapping = aes(colour=income),
        progress = FALSE, # suppress verbose progress bar output
        lower = list(combo = wrap('facethist', bins=20))
)

dev.inc %>% select(income,Life.Expect.female,Life.Expect.male,Mortality.u5) %>% 
  ggpairs(mapping = aes(colour=income),
          progress = FALSE, # suppress verbose progress bar output
          lower = list(combo = wrap('facethist', bins=20))
  )

dev.inc %>% select(income,Arable.Land.pcnt,CO2.emiss.mtpercap,Access2Elec.pcnt) %>% 
  ggpairs(mapping = aes(colour=income),
          progress = FALSE, # suppress verbose progress bar output
          lower = list(combo = wrap('facethist', bins=20))
  )


# Compute data with principal components ------------------
num.data<-num.data %>% select(-Education.Expend)
pca_mod <- prcomp(num.data,center=TRUE, scale= TRUE)  # compute principal components
pc1 <- pca_mod$x[,1]
pc2 <- pca_mod$x[,2]
pc_df <- data.frame(pc1,pc2,regions=dev.inc$region)
cumsum_evalues <- cumsum(pca_mod$sdev^2)
sum_evalues <- sum(pca_mod$sdev^2)

cat("Proportion of variance across top k PCs, for k=1,...,4:",cumsum_evalues/sum_evalues,"\n")

# Data frame of principal components ----------------------
df_pc <- data.frame(pca_mod$x, region=dev.inc$region,income=dev.inc$income)  # dataframe of principal components

ggplot(data = data.frame(index=1:10,var_prop=(cumsum_evalues/sum_evalues)*100)) +
  geom_point(mapping = aes(x=index,y=var_prop)) + 
  geom_line(mapping = aes(x=index,y=var_prop))+
  ylim(c(0,100)) + 
  scale_x_continuous(breaks = seq(1,10))+
  ggtitle("PCA:Proportion of variance explained by top k PCs") +
  ylab("Proportion of variance") + 
  xlab("Principal components") + 
  theme_bw()

ggplot(pc_df, aes(x=pc1,y=pc2)) +
  geom_point() +
  geom_density_2d() + 
  labs(title="PCA: projection of 68 observations of countries characteristics onto first two PCs")

# Plot ----------------------------------------------------
ggplot(df_pc, aes(PC1, PC2, col=region)) + 
  geom_point(size=2) +   # draw points
  labs(title="Clustering", 
       subtitle="With principal components PC1 and PC2 as X and Y axis") + 
  coord_cartesian(xlim = 1.2 * c(min(df_pc$PC1), max(df_pc$PC1)), 
                  ylim = 1.2 * c(min(df_pc$PC2), max(df_pc$PC2))) 

ggplot(df_pc, aes(PC1, PC2, col=income)) + 
  geom_point(size=2) +   # draw points
  labs(title="Clustering", 
       subtitle="With principal components PC1 and PC2 as X and Y axis") + 
  coord_cartesian(xlim = 1.2 * c(min(df_pc$PC1), max(df_pc$PC1)), 
                  ylim = 1.2 * c(min(df_pc$PC2), max(df_pc$PC2))) 



# K-means clustering
devinc_pca_km2 <- kmeans(pca_mod$x[,1:2], centers=2)

pc_km_df <- bind_cols(pc_df,cluster=as.factor(devinc_pca_km2$cluster))

ggplot(pc_km_df, aes(x=pc1,y=pc2)) +
  geom_point(mapping = aes(colour=cluster)) +
  geom_density_2d(alpha=0.4) + 
  xlab("Principal component 1") + ylab("Principal component 2")



library(factoextra)
devinc_pca_km3 <- kmeans(pca_mod$x[,1:2], centers=3, nstart=10)
fviz_cluster(devinc_pca_km3, 
             data = pca_mod$x[,1:2], 
             labelsize = 0) 

dev_km3 <- kmeans(num.data, centers=3, nstart = 10)
fviz_cluster(dev_km3, 
             data = num.data, 
             labelsize = 0)  #  otherwise the observations are each labelled


z <- num.data
means <- apply(z,2,mean)
sds <- apply(z,2,sd)
nor <- scale(z,center=means,scale=sds)
distance = dist(nor)

mydata.hclust = hclust(distance)
library(cluster)
plot(silhouette(cutree(mydata.hclust,3), distance))
