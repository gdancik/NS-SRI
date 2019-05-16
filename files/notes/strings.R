###############################################################
# An overview of working with strings in R
###############################################################

library(stringr) # needed for str_extract_all

#concatenate and print
x = 4
cat("x =", x, "at this time") 

# separator is blank space by default
cat("1", "2", "3")

# change the separator
cat("1", "2", "3", sep = "-")

# a backslash is used to denote special characters 
# (e.g., "\t" for tab and "\n" for newline)
string <- "column1\tcolumn2\nA\tB\n"
cat(string) 


# newlines are not added by default 
for (i in 1:3) {
  cat(i)  # you probably want to use cat(i,"\n") instead
}

# paste is used to concatenate vectors into a single character string
# by default, objects are separated by spaces
paste("A", "B", "C")

# use 'sep' to separate objects by specific characters
paste("A", "B", "C", x, sep = "--") 
paste("A", "B", "C", x, sep = "")

# use 'paste0' as a shortcut for paste with sep = ""
paste0("A", "B", "C", x)


# paste will combine corresponding elements from multiple
# vectors
abc <- c("A", "B", "C")
xyz <- c("X", "Y", "Z")
paste(abc, xyz)

# use paste to collapse elements in a vector to a single string
paste(abc, xyz, sep = "-", collapse = ", ")


#############################################################################
# searching strings
#############################################################################

strings <- c("network science", "computer science", "biology", 
             "computers", "computer networks", "computers", "summer 2019", "science")

# match(x,s)  returns the index of where the FIRST exact match is found,
# or returns an NA if there is no match
match("computers", strings)   # only first occurence is identified
match("computer", strings)    # no exact matches, NA is returned

# if the first argument is a vector, match will look for each element
match(c("network science", "summer", "summer 2019"), strings) 

# the "%in%" operator returns TRUE or FALSE depending on whether each 
# element of the first vector is found exactly in the second

"network" %in% strings

c("network science", "summer", "summer 2019") %in% strings

# grep returns the index or vector of indices for where a pattern is found
# in a vector of strings (unlike 'match', 'grep' returns multiple matches)
# the match does not have to be exact
grep("network", strings)

# Use grep with value = TRUE to return the matching string instead of the index
grep("network", strings, value = TRUE)

# grepl is the same as 'grep' but returns a logical vector containing TRUE in 
# the position where the pattern is found
grepl("network", strings)


##############################################################################
# A regular expression specifies a pattern to find, and can include
# special characters, some of which are described below:

# Anchors:
#   - a caret ('^') matches the beginning of a string
#   - a dollar sign ('$') matches the end of a string (which may be
#     before a newline character)
#   - \\b matches the beginning or end of a word (ignoring punctuation)

# Character classes:
#   - a dot ('.') matches any character except a newline
#   - a vertical bar (|) is used for matching one pattern or another
#   - brackets [ab] will match any character in the brackets 
#       (e.g., 'a' or 'b')
#   - brackets [^ab] will match any characters NOT in the brackets 
#       (e.g., any character other than 'a' or 'b')
#   - brackets [1-4] will match any characters in the range 1-4
#   - [[:digit:]] or \\d is the same as [[0-9]] and matches any digit between 0-9
#   - [[:alpha:]] matches any alphabetical character, [[A-z]]
#   - [[:upper:]] matches any uppercase character, [[A-Z]]
#   - [[:space:]] or \\s matches any space, tab, or newline
#   - [^[:space:]] or \\S matches any non-space, tab or newline character
#   - \\w matches any 'word' characters [A-z0-9_] (use \\W for negation)
#   - parentheses () are used for grouping

# Quantifiers, which apply to the previous character or group of 
# characters
#   - an asterisk ('*') matches 0 or more times
#   - a plus sign ('+') matches 1 or more times
#   - braces of the form {n}, {n,m}, {n,}, {,m} match exactly 'n' times,
#     between 'n' and 'm' times, 'at least 'n' times, and no more than 'm'
#     times, respectively
#   - a question mark ('?') matches at MOST one time, and can be 
#     placed after any quantifier for 'lazy' evaluation



# For more details, see: 
#   https://www.rstudio.com/wp-content/uploads/2016/09/RegExCheatsheet.pdf
##############################################################################

# strings that contain "network"
grep("network", strings, value = TRUE)

# strings that begin with "network"
grep("^network", strings, value = TRUE)

# strings that contain "computer"
grep("computer", strings, value = TRUE)

# strings that contain the WORD "computer"
grep("\\bcomputer\\b", strings, value = TRUE)

# strings that contain "network" or "computer"
grep("network|computer", strings, value = TRUE)

# strings that contain one or more digits
grep("[[:digit:]]", strings, value = TRUE)

# strings that contain one or more digits or the word computer
# Note that parentheses are used for grouping
grep("([[:digit:]])|(\\bcomputer\\b)", strings, value = TRUE)


# strings that contain two alphabetical characters separated by a space, tab, or newline
# Note that \\s can be used instead of [[:space:]]
grep("[[:alpha:]][[:space:]][[:alpha:]]", strings, value = TRUE)

# strings containing 7 characters, followed by a blank space and "science"
grep(".{7} science", strings, value = TRUE)

# strings containing any word that is at least 8 characters long
# (where word must contain alphabetical characters only)
grep("\\b[[:alpha:]]{8,}\\b", strings, value = TRUE)


########################################################################
# Exercises - use 'grep' and the appropriate regular expression to 
# identify the following from the vector 'strings'
########################################################################

# (1) find strings containing the letter 'e'. 

# (2) find strings containing words that end in an 'e' 

# (3) find strings containing words that begin with a 'c' and end with an 's'

# (4) (a) find strings containing words that include a 'c' and an 's' any where in the word
#          (assume the 'c' comes before the 's') (Hint: recall that '\\w' is a word character)
#      (b) find strings containing words that include a 's' and an 'c' any where in the word
#          (assume the 's' comes before the 'c')
#      (c) find strings containing words containing an 's' or a 'c' in any order

# (5) Find all strings containing ONLY uppercase words and spaces in the words vector 
#     (Note: use [[:upper:]] to match a single uppper case letter, and [[:space:]] to 
#     match a space)

words <- c("HELLO", "Hi", "HI THERE", "bye", "BYE", "Good Bye", 
           "look AT this", "XX YY ZZ")

############################################################################
# We can retreive the matching pattern (rather than the entire string)
# by using 'str_extract_all' from the 'stringr' package. 'str_extract_all'
# returns a list with each element a vector of matching patterns
############################################################################

# strings containing two characters separated by a space
grep("[[:alpha:]]\\s[[:alpha:]]", strings, value = TRUE)

# extract patterns only; note that the string is specified first, then the pattern
str_extract_all(strings, "[[:alpha:]]\\s[[:alpha:]]")

# extract words (alphanumeric) that are at least 5 characters long
str_extract_all(strings, "\\b\\w{5,}\\b")


##################################################################################
# Greedy vs. lazy evaluation: regular expressions are greedy by default 
# (they find the longest string that matches the specified pattern). A question 
# mark (?) can be used after a quantifier for lazy evaluation, which finds the 
# shortest string that matches the pattern instead
##################################################################################

# Find the first sentence (ending in a period) 
#   This is incorrect because of greedy evaluation.
# Note: the period is specified using "\\."
text <- "This is the first sentence. This is the second sentence."
str_extract_all(text, "^.*\\.")

# Find the first sentence that ends in a period (correct, uses lazy evaluation)
str_extract_all(text, "^.*?\\.")


########################################################################
# strsplit can be used to split a string by a token (e.g., a word or
# pattern). Note that strsplit will always return a list
########################################################################

strsplit(strings, " ") # split each string by a blank space (" ")


########################################################################
# The website https://regex101.com/ can be used to test regular
# expressions. Note that on the website, all double dashes in R should
# be replaced with a single dash (e.g., //b would be /b)
# Example: cat(paste(strings, collapse = "\n"))
########################################################################



