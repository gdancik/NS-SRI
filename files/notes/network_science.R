##########################################################################
## Constructing and analyzing networks in R
##########################################################################

library(readxl)
library(igraph)

# Let's import the adjacency matrix from:
# https://github.com/gdancik/NS-SRI/blob/master/data/notes/PrincessBrideAdjacency.xlsx?raw=true


# Note: you can get this code by using the Import Dataset wizard
# from the Environment panel, and importing the code from the 
# History panel
url <- "https://github.com/gdancik/NS-SRI/blob/master/data/notes/PrincessBrideAdjacency.xlsx?raw=true"
destfile <- "A.xlsx"
download.file(url, destfile)
A <- read_excel(destfile)

# we will remove the first column, which contains the character names
A <- A[,-1]

# how many interactions were there between BUTTERCUP and WESTLEY?


# How do we calculate the degree centrality and average degree centrality


# create a weighted graph
g <- graph_from_adjacency_matrix(as.matrix(A), mode = "undirected", weighted = TRUE)

# plot weighted graph
plot(g, vertex.label.cex = .6, edge.curved = FALSE,
     vertex.color = "green", asp = 0,
     main = "Princess Bride Character Interactions", vertex.size = 12)

weights <- E(g)$weight
plot(g, vertex.label.cex = .6, edge.curved = FALSE,
     vertex.color = "green", main = "Princess Bride Character Interactions (Weighted)",
     edge.width = weights, layout=layout_in_circle, asp = 0)
     

plot(g, vertex.label.cex = .6, edge.curved = FALSE,
     vertex.color = "green", main = "Princess Bride Character Interactions (Weighted)",
     edge.width = weights)


colors <- rep(NA, ncol(A))
colors[colnames(A)=="Buttercup"] <- "green"
plot(g, vertex.label.cex = .6, main = "Princess Bride Character Interactions",
     vertex.color = colors)

################################################################
# Girvan-Newman algorithm for community detection 
#   (not applicable for weighted graphs)
################################################################

# start with unweighted graph or multigraph (weighted graphs cannot be used)
g <- graph_from_adjacency_matrix(as.matrix(A), mode = "undirected")

# Remove multi-edges and loops
g <- simplify(g)

# apply the Newman Girvan algorithm for community detection
ceb <- cluster_edge_betweenness(g1, directed=FALSE)

# plot the communities
plot(ceb,g, vertex.label.cex = .6, 
     main = "Princess Bride Communities Identified by Girvan-Newman Algorithrm",
     asp = 0)