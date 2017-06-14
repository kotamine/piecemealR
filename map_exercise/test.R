
# ----- Labor statistics summary ------- 

library(blscrapeR)
library(dplyr)
# https://mran.revolutionanalytics.com/web/packages/blscrapeR/vignettes/Employment_and_Unemployment.html
# https://mran.revolutionanalytics.com/web/packages/blscrapeR/vignettes/QCEW_API.html

## Example
# df <- bls_api(c("LNS13327709", "LNS14000000"),
#               startyear = 2000, endyear = 2015)
# tail(df)

# Retrieve data from Quarterly Census of Employment and Wages API (2012 - some part of 2016)
# based on NAICS industry code 
# https://data.bls.gov/cew/doc/access/csv_data_slices.htm
# https://classcodes.com/naics-5-digit-industry-code-list/
# https://classcodes.com/naics-4-digit-industry-group-code-list/
# example: tmp_df0  <- qcew_api(year=2015, qtr = 1, slice="industry", sliceCode=11212)

qcew_by_niacs  <- function(niacs, start_year=2012, end_year=2015) {
  tmp_df <- bind_rows(
    lapply(c(start_year:end_year), function(y) {
      bind_rows(
        lapply(c(1:4), function(q) qcew_api(year=y, 
                                            qtr = q, 
                                            slice="industry", 
                                            sliceCode=niacs))
      )
    })
  )
}

qcew_emplvl_wage <- function(df, level = "county") {
  if (level=="county") {
    level_code_low <-  70; level_code_high <- Inf 
  } else if (level=="state") {
    level_code_low <-  50; level_code_high <- 69 
  } else {
    level_code_low <-  0; level_code_high <- Inf 
  }
  
  df %>%
    mutate(
      avg_emplvl = rowMeans(cbind(month1_emplvl, month2_emplvl, month3_emplvl), na.rm=TRUE),
      avg_wage = total_qtrly_wages/avg_emplvl
    ) %>% 
    filter(agglvl_code >= level_code_low, agglvl_code <= level_code_high) %>%  
    group_by(own_code, area_fips, year) %>%
    summarise(
      avg_emplvl = mean(avg_emplvl, na.rm =TRUE) %>% round(0),
      avg_wage = sum(avg_wage, na.rm =TRUE) %>% round(0),
      avg_wage = ifelse(avg_wage==0, NA, avg_wage)
    ) %>% mutate(
      state = substr(area_fips, 1, 2)
    )
}

data_elementary_school <- qcew_by_niacs(niacs = 6111)


na_to_zero <- function(v) ifelse(is.na(v), 0, v)

na_mean3 <- function(v1, v2, v3) {
  (na_to_zero(v1) + na_to_zero(v2) + na_to_zero(v3))/
  sum(!is.na(c(v1,v2,v3)))
}

na_mean3(1,2,NA)

na_mean3b <- function(vec) {
  sum(vec, na.rm=TRUE)/sum(!is.na(vec))
}


na_mean3b(c(1,2,NA))

tmp <- data_elementary_school %>%
  mutate(
    avg_emplvl = rowMeans(cbind(month1_emplvl, month2_emplvl, month3_emplvl), na.rm=TRUE),
    avg_wage = total_qtrly_wages/avg_emplvl,
    avg_wage = ifelse(avg_wage==0, NA, avg_wage)
  ) 

tmp %>% head

tmp %>% filter(agglvl_code >= 70) %>% with(summary(avg_wage))

tmp %>% filter(agglvl_code >= 70, year==2015, area_fips=="27053") 



tmp2 <- tmp %>%
  filter(agglvl_code >= 70) %>%
  group_by(area_fips, own_code, year) %>%
  summarise(
    avg_emplvl = mean(avg_emplvl, na.rm =TRUE) %>% round(0),
    avg_wage = sum(avg_wage, na.rm =TRUE) %>% round(0)
  ) %>%
  mutate(
    state = substr(area_fips, 1, 2)
  )

tmp2 %>% filter(year==2015, area_fips=="27053") 


tmp2  %>% filter(avg_wage>0) %>% with(summary(avg_wage))
 

df_elementary_school <- data_elementary_school %>% qcew_emplvl_wage()
# df_elementary_school <- qcew_by_niacs(niacs = 6111) %>% qcew_emplvl_wage()

library(dplyr)
library(tidyr)
library(broom)
library(ggplot2)
library(RColorBrewer)
library(grid)
library(gridExtra)
library(scales)
library(tigris)
# library(acs)
library(stringr)
library(stringi)
library(leaflet)
library(htmlwidgets)

setwd("/Users/kota/Dropbox/R_projects/dairy_maps")

load("data/shape_counties.RData")

geo_data <- geo_join(shape_counties, 
         df_elementary_school %>% filter(year == 2015, own_code==3),
         "FIPS", "area_fips") 

var <- "avg_wage"

geo_data[[var]] <- geo_data@data[[var]]

pal <- colorQuantile('YlGnBu', NULL, n = 8, na.color = '#DBDBDB')
# pal <- colorNumeric(
#   palette = "YlGnBu",
#   domain = geo_data[[var]],
#   na.color = 	"#FFFFFF"
# )
# pal <- colorFactor(
#   palette = palette,
#   domain = geo_data[[var]],
#   na.color = 	"#FFFFFF"
# )
  

label <- paste0("FIPS", geo_data$FIPS, "  ",
                "$", round(geo_data@data[[var]], 0))

leaflet() %>%
  addProviderTiles("CartoDB.Positron") %>%
  addPolygons(
    data = geo_data,
    fillColor = ~pal(geo_data[[var]]),
    color = "#b2aeae", # you need to use hex colors
    fillOpacity = 0.7,
    weight = 1,
    smoothFactor = 0.2,
    # popup = popup
    label = label
  ) %>%
  addLegend(pal = pal,
            values = data_geo[[var]],
            position = "bottomright",
            title = "Teacher salary",
            na.label = "",
            labFormat = labelFormat(prefix = "", suffix="")) %>%
  setView(lng = -93.85, lat = 37.45, zoom = 4) %>%
  fitBounds(-125, 25, -67, 50)


