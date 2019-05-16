######################################
# R is an interpreted, command-based
# language. 
######################################

# This is a comment

#################################################
## R Basics: expressions, variables, and vectors
#################################################

# R can be used like a calculator
7+10
7*9
sqrt(64)


# The assignment operator ("<-" or "=") is used to assign a value to an object. 

x <- 14  # x = 14 will do the same thing
x # print an object

y <- 21
total <- x+y
num <- x / y
name <- 'Bob' # you can use single or double quotes, e.g., name <- "Bob"


# A fundamental type of object in R is a vector (like a 1D array), for storing
# multiple values of the same type
ages <- c(19,20,24, 22, 20)

# how many ages do we have?
length(ages)

# what is the age of the 2nd individual? Note that unlike Java, 
# indexing begins at 1
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

# Specific elements of a vector can be accessed using bracket notation 
# with the corresponding positions (indices) of elements to access (as above); 
# or by specifying a logical vector which accesses elements where the 
# corresponding value is TRUE

# example: what are the ages greater than 20?
index <- ages > 20   # creates logical vector c(FALSE, FALSE, TRUE, TRUE, FALSE)
ages[index]    # or alternatively, use ages[ages > 20]

# how many ages are > 20? 
sum(index) # counts the number of TRUE values (TRUE = 1, FALSE = 0)

# the AND (&) and OR (|) operators perform pairwise comparison between 
# logical values: example: what ages are between 20 and 23 (inclusive)
# Note: && and || only compare the first element but allow for
# short-circuit evaluation. Always use & and | when comparing vectors
# with length > 1
keep <- ages >= 20 & ages <= 23
ages[keep] # same as: ages [ ages >= 20 & ages <= 23]   

index1 <- ages >= 20
index2 <- ages <= 23
cbind("age>=20"=index1, "age<=23"=index2, "age is 20-23" = index1 & index2)

# Logical operators:
#   ==, is equal to
#   !=, not equal to
#   !, not operator
#   >, greater than 
#   >=, greater than or equal to
#   <, less than
#   <=, less than or equal to


# another vector example
names <- c("Bob", "Lynn")

# the assignment operator can be used to simultaneously change several 
# values 
x <- 1:5
x[c(1,5)] # look at the 1st and 5th element
x[c(1,5)] <- 0 # change the 1st and 5th element to 0
x

# Additional ways of creating vectors

x1 <- 1:10  # integers 1 through 10
x2 <- 20:10 # integers 20 through 10
x3 <- seq(1,10,by=2) # integers 1,3,5,7,9
x4 <- rep(-7, 20) ## a vector containing 20 values of -7

###########################################################################
## Question set A
## 1. How many ages are equal to 20 (use R to find this value)
## 2. Create a vector of all integers 1 through 100
## 3. Create a vector of all even integers between 50 and 100 (inclusive)
##  3a. How many even integers are there between 50 and 100 (inclusive)?
##  3b. What is the sum of the 3rd and 19th even integer 
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
# a matrix combining both vectors ('cbind' is for 'column bind'); 
cbind(x,y) # single value is repeated for each element of 'x'

# operations apply to each pair of elements (across each 'row')
ans.add <- x+y  # adds each element of x (a vector) to y (a single value)
ans.multiply <- x*y  # multiplies each element of x (a vector) to y (a single value)
ans.divide <- x / y  # divides each element of x (a vector) by y (a single value)

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
## elements in the smaller vector are 'recycled' to
## create two vectors of the same length
## NOTE: You will NOT get an error if the vectors are 
## different lengths. You will get a warning, but only if 
## the number of elements in one vector is not a multiple 
## of the number of elements in the other vector
#########################################################
x <- 1:10
y <- 1:5
cbind(x,y)
ans.add <- x+y  
ans.multiply <- x*y  
ans.divide <- x/y  

## you will get a warning (but NOT an error) if length(y) is not 
## a multiple of length(x)
x <- 1:10
y <- 1:5
y <- y[-5]   ### the same as y = y[1:4]
cbind(x,y)
ans.add <- x+y  


### additional operations for vectors (or matrices)
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

# sum each row
rowSums(m)

# sum each column
colSums(m)


# create matrix using rbind or cbind

# rbind will bind consecutive rows:
m1 <- rbind(1:10, 10:1)
m1

# cbind will bind consecutive columns:
m2 <- cbind(1:10, 10:1)
m2


#############################################################################
## Question set C
## 1. For the matrix 'm', change the value of the observation in the 2nd row
#     and 3rd column to 5
## 2. Create a matrix with 2 columns, the first containing 
##    odd numbers between 1-10 and the 2nd containing even
##    numbers between 1-10. 
#############################################################################


########################################################
## list - a collection of objects that can be accessed
##    by index or by name
########################################################

person <- list(name = "Bob", age = 23, class = "Soph")

## how many objects are in person, and what are their names?
length(person)
names(person)

## access the first object:
person[[1]]

## access the 2nd object:
person[[2]]

## access objects by name:
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
