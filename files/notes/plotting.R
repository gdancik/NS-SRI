##########################################################################
## Generating plots in R using ggplot
##########################################################################

library(ggplot2)

##########################################################################
## a data.frame is a table (like a matrix) where columns
## can be accessed by name (like a list) and where
## columns can be of different types. Data.frames are the standard 
## storage object for use in data analysis
##########################################################################

# the iris dataset (one of many built-in datasets in R) gives an 
# example of a data.frame
View(iris)
head(iris)

# Since a data.frame is stored like a list, where each column is an element
# of the list, we have three ways of accessing a column:
iris$Species
iris[['Species']]
iris[[5]]

###########################################################
# ggplot provides a powerful framework for generating
# complex graphics, based on a philosophy/language of 
# visualization that separates the data, the aesthetics,
# and the plotting layer
###########################################################

# First, we will look at a simple scatterplot using the 
# 'base' plot function in R
plot(iris$Petal.Width, iris$Petal.Length, pch = 18, 
     xlab = "Petal Width", ylab = "Petal Length",
     main = "Petal Length vs. Petal Width from Iris dataset")


####################################################################
# ggplot examples -- we will generally use this format
# ggplot(data, aes(x,y)) + layer(aes(...)) + labels + ...
#    data - the data.frame containing data to plot
#    aes - an aesthetic mapping, specifying the x- and y-values
#             to plot, and optionally the coloring to use. 
#             If specified in ggplot(), mapping applies to all layers
#    layer - the type of plot, e.g., geom_point() for a scatterplot, 
#             geom_bar() for a bar plot, etc
#    labels - ggtitle(), labs(x = "x label", y = "ylabel")
####################################################################


########################################################################
# A scotterplot plots (x,y) pairs of numerical values
# scatterplot: ggplot(data, aes(x,y)) + geom_point(aes(color = color))
########################################################################
ggplot(iris, aes(x=Petal.Width, y = Petal.Length)) +
      geom_point() + 
      ggtitle("Petal Length vs. Petal Width from Iris dataset") +
      labs(x = "Petal Width", y = "Petal Length")

# we can color the points by specifying the color (or colour) aesthetic
# we can also store the plot in an object and plot later using the
# print function
g = ggplot(iris, aes(x=Petal.Width, y=Petal.Length)) +
  geom_point(aes(color = Species)) +
  ggtitle("Petal Length vs. Petal Width from Iris dataset") +
  labs(x = "Petal Width", y = "Petal Length")
print(g)

# alternative plots with added components
g + geom_smooth(color = "blue")
g + geom_smooth(color = "blue") + theme_linedraw()



########################################################################
# In a bar graph, the height of a bar corresponds to the frequency
# (number of times) or proportion (relative frequency) for which a 
# categorical value is observed in the data
# barchart: ggplot(data, aes(x)) + geom_bar(aes(fill, weight))
########################################################################

status <- c("freshman", "freshman", "sophomore", "sophomore", "junior", "sophomore")

d.status <- data.frame(status = status) # need to create data.frame
ggplot(d.status, aes(x=status)) + geom_bar(aes(fill = status)) +
  ggtitle("Class status of students") +
  labs(x = "Class status", y = "Frequency") + theme_classic() +
  theme(legend.position = "none")


# set weight = 1 / n, where n = the number of observations, to plot relative
# frequencies
ggplot(d.status, aes(x=status)) + geom_bar(aes(fill = status, weight = 1/length(status))) +
  ggtitle("Class status of students") +
  labs(x = "Class status", y = "Relative frequency") + theme_classic() +
  theme(legend.position="none")

##################################################################
# Construct a Pareto chart to show bars from tallest to shortest
##################################################################

# the class status data is stored as a 'factor', which is a categorical value. 
# By default, these levels are ordered alphabetically
d.status$status
levels(d.status$status)

# let's change the order
status <- factor(status, levels = c("freshman", "sophomore", "junior", "senior"))

d.status <- data.frame(status)
ggplot(d.status, aes(x=status)) + geom_bar(aes(fill = status)) +
  ggtitle("Class status of students") +
  labs(x = "Class status", y = "Frequency") + theme_classic() + 
  theme(legend.position = "none")

# change the order for a Pareto chart where bars are ordered from highest 
# (most frequent) to lowest (least frequent)
counts <- table(status)
sorted.counts <- sort(counts, decreasing = TRUE)
status <- factor(status, levels = names(sorted.counts))
d.status <- data.frame(status)
ggplot(d.status, aes(x=status)) + geom_bar(aes(fill = status)) +
  ggtitle("Class status of students") +
  labs(x = "Class status", y = "Frequency") + theme_classic() +
  theme(legend.position = "none")


#################################################
# frequency table and relative frequency tables #
#################################################

# frequency table
table(status) 

#relative frequency (proportions), but is not correct if status contains missing values
table(status) / length(status) 


###########################################################################
# a boxplot generates a box that summarizes a numerical value based on its
# association with a categorical variable. The box contains the middle 
# 50% of the data
# boxplot: ggplot(data, aes(x,y,fill)) + geom_boxplot(aes(color = color))
###########################################################################

ggplot(iris, aes(Species, Petal.Length, fill = Species)) + geom_boxplot() +
  ggtitle("Petal Length for Different Species in the Iris Dataset") +
  theme_classic() + theme(legend.position = "none")

