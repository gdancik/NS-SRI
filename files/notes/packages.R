####################################################################################
## Installing packages 
####################################################################################

# Due to permission issues, when working on school computers R packages 
# must be installed and loaded from the Z:/ drive. If working on your 
# personal computer, it is best to install packages to their default
# positions (i.e., you do not need to change the library path, as described below).

# To install and load R packages on school computers, first reate a directory on 
# your Z:/ drive called 'Rlib'. I will assume that this  directory is created in 
# the directions that follow. If you use a different directory name, replace 
# "Z:/Rlib" with the directory that you created.

# Within R, set the package directory by typing the command below. This must be
# done prior to installing or loading packages

.libPaths("Z:/Rlib")

# Install packages
install.packages("ggplot2")
install.packages("stringr")
install.packages("sentimentr")
install.packages("wordcloud2")
install.packages("text2vec")
install.packages("tm")
install.packages("readxl")
install.packages("igraph")


# Verify that the packages have been installed (If on a school computer, you must 
# set the library path before you can load an installed package)

library("ggplot2")
library("stringr")
library("sentimentr")
library("wordcloud2")
library("text2vec")
library("tm")
library("readxl")
library("igraph")
