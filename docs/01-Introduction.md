

# Introduction {#intro} 

<!-- 2018-06-26: <span style="color:red">*VERY Preliminary!*</span> -->




**Prerequisites** 

<!-- [R](https://www.r-project.org/) has come a long way in its evolution. [Its download page](https://cran.r-project.org/) looks pretty much unchanged from years ago but don't be fooled by its archaic appearance. This piece of the past may be something to do with how the R developer community honors its legacy of turning an open-source project into one of the most popular data analytic tools of today. Please don't mistake that archaic look as a sign of snobbishness--I hope you too will appreciate it some day. Welcome to the community.       -->

In what follows below, we assume that you have  [R](https://cran.r-project.org/) and [RStudio](https://www.rstudio.com/products/rstudio/download/) (free/open-source IDE) installed. 

**Sneak Peek**

If you are new to R, the following cheatsheets give you a good idea of how it is like to conduct data analyses in R: [Base R](http://github.com/rstudio/cheatsheets/raw/master/base-r.pdf), 
[RStudio IDE](https://github.com/rstudio/cheatsheets/raw/master/rstudio-ide.pdf), [dplyr](https://github.com/rstudio/cheatsheets/raw/master/data-transformation.pdf), [ggplot2](https://github.com/rstudio/cheatsheets/raw/master/data-visualization-2.1.pdf).  

If you find the materials in this introduction too technical, please start with [ModernDive](https://ismayc.github.io/moderndiver-book/4-viz.html), an open-source textbook that gave an initial inspiration to start this site. Also, more information on R is available in Section \@ref(essentials), as well as various resources listed in Section \@ref(resources).   

## Materials

R is continuously evolving with user-contributed R packages, or a bundle of user-developed programs. Recent developments such as [tidy](https://cran.r-project.org/web/packages/tidyr/vignettes/tidy-data.html), [dplyr](https://cran.r-project.org/web/packages/dplyr/vignettes/dplyr.html), and [ggplot2](https://ggplot2.tidyverse.org/index.html) (often referred to as [tidyverse](https://www.tidyverse.org/) tools) have greatly streamlined the coding for data manipulation and analysis, which is the starting point for learning R chosen for this site.  This [tidyverse](https://www.tidyverse.org/) syntax gives you an intuitive and powerful *data operation language*  to wrangle, visualize, and analyze data. 

Following [dplyr](https://cran.r-project.org/web/packages/dplyr/vignettes/dplyr.html)'s documentation, let's start with a sample dataset of airplane departures and arrivals. This contains information on about 337,000 flights departed from New York City in 2013 (source: [Bureau of Transportation Statistics](https://www.transtats.bts.gov/DatabaseInfo.asp?DB_ID=120&Link=0)). 

In the R console (i.e., the left bottom pane in RStudio), type `install.packages("nycflights13")` and hit enter.  Then, load the package via `library(nycflights13)`, in the current computing environment (called R *session*).  Its built-in data frames will be added to your R session.     

Generally, R packages are installed locally on your computer on an as-needed basis. To install several more packages that we will use, copy the following code and execute it in your R console. 

```r
# Since we're just starting, don't worry about understanding the code here
# "#"" symbole is for adding comments that are helpful to humans but are ignored by R 

required_pkgs <- c("nycflights13", "dplyr", "ggplot2", "lubridate", "knitr", "tidyr", "broom")   
  #  creating a new object "required_pkgs" containing strings "nycflights13", "dplyr",..
  # c(): concatenates string names here 
  # <-:  an assignment operator from right to left

new_pkgs <- required_pkgs[!(required_pkgs  %in% installed.packages())] 
  # checking whether "required_pkgs" are already installed 
  # [ ]:extraction by logical TRUE or FALSE
  # %in%: checks whether items on the left are members of the items on the right.
  # !: a negation operator 

if (length(new_pkgs)) {
  install.packages(new_pkgs, repos = "http://cran.rstudio.com")
}   
```

Once packages are downloaded and installed on your computer, they become available for your libraries. 
In each R session, we load libraries we need (instead of all existing libraries). Here we load the following;


```r
library(dplyr)  # for data manipulation 
library(ggplot2)  # for figures  
library(lubridate) # for date manipulation
library(nycflights13)  # sample data of NYC flights
library(knitr) # for table formatting
library(tidyr) # for table formatting
library(broom)  # for table formatting
```

Let's see the data. 

```r
class(flights) # shows the class attribute
dim(flights)   # obtains dimention of rows and columns 
```

```
## [1] "tbl_df"     "tbl"        "data.frame"
## [1] 336776     19
```
 

```r
head(flights)  # displays first seveal rows and columns 
```

```
## # A tibble: 6 x 19
##    year month   day dep_time sched_dep_time dep_delay arr_time
##   <int> <int> <int>    <int>          <int>     <dbl>    <int>
## 1  2013     1     1      517            515        2.      830
## 2  2013     1     1      533            529        4.      850
## 3  2013     1     1      542            540        2.      923
## 4  2013     1     1      544            545       -1.     1004
## 5  2013     1     1      554            600       -6.      812
## 6  2013     1     1      554            558       -4.      740
## # ... with 12 more variables: sched_arr_time <int>, arr_delay <dbl>,
## #   carrier <chr>, flight <int>, tailnum <chr>, origin <chr>, dest <chr>,
## #   air_time <dbl>, distance <dbl>, hour <dbl>, minute <dbl>,
## #   time_hour <dttm>
```

 `dim()` returns the dimensions of a data frame, and `head()` returns the first several rows and columns. The `flights` dataset contains information on dates, actual departure times, and arrival times, etc. The variables are arranged in columns, and each row is an observation of flight data.   


In R, we refer to a dataset as **data frame**, which is a *class* of R object. The **data frame** class is more general than the **matrix** class in that it can contain variables of more than one mode (numeric, character, factor etc). 
<!-- In case you want an overview of data types right away, here is a [summary](http://www.statmethods.net/input/datatypes.html). -->


## Crafts  

We will focus on six data wrangling functions in the `dplyr` package:

* `filter()`: extracts rows (observations) of a data frame based on logical vectors.   

* `select()`: extracts columns (variables) of a data frame based on column names. 

* `arrange()`: orders rows of a data frame based on column names. 

* `summarise()`: collapses a data frame into summary statistics based on **summary functions** (e.g., statistics functions) specified with column names.      

* `mutate()`: creates new variables and adds them to the existing columns based on **window functions** (e.g., transforming operations) specified with column names.  

* `group_by()`: assigns rows into groups within a data frame based on column names.  

The very first argument in all these functions is a **data frame**, followed by logical vectors, column names, or other kinds of items. This allows for applying these functions sequentially through the first argument; for example, `func3(func2(func1(data,...), ...), ...)`.  This can be rewritten as `data %>% func1(...) %>% func2(...) %>% func3(...)` via **a pipe operator** `%>%`.   
This lets us express a sequence of data wrangling operations in plain English. Specifically, we read `%>%` as **then**, so that the above example becomes; start with the data, then apply `func1(...)`, then apply `func2(...)`, then `func3(..)`.  

Say, we want to find the average of delays in departures and arrivals from New York to the St. Paul-Minneapolis airport (MSP). We can construct the following sequence of instructions: start with the flight data frame, apply `filter()` to extract the rows of flights to MSP, and then apply `summarise()` to calculate the mean.


```r
flights %>%  # data frame "flights", then
  filter(dest == "MSP") %>%  # filter rows, then  
  summarise(   
    # summarise departure and arrival delays for their means 
    # and call them mean_dep_delay and mean_arr_delay respectively
    mean_dep_delay = mean(dep_delay, na.rm = TRUE), 
    mean_arr_delay = mean(arr_delay, na.rm = TRUE) 
    )    # calculate the mean, while removing NA values  
```

```
## # A tibble: 1 x 2
##   mean_dep_delay mean_arr_delay
##            <dbl>          <dbl>
## 1           13.3           7.27
```

In `summarise()`, one can use **summary functions** that maps a vector to a scaler. Examples include functions like `mean()`, `sd()` (standard deviation), `quantile()`, `min()`, `max()`, and `n()` (observation count in the `dplyr` package).      

Each time we apply the `%>%` operator above, we pass a modified data frame from one data wrangling operation to another through the first argument. The above code is equivalent to  


```r
summarise(   # data frame "flights" is inside filter(), which is inside summarise() 
    filter(flights, dest == "MSP"), 
    mean_dep_delay = mean(dep_delay, na.rm = TRUE),
    mean_arr_delay = mean(arr_delay, na.rm = TRUE)
    )
```

```
## # A tibble: 1 x 2
##   mean_dep_delay mean_arr_delay
##            <dbl>          <dbl>
## 1           13.3           7.27
```

You will quickly discover that `%>%` operator makes the code much easier to read, write, and edit and how that inspires you to explore the data more.  

Let's add a few more lines to the previous example. Say, now we want to see the average delay by carrier and sort the results by the number of observations (e.g. flights) in descending order. 

Okay, what do we do?  We make **a sequence of data wrangling operations in plain English** and translate that into **code** by replacing **then** with pipe operator `%>%`.  
For example, try thinking this way; "start with the data frame `flights`; **then** (`%>%`) `filter()` to extract the rows of flights to MSP; **then** group rows by carrier; **then**  `summarise()` data for the number of observations and the means; **then**  `arrange()` the results by the observation count in descending order."   


```r
flight_stats_MSP <- flights %>%  # assign the results to an object named "flight_stats"
  filter(dest == "MSP") %>% 
  group_by(carrier) %>%  #  group rows by carrier 
  summarise(
    n_obs = n(),  # count number of rows 
    mean_dep_delay = mean(dep_delay, na.rm = TRUE),
    mean_arr_delay = mean(arr_delay, na.rm = TRUE)
  ) %>% 
  arrange(desc(n_obs))  # sort by n_obs in descending order

flight_stats_MSP  # show flight_stats object
```

```
## # A tibble: 6 x 4
##   carrier n_obs mean_dep_delay mean_arr_delay
##   <chr>   <int>          <dbl>          <dbl>
## 1 DL       2864         10.7             4.04
## 2 EV       1773         17.1            10.5 
## 3 MQ       1293          8.26            9.56
## 4 9E       1249         19.7             8.09
## 5 OO          4          0.750          -2.00
## 6 UA          2         -6.00           -5.50
```

**Tip #1: Frame tasks in a sequence and use pipe operator %>% accordingly.**

The carrier variable is expressed in the International Air Transportation Association (IATA) code, so let's add a column of carrier names by joining another data frame called `airlines`. In RStudio, you can find this data frame under the **Environment**  tab (in the upper right corner); switch the display option from *Global Environment* to *package:nycflights13*. To inspect the data frame, type `View(airlines)` in the R console. Also, by typing `data()` you can see a list of all datasets that are loaded with libraries. 


```r
# left_join(a,b, by="var") joins two data frames a and b by matching rows of b to a 
  # by identifier variable "var".
# kable() prints a better-looking table here
left_join(flight_stats_MSP, airlines, by="carrier") %>%
  kable(digits=2) 
```



carrier    n_obs   mean_dep_delay   mean_arr_delay  name                     
--------  ------  ---------------  ---------------  -------------------------
DL          2864            10.65             4.04  Delta Air Lines Inc.     
EV          1773            17.09            10.53  ExpressJet Airlines Inc. 
MQ          1293             8.26             9.56  Envoy Air                
9E          1249            19.66             8.09  Endeavor Air Inc.        
OO             4             0.75            -2.00  SkyWest Airlines Inc.    
UA             2            -6.00            -5.50  United Air Lines Inc.    


In the next example, we add new variables to `flights` using `mutate()`.   


```r
flights %>%
  # keep only columns named "dep_delay" and "arr_delay"
  select(dep_delay, arr_delay) %>% 
  mutate(
    gain = arr_delay - dep_delay,
    gain_rank = round(percent_rank(gain), digits = 2)
      # Note: we can immediately use the "gain" variable we just defined. 
  )
```

```
## # A tibble: 336,776 x 4
##    dep_delay arr_delay  gain gain_rank
##        <dbl>     <dbl> <dbl>     <dbl>
##  1        2.       11.    9.     0.810
##  2        4.       20.   16.     0.880
##  3        2.       33.   31.     0.940
##  4       -1.      -18.  -17.     0.220
##  5       -6.      -25.  -19.     0.180
##  6       -4.       12.   16.     0.880
##  7       -5.       19.   24.     0.920
##  8       -3.      -14.  -11.     0.370
##  9       -3.       -8.   -5.     0.540
## 10       -2.        8.   10.     0.820
## # ... with 336,766 more rows
```

We extracted specific columns of `flights` by `select()` and added new columns defined in `mutate()`. `mutate()` differs from `summarise()` in that  `mutate()` adds new columns to the data frame, while `summarise()` collapses the data frame into a summary table. 

There are roughly five types of [window functions](https://cran.r-project.org/web/packages/dplyr/vignettes/window-functions.html) that are commonly used inside `mutate()`: 

  - 1.  **summary functions**, which are interpreted as a vector of repeated values (e.g., a column of an identical mean value)
  - 2.  ranking or ordering functions (e.g., `row_number()`, `min_rank()`, `dense_rank()`, `cume_dist()`, `percent_rank()`, and `ntile()`)
  - 3. offset functions, say defining a lagged variable in time series data (`lead()` and `lag()`)
  - 4. cumulative aggregates (e.g., `cumsum()`, `cummin()`, `cummax()`, `cumall()`, `cumany()`, and `cummean()`)
  - 5. fixed-window rolling aggregates such as a windowed mean, median, etc.  
To look up documentations of these function, for example, type `?cumsum`.  

**Tip #2: In the beginning you might find it confusing to choose between `summarise()` and `mutate()`. Just remeber `mutate()` is for creating new variables or overwriting existing variables.**

By no means, the use of `summarise()` and `mutate()` is not restricted to these functions listed above. You can define your own function and apply inside `summarise()` or `mutate()`. 
Let's quickly go over what a **function** is in R and how you can use a custom function in the *tidyverse syntax*.   

In R, we use `function()` to define a function, which consists of a function name, input arguments separated by comma, and a body containing tasks to be performed (multiple expressions are bundled by brackets `{ }`, and the last expression is returned as an output).    

```
your_function_name <- function(input_arg1, input_arg2) {
                        task1
                        task2
                        .
                        .
                        .
                        output_to_return 
                      } 
```

For a function having only a single expression to execute, we can omit brackets `{ }`.

```
another_function <- function(input args) task_and_output_in_a_single_expression                    
```

Let's go through a few examples. 


```r
vec1 <- c(1:10, NA, NA)
vec1
```

```
##  [1]  1  2  3  4  5  6  7  8  9 10 NA NA
```

```r
my_mean <- function(x, na.rm=TRUE)  mean(x, na.rm = na.rm)   
# sets the default of "na.rm" argument to be TRUE. 

mean(vec1) # returns NA
```

```
## [1] NA
```

```r
my_mean(vec1)
```

```
## [1] 5.5
```

```r
my_mean(vec1, na.rm=FALSE)  # returns NA
```

```
## [1] NA
```

```r
my_zscore <- function(x, remove_na=TRUE, digits=2) { 
  zscore <- (x - my_mean(x, na.rm = remove_na))/sd(x, na.rm = remove_na)  
  round(zscore, digits=digits)
}
  # calculates a z-score of vector x

my_zscore(vec1)
```

```
##  [1] -1.49 -1.16 -0.83 -0.50 -0.17  0.17  0.50  0.83  1.16  1.49    NA
## [12]    NA
```



Let's try using functions `my_mean()` and `my_zscore()` in `summarise()` and `mutate()`. 

```r
flights %>% 
  select(dep_delay) %>% 
  summarise(
    mean_dep_delay_na = mean(dep_delay),  # returns NA
    mean_dep_delay_1 = mean(dep_delay, na.rm = TRUE), # passing argument na.rm = TRUE
    mean_dep_delay_2 = my_mean(dep_delay)  # using my_mean()  
  ) %>%
  kable(digits=2)
```



 mean_dep_delay_na   mean_dep_delay_1   mean_dep_delay_2
------------------  -----------------  -----------------
                NA              12.64              12.64

```r
flights_gain <- flights %>%
  select(dep_delay, arr_delay) %>% 
  mutate(
    gain = arr_delay - dep_delay,
    gain_mean = my_mean(gain),  # returns the same mean for all rows
    gain_z2 = my_zscore(gain)  # using my_zscore()   
  )

head(flights_gain) %>%  # show the first several rows
  kable(digits=2)
```



 dep_delay   arr_delay   gain   gain_mean   gain_z2
----------  ----------  -----  ----------  --------
         2          11      9       -5.66      0.81
         4          20     16       -5.66      1.20
         2          33     31       -5.66      2.03
        -1         -18    -17       -5.66     -0.63
        -6         -25    -19       -5.66     -0.74
        -4          12     16       -5.66      1.20

<!-- Creating a function reduces repetitious codes in multiple places, which makes editing easier and also helps reduce coding errors.  -->

`summarise_all()` and `mutate_all()` apply **summary functions** like `mean()` and `sd()` to all columns in a data frame. But, we can also use any custom function that returns appropriate output (i.e., a scalar output for `summarise_all()` and a vector output for `mutate_all()`).  For example, here are several ways to calculate the means when the data frame contains missing values.  


```r
# Calculation fails due to NA values 
flights_gain %>% 
  select(dep_delay, arr_delay, gain)  %>%
  summarise_all(mean) %>%  
  kable(digits=2) 
```



 dep_delay   arr_delay   gain
----------  ----------  -----
        NA          NA     NA

```r
# filter rows that contain any NA value 
flights_gain %>% 
  select(dep_delay, arr_delay, gain)  %>%
  filter(!is.na(dep_delay) & !is.na(arr_delay)) %>%  
  summarise_all(mean) %>%  
  kable(digits=2) 
```



 dep_delay   arr_delay    gain
----------  ----------  ------
     12.56         6.9   -5.66

```r
# pass argument na.rm=TRUE to mean()
flights_gain %>% 
  select(dep_delay, arr_delay, gain) %>%
  summarise_all(funs(mean), na.rm=TRUE) %>%
    kable(digits=2)
```



 dep_delay   arr_delay    gain
----------  ----------  ------
     12.64         6.9   -5.66

```r
# use a custom function with default na.rm=TRUE
flights_gain %>% 
  select(dep_delay, arr_delay, gain) %>%
  summarise_all(funs(my_mean)) %>%
    kable(digits=2)
```



 dep_delay   arr_delay    gain
----------  ----------  ------
     12.64         6.9   -5.66
 
To practice the *tydiverse syntax* above, start with data extraction by combining `filter()`, `select()`, and `arrange()`.  Then, try summarising data via `summarise()` and creating new variables via `mutate()`, followed by adding additional layers of tasks such as grouping statistics via `group_by()` and filtering data by `filter()`.  


**Exercise** 

Try the following exercises using `flights` data. 

  -  Find the set of all origin-carrier combinations whose destination is MSP. Hint: use `filter()`, `select()`, and `unique()`.  (Ans.: 10 unique combinations.)
  -  Sort that by origin. Hint: use `arrange()`.  
  - Find the mean and standard deviation of air time from New York to MSP. Hint: use `filter()` and `summarise()`. 
  - Find the average arrival delay as a percentage of air time from New York to MSP. Hint: use `filter()`, `mutate()`, and `summarise()`. (Ans.: 4.50%.) 
  - Do the above calculation by carrier. Hint: use `filter()`, `mutate()`, `group_by()`, and `summarise()`.  (Ans.: ranges from -3.57% to 4.97%.) 
  - Do the above calculation by origin and carrier and sort the results by origin. 
  - Do that in z-score using the grand mean and grand s.d. to find any origin-carrier combination exhibits statistically significant arrival delay (in percentage of air time).   Hint: do the following all inside `mutate()`, define a percentage arrival delay variable, define variables for its mean and s.d., and define a z-statistic using those three variables. (Ans.: ranges from -0.118 to 1.584.)    


<!-- ```{r} -->
<!-- flights %>% filter(dest == "MSP") %>%  -->
<!--   mutate(arr_delay_pct = arr_delay/air_time, -->
<!--          avg_arr_delay_pct = mean(arr_delay_pct, na.rm=TRUE), -->
<!--          sd_arr_delay_pct = sd(arr_delay_pct, na.rm=TRUE), -->
<!--          z_arr_delay_pct = (arr_delay_pct -  avg_arr_delay_pct)/sd_arr_delay_pct -->
<!--          ) %>% group_by(origin, carrier) %>% summarise(mean(z_arr_delay_pct, na.rm=T)) %>% arrange(origin) -->
<!-- ``` -->

Take time to do these exercises since we will be using the *tydiverse syntax* in next section.


## Arts  

Now we will cover the tools of data visualization via [ggplot2](http://docs.ggplot2.org/current/).  
The `ggplot2` syntax has three essential components for generating graphics:  **data**,  **aes**,  and **geom**, implementing the following philosophy; 

> 
A statistical graphic is a mapping of **data** variables to **aesthetic** attributes of **geometric** objects.  
--- [@Wilkinson2005]
>  


Coding complex graphics via `ggplot()` may  appear at first intimidating, yet it is very simple once you understand the three primary components:

* **data**: a data frame e.g., the first argument in `ggplot(data, ...)`.    

* **aes**:  specifications for x-y variables and the variables that differentiate **geom** objects by color , shape, or size. e.g., `aes(x = var_x, y = var_y, shape = var_z)`  

* **geom**: geometric objects such as points, lines, bars, etc. with parameters given in the (), e.g., `geom_point()`, `geom_line()`,  `geom_histogram()`  


 
We can further refine a plot by adding secondary components or characteristics such as

* stat: data transformation, overlay of statistical inferences etc. 

* scales: scaling data points etc. 

* coord: Cartesian coordinates, polar coordinates, mapping projections etc.

* facet: laying out multiple plot panels in a grid etc. 

However, don't worry about learning details. You don't need to know them all. All you need is a basic but solid understanding of the three primary components that makes up the structure of the `ggplot` syntax. You can find everything else by Internet search. 

**Tip #3. Learn to ask questions in Internet search for what you want to accomplish with your custom plots. You will frequently find answers in [Stack Overflow](https://stackoverflow.com/).**     

Let's generate five common types of plots: 
**scatter-plots**, **line-graphs**, **boxplots**, **histograms**, and **barplots**. 
To provide a context, we will use these plots to explore potential causes of flight departure delays.   

First, let's consider the possibility of congestion at an airport during certain times of the day or certain seasons. We can use  **barplots** to see whether there is any obvious pattern in the flight distribution across flight origins (i.e., airports) in New York City. A barplot shows observation counts (e.g., rows) by category. 


```r
ggplot(data = flights,  # the first argument is the data frame
       mapping = aes(x = origin)) +   # the second argument is mapping, which is aes()   
  geom_bar()  #  after "+" operator of ggplot(), we add geom_XXX() elements 
```

<img src="01-Introduction_files/figure-html/unnamed-chunk-13-1.png" width="672" />

We can make the plot more informative and aesthetic. 

```r
ggplot(data = flights, 
       mapping = aes(x = origin, fill = origin)) +  # here "fill" gives bars distinct colors 
  geom_bar() +  
  facet_wrap( ~ hour)  #  "facet_wrap( ~ var)" generates a grid of plots by var 
```

<img src="01-Introduction_files/figure-html/unnamed-chunk-14-1.png" width="672" />

Another way to see the same information is a **histogram**. 

```r
flights %>% 
  filter(hour >= 5) %>%  # exclude hour earlier than 5 a.m.
  ggplot(aes(x = hour, fill = origin)) + geom_histogram(binwidth = 1, color = "white") 
```

<img src="01-Introduction_files/figure-html/unnamed-chunk-15-1.png" width="672" />
 
While mornings and late afternoons tend to get busy, there is not much difference in the number of flights across airports. 

**Exercise** 

  - Generate a bar graph showing the number of flights by carrier in the `flights` dataset. Hint: use `aes(x=...)` and  `+ geom_bar()`. 
  
  - Add color coded origins of flights to the previous graph. Hint: use `aes(x=..., fill=...)`. 
  
  - Filter the `flights` data for the date of Janauary 1st and generate a scatter plot of distance and air time. Hint: use `filter()`, `ggplot(aes(x=..., y=...))`, and `+ geom_point(alpha=0.1)`.  
  
  - Add a fitted linear curve to the previous plot. Hint: use `+ geom_smooth(method="lm")`. 
  
  - Further filter the data for the distance range of [0, 2800] and carrier to be either "AA (American Airways)", "DL (Delta)", and "WN (Southwest)" and color-code the graph by carrier. Hint: use `filter(..., carrier %in% c("AA", "DL", "WN"))` and  `aes(x=..., y=..., color=...)` and `geom_smooth(method="lm", se=FALSE)`. 

## More examples 1

The rest of the section provides more examples of `dplyr` and `ggplot2` functions in the context of continued exploration of the flight data.   

Let's see if there are distinct patters of departure delays over the course of a year. We can do this by taking the average of departure delays for each day by flight origin and plot the data as a time series using **line-graphs**.   


```r
delay_day <- flights %>% 
  group_by(origin, year, month, day) %>% 
  summarise(dep_delay = mean(dep_delay, na.rm = TRUE))  %>% 
  mutate(date = as.Date(paste(year, month, day), format="%Y %m %d")) %>%
  filter(!is.na(dep_delay))  #  exclude rows with dep_delay == NA 

delay_day %>%     # "facet_grid( var ~ .)" is similar to "facet_wrap( ~ var)" 
  ggplot(aes(x = date, y = dep_delay)) + geom_line() + facet_grid( origin ~ . ) 
```

<img src="01-Introduction_files/figure-html/unnamed-chunk-16-1.png" width="672" />

Seasonal patterns seem similar across airports, and summer months appear to be busier on average. Let's see how closely these patterns compare across the three line-graphs (EWR, JFK, and LGA) in summer months. 


```r
delay_day %>% 
  filter("2013-07-01" <= date, "2013-08-31" >= date)  %>% 
  ggplot(aes(x = date, y = dep_delay, color = origin)) + geom_line()  
```

<img src="01-Introduction_files/figure-html/unnamed-chunk-17-1.png" width="672" />

We can see similar patterns of spikes across airports occurring on certain days, indicating a tendency for the three airports to get busy on the same days. Would this mean that the three airports tend to be congested at the same time? 

In the previous figure, there seems to be some cyclical pattern of delays. A good place to start would be comparing delays by day of the week. Here is a function to calculate day of the week for a given date.   


```r
# Input: date in the format as in "2017-01-23"
# Output: day of week 
my_dow <- function(date) {
  # as.POSIXlt(date)[['wday']] returns integers 0, 1, 2, .. 6, for Sun, Mon, ... Sat.  
  # We extract one item from a vector (Sun, Mon, ..., Sat) by position numbered from 1 to 7. 
  dow <- as.POSIXlt(date)[['wday']] + 1
  c("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")[dow]  # extract "dow"-th element    
} 

Sys.Date()  # Sys.Date() returns the current date 
```

```
## [1] "2018-06-22"
```

```r
my_dow(Sys.Date()) 
```

```
## [1] "Fri"
```

Now, let's take a look at the mean delay by day of the week using  **boxplots**.


```r
delay_day <- flights %>% 
  group_by(year, month, day) %>% 
  summarise(dep_delay = mean(dep_delay, na.rm = TRUE))  %>% 
  mutate(date = as.Date(paste(year, month, day), format="%Y %m %d"),  
         # date defined by as.Data() function 
         dow = my_dow(date),
         weekend = dow %in% c("Sat", "Sun")  
         # %in% operator: A %in% B returns TRUE/FALSE for whether each element of A is in B. 
  )

# show the first 10 elements of "dow" variable in "delay_day" data frame 
delay_day$dow[1:10]  
```

```
##  [1] "Tue" "Wed" "Thu" "Fri" "Sat" "Sun" "Mon" "Tue" "Wed" "Thu"
```

```r
delay_day <- delay_day %>% mutate(
  # add a sorting order (Mon, Tue, ..., Sun) and overwrite dow    
  dow = ordered(dow, 
                 levels = c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"))
                    )
                           
delay_day$dow[1:10]  
```

```
##  [1] Tue Wed Thu Fri Sat Sun Mon Tue Wed Thu
## Levels: Mon < Tue < Wed < Thu < Fri < Sat < Sun
```

```r
delay_day  %>% 
  filter(!is.na(dep_delay)) %>%
  ggplot(aes(x = dow, y = dep_delay, fill = weekend)) + geom_boxplot() 
```

<img src="01-Introduction_files/figure-html/unnamed-chunk-19-1.png" width="672" />

It appears that delays are on average longer on Thursdays and Fridays and shorter on Saturdays. This is plausible if more people are traveling on Thursdays and Fridays before the weekend, and less are traveling on Saturdays to enjoy the weekend. Are Saturdays really less busy? Let's find out.  


```r
flights_dow <- flights %>% 
  mutate(date = as.Date(paste(year, month, day), format="%Y %m %d"),  
         dow = ordered(my_dow(date),
                        levels = c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun")),
         weekend = dow %in% c("Sat", "Sun")  
  )

# count flight numbers by  
flights_dow %>% 
  group_by(dow) %>%
  summarise( nobs = n() )
```

```
## # A tibble: 7 x 2
##   dow    nobs
##   <ord> <int>
## 1 Mon   50690
## 2 Tue   50422
## 3 Wed   50060
## 4 Thu   50219
## 5 Fri   50308
## 6 Sat   38720
## 7 Sun   46357
```

```r
# visualize this as a bar plot 
flights_dow  %>% 
  ggplot(aes(x = dow)) + geom_bar() 
```

<img src="01-Introduction_files/figure-html/unnamed-chunk-20-1.png" width="672" />

Yes, Saturdays are less busy for the airports in terms of flight numbers.   

Could we generalize this positive relationship between the number of flights and the average delays, which we find across days of the week? To explore this, we can summarize the data into the average delays by date-hour and see if the busyness of a particular hour of a particular day is correlated with the mean delay. Let's visualize these data using a **scatter plot**.     


```r
delay_day_hr <- flights %>% 
  group_by(year, month, day, hour) %>%  # grouping by date-hour 
  summarise(
    n_obs = n(),
    dep_delay = mean(dep_delay, na.rm = TRUE)
    )  %>% 
  mutate(date = as.Date(paste(year, month, day), format="%Y %m %d"),
         dow = my_dow(date)
  ) %>% ungroup()   # it's a good practice to remove group_by() attribute


plot_delay <- delay_day_hr  %>%
  filter(!is.na(dep_delay)) %>% 
  ggplot(aes(x = n_obs, y = dep_delay)) + geom_point(alpha = 0.1)  
    # plot of n_obs against the average dep_delay 
    # where each point represents an date-hour average
    # "alpha = 0.1"  controls the degree of transparency of points 

plot_delay 
```

<img src="01-Introduction_files/figure-html/unnamed-chunk-21-1.png" width="672" />

Along the horizontal axis, we can see how the number of flights is distributed across date-hours. Some days are busy, and some hours busier still. It appears that there are two clusters in the number of flights, showing very slow date-hours (e.g., less than 10 flights flying out of New York city per hour) and normal date-hours (e.g., about 50 to 70 flights per hour). We might guess that the delays in the slow hours are caused by bad weather. On the other hand, for normal hours we may wonder if the excess delays are caused by congestion at the airports. To see this, let's fit a curve that captures the relationships between `n_obs` and `dep_delay`. Our hypothesis is that the delay would become longer as the number of flights increases, which would result in an upward-sloped curve.     


```r
plot_delay  +
  geom_smooth()   #  geom_smooth() addes a layer of fitted curve(s) 
```

```
## `geom_smooth()` using method = 'gam'
```

<img src="01-Introduction_files/figure-html/unnamed-chunk-22-1.png" width="672" />

We cannot see any clear pattern. How about fitting a curve by day of the week? 


```r
plot_delay  +
     # additional aes() argument for applying different colors to the day of the week
  geom_smooth(aes(color = dow), se=FALSE) 
```

```
## `geom_smooth()` using method = 'gam'
```

<img src="01-Introduction_files/figure-html/unnamed-chunk-23-1.png" width="672" />

Surprisingly, the delay does not seem to increase with the flights. There are more delays on Thursdays and Fridays and less delays on Saturdays, but we see no evidence of flight congestion as a cause of delay.   

Let's take a closer look at the distribution of the delays. If it is not normally distributed, we may want to apply a transformation.  


```r
delay_day_hr %>%  filter(!is.na(dep_delay)) %>% 
  ggplot(aes(x = dep_delay)) + geom_histogram(color = "white") 
```

```
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

<img src="01-Introduction_files/figure-html/unnamed-chunk-24-1.png" width="672" />

The distribution of the average delays are greatly skewed.   
To apply a logarithmic transformation, here we have to shift the variable by setting its minimum value  zero.


```r
# define new column called "dep_delay_shifted"
delay_day_hr <- delay_day_hr %>% 
  mutate(dep_delay_shifted = dep_delay - min(dep_delay, na.rm = TRUE) + 1) 

# check summary stats 
delay_day_hr %>% 
  select(dep_delay, dep_delay_shifted) %>%
  with(
    apply(., 2, summary)
    ) %>% t() #  transpose rows and columns  
```

```
##                   Min. 1st Qu.    Median     Mean 3rd Qu. Max. NA's
## dep_delay          -18  1.0543  6.571429 12.98602 15.4414  269   13
## dep_delay_shifted    1 20.0543 25.571429 31.98602 34.4414  288   13
```

**Tips #3:  `with(data, ...)` function allows for referencing variable names inside the data frame (i.e., "var_name" instead of "data$var_name"). This is very useful when you work with various functions that were created outside the tidyverse syntax, while keeping your codes consistent with the tidyverse syntax.**

**Tips #4: apply(data, num, fun)  applies function "fun" for each item in dimension "num" (1 = cows, 2= columns) of the data frame. The data referenced by "." means all variables in the dataset.** 
    
Now the transformed distribution; 


```r
# Under the log of 10 transformation, the distribution looks closer to a normal distribution.
delay_day_hr %>% filter(!is.na(dep_delay_shifted)) %>% 
  ggplot(aes(x = dep_delay_shifted))  +  
  scale_x_log10() + 
  geom_histogram(color = "white") 
```

```
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

<img src="01-Introduction_files/figure-html/unnamed-chunk-26-1.png" width="672" />

```r
# # Alternatively, one can apply the natural logarithm to transform a variable. Histogram shows no difference here.    
# delay_day_hr %>% filter(!is.na(dep_delay_shifted)) %>% 
#   ggplot(aes(x = dep_delay_shifted)) +  
#   scale_x_continuous(trans = "log") +  
#   geom_histogram(color = "white")
```

The transformed distribution is much less skewed than the original. Now, let's plot the relationship between delays and flights again. 


```r
delay_day_hr  %>% filter(!is.na(dep_delay_shifted), dep_delay_shifted > 5) %>% 
  ggplot(aes(x = n_obs, y = dep_delay_shifted)) + 
  scale_y_log10() +     # using transformation scale_y_log10() 
  geom_point(alpha = 0.1)  + 
  geom_smooth()  
```

```
## `geom_smooth()` using method = 'gam'
```

<img src="01-Introduction_files/figure-html/unnamed-chunk-27-1.png" width="672" />

Again we do not see a pattern of more delays for busier hours. It seems that the airports in New York City manage the fluctuating number of flights without causing congestion.  




## More examples 2

Let's keep going with exmaples using `flights` data. 

Previously, we find that the congestion at the airports is unlikely the cause of delays. Then, what else may explain the patterns of delays? Recall that earlier we observe that some airlines have longer delays than others for NYC-MSP flights.  Are some airlines responsible for the delays? Let's take a look at the average delays by carrier.   


```r
stat_carrier <- flights %>% 
  group_by(carrier) %>%
  summarise(n_obs = n(),
            dep_delay = mean(dep_delay, na.rm = TRUE),
            arr_delay = mean(arr_delay, na.rm = TRUE)
            ) %>% 
  left_join(airlines, by="carrier") %>%
  arrange(desc(n_obs)) 

stat_carrier %>% kable(digit=2)
```



carrier    n_obs   dep_delay   arr_delay  name                        
--------  ------  ----------  ----------  ----------------------------
UA         58665       12.11        3.56  United Air Lines Inc.       
B6         54635       13.02        9.46  JetBlue Airways             
EV         54173       19.96       15.80  ExpressJet Airlines Inc.    
DL         48110        9.26        1.64  Delta Air Lines Inc.        
AA         32729        8.59        0.36  American Airlines Inc.      
MQ         26397       10.55       10.77  Envoy Air                   
US         20536        3.78        2.13  US Airways Inc.             
9E         18460       16.73        7.38  Endeavor Air Inc.           
WN         12275       17.71        9.65  Southwest Airlines Co.      
VX          5162       12.87        1.76  Virgin America              
FL          3260       18.73       20.12  AirTran Airways Corporation 
AS           714        5.80       -9.93  Alaska Airlines Inc.        
F9           685       20.22       21.92  Frontier Airlines Inc.      
YV           601       19.00       15.56  Mesa Airlines Inc.          
HA           342        4.90       -6.92  Hawaiian Airlines Inc.      
OO            32       12.59       11.93  SkyWest Airlines Inc.       

While we see some differences, the simple average of delays over various routes, days, and hours of flights may not be a good measure for the comparison across carriers. For example, some carriers may serve the routes and hours that tend to have more delays. Also, given that our dataset covers only the flights from New York City, the comparison may not be nationally representative since carriers use different airports around the country as their regional hubs. 

For our purposes, instead of delays, let's compare the average air time among carriers, for whihch we can account for flight's destination and timing. The differences in air time may indicate some efficiency differences. 

Let's first check how air time relates to flight distance.   

```r
flights %>% 
  filter (month == 1, day == 1, !is.na(air_time)) %>%
  ggplot(aes(x = distance, y = air_time)) + 
  geom_point(alpha = 0.05)  +  
  geom_smooth()
```

```
## `geom_smooth()` using method = 'loess'
```

<img src="01-Introduction_files/figure-html/unnamed-chunk-29-1.png" width="672" />

`air_time` and `distance` show a general linear relationship. We can better account for this relationship if we calculate the average air time for each flight destination from New York City.  

First, consider using a simple linear regression model of air time to account for varying destinations. The idea is to estimate the regression-mean air time for each destination, remove the destination effects from the total variation of air time, and then compare that across carriers. 


```r
# make a copy of flights data
flights2 <- flights

flights2 <- flights2 %>%  # handle missing data as NA 
  mutate( idx_na1 = is.na(air_time) | is.na(dest) )

res <- flights2 %>%  # estimate a linear model and obtain residuals 
  with( 
   lm( air_time ~ 0 + as.factor(dest), subset=!idx_na1)  
        # lm() estimates a linear model. 
        # "y ~ x"" is the formula for regressing y on x. 
        # "y ~ 0 + x" removes the intercept from the model. 
        # as.factor() converts "dest" to a factor (categorical) class
        # which is used as a set of dummy variables in the regression.  
   ) %>% 
  residuals()

summary(res)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
## -57.574  -6.909  -0.953   0.000   5.862 144.317
```

```r
# define a variable containing a vector of NA
# replace rows with idx_na1 == FALSE
flights2$res <- NA
flights2$res[!flights2$idx_na1] <- res 

flights2 %>% 
  group_by(carrier) %>%
  summarise(
    mean_res = mean(res, na.rm = TRUE), # mean residual by carrier 
    sd_res = sd(res, na.rm = TRUE)
    ) %>%
  left_join(stat_carrier, by="carrier") %>% 
  select(carrier, name, n_obs, dep_delay, arr_delay, mean_res, sd_res) %>% 
  arrange(-n_obs) %>% 
  kable(digit=2)
```



carrier   name                           n_obs   dep_delay   arr_delay   mean_res   sd_res
--------  ----------------------------  ------  ----------  ----------  ---------  -------
UA        United Air Lines Inc.          58665       12.11        3.56      -0.87    14.59
B6        JetBlue Airways                54635       13.02        9.46       0.28    11.55
EV        ExpressJet Airlines Inc.       54173       19.96       15.80      -0.37     8.94
DL        Delta Air Lines Inc.           48110        9.26        1.64      -0.20    12.32
AA        American Airlines Inc.         32729        8.59        0.36       0.68    13.86
MQ        Envoy Air                      26397       10.55       10.77       0.45     8.87
US        US Airways Inc.                20536        3.78        2.13      -0.42     9.43
9E        Endeavor Air Inc.              18460       16.73        7.38       0.84     8.76
WN        Southwest Airlines Co.         12275       17.71        9.65       0.16    12.55
VX        Virgin America                  5162       12.87        1.76       3.26    17.58
FL        AirTran Airways Corporation     3260       18.73       20.12       1.16     8.75
AS        Alaska Airlines Inc.             714        5.80       -9.93      -2.13    16.17
F9        Frontier Airlines Inc.           685       20.22       21.92       3.12    15.16
YV        Mesa Airlines Inc.               601       19.00       15.56      -0.05     7.06
HA        Hawaiian Airlines Inc.           342        4.90       -6.92       5.64    20.69
OO        SkyWest Airlines Inc.             32       12.59       11.93       1.02     7.26

It appears to make sense that the average air time is longer for low-cost carriers such as Virgin America, Frontier Airlines, and Hawaiian Airlines. The differences across other carriers, on the other hand, appear small relative to standard errors. To get a sense of whether these differences have any statistical significance, let's use t-test to compare the mean residual between United Airlines and American Airlines.    

```r
# t-test comparing UA vs AA for the mean air time 
flights2 %>%
  with({
    idx_UA <- carrier == "UA"
    idx_AA <- carrier == "AA"
    t.test(res[idx_UA], res[idx_AA])
    })
```

```
## 
## 	Welch Two Sample t-test
## 
## data:  res[idx_UA] and res[idx_AA]
## t = -15.722, df = 68826, p-value < 2.2e-16
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -1.741133 -1.355142
## sample estimates:
##  mean of x  mean of y 
## -0.8689523  0.6791852
```

With a large number of observations, a seemingly small difference in the means often turns out to be statistically significant. Nonetheless, the average difference of about 1.5 minute air time per flight appears very small. 

In fact, we can do this sort of pair-wise comparison all at once using a regression. Using carrier fixed effects in addition to destination fixed effects, we can directly compare the mean effects across carriers. We will set United Airlines to be a reference of the carrier fixed effects, so that the fixed effect for United Airlines is set to zero (i.e., omitted category), from which the fixed effects of all other airlines are estimated. 


```r
flights2$carrier <- relevel(factor(flights2$carrier), ref="UA")  
# reference level is United Airlines
flights2$carrier %>% table()
```

```
## .
##    UA    9E    AA    AS    B6    DL    EV    F9    FL    HA    MQ    OO 
## 58665 18460 32729   714 54635 48110 54173   685  3260   342 26397    32 
##    US    VX    WN    YV 
## 20536  5162 12275   601
```

```r
flights2 %>% 
  with({
    n_carrier <- unique(carrier) %>% length()
    n_dest <- unique(dest) %>% length() 
    print(paste('There are', n_carrier, 'distinct carriers and', 
                n_dest,'distinct destinations in the data.' ))
  })
```

```
## [1] "There are 16 distinct carriers and 105 distinct destinations in the data."
```

With 16 carriers and 105 destinations minus 2 reference levels for carriers and destinations, the total of 119 coefficients will be estimated for the fixed effects.  


```r
f1 <- flights2 %>%
 with(
   lm( air_time  ~  as.factor(carrier) + as.factor(dest) )  
    # fixed effects for carriers and destinations
 )

tidy(f1)[1:20,] # show the first 20 coefficients
```

```
##                    term     estimate  std.error    statistic       p.value
## 1           (Intercept)  247.9884874 0.75069658  330.3445016  0.000000e+00
## 2  as.factor(carrier)9E    1.8015498 0.12723996   14.1586788  1.702649e-45
## 3  as.factor(carrier)AA    1.9326712 0.09731105   19.8607572  1.002388e-87
## 4  as.factor(carrier)AS   -1.9071536 0.49596319   -3.8453531  1.204017e-04
## 5  as.factor(carrier)B6    1.1808039 0.08495098   13.8998267  6.535025e-44
## 6  as.factor(carrier)DL    0.7531812 0.08722600    8.6348244  5.907432e-18
## 7  as.factor(carrier)EV    0.4174574 0.11044837    3.7796605  1.570702e-04
## 8  as.factor(carrier)F9    3.8891981 0.48090201    8.0872985  6.120836e-16
## 9  as.factor(carrier)FL    2.6434074 0.27600661    9.5773336  1.002386e-21
## 10 as.factor(carrier)HA   11.0125104 0.89821710   12.2604106  1.503557e-34
## 11 as.factor(carrier)MQ    1.4592669 0.11892133   12.2708590  1.321669e-34
## 12 as.factor(carrier)OO    1.8091432 2.21222472    0.8177936  4.134757e-01
## 13 as.factor(carrier)US    0.1319337 0.13826299    0.9542230  3.399715e-01
## 14 as.factor(carrier)VX    4.5298528 0.18441295   24.5636378 4.086448e-133
## 15 as.factor(carrier)WN    1.2226161 0.17520980    6.9780125  2.999500e-12
## 16 as.factor(carrier)YV    0.5167461 0.52737831    0.9798395  3.271661e-01
## 17   as.factor(dest)ACK -207.1011095 1.04478912 -198.2228803  0.000000e+00
## 18   as.factor(dest)ALB -216.6188634 0.95130943 -227.7059972  0.000000e+00
## 19   as.factor(dest)ANC  165.1365126 4.26930687   38.6799351  0.000000e+00
## 20   as.factor(dest)ATL -136.1282095 0.75641976 -179.9638460  0.000000e+00
```


```r
# a function to clean up the coefficient table above  
clean_lm_rlt <- function(f) {
  # keep only rows for which column "term" contains "carrier"  e.g., rows 2 to 16 above
  rlt <- tidy(f) %>% filter(grepl("carrier",term)) 

  # create column named carrier 
  rlt <- rlt %>% mutate(carrier = gsub('as.factor\\(carrier\\)','', term)) 

  # drop column term
  rlt <- rlt %>% select(-term)
  
  # add columns of carrier, name, and n_obs from the stat_carrier data frame
  stat_carrier %>%  
    select(carrier, name, n_obs) %>%
    left_join(rlt, by="carrier") 
}

clean_lm_rlt(f1) %>% kable(digit=2)
```



carrier   name                           n_obs   estimate   std.error   statistic   p.value
--------  ----------------------------  ------  ---------  ----------  ----------  --------
UA        United Air Lines Inc.          58665         NA          NA          NA        NA
B6        JetBlue Airways                54635       1.18        0.08       13.90      0.00
EV        ExpressJet Airlines Inc.       54173       0.42        0.11        3.78      0.00
DL        Delta Air Lines Inc.           48110       0.75        0.09        8.63      0.00
AA        American Airlines Inc.         32729       1.93        0.10       19.86      0.00
MQ        Envoy Air                      26397       1.46        0.12       12.27      0.00
US        US Airways Inc.                20536       0.13        0.14        0.95      0.34
9E        Endeavor Air Inc.              18460       1.80        0.13       14.16      0.00
WN        Southwest Airlines Co.         12275       1.22        0.18        6.98      0.00
VX        Virgin America                  5162       4.53        0.18       24.56      0.00
FL        AirTran Airways Corporation     3260       2.64        0.28        9.58      0.00
AS        Alaska Airlines Inc.             714      -1.91        0.50       -3.85      0.00
F9        Frontier Airlines Inc.           685       3.89        0.48        8.09      0.00
YV        Mesa Airlines Inc.               601       0.52        0.53        0.98      0.33
HA        Hawaiian Airlines Inc.           342      11.01        0.90       12.26      0.00
OO        SkyWest Airlines Inc.             32       1.81        2.21        0.82      0.41
 
The "estimate" column shows the mean difference in air time comapred to United Airlines, accounting for the flight destination. The estimate tends to be more precise (i.e., smaller standard errors) for carriers with a larger number of observations. This time, we find that Virgin America, Air Tran, Frontier Airlines, and Hawaiian Airlines tend to show particularly longer air times than United Airlines. 

Next, let's take a step further to account for flight timing as well. We can do this by adding fixed effects for flight dates and hours. 


```r
flights2 <- flights2 %>%
  mutate( date_id = month*100 + day )

flights2$date_id %>% unique() %>% length()
```

```
## [1] 365
```

```r
f2 <- flights2 %>%
 with(
   lm( air_time ~  as.factor(carrier) + as.factor(dest) +
        + as.factor(date_id) + as.factor(hour) )
 )

lm_rlt2 <- clean_lm_rlt(f2)
lm_rlt2 %>% kable(digit=2)
```



carrier   name                           n_obs   estimate   std.error   statistic   p.value
--------  ----------------------------  ------  ---------  ----------  ----------  --------
UA        United Air Lines Inc.          58665         NA          NA          NA        NA
B6        JetBlue Airways                54635       1.60        0.07       22.50      0.00
EV        ExpressJet Airlines Inc.       54173       0.61        0.09        6.67      0.00
DL        Delta Air Lines Inc.           48110       0.95        0.07       13.03      0.00
AA        American Airlines Inc.         32729       1.84        0.08       22.81      0.00
MQ        Envoy Air                      26397       1.45        0.10       14.70      0.00
US        US Airways Inc.                20536       0.17        0.11        1.51      0.13
9E        Endeavor Air Inc.              18460       1.57        0.11       14.72      0.00
WN        Southwest Airlines Co.         12275       1.14        0.15        7.82      0.00
VX        Virgin America                  5162       4.85        0.15       31.57      0.00
FL        AirTran Airways Corporation     3260       2.19        0.23        9.58      0.00
AS        Alaska Airlines Inc.             714      -2.55        0.41       -6.21      0.00
F9        Frontier Airlines Inc.           685       3.31        0.40        8.29      0.00
YV        Mesa Airlines Inc.               601       0.32        0.44        0.73      0.46
HA        Hawaiian Airlines Inc.           342      11.79        0.75       15.80      0.00
OO        SkyWest Airlines Inc.             32       7.63        1.83        4.17      0.00

```r
lm_rlt2 %>% filter(carrier!='UA') %>%
  ggplot(aes(x = carrier, y = estimate)) + geom_col() +
  labs(title = "Mean Air Time Compared to United Airlines")
```

<img src="01-Introduction_files/figure-html/unnamed-chunk-35-1.png" width="672" />

The results are similar to the previous linear mode except that this time SkyWest Airlines shows much longer air time.  

Our final model is a check for the robustness of the above results. Let's replace the date and hour fixed effects in the previous model with date-hour fixed effects (i.e., the interaction between date and hour). We could add such fixed effects using `time_hour` variable defined above. However, that would mean adding nearly 7,000 dummy variables to our linear regression, which is computationally intensive. 

To work around this issue, we approximate this estimation by pre-processing the dependent variable. Specifically, we calculate the average air time for each combination of `time_hour` and `dest` and define a new dependent variable by subtracting this average value from the original air time variable (i.e., the new variable is centered at zero-mean for each combination of `time_hour` and `dest`).  Then, we estimate a linear model with carrier and destination fixed effects. 


```r
## Adding time_hour fixed effects is computationally intensive 
# f1 <- flights %>%
#  with(
#    lm( air_time  ~  as.factor(carrier) + as.factor(dest) + as.factor(time_hour))   
#  )

unique(flights2$time_hour) %>% length()  # 6,936 unique time_hour 
```

```
## [1] 6936
```

```r
flights2 <- flights2 %>% 
  group_by(dest, time_hour) %>%   
  mutate(
    air_time_centered = air_time - mean(air_time, na.rm=TRUE) 
  )

f3 <- flights2 %>%
 with(
   lm( air_time_centered  ~  as.factor(carrier) + as.factor(dest) )
 )
  
lm_rlt3 <- clean_lm_rlt(f3)
lm_rlt3 %>% kable(digit=2) # Note: standard errors, t-stat, and p-val are incorrect
```



carrier   name                           n_obs   estimate   std.error   statistic   p.value
--------  ----------------------------  ------  ---------  ----------  ----------  --------
UA        United Air Lines Inc.          58665         NA          NA          NA        NA
B6        JetBlue Airways                54635       0.82        0.03       32.24      0.00
EV        ExpressJet Airlines Inc.       54173       0.88        0.03       26.50      0.00
DL        Delta Air Lines Inc.           48110       0.52        0.03       19.85      0.00
AA        American Airlines Inc.         32729       1.20        0.03       41.06      0.00
MQ        Envoy Air                      26397       1.00        0.04       27.84      0.00
US        US Airways Inc.                20536      -0.09        0.04       -2.21      0.03
9E        Endeavor Air Inc.              18460       1.27        0.04       33.07      0.00
WN        Southwest Airlines Co.         12275       1.30        0.05       24.70      0.00
VX        Virgin America                  5162       3.47        0.06       62.59      0.00
FL        AirTran Airways Corporation     3260       1.78        0.08       21.48      0.00
AS        Alaska Airlines Inc.             714      -2.86        0.15      -19.15      0.00
F9        Frontier Airlines Inc.           685       1.99        0.14       13.73      0.00
YV        Mesa Airlines Inc.               601       0.78        0.16        4.89      0.00
HA        Hawaiian Airlines Inc.           342       1.34        0.27        4.96      0.00
OO        SkyWest Airlines Inc.             32       3.50        0.67        5.26      0.00

```r
lm_rlt3 %>% filter(carrier!='UA') %>%
  ggplot(aes(x = carrier, y = estimate)) + geom_col() +
  labs(title = "Mean Air Time Compared to United Airlines: Robustness Check")
```

<img src="01-Introduction_files/figure-html/unnamed-chunk-36-1.png" width="672" />

The point estimates should be approximately what we would obtain if we regress `air_time` on the fixed effects of `carrier`, `dest`, and `time_hour`. However, the standard errors are not correctly displayed in the table because the centered variable has a smaller total variation compared to the original `air_time` variable. (Correct standard errors can be obtained, for example, through a bootstrapping technique.)  

Overall, we see again a tendency that lower-cost carriers like Sky West Airlines, Virgin America, Frontier Airlines, and Air Tran show particularly longer air time than United Airlines. Jet Blue Airways, another low-cost carrier, shows a less obvious difference from  United Airlines, possibly suggesting that their operation focused on the East Cost is efficient for the flights departing from New York City.  Hawaiian Airlines and Alaskan Airlines appear to be somewhat different from other carriers perhaps because they are more specialized in particular flight destinations compared to their rivals. In particular, the flights to Hawaii may have distinct delay patterns that are concentrated on peak vacation seasons. 

##  Reflections 

In this introduction, we reviewed the tools of `deplyr` and `ggplot2` packages as a starting point for data analyses and visualization in R.  This new generation of tools utilizing the *tidyverse syntax*  is particularly suitable for data exploration. It allows for simple conversions of our inquiry into sequential coding of data manipulation and analysis via pipe operator `%>%`. Also, manipulating data and creating plots are streamlined via the systematic framework over three primary components `data`, `aes`, and `geom`.         


<!-- Using the flight dataset, we also investigated flight delay patterns. We found that airport congestion was unlikely a major cause of delay in New York City. There were small differences in the air time (e.g. less than 5 minutes) across carriers for a given destination.   -->

<!-- In fact, the concept of "delay" is complicated because it is defined in reference to the scheduled time of departure and arrival.  A delay may be not capture  the time people spend sitting in the airplane before the take-off or after landing. -->


<!-- This brings us to the final point of this exercise; an interesting data analysis requires **knowledge on the real-world process that generated the data** and **the ability to ask insightful questions**. `deplyr` and `ggplot2` packages can let you employ a variety of data analytics tools with ease, but the ultimate power of the analysis will always rest on your knowledge and creativity.  -->

