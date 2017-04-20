


# Essentials {#essentials}

2017-04-20: <span style="color:red">*VERY Preliminary!*</span>

This section provides an overview of the essential concepts for manipulating data and programming in R. 


## Cheatsheets 

Cheatsheets are useful for glancing at various functions.    

* [Base R](http://github.com/rstudio/cheatsheets/raw/master/source/pdfs/base-r.pdf)

* [RStudio IDE](https://www.rstudio.com/wp-content/uploads/2016/01/rstudio-IDE-cheatsheet.pdf)

* [dplyr](https://github.com/rstudio/cheatsheets/raw/master/source/pdfs/data-transformation-cheatsheet.pdf)

* [ggplot2](https://www.rstudio.com/wp-content/uploads/2016/11/ggplot2-cheatsheet-2.1.pdf)


## Data types

### Atomic 

In most cases, each atomic element has a type (mode) of

* `numeric`: number

* `logical`: TRUE or FALSE (T or F for shortcuts)

* `character`: character string

* `factor`: a level of categorical variable   

Other types include [date](http://www.statmethods.net/input/dates.html) and nonexistent `NULL`. The factor is also a *class* of its own, meaning that many R functions apply operations that are specific to the *factor class*.  


```r
# assess objects 123, "abc", and TRUE for their types 
str(123)  # str() returns the structure
```

```
##  num 123
```

```r
str("abc")
```

```
##  chr "abc"
```

```r
str(TRUE)
```

```
##  logi TRUE
```

```r
c(is.numeric(123), is.numeric("abc"), is.numeric(TRUE))
```

```
## [1]  TRUE FALSE FALSE
```

```r
c(is.logical(123), is.logical("abc"), is.logical(TRUE))
```

```
## [1] FALSE FALSE  TRUE
```

```r
c(is.character(123), is.character("abc"), is.character(TRUE))
```

```
## [1] FALSE  TRUE FALSE
```

```r
# "<-" means an assignment from right to left
factor1 <- as.factor(c(1,2,3)) # Looks like numeric but not
factor1
```

```
## [1] 1 2 3
## Levels: 1 2 3
```

```r
factor2 <- as.factor(c("a","b","c"))  # Looks like characters but not
factor2
```

```
## [1] a b c
## Levels: a b c
```

```r
factor3 <- as.factor(c(TRUE,FALSE,T)) # Looks like logicals but not
factor3
```

```
## [1] TRUE  FALSE TRUE 
## Levels: FALSE TRUE
```

```r
c(is.factor(factor1[1]), is.factor(factor2[1]), is.factor(factor3[1]))
```

```
## [1] TRUE TRUE TRUE
```

```r
# Extract the first element (factor1[1] etc.) 
factor1[1]
```

```
## [1] 1
## Levels: 1 2 3
```

```r
factor2[2]
```

```
## [1] b
## Levels: a b c
```

```r
factor3[3]
```

```
## [1] TRUE
## Levels: FALSE TRUE
```

`NULL` has zero-length. Also, empty numeric, logical, and character objects have zero-length.  

```r
length(NULL) 
```

```
## [1] 0
```

```r
length(numeric(0))  # numeric(N) returns a vector of N zeros 
```

```
## [1] 0
```

```r
length(logical(0))  # logical(N) returns a vector of N FALSE objects
```

```
## [1] 0
```

```r
length(character(0)) # character(N) returns a vector of N "" objects
```

```
## [1] 0
```

Each **vector** has a type of `numeric`, `logical`, `character`, or `factor`.
Each **matrix** has a type of `numeric`, `logical`, or `character`.
A **data frame** can contain mixed types across columns where each column (e.g., a variable) has a type of `numeric`, `logical`, `character` or `factor`. 


```r
vector1 <- c(1, NA, 2, 3) # read as numeric
vector1
```

```
## [1]  1 NA  2  3
```

```r
vector2 <- c(TRUE, FALSE, T, F) # read as logical
vector2
```

```
## [1]  TRUE FALSE  TRUE FALSE
```

```r
vector3 <- c(1, NA, "abc", TRUE, "TRUE") # read as character
vector3
```

```
## [1] "1"    NA     "abc"  "TRUE" "TRUE"
```

```r
vector4 <- as.factor(c(1, NA, "abc", TRUE, "TRUE")) # read as factor 
vector4
```

```
## [1] 1    <NA> abc  TRUE TRUE
## Levels: 1 abc TRUE
```


```r
matrix1 <- matrix(c(1:6), nrow = 3) # read as numeric
matrix1
```

```
##      [,1] [,2]
## [1,]    1    4
## [2,]    2    5
## [3,]    3    6
```

```r
matrix2 <- matrix(c(TRUE,FALSE,rep(T,3),F), nrow = 3)  # read as logical
matrix2
```

```
##       [,1]  [,2]
## [1,]  TRUE  TRUE
## [2,] FALSE  TRUE
## [3,]  TRUE FALSE
```

```r
matrix3 <- matrix(c(1,2,3,"a","b","abc"), nrow = 3) # read as character
matrix3
```

```
##      [,1] [,2] 
## [1,] "1"  "a"  
## [2,] "2"  "b"  
## [3,] "3"  "abc"
```

```r
df1 <- data.frame(
        num  = c(1,2,3),           # read as numeric
        fac1 = c("a","b","abc"),   # read as factor
        logi = c(TRUE, FALSE, T),  # read as logical
        fac2  = c(1,"a",TRUE)      # read as factor
       )  
df1
```

```
##   num fac1  logi fac2
## 1   1    a  TRUE    1
## 2   2    b FALSE    a
## 3   3  abc  TRUE TRUE
```

```r
df1$num   # "$" symbol is used to extract a column 
```

```
## [1] 1 2 3
```

```r
df1$fac1  # character type is converted into a factor 
```

```
## [1] a   b   abc
## Levels: a abc b
```

```r
df1$logi
```

```
## [1]  TRUE FALSE  TRUE
```

```r
df1$fac2  # mixed types within a column is converted into a factor
```

```
## [1] 1    a    TRUE
## Levels: 1 a TRUE
```

```r
# additional argument "stringsAsFactors = FALSE" preserves character types.
df2 <- data.frame(
        num  = c(1,2,3),           # read as numeric
        char = c("a","b","abc"),   # read as character
        logi = c(TRUE, FALSE, T),  # read as logical
        fac2  = as.factor(c(1,"a",TRUE)),      # read as factor
        stringsAsFactors = FALSE
       )  
df2
```

```
##   num char  logi fac2
## 1   1    a  TRUE    1
## 2   2    b FALSE    a
## 3   3  abc  TRUE TRUE
```

```r
df2$num  
```

```
## [1] 1 2 3
```

```r
df2$char
```

```
## [1] "a"   "b"   "abc"
```

```r
df2$logi
```

```
## [1]  TRUE FALSE  TRUE
```

```r
df2$fac2
```

```
## [1] 1    a    TRUE
## Levels: 1 a TRUE
```

### Factor

A factor object is defined with a set of categorical levels, which may be labeled. The levels are either **ordered** (defined by `ordered()`) or **unordered** (defined by `factor()`). 
Ordered factor objects are treated in the specific order by certain statistical and graphical procedures.    


```r
# We will convert the columns of df into factors   
df <- data.frame(
      fac1 = c(0,1,1,4,4,2,2,3),
      fac2 = c(1,2,3,1,1,2,2,3),
      fac3 = c(4,2,3,4,4,2,2,3)
      )

# convert fac1 to ordered factors
df$fac1 <- ordered(df$fac1,
                  levels = c(0,4,3,2,1) # defines the order
                  ) 
df$fac1
```

```
## [1] 0 1 1 4 4 2 2 3
## Levels: 0 < 4 < 3 < 2 < 1
```

```r
summary(df$fac1)  # gives the table of counts for each level
```

```
## 0 4 3 2 1 
## 1 2 1 2 2
```

```r
# convert fac2 to unordered factors with labels
df$fac2 <- factor(df$fac2,
                  levels = c(1,2,3), #  no particular order
                  # attach labels to factors: 1=red, 2=blue, 3=green
                  labels = c("red", "blue", "green")
                  ) 
df$fac2
```

```
## [1] red   blue  green red   red   blue  blue  green
## Levels: red blue green
```

```r
summary(df$fac2)                
```

```
##   red  blue green 
##     3     3     2
```

```r
# convert fac3 to ordered factors with labels
df$fac3 <- ordered(df$fac3,
                  levels = c(2,3,4),
                  # attach labels to factors: 2=Low, 3=Medium, 4=High
                  labels = c("Low", "Medium", "High")
                  ) 
df$fac3
```

```
## [1] High   Low    Medium High   High   Low    Low    Medium
## Levels: Low < Medium < High
```

```r
summary(df$fac3)
```

```
##    Low Medium   High 
##      3      2      3
```

### Matrix

`matrix()` defines a matrix from a vector. The default is to arrange the vector by column (`byrow = FALSE`).  


```r
# byrow = FALSE  (the default)
matrix(data = c(1:6), nrow = 2, ncol = 3, byrow = FALSE, dimnames = NULL)
```

```
##      [,1] [,2] [,3]
## [1,]    1    3    5
## [2,]    2    4    6
```

```r
# byrow = TRUE 
matrix(data = c(1:6), nrow = 2, ncol = 3, byrow = TRUE, dimnames = NULL)
```

```
##      [,1] [,2] [,3]
## [1,]    1    2    3
## [2,]    4    5    6
```

```r
# give row and column names to a matrix 
mat1 <- matrix(data = c(1:6), nrow = 2, ncol = 3, byrow = FALSE, 
       dimnames = list(c("r1","r2"), c("c1","c2","c3")))
mat1
```

```
##    c1 c2 c3
## r1  1  3  5
## r2  2  4  6
```

```r
dim(mat1)  # dimension: row by column
```

```
## [1] 2 3
```

```r
colnames(mat1)
```

```
## [1] "c1" "c2" "c3"
```

```r
rownames(mat1)
```

```
## [1] "r1" "r2"
```

```r
colnames(mat1) <- c("v1","v2","v3")  # change column names by assignment "<-" 
mat1
```

```
##    v1 v2 v3
## r1  1  3  5
## r2  2  4  6
```

```r
# R makes a guess when only nrow or ncol is supplied
matrix(data = c(1:6), nrow = 2)
```

```
##      [,1] [,2] [,3]
## [1,]    1    3    5
## [2,]    2    4    6
```

```r
matrix(data = c(1:6), ncol = 3)
```

```
##      [,1] [,2] [,3]
## [1,]    1    3    5
## [2,]    2    4    6
```

```r
# combine matrices by column via "cbind()" or by row via "rbind()"
cbind(mat1,mat1)
```

```
##    v1 v2 v3 v1 v2 v3
## r1  1  3  5  1  3  5
## r2  2  4  6  2  4  6
```

```r
rbind(mat1,mat1)
```

```
##    v1 v2 v3
## r1  1  3  5
## r2  2  4  6
## r1  1  3  5
## r2  2  4  6
```

There are recycling rules (which does/controls what?) in R. 


```r
# the vector shorter than the length of all elements of a matrix
matrix(data = c(1:4), nrow = 2, ncol= 3)
```

```
## Warning in matrix(data = c(1:4), nrow = 2, ncol = 3): data length [4] is
## not a sub-multiple or multiple of the number of columns [3]
```

```
##      [,1] [,2] [,3]
## [1,]    1    3    1
## [2,]    2    4    2
```

```r
# R treats a scaler as a vector of length that conforms cbind() or rbind()  
cbind(mat1, colA = 1)
```

```
##    v1 v2 v3 colA
## r1  1  3  5    1
## r2  2  4  6    1
```

```r
rbind(mat1, rowA= 1, rowB= 2, rowC= 3)
```

```
##      v1 v2 v3
## r1    1  3  5
## r2    2  4  6
## rowA  1  1  1
## rowB  2  2  2
## rowC  3  3  3
```

To replace elements of a matrix, we can use assignment operator `<-`. 

```r
mat1[1,1] <- 10
mat1
```

```
##    v1 v2 v3
## r1 10  3  5
## r2  2  4  6
```

```r
mat1[,2] <- c(7,8)
mat1
```

```
##    v1 v2 v3
## r1 10  7  5
## r2  2  8  6
```

```r
mat1[,1] <- 0  # recycling rule
mat1
```

```
##    v1 v2 v3
## r1  0  7  5
## r2  0  8  6
```

Matrix allows for easy extraction for rows and columns separated by comma. 

```r
mat1
```

```
##    v1 v2 v3
## r1  0  7  5
## r2  0  8  6
```

```r
mat1[1, ]  # row = 1 and all columns
```

```
## v1 v2 v3 
##  0  7  5
```

```r
mat1[, 1]  # all rows and col = 1 
```

```
## r1 r2 
##  0  0
```

```r
mat1[c(TRUE,FALSE),]  # by a logical vector 
```

```
## v1 v2 v3 
##  0  7  5
```

```r
mat1[, c(TRUE,FALSE)]
```

```
##    v1 v3
## r1  0  5
## r2  0  6
```

```r
mat1[2,3]  # row = 2 and col = 3
```

```
## [1] 6
```

```r
mat1[1:2, 2:3]  # row = 1:2 and col = 2:3
```

```
##    v2 v3
## r1  7  5
## r2  8  6
```

```r
mat1[1:2, 2:3][2,2]  # subset of a subset
```

```
## [1] 6
```

```r
mat1[, 1][2]  # vector extraction is done with one-dimensional index  
```

```
## r2 
##  0
```

Important: when a single row or column is extracted, it gets converted to a vector with no dimension. 

```r
mat1[1,]
```

```
## v1 v2 v3 
##  0  7  5
```

```r
is.matrix(mat1[1, ])  
```

```
## [1] FALSE
```

```r
dim(mat1[1,])
```

```
## NULL
```

```r
length(mat1[1, ])  
```

```
## [1] 3
```

```r
# to keep a row or column vector structure, use drop = FALSE
mat1[1,, drop = FALSE]
```

```
##    v1 v2 v3
## r1  0  7  5
```

```r
is.matrix(mat1[1,,drop = FALSE])  
```

```
## [1] TRUE
```

```r
dim(mat1[1,,drop = FALSE])
```

```
## [1] 1 3
```

```r
length(mat1[1,,drop = FALSE])  
```

```
## [1] 3
```

```r
mat1[,1, drop = FALSE]
```

```
##    v1
## r1  0
## r2  0
```

```r
is.matrix(mat1[,1,drop = FALSE])  
```

```
## [1] TRUE
```

```r
dim(mat1[,1,drop = FALSE])
```

```
## [1] 2 1
```

```r
length(mat1[,1,drop = FALSE])  
```

```
## [1] 2
```

Another way of extraction from a matrix is to use row or column names.

```r
mat1[,'v1']
```

```
## r1 r2 
##  0  0
```

```r
mat1[,c('v1','v3')]
```

```
##    v1 v3
## r1  0  5
## r2  0  6
```

```r
mat1['r2',,drop= FALSE]
```

```
##    v1 v2 v3
## r2  0  8  6
```

`apply()` applies a function for a specified margin (dimension index number) of the matrix. 


```r
mat1
```

```
##    v1 v2 v3
## r1  0  7  5
## r2  0  8  6
```

```r
apply(mat1,1,mean)  # dimension 1 (across rows)
```

```
##       r1       r2 
## 4.000000 4.666667
```

```r
apply(mat1,2,mean)  # dimension 2 (across columns)
```

```
##  v1  v2  v3 
## 0.0 7.5 5.5
```

```r
# one can write a custom function inside apply(). (called annonymous function)    
# Its argument corresponds to the row or column vector passed by apply(). 
apply(mat1,2, function(x) sum(x)/length(x) )  # x is the internal vector name
```

```
##  v1  v2  v3 
## 0.0 7.5 5.5
```

```r
ans1 <- apply(mat1,2, function(x) {   
                         avg = mean(x)
                         sd = sd(x)
                          # return the results as a list
                         list(Avg = avg, Sd = sd)
                      }
        )

unlist(ans1[[2]])  # results for the second column  
```

```
##       Avg        Sd 
## 7.5000000 0.7071068
```

```r
unlist(ans1[[3]])  # results for the third column  
```

```
##       Avg        Sd 
## 5.5000000 0.7071068
```


Arrays are a generalization of matrices and can have more than 2 dimensions. 

```r
array(c(1:18), c(2,3,3))  # dimension 2 by 2 by 3
```

```
## , , 1
## 
##      [,1] [,2] [,3]
## [1,]    1    3    5
## [2,]    2    4    6
## 
## , , 2
## 
##      [,1] [,2] [,3]
## [1,]    7    9   11
## [2,]    8   10   12
## 
## , , 3
## 
##      [,1] [,2] [,3]
## [1,]   13   15   17
## [2,]   14   16   18
```

```r
array(c(1:9), c(2,3,3))  # R recycles the vector 
```

```
## , , 1
## 
##      [,1] [,2] [,3]
## [1,]    1    3    5
## [2,]    2    4    6
## 
## , , 2
## 
##      [,1] [,2] [,3]
## [1,]    7    9    2
## [2,]    8    1    3
## 
## , , 3
## 
##      [,1] [,2] [,3]
## [1,]    4    6    8
## [2,]    5    7    9
```

### Data Frame
A data frame is similar to a matrix, but it accepts multiple types (modes) of variables across columns (e.g., a dataset in typical data analysis programs like SAS, SPSS, Stata etc.). In some cases matrices and data frames may be treated interchangeably, but generally they need to be distinguished. Data manipulation functions are often written for data frames, while some base R functions are written for matrices.    


```r
mymat1 <- matrix(data = c(1:6), nrow = 2, ncol = 3, 
       dimnames = list(c("r1","r2"), c("c1","c2","c3"))) 
mymat1
```

```
##    c1 c2 c3
## r1  1  3  5
## r2  2  4  6
```

```r
class(mymat1)
```

```
## [1] "matrix"
```

```r
colnames(mymat1)
```

```
## [1] "c1" "c2" "c3"
```

```r
names(mymat1)
```

```
## NULL
```

```r
mydf1 <- data.frame(
                mymat1, 
                num  = c(1,2),         
                fac1 = c("a","abc"),    
                logi = c(TRUE, FALSE), 
                fac2  = c(1,"a")   
              )  
mydf1
```

```
##    c1 c2 c3 num fac1  logi fac2
## r1  1  3  5   1    a  TRUE    1
## r2  2  4  6   2  abc FALSE    a
```

```r
class(mydf1)
```

```
## [1] "data.frame"
```

```r
colnames(mydf1)
```

```
## [1] "c1"   "c2"   "c3"   "num"  "fac1" "logi" "fac2"
```

```r
names(mydf1)   # colnames and names are the same 
```

```
## [1] "c1"   "c2"   "c3"   "num"  "fac1" "logi" "fac2"
```

Extracting elements from a data frame is similar to extracting from a matrix, but there are a few additional methods.

```r
mydf1[1,]   # row = 1 and all columns 
```

```
##    c1 c2 c3 num fac1 logi fac2
## r1  1  3  5   1    a TRUE    1
```

```r
mydf1[,1]   # all rows and col = 1
```

```
## [1] 1 2
```

```r
# data frame preserves dimension while extracting a row but not a column
dim(mydf1[1,])  
```

```
## [1] 1 7
```

```r
dim(mydf1[,1])  
```

```
## NULL
```

```r
dim(mydf1[,1,drop=FALSE])   # use drop = FALSE to keep a column vector
```

```
## [1] 2 1
```

```r
mydf1[,1,drop=FALSE]
```

```
##    c1
## r1  1
## r2  2
```

```r
mydf1[, c('c1','num','logi')]
```

```
##    c1 num  logi
## r1  1   1  TRUE
## r2  2   2 FALSE
```

```r
class(mydf1[, c('c1','num','logi')])
```

```
## [1] "data.frame"
```

```r
# extraction by column name with "$" symbol:  df$varname  
mydf1$c1
```

```
## [1] 1 2
```

```r
dim(mydf1$c1)
```

```
## NULL
```

```r
# one can use quote ' ' or " " as well 
mydf1$'c1'
```

```
## [1] 1 2
```

```r
# similarly, extraction by column name with [[ ]]: df[['varname']]    
mydf1[['c1']]
```

```
## [1] 1 2
```

```r
dim(mydf1[['c1']])
```

```
## NULL
```

```r
# or by index 
mydf1[[1]]
```

```
## [1] 1 2
```

```r
# [[ ]] method is useful when passing a variable name as a string
set_to_na <- function(df, var) {
                df[[var]] <- NA  
                df 
              }
mydf1
```

```
##    c1 c2 c3 num fac1  logi fac2
## r1  1  3  5   1    a  TRUE    1
## r2  2  4  6   2  abc FALSE    a
```

```r
mydf2 <- set_to_na(mydf1, "c2") 
mydf2
```

```
##    c1 c2 c3 num fac1  logi fac2
## r1  1 NA  5   1    a  TRUE    1
## r2  2 NA  6   2  abc FALSE    a
```

```r
# add a variable 
mydf1$newvar <- c(4, 4)
mydf1
```

```
##    c1 c2 c3 num fac1  logi fac2 newvar
## r1  1  3  5   1    a  TRUE    1      4
## r2  2  4  6   2  abc FALSE    a      4
```

```r
mydf1$newvar2 <- mydf1$c2 + mydf1$c3
mydf1
```

```
##    c1 c2 c3 num fac1  logi fac2 newvar newvar2
## r1  1  3  5   1    a  TRUE    1      4       8
## r2  2  4  6   2  abc FALSE    a      4      10
```

`apply()` may not work well with data frames since data frames are not exactly matrices. We can use simplified apply `sapply()` or list apply `lapply()` instead.  


```r
mydf1 
```

```
##    c1 c2 c3 num fac1  logi fac2 newvar newvar2
## r1  1  3  5   1    a  TRUE    1      4       8
## r2  2  4  6   2  abc FALSE    a      4      10
```

```r
# sapply() 
idx_num <- sapply(mydf1, is.numeric) 
idx_num
```

```
##      c1      c2      c3     num    fac1    logi    fac2  newvar newvar2 
##    TRUE    TRUE    TRUE    TRUE   FALSE   FALSE   FALSE    TRUE    TRUE
```

```r
apply(mydf1[,idx_num], 2, mean)
```

```
##      c1      c2      c3     num  newvar newvar2 
##     1.5     3.5     5.5     1.5     4.0     9.0
```

```r
sapply(mydf1[,idx_num], mean)
```

```
##      c1      c2      c3     num  newvar newvar2 
##     1.5     3.5     5.5     1.5     4.0     9.0
```

```r
# lapply() 
idx_num2 <- unlist(lapply(mydf1, is.numeric)) 
idx_num2
```

```
##      c1      c2      c3     num    fac1    logi    fac2  newvar newvar2 
##    TRUE    TRUE    TRUE    TRUE   FALSE   FALSE   FALSE    TRUE    TRUE
```

```r
unlist(lapply(mydf1[,idx_num2], mean))
```

```
##      c1      c2      c3     num  newvar newvar2 
##     1.5     3.5     5.5     1.5     4.0     9.0
```

### List

A list is an ordered collection of (possibly unrelated) objects.  The objects in a list are referenced by [[1]], [[2]], ..., or [['var1']], [['var2']], ... etc.   


```r
mylist1 <- list(v1 = c(1,2,3),
             v2 = c("a","b"),
             v3 = factor(c("blue","red","orange","yellow")),
             v4 = data.frame( u1 = c(1:3), u2 = c("p","q","r"))
             )
mylist1 
```

```
## $v1
## [1] 1 2 3
## 
## $v2
## [1] "a" "b"
## 
## $v3
## [1] blue   red    orange yellow
## Levels: blue orange red yellow
## 
## $v4
##   u1 u2
## 1  1  p
## 2  2  q
## 3  3  r
```

```r
# extraction
mylist1[[1]]             
```

```
## [1] 1 2 3
```

```r
mylist1[["v2"]]             
```

```
## [1] "a" "b"
```

```r
mylist1$v3      
```

```
## [1] blue   red    orange yellow
## Levels: blue orange red yellow
```

```r
mylist1$v4$u2
```

```
## [1] p q r
## Levels: p q r
```

```r
# assignment
mylist1$v5 <- c("a",NA)
mylist1$v5 
```

```
## [1] "a" NA
```

```r
# a list can be nested 
mylist1$v6 <- list(y1 = c(2,9), y2 = c(0,0,0,1))
mylist1$v6
```

```
## $y1
## [1] 2 9
## 
## $y2
## [1] 0 0 0 1
```

`lapply()` is very versatile since the items in a list can be completely unrelated. 


```r
unlist(lapply(mylist1, class))
```

```
##           v1           v2           v3           v4           v5 
##    "numeric"  "character"     "factor" "data.frame"  "character" 
##           v6 
##       "list"
```

```r
unlist(lapply(mylist1, attributes))  # some variables have attributes
```

```
##    v3.levels1    v3.levels2    v3.levels3    v3.levels4      v3.class 
##        "blue"      "orange"         "red"      "yellow"      "factor" 
##     v4.names1     v4.names2 v4.row.names1 v4.row.names2 v4.row.names3 
##          "u1"          "u2"           "1"           "2"           "3" 
##      v4.class     v6.names1     v6.names2 
##  "data.frame"          "y1"          "y2"
```

```r
lapply(mylist1, function(x) {
                  if (is.numeric(x)) return(summary(x))
                  if (is.character(x)) return(x)
                  if (is.factor(x)) return(table(x))
                  if (is.data.frame(x)) return(head(x))
                  if (is.list(x)) return(unlist(lapply(x,class)))
                }
)
```

```
## $v1
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     1.0     1.5     2.0     2.0     2.5     3.0 
## 
## $v2
## [1] "a" "b"
## 
## $v3
## x
##   blue orange    red yellow 
##      1      1      1      1 
## 
## $v4
##   u1 u2
## 1  1  p
## 2  2  q
## 3  3  r
## 
## $v5
## [1] "a" NA 
## 
## $v6
##        y1        y2 
## "numeric" "numeric"
```

## Programming

### Operator





Table: (\#tab:unnamed-chunk-20)Basic R Operators

Operation   Description                       
----------  ----------------------------------
x + y       Addition                          
x - y       Subtraction                       
x * y       Multiplication                    
x / y       Division                          
x ^ y       Exponentiation                    
x %% y      Modular arithmatic                
x %/% y     Integer division                  
x == y      Test for equality                 
x <= y      Test for less than or equal to    
x >= y      Test for greater than or equal to 
x && y      Boolean AND for scalars           
x || y      Boolean OR for scalers            
x & y       Boolean AND for vectors           
x | y       Boolean OR for vectors            
!x          Boolean negation                  



source: [@Matloff2011]


### If else


```r
if (1 > 0) {
  print("result: if")
} else {
  print("result: else")
}
```

```
## [1] "result: if"
```

```r
# {} brackets can be used to combine multiple expressions 
# They can be skipped for a single-expression if-else statement. 
if (1 > 2) print("result: if")  else print("result: else")
```

```
## [1] "result: else"
```

```r
ifelse(c(1,2,3) > 2, 1, -1)  # return 1 if TRUE and -1 if else  
```

```
## [1] -1 -1  1
```

```r
Sys.time()
```

```
## [1] "2017-04-20 16:36:21 CDT"
```

```r
time <- Sys.time()
hour <- as.integer(substr(time, 12,13))
# sequential if-else statements
if (hour > 8 & hour < 12) {
    print("morning")
} else if (hour < 18) {
    print("afternoon")
} else {
    print("private time")
}
```

```
## [1] "afternoon"
```

### Loop


```r
for (i in 1:3) {
  print(i)
}
```

```
## [1] 1
## [1] 2
## [1] 3
```

```r
for (i in c(1,3,5)) print(i)
```

```
## [1] 1
## [1] 3
## [1] 5
```

```r
i <- 1 
while (i < 5) {
  print(i) 
  i <- i + 1
}
```

```
## [1] 1
## [1] 2
## [1] 3
## [1] 4
```


### Function

We can avoid repeating ourselves with writing similar lines of codes if we turn them into a function. Functions contain a series of tasks that can be applied to varying objects such as different vectors, matrices, characters, data frames, lists, and functions.

A function consists of input arguments, tasks (R expressions), and output as an object (e.g. a vector, matrix, character, data frame, list, or function etc.). It can be named or remain anonymous (typically used inside a function like `lapply()`). 


```r
##  name_to_be_assigned  <- function(input args) {
##                            tasks 
##                           }
```

The output of the function, aside from those that are printed, saved, or exported, is the very last task (expression). If variable `result` is created inside the function, having `result` at the very end will return this item as an output. When multiple objects are created, it is often convenient to return those as a *list*. Use `return()` to return a specific item in the middle of the function and skip the rest of the evaluations. For checking errors and halting evaluations, use `stop()` or `stopifnot()`.           




```r
myfun1 <- function() print("Hello world")  # just returning "Hello world"
myfun1()  
```

```
## [1] "Hello world"
```

```r
myfun2 <- function(var) var^2 
myfun2(var = 3)
```

```
## [1] 9
```

```r
myfun3 <- function(var = 1)  ifelse(var>0, log(var), var) 
myfun3()   # default argument is var = 1
```

```
## [1] 0
```

```r
myfun3(2)
```

```
## [1] 0.6931472
```

```r
myfun4 <- function(x1, x2) {
            if (!is.numeric(x1) | !is.numeric(x2)) stop('demo of error: numeric args needed')
            x1*x2
          }
# try(myfun4(1, "a"))  
myfun4(4, 3)
```

```
## [1] 12
```


### Environment

A function, formally known as a *closure*, consists of its arguments (called *formals*), a body, and an *environment*. An *environment*  is a collection of existing R objects at the time when the function is created. Functions created at the *top level* have `.GlobalEnv` as their environments (R may refer to it as `R_GlobalEnv` as well).  



```r
environment()  # .GlobalEnv  (or R_GlobalEnv) is the top-level environment 
```

```
## <environment: R_GlobalEnv>
```

```r
f1 <- function(arg1) environment()  
formals(f1)  # arguments of f1()
```

```
## $arg1
```

```r
body(f1)     # body of f1()
```

```
## environment()
```

```r
environment(f1)  # environment of f1(), which is .GlobalEnv 
```

```
## <environment: R_GlobalEnv>
```

```r
f1()  # inside f1 has its own enviornment 
```

```
## <environment: 0x7f9ac55a5d78>
```

A function can access to the objects in its environment (i.e., *global* to the function) and those defined inside (i.e., *local* to the function) and generally cannot overwrite the global objects. It allows for using common names such as "x1", "var1" etc. defined inside functions, but those objects are only accessible within the function. 


```r
a <- NULL  # object named "a" in .GlobalEnv
f2 <- function() {
        a <- 1  # object named "a" in an environment inside f2
        print(a)
        environment()
      }
f2()  #  one instance creating an environment   
```

```
## [1] 1
```

```
## <environment: 0x7f9ac5ecf950>
```

```r
f2()  #  another instance creating another environment
```

```
## [1] 1
```

```
## <environment: 0x7f9ac5efe038>
```

```r
a  # stays NULL 
```

```
## NULL
```

```r
ls()  # ls() shows all objects of an environment (here .GlobablEnv)
```

```
##  [1] "a"            "ans1"         "df"           "df1"         
##  [5] "df2"          "f1"           "f2"           "factor1"     
##  [9] "factor2"      "factor3"      "hour"         "i"           
## [13] "idx_num"      "idx_num2"     "mat1"         "matrix1"     
## [17] "matrix2"      "matrix3"      "mydf1"        "mydf2"       
## [21] "myfun1"       "myfun2"       "myfun3"       "myfun4"      
## [25] "mylist1"      "mymat1"       "set_to_na"    "tbl_operator"
## [29] "time"         "vector1"      "vector2"      "vector3"     
## [33] "vector4"
```

```r
rm(list = ls())  # rm() removes items of an  environment (here .GlobablEnv)
ls()  # all gone in GlobalEnv
```

```
## character(0)
```

Using global assignment `<<-` operator, one can bend this general rule of not affecting global objects. This can be useful when it is desirable to make certain objects accessible across multiple functions without explicitly passing them through arguments.  


```r
a <- NULL
b <- NULL
f1 <- function() {
        a <<- 1  # global assignment
        # another way to assign to GlobalEnv 
        assign("b", 2, envir = .GlobalEnv)  
      }
f1() 
a
```

```
## [1] 1
```

```r
b
```

```
## [1] 2
```

```r
a <- 2
f2 <- function() {
        # Since there is no "a" local to f2, R looks for "a" 
        # in a parent environment, or .GlobalEnv  
        print(a) 
        
        # g() assigns a number to "a" in g()'s environment 
        g <- function() a <<- 5
        
        a <- 0  #  object called "a" local to f2   
        print(a)
        
        # g() updates only the local "a" to f2(), but not "a" in GlobalEnv 
        # R's scope hierarchy starts from local to its environment  
        g()   
        print(a)
      }
a <- 3

# the first "a" is in .GlobalEnv when f2() is called
# the second "a" is local to an instace of f2()
# the third "a" is the updated version of the local "a" by g() 
f2() 
```

```
## [1] 3
## [1] 0
## [1] 5
```

```r
a   # object "a" in GlobalEnv: unchanged by g()
```

```
## [1] 3
```

It is convenient to use `<<-` if you are sure about which object to overwrite. Otherwise, the use of `<<-` should be avoided.    

### Debugging 

`browser()` and `traceback()` are common debugging tools. A debugging session starts where `browser()` is inserted and allows for a line-by-line execution onward. Putting `browser()` inside a loop or function is useful because it allows for accessing the objects at a particular moment of execution in its environment. After an error alert, executing `traceback()` shows at which process the error occurred. Other tools include `debug()`, `debugger()`, and `stopifnot()`. 


### Stat func.

What is going on here? What do we see?





Table: (\#tab:unnamed-chunk-28)Common R Statistical Distribution Functions

Distribution   Density_pmf   cdf         Quantiles   Random_draw 
-------------  ------------  ----------  ----------  ------------
Normal         dnorm( )      pnorm( )    qnorm( )    rnorm( )    
Chi square     dchisq( )     pchisq( )   qchisq( )   rchisq( )   
Binomial       dbinom( )     pbinom( )   qbinom( )   rbinom()    



source: [@Matloff2011]

### String func.

R has built-in string manipulation functions. They are commonly used for;

* detecting a certain pattern in a vector (`grep()` returning a location index vector, `grepl()` returning a logical vector)

* replacing a certain pattern with another (`gsub()`)

* counting the length of a string (`nchar()`) 

* concatenating characters and numbers as a string (`paste()`, `paste0()`, `sprintf()`)

* extracting a segment of a string by character position range (`substr()`)

* splitting a string with a particular pattern (`strsplit()`)

* finding a character position of a pattern in a string (`regexpr()`)


```r
oasis <- c("Liam Gallagher", "Noel Gallagher", "Paul Arthurs", "Paul McGuigan", "Tony McCarroll") 
grep(pattern = "Paul", oasis)
```

```
## [1] 3 4
```

```r
grepl(pattern = "Gall", oasis)
```

```
## [1]  TRUE  TRUE FALSE FALSE FALSE
```

```r
gsub("Gallagher", "Gallag.", oasis)
```

```
## [1] "Liam Gallag."   "Noel Gallag."   "Paul Arthurs"   "Paul McGuigan" 
## [5] "Tony McCarroll"
```

```r
nchar(oasis)
```

```
## [1] 14 14 12 13 14
```

```r
paste(oasis)
```

```
## [1] "Liam Gallagher" "Noel Gallagher" "Paul Arthurs"   "Paul McGuigan" 
## [5] "Tony McCarroll"
```

```r
paste(oasis, collapse=", ")
```

```
## [1] "Liam Gallagher, Noel Gallagher, Paul Arthurs, Paul McGuigan, Tony McCarroll"
```

```r
sprintf("%s from %d to %d", "Oasis", 1991, 2009)
```

```
## [1] "Oasis from 1991 to 2009"
```

```r
substr(oasis, 1, 6)
```

```
## [1] "Liam G" "Noel G" "Paul A" "Paul M" "Tony M"
```

```r
strsplit(oasis, split=" ")  # split by a blank space
```

```
## [[1]]
## [1] "Liam"      "Gallagher"
## 
## [[2]]
## [1] "Noel"      "Gallagher"
## 
## [[3]]
## [1] "Paul"    "Arthurs"
## 
## [[4]]
## [1] "Paul"     "McGuigan"
## 
## [[5]]
## [1] "Tony"      "McCarroll"
```

```r
regexpr("ll", oasis[1])[1]
```

```
## [1] 8
```

Common regular expressions used in R include;

* `"[char]"` (any string containing either "c", "h", "a", or "r" )

* `"a.c"` (any string containing "a" followed by any letter followed by "c")

* `"\\."` (any string containing symbol ".").   


```r
grepl("[is]", oasis)
```

```
## [1]  TRUE FALSE  TRUE  TRUE FALSE
```

```r
grepl("P..l", oasis)
```

```
## [1] FALSE FALSE  TRUE  TRUE FALSE
```

```r
grepl("\\.", c("Liam", "Noel", "Paul A.", "Paul M.", "Tony"))
```

```
## [1] FALSE FALSE  TRUE  TRUE FALSE
```


### Set func.
The functions for common set operations include `union()`, `intersect()`, `setdiff()`, and `setequal()`. The most commonly used function is `%in%` operator; `X %in% Y` returns a logical vector indicating whether an each element of `X` is a member of `Y`.        
```r
c(1,2,3,4,5) %in% c(3,2,5)
c("a","b","t","s") %in% c("t","a","a")
```


## Housekeeping

### Working directory

`getwd()` returns the current working directly. `setwd(new_directory)` sets a specified working directory. 

### R session

`sessionInfo()` shows the current session information. In RStudio, `.rs.restartR()` restarts a session. 

### Save & load 

R objects can be saved and loaded by `save(object1, object2, ..., file="file_name.RData")` and `load(file="file_name.RData")`. A `ggplot` object can be save by `ggsave("file_name.png")`.   


### Input & Output

A common method to read and write data files is `read.csv("file_name.csv")` and `write.csv(data_frame, file = "file_name.csv")`. `scan()` is a more general function to read data files and interact with user keyboard inputs. `file()` is also a general function for reading data through *connections*, which refer to R's mechanism for various I/O operations. `dir()` returns the file names in your working directory.     

A useful function is `cat()`, which can print a cleaner output to the screen, compared to `print()`.

```r
print("example")
```

```
## [1] "example"
```

```r
cat("example\n")  # end with \n
```

```
## example
```

```r
cat("some string", c(1:4), "more string\n")
```

```
## some string 1 2 3 4 more string
```

```r
cat("some string", c(1:4), "more string\n", sep="_")
```

```
## some string_1_2_3_4_more string
```


### Updating

R needs regular updates for R distribution, individual R packages, and RStudio. Generally, updating once or twice a year would suffice.  For updating RStudio, go to `Help` and then `Check for Updates`. Also, RStudio also makes it easy to update packages; go to `Tools` and the `Check for Package Updates`. Do these updates when you have time or you know that you need to update a particular package; updating R and R packages can be trickier than it seems. 


```r
# check R version
getRversion()
```

```
## [1] '3.3.1'
```

```r
version
```

```
##                _                           
## platform       x86_64-apple-darwin13.4.0   
## arch           x86_64                      
## os             darwin13.4.0                
## system         x86_64, darwin13.4.0        
## status                                     
## major          3                           
## minor          3.1                         
## year           2016                        
## month          06                          
## day            21                          
## svn rev        70800                       
## language       R                           
## version.string R version 3.3.1 (2016-06-21)
## nickname       Bug in Your Hair
```

```r
# check installed packages
## installed.packages()

# list all packages where an update is available
## old.packages()

# update all available packages of installed packages 
## update.packages()

# update, without prompt
## update.packages(ask = FALSE)
```

For windows users, one can automate the process using `installr` package. 

```r
## --- execute the following ---
## install.packages("installr") # install
## setInternet2(TRUE) # only for R versions older than 3.3.0
## installr::updateR() # updating R.
```

<!-- not sure if this works
Another way to automate is discussed [here](http://bioinfo.umassmed.edu/bootstrappers/bootstrappers-courses/courses/rCourse/Additional_Resources/Updating_R.html).

```r
### get packages installed
## packs = as.data.frame(installed.packages(.libPaths()[1]), stringsAsFactors = F)

### and now re-install install packages using install.packages()
## install.packages(packs$Package)
```
--> 

Sometimes, you can accidentally corrupt sample datasets that come with packages. To restore the original datasets, you have to remove the package by `remove.packages()` and then install it again. Use `class()`, `attributes()`, and `str()` to check for any unrecognized attributes attached to the dataset. Also, if you suspect that you have accidentally corrupted R itself, you should re-install the R distribution.  




