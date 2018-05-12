######################################
# R is an interpreted, command-based
# language. 
######################################

# This is a comment

##########################################
## R Basics: expressions, variables, and vectors
##########################################

# R can be used like a calculator
7+10
7*9
sqrt(64)


# The assignment operator ("<-" or "=") is used to assign a value to an object. 

x <- 14  # x = 14 will do the same thing
y <- 21
total <- x+y
num <- x / y
name <- "Bob" # you can use single or double quotes, e.g., name = 'Bob'


# A fundamental type of object in R is a vector (like a 1D array), for storing
# multiple values of the same type
ages <- c(19,20,24, 22, 18)

# how many ages do we have?
length(ages)

# what is the age of the 2nd individual? Note that unlike C++/Java, indexing begins at 1
ages[2]

# What are the ages of individuals 2-4?
ages[2:4]

# What are the ages of the 1st and 3rd individual?
index <- c(1,3)
ages[index]

# What are the ages of the 1st and 3rd individual (alternative approach)? 
ages[c(1,3)]

# What are the ages of everyone EXCEPT the 2nd individual?
ages[-2]

# What are the ages of everyone EXCEPT the 1st two individuals?
ages[-(1:2)]   ## note that ages[-1:2] is not correct. Why??

# a logical vector contains TRUE/FALSE values
ages > 20

# the brackets can be used to specify the indices (positions) of values to retreive,
# or for speciying a logical vector to retrieve positions that are TRUE

# example: what are the ages greater than 20?
index <- ages > 20
ages[index]    # or alternatively, use ages[ages > 20]

# how many ages are > 20? 
sum(index) # counts the number of TRUE values (TRUE = 1, FALSE = 0)

# the AND (&) and OR (|) operators perform pairwise comparison between logical values:
# example: what ages are between 20 and 23 (inclusive)
keep <- ages >= 20 & ages <= 23
ages[keep] # same as: ages [ ages > 20 & ages < 23]   

index1 <- ages >= 20
index2 <- ages <= 23
cbind("age>=20"=index1, "age<=23"=index2, "age is 20-23" = index1 & index2)

# another vector example
names <- c("Bob", "Lynn")

# Additional ways of creating vectors

x1 <- 1:10  # integers 1 through 10
x2 <- 20:10 # integers 20 through 10
x3 <- seq(1,10,by=2) # integers 1,3,5,7,9
x4 <- rep(-7, 20) ## a vector containing 20 values of -7

###########################################################################
## Question set A
## 1. Create a vector of all integers 1 through 100
## 2. Create a vector of all even integers between 50 and 100 (inclusive)
##  2a. How many even integers are there between 50 and 100 (inclusive)?
##  2b. What is the sum of the 3rd and 19th even integer 
##      between 50 and 100?
###########################################################################

# To get help on a command, use the question mark (?) or
# the help.search command, e.g.,
# ?c        ?ls       help.search("plot")

# remove an object (variable or function) from the environment
rm(x)

# remove all objects
rm(list = ls())

##########################################
## Calculations with vectors
##########################################

###################################
##  when one vector is of length 1
###################################
x <- 1:10
y <- 4

# Note: we can visualize the vector calculations by creating
# a matrix combining both vectors; calculations occur across each row 
cbind(x,y)

ans.add <- x+y  # adds each element of x to y
ans.multiply <- x*y  # multiplies each element of x by y
ans.divide <- x / y

##########################################
##  when both vectors are the same length
#########################################
x <- 1:10
y <- seq(0,1,length.out = 10)
cbind(x,y)
ans.add <- x+y  # the nth element of x is added to the nth element of y
ans.multiply <- x*y  # the nth element of x is multipled by the nth element of y
ans.divide <- x/y  # the nth element of x is divided by the nth element of y


#########################################################
## when vectors are of different lengths, 
## elements in smaller vector are recycled as necessary
## NOTE: Unlike in other languages, you will not get
## an error if the vectors are of different lengths
## You will get a warning if the number of elements in
## one vector is not a multiple of the number of elements
## in the other vector
#########################################################
x <- 1:10
y <- seq(0,1,length.out = 5)
cbind(x,y)
ans.add <- x+y  
ans.multiply <- x*y  
ans.divide <- x/y  

## you will get a warning (but NOT an error) if length(y) is not 
## a multiple of length(x)
x <- 1:10
y <- seq(0,1,length.out = 5)
y <- y[-5]   ### the same as y = y[1:4]
cbind(x,y)
ans.add <- x+y  


### additional calculations 
x <- 1:10
sum(x)
min(x)
max(x)

##########################################################
## Question set B
## 1. If you drive 60 miles per hour, how far would you travel
##    in 3,4,5,6, and 10 hours?
##########################################################

##############################################
## matrices - all elements must be same type
##############################################
m <- matrix(1:30,ncol=5,byrow = TRUE)
colnames(m) = paste("x",1:5, sep = "")
rownames(m) = paste("p", 1:6, sep = "")

## what are the dimensions of the matrix?
dim(m)   ## rows, columns
nrow(m)  ## number of rows
ncol(m)  ## number of columns
length(m) ## number of observations

## get the observation in the 1st row and 3rd column
m[1,3]

## get the first row
m[1,]

# get the first 2 rows
m[1:2,]

# get the first column
m[,1]

# get all information except the last column
lc = ncol(m)
m[,-lc] ## you could also use m[,-ncol(m)]

# sum each row
rowSums(m)

# sum each column
colSums(m)


# create matrix using rbind or cbind

# rbind will bind consecutive rows:
m1 <- rbind(1:10, 10:1)
m1

m2 <- cbind(1:10, 10:1)
m2



#############################################################################
## Question set C
## 1. Change the value of the observation in the 2nd row and 3rd 
##  column to 5
## 2. Create a matrix with 2 columns, the first containing 
##    odd numbers between 1-10 and the 2nd containing even
##    numbers between 1-10. 
#############################################################################


########################################################
## lists - a collection of objects that can be accessed
##    by index or by name
########################################################

person <- list(name = "Bob", age = 23, sex = "M")

## how many objects are in person, and what are their names?
length(person)
names(person)

## access the first object:
person[[1]]

##access the 2nd object:
person[[2]]

# # access objects by name:
person[['name']]
person[['age']]

## another way to access objects by name:
person$name
person$age

## add a new object
person$major <- "cs"

## delete age
person$age <- NULL

## add object to person by index (NULL objects created as necessary)
person[[8]] <- 63.5

## name this object
names(person)[8] <- "height"

## note that each object need not be of length 1
person$sibling.ages <- c(3,6)



## Additional commands
# display your current working directory (the file path used by default)
getwd()

##############################################################################
## Exiting R:
## save.image(file = "intro.RData")     ## saves all objects in workspace
## save(survey, s, file = "intro.RData")  ## save selected objects
## q()  ## you will be prompted to save image in default location
################################################################################

##############################################################################
## File -> Knit Document can be used to create an HTML notebook
################################################################################