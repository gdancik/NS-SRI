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

# use 'paste0' as a shortcut to set sep = "" 
paste0("A", "B", "C", x)


# use paste to collapse elements in a vector
abc <- c("A", "B", "C")
paste(abc, collapse = "")


#############################################################################
# searching strings
#############################################################################

strings <- c("network science", "computer science", "biology", 
             "computers", "computer networks", "computers", "summer 2018", "science")

# match looks for an exact match of a string in a vector of strings, and 
# returns the index of where the FIRST exact match is found; an NA is 
# returned if there is no match
match("computers", strings)   # only first occurence is identified
match("computer", strings)    # no exact matches, NA is returned

# if the first argument is a vector, match is applied to each element
match(c("network science", "summer", "summer 2018"), strings) 

# the "%in%" operator returns TRUE or FALSE for whether each element
# of the first vector is found exactly in the second

"network" %in% strings

c("network science", "summer", "summer 2018") %in% strings

# grep returns the index or vector of indices for where a pattern is found
# in a vector of strings (unlike 'match', 'grep' returns multiple matches)
grep("network", strings)

# grepl is the same as 'grep' but returns a logical vector containing TRUE in 
# the position where the pattern is found
grepl("network", strings)

# Use grep with value = TRUE to return the matching string instead of the index
grep("network", strings, value = TRUE)


##############################################################################
# A regular expression can be used to search for a pattern, which can
# include special characters:

# Anchors:
#   - a caret ('^') matches the beginning of a string
#   - a dollar sign ('$') matches the end of a string (which may be
#     before a newline character)
#   - \\b matches the beginning or end of a word (ignoring punctuation)

# Character classes:
#   - a dot ('.') matches any character except a newline
#   - a vertical bar (|) is used for matching one pattern or another
#   - brackets [ab] will match any characters in the brackets 
#       (e.g., 'a' or 'b')
#   - brackets [^ab] will match any characters NOT in the brackets 
#       (e.g., any character other than 'a' or 'b')
#   - brackets [1-4] will match any characters in the range 1-4
#   - [[:digit:]] or \\d matches [[0-9]]
#   - [[:alpha:]] matches any alphabetical character, [[A-z]]
#   - [[:upper:]] matches any uppercase character, [[A-Z]]
#   - [[:space:]] or \\s matches any space, tab, or newline
#   - [^[:space:]] or \\S matches any non-space, tab or newline character
#   - \\w matches any 'word' characters [A-z0-9_] (use \\W for negation)
#   - parentheses () are used for grouping

# Quantifiers which apply to the previous character or group of 
# characters
#   - an asterisk ('*') matches 0 or more times
#   - a plus sign ('+') matches 1 or more times
#   - braces of the form {n}, {n,m}, {n,}, {,m} match exactly 'n' times,
#     between 'n' and 'm' times, 'at least 'n' times, and no more than 'm'
#     times, respectively
#   - a question mark ('?') matches at most one time, and can also be 
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


# strings that contain two alphabetical characters separated by a space or newline
grep("[[:alpha:]][[:space:]][[:alpha:]]", strings, value = TRUE)
grep("[[:alpha:]]\\s[[:alpha:]]", strings, value = TRUE)

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

# (4) find strings containing words that include a 'c' and an 's' in any order.

# (5) Find all strings containing ONLY all uppercase words in the words vector
words <- c("HELLO", "Hi", "HI THERE", "heLLo", "bye", "BYE", "Good Bye", "look AT this")

############################################################################
# We can retreive the matching pattern (rather than the entire string)
# by using 'str_extract_all' from the 'stringr' package. 'str_extract_all'
# returns a list with each element a vector of matching patterns
############################################################################

# strings containing two characters separated by a space
grep("[[:alpha:]]\\s[[:alpha:]]", strings, value = TRUE)

# extract patterns only; note that the string is specified first, and 
# then the pattern 
str_extract_all(strings, "[[:alpha:]]\\s[[:alpha:]]")

# extract words (alphanumeric) that are at least 5 characters long --
# why does this not work??
str_extract_all(strings, "\\b.{5,}\\b")

# extract words (alphanumeric) that are at least 5 characters long
str_extract_all(strings, "\\b\\w{5,}\\b")


##################################################################################
# Greedy vs. lazy evaluation: regular expressions are greedy by default 
# (they find the longest string that matches the specified pattern). A question 
# mark (?) can be used after a quantifier for lazy evaluation, which finds the 
# shortest string that matches the pattern instead
##################################################################################

# Find the first sentence that ends in a period (incorrect because of greedy evaluation)
# Note: the actual period is specified using "\\.", because "." already has a 
# special meaning
str_extract_all("This is the first sentence. This is the second sentence.", "^.*\\.")

# Find the first sentence that ends in a period (correct, uses lazy evaluation)
str_extract_all("This is the first sentence. This is the second sentence.", "^.*?\\.")


########################################################################
# strsplit can be used to split a string by a token (e.g., a word or
# pattern). Note that strsplit will always return a list
########################################################################

strsplit(strings, " ") # split each string by a blank space (" ")


