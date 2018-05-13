###################################################
## functions - a function is a named block of code
## that can return a value
##################################################

## two arguments ##
divide <-function(x,y) {
    return(x/y)
}
divide(3,4)

## default arguments ##
divide <-function(x,y = 1) {
  return(x/y)
}

### arguments are matched in order unless they are named
divide(3)         # 3 / 1 (since y = 1 by default)
divide(3,2)       # 3/2 = 1.5
divide(2,3)       # 2/3 = .666
divide(y = 2, 3)  # 3/2 = 1.5

###################################################
# return is implicit if the function ends with
# an expression (but NOT an assignment)
##################################################

# same divide function as above, with implicit return
divide <-function(x,y = 1) {
  x/y
}

divide(3,2) ## 3/2 = 1.5


################################################################################
# Question set A

numbers <- c(20,18,6, -10, 4)

# 1. Write a function called 'firstValue' that takes a vector and returns the 
#    1st element. Use this function to get the first element of 'numbers'
# 2. Write a function called 'lastValue' that returns the last element of a 
#    vector, and use this function to get the last element of 'numbers'
# 3. Write a function that returns the mean value of a vector of numbers,
#    after removing the lowest value (if multiple values are equally lowest, only
#    one of the values is removed). Hint: you may use the function 'sort', which 
#    sorts a vector from smallest to largest.
################################################################################


#############################################################
## for loops - repeat something for each element of a vector
#############################################################

# repeat based on the index of the vector 'x'
x <- c(1,3,4)
for (i in 1:length(x)) {
    cat (x[i])
}

numbers <- c(1,2,5,7)
# repeat for each value of x
for (x in numbers) {
    cat (x) # cat is used for printing
}

######################################################################
## Note: In many cases 'functional' approaches are preferred over 
## loops in R. Examples of functional approaches using 'apply', 
## 'sapply', and 'lapply' are given below 
#####################################################################


######################################################################
## apply - applies a function to a row (MARGIN = 1) 
## or column (MARGIN = 2) of a matrix
######################################################################

###########################################
# example: find max of each row of 'm'
###########################################
m <- matrix(1:20, ncol=5, byrow=TRUE)
rowMaxes <- apply(m, 1, max)
rowMaxes

###############################################################
## add the 'n' smallest numbers in a vector
## Note: could also return sum(sort(x)[1:n])
###############################################################
add.smallest <- function(x, n=2) {
  x.sorted <- sort(x)
  sum(x.sorted[1:n])
}
ans.row <- apply(m, 1, add.smallest) ## for each row
ans.row

ans.col <- apply(m, 2, add.smallest) ## for each col
ans.col

ans.row.4 <- apply(m, 1, add.smallest, n = 4)
ans.row.4

## alternative using an inline function
ans.row <- apply(m, 1, function(x) sum(sort(x)[1:2]))

## lapply applies a function to each object in a list, and returns a
## list of values
person <- list(name = "Bob", sibling.ages = c(43,21, 29), pet.ages = c(8,3))
lapply(person, length)

## sapply does the same but returns a vector 
sapply(person, length)

#############################################
# if statements - follows C/C++/Java format
############################################
compare <-function(x, ref = 0) {
  if (x < ref) {
    cat("the number", x, "is less than", ref, "\n")
  } else if (x > ref) {
    cat("the number", x, "is greater than", ref, "\n")
  } else {
    cat("the number", x, "is equal to", ref, "\n")
  }
}

compare(5, 3)

#######################################################################
# Question set (use the grades matrix below):
#######################################################################

grades <- matrix(c(71,86,82,93,87,92,85,85,98,99,100,92),ncol=3,byrow=T)
rownames(grades) <- c("Steve", "Joe", "Jane", "Andrea")

# 1. Using the apply function, find the mean grade for each student, and
#    the mean grade for each assignment

# 2. The function below returns the letter grade for each individual. 
#    The grade is an 'A' if the mean grade >= 90
#    otherwise a 'B' if the mean grade >= 80
#    otherwise a 'C' if the mean grade >= 70
#    otherwise a 'D' if the mean grade >= 60
#    otherwise an 'F' grade

calcGrade <-function(x) {
  m <- mean(x)
  if (m >= 90) {
    return('A')
  } else if (m >= 80) {
    return('B')
  } else if (m >= 70) {
    return('C')
  } else if (m >= 60) {
    return('D')
  } else {
    return('F')
  }
}

# Use this function and 'apply' to find the grade for each individual
# Can you output only the individuals who have A's?


# 3. Use the 'sapply' function to find the mean for each element in the list below:

info <- list(ages = c(19,21,20,20,19,19), heights = c(67,65, 69, 66,68))
info


