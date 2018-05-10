##############################################################################
# Let's look at the Princess Bride script
##############################################################################

library(stringr)
library(sentimentr)
library(wordcloud2)
library(text2vec) # needed for tokenizer
library(tm) # needed for stopwords
library(ggplot2)

# use readLines to return a character vector (each element is a line in the file)
script <- readLines("https://raw.githubusercontent.com/gdancik/NS-SRI/master/data/notes/PrincessBride.txt")
cat(script, sep = "\n")


# Note: you will need to 'manually' look through the script to understand 
# the format. In general, names of characters are written in all upper-case,
# and dialogue is centered on the screen

##################################################################
# Get a list of characters with speaking roles
##################################################################

# keep lines with uppercase text in middle
pattern <- "\\s{10,}[[:upper:]]+$"
characters <- grep(pattern, script, value = TRUE)
unique(characters)

pattern <- "\\s{10,}[[:upper:]]+ *[[:upper:]]+$"
pattern <- "\\s{10,}([[:upper:]]+ ?)+$"

# But are we missing anybody? How can we correct this?
characters <- grep(pattern, script, value = TRUE)
unique(characters)

# to ensure we are getting character headings for speaking parts, take only
# matches where the previous line is blank
# line should be blank ("")

i <- grep(pattern, script)  # get index for current matches
keep <- script[i-1] == ""   # get logical vector for matches where previous line is blank

characters <- script[i]  # get strings matching the regular expression
characters <- characters[keep] # keep strings that follow a blank line

# summarize the number of speaking parts for each character -- can you
# generate a barplot of this data?
table(characters)


###########################################################################
# Now let's print out script, highlighting scene changes with lines ending
# with "CUT TO:" or lines beginning with any number upper case words, as
# specified by:
#   ^ - beginning of string
#   \\b - start and end of a word boundary (alpha)
#   [A-Z] any uppercase letter
#   [A-Z]+ any sequence of uppercase letters
# Note that different movie scripts may have slightly different formats
###########################################################################
for (line in script) {
  g <- grep("(CUT TO:$)|(^\\b[A-Z]+\\b)", line)
  if (length(g) > 0) {
    message(line) # prints text in red
  } else {
    cat(line)  # print text in standard format
  }
  cat("\n")
}

# for patterns spanning over multiple lines, it is usually easier
# to 'collapse' all lines into a single string
script1 <- paste0(script, collapse = "\n")
script1
cat(script1)

#######################################################################
# Let's analyze VIZZINI's dialogue. The regular expression below will 
# find VIZZINI's dialogue, based on the following criteria:

# start with the "VIZZINI" label :
#  "\n {10,}VIZZINI\n" - the line starts with at least 10 blank spaces and
#                             ends with "VIZZINI"

# stop when we get to a blank line ("\n\n"), based on the following:
#  "[^\n]+" - one or more non-newline characters
#  "[^\n]+\n" - a line of of text (or numbers, etc), stopping at the line break ('\n')
#  "([^\n]+\n)+" - multiple lines of text (one or more of the previous regular expression)
# 

pattern <- "\n\ {10,}VIZZINI\n([^\n]+\n)+"
vizzini <- str_extract_all(script1, pattern)  # this returns a list of length 1
vizzini <- vizzini[[1]] # 1st element of list contains the matches

# print out each spoken part
cat(vizzini)

# we don't care about "VIZZINI", so can gsub which is a "find" and "replace" function 
vizzini <- gsub("\n\ {10,}VIZZINI\n", "", vizzini)

words <- word_tokenizer(tolower(vizzini))

# use 'unlist' to collapse a list of elements into a single 'vector'
words <- unlist(words)

# summarize the words
t <- table(words)
sort(t)

# get a logical vector for words to remove
remove <- words %in% stopwords()

# keep only the words we do NOT want to remove
words <- words[!remove]


#################################################################
# construct a wordcloud for VIZZINI's dialogue
#################################################################

# we need a data.frame with the first column containing the words
# and the second column containing the frequency
t <- table(words)
df <- data.frame(t)

# generate the word cloud, where size is the font size
#  (note: you may have to modify the font size so that all words
#  are displayed)
wordcloud2(df, size = .5)  

# generate word cloud for only words occuring at least 2 times
keep <- df$Freq >= 2
wordcloud2(df[keep,], size = .5)  



#################################################################
# Carry out a sentiment analysis for VIZZINI's dialogue
#################################################################

# sentiment calculates the sentiment for each sentence in a vector
# scores > 0 are considered positive; scores < 0 are considered negative
sentiment("You are the best")
sentiment("You are an idiot")
sentiment("Look at that dog. Isn't it cute?")

# sentiment_by will group sentences together
# (by default, sentences within a string are grouped together)
sentiment_by("Look at that dog. Isn't it cute?")


# use sentiment_by to find the sentiment of each section of dialogue
s <- sentiment_by(vizzini)


# let's look at the lines with the lowest and highest sentiment scores
i <- which.min(s$ave_sentiment)
vizzini[i]

i <- which.max(s$ave_sentiment)
vizzini[i]

# highlight sentences by sentiment polarity. will create and open the file
# polarity.html
highlight(s)

file.remove("polarity.html")

interpretScore <- function(x) {
  y <- rep("neutral", length(x))
  y[x > 0.05] <- "positive"
  y[x < -0.05] <- "negative"
  y
}

sentiments <- interpretScore(s$ave_sentiment)

df <- data.frame(sentiments)

ggplot(df, aes(x=sentiments, fill = sentiments)) + geom_bar() +
  theme(legend.position = "none") + ggtitle("Sentiment Analysis of VIZZINI") +
  ylab("Number of lines")


