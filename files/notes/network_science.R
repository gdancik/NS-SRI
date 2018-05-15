##########################################################################
## Constructing and analyzing networks in R
##########################################################################

library(readxl)
library(igraph)

# Let's download the adjacency matrix from:
# https://gdancik.github.io/NS-SRI/files/PrincessBrideAdjacency.xlsx

# if applicable, change the code below to specify the path and file name of the adjacency matrix
file <- "Z:/PrincessBrideAdjacency.xlsx"

# Note: you can get the code below by using the Import Dataset wizard
# from the Environment panel, and inserting the code from the history panel
A <- read_excel(file)

# how many interactions were there between BUTTERCUP and WESTLEY?


# we will remove the first column, which contains the character names
A <- A[,-1]


# How do we calculate the degree centrality and average degree centrality


# create a weighted graph
g <- graph_from_adjacency_matrix(as.matrix(A), mode = "undirected", weighted = TRUE)

# plot graph (weights are not visualized by default)
plot(g, vertex.label.cex = .6, edge.curved = FALSE,
     vertex.color = "green", asp = 0,
     main = "Princess Bride Character Interactions", vertex.size = 12)

# plot weighted graph by setting each edge.width to the corresponding weight
weights <- E(g)$weight
plot(g, vertex.label.cex = .6, edge.curved = FALSE,
     vertex.color = "green", main = "Princess Bride Character Interactions (Weighted)",
     edge.width = weights)

# plot weighted graph using a circular layout
plot(g, vertex.label.cex = .6, edge.curved = FALSE,
     vertex.color = "green", main = "Princess Bride Character Interactions (Weighted)",
     edge.width = weights, layout=layout_in_circle, asp = 0)
     

################################################################
# Girvan-Newman algorithm for community detection 
#   (not applicable for weighted graphs)
################################################################

# start with unweighted graph or multigraph (weighted graphs cannot be used)
g <- graph_from_adjacency_matrix(as.matrix(A), mode = "undirected")

# Remove multi-edges and loops
g <- simplify(g)

# apply the Newman Girvan algorithm for community detection
ceb <- cluster_edge_betweenness(g, directed=FALSE)

# plot the communities
plot(ceb,g, vertex.label.cex = .6, 
     main = "Princess Bride Communities Identified by Girvan-Newman Algorithrm",
     asp = 0)
