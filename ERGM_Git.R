## Load necessary packages
library(graph)         # For graph objects and operations
library(igraph)        # For advanced network analysis and visualization
library(Rgraphviz)     # For graph visualization in R
library(gRbase)        # For graphical models
library(RBGL)          # For graph algorithms
library(graphics)      # For basic plotting
library(gRim)          # For graphical models and inference
library(qgraph)        # For visualizing networks
library(lcd)           # For various network-related functions
library(network)       # For network analysis
library(sna)           # For social network analysis
library(ergm)          # For Exponential Random Graph Models
library(ggplot2)       # For creating frequency graphs
library(tnet)          # For weighted and directed network analysis

## Create a network object named 'company'
s <- graph(n=44, edges=c())  # Create an empty graph object with 44 nodes and 0 edges

# Read edges from a CSV file
edges <- read.csv("final_edges.csv")  # Load edge data from a CSV file
e <- c()  # Initialize an empty vector for edges
for (i in 1:nrow(edges)) {
  e <- c(e, edges$from[i], edges$to[i])  # Append edges to the vector
}

ss <- s + edge(e)  # Add edges to the graph
E(ss)$weight <- edges$ans  # Add edge attribute 'weight' from the data

# Read nodes from a CSV file
n <- read.csv("final_node.csv")  # Load node data from a CSV file

# Add node attributes
V(ss)$name <- n$name  # Add node names (numbers)
V(ss)$gender <- n$gender  # Add node gender attributes
V(ss)$level <- n$level  # Add node level attributes
V(ss)$location <- n$location  # Add node location attributes
V(ss)$region <- n$region  # Add node region attributes

company <- ss  # Finalize the network object
company
is.weighted(company)  # Check if the graph is weighted

##### Chapter 3 Research Methods: Employee Network Analysis #####
# Figure 3.1 Gender Frequency Graph
# Figure 3.2 Level Frequency Graph
# Figure 3.3 Location Frequency Graph
# Figure 3.4 Region Frequency Graph
# Figure 3.5 Weight Frequency Graph
# Figure 3.6 All Variable Grid Graph
# Figure 3.7 All Variable Fruchterman-Reingold Graph
# Figure 3.8 Gender Variable Grid Graph
# Figure 3.9 Gender Variable Fruchterman-Reingold Graph
# Figure 3.10 Level Variable Grid Graph
# Figure 3.11 Level Variable Fruchterman-Reingold Graph
# Figure 3.12 Location Variable Grid Graph
# Figure 3.13 Location Variable Fruchterman-Reingold Graph
# Figure 3.14 Region Variable Grid Graph
# Figure 3.15 Region Variable Fruchterman-Reingold Graph
# Figure 3.16 Histogram of Advice Given
# Figure 3.17 Histogram of Advice Received

# Table 3.1 Basic Statistics of Variables
# Table 3.2 Basic Statistics of Weights
# Table 3.3 Basic Statistics of Network

# 1. Research Subjects

# Figure 3.1 Gender Frequency Graph
qplot(V(company)$gender, binwidth=0.5) +
  xlab("Gender") +
  geom_text(stat='count', aes(label=..count..), vjust=-0.5)

# Figure 3.2 Level Frequency Graph
qplot(V(company)$level, binwidth=0.5) +
  xlab("Level") +
  geom_text(stat='count', aes(label=..count..), vjust=-0.5)

# Figure 3.3 Location Frequency Graph
qplot(V(company)$location, binwidth=0.5) +
  xlab("Location") +
  geom_text(stat='count', aes(label=..count..), vjust=-0.5)

# Figure 3.4 Region Frequency Graph
qplot(V(company)$region, binwidth=0.5) +
  xlab("Region") +
  geom_text(stat='count', aes(label=..count..), vjust=-0.5)

# Figure 3.5 Weight Frequency Graph
qplot(E(company)$weight, binwidth=0.5) +
  xlab("Weight") +
  geom_text(stat='count', aes(label=..count..), vjust=-0.5)

# Define edge colors and node labels (common for below graphs)
e.col <- c(NA, "Wheat", "Orange", "Sienna", "Dark Green")  # Colors for weight values 2-5 (1 is not present)
pie(rep(1,5), col=e.col)  # Check colors
e.color <- e.col[E(company)$weight]  # Color edges based on advice received
v.label <- V(company)$name  # Node labels

# Figure 3.6 All Variables Grid Graph
# Figure 3.7 All Variables Fruchterman-Reingold Graph
v.shapes <- c("square", "circle")[V(company)$gender]  # Node shapes based on gender: 1 (male) is square
v.col <- rainbow(7, s=0.5)  # Define colors
pie(rep(1,7), col=v.col)  # Check colors
v.colors <- v.col[V(company)$location]  # Node colors based on location: Red for Boston
v.size <- 4*(V(company)$level)  # Node size based on level
v.f.colors <- c("blue", "red")[V(company)$region]  # Node border color based on region: Red for USA

plot(company, layout=layout.grid, vertex.color=v.colors,  # Grid layout
     vertex.shape = v.shapes, vertex.size=v.size,
     vertex.label=v.label, vertex.label.cex=0.7,
     vertex.label.color="black",
     vertex.frame.color= v.f.colors,
     edge.color=e.color, edge.arrow.size=0.4)

plot(company, layout=layout.fruchterman.reingold, vertex.color=v.colors, 
     vertex.shape = v.shapes, vertex.size=0.7*v.size,  # Apply 0.7x size to prevent node overlap
     vertex.label=v.label, vertex.label.cex=0.7,
     vertex.label.color="black",
     vertex.frame.color= v.f.colors,
     edge.color=e.color, edge.arrow.size=0.4)

# Figure 3.8 Gender Variable Grid Graph 
# Figure 3.9 Gender Variable Fruchterman-Reingold Graph
v.colors <- terrain.colors(2)[V(company)$gender]  # Colors based on gender

plot(company, layout=layout.grid,  # Grid layout
     vertex.color=v.colors, vertex.label=v.label,
     vertex.label.cex=0.7, vertex.label.color="black",
     vertex.size=10, edge.color=e.color, edge.arrow.size=0.4)

legend("topright",legend=c("Male","Female", "Very Often", "Often", "Sometimes", "Seldom"), 
       fill=c(terrain.colors(2), "Dark Green", "Sienna", "Orange", "Wheat"),
       cex=1, box.lty=0, bg="transparent")

# Figure 3.10 Level Variable Grid Graph
# Figure 3.11 Level Variable Fruchterman-Reingold Graph
v.colors <- rev(terrain.colors(5))[V(company)$level]  # Colors based on level

plot(company, layout=layout.grid,  # Grid layout
     vertex.color=v.colors, vertex.label=v.label,
     vertex.label.cex=0.7, vertex.label.color="black",
     vertex.size=10, edge.color=e.color, edge.arrow.size=0.4)

legend("topright",legend=c("Partner","Managing C", "Senior C", "Junior C", "Assistant",
                           "Very Often", "Often", "Sometimes", "Seldom"), 
       fill=c(terrain.colors(5), "Dark Green", "Sienna", "Orange", "Wheat"),
       cex=1, box.lty=0, bg="transparent")

# Figure 3.12 Location Variable Grid Graph
# Figure 3.13 Location Variable Fruchterman-Reingold Graph
v.colors <- terrain.colors(7)[V(company)$location]  # Colors based on location

plot(company, layout=layout.grid,  # Grid layout
     vertex.color=v.colors, vertex.label=v.label,
     vertex.label.cex=0.7, vertex.label.color="black",
     vertex.size=10, edge.color=e.color, edge.arrow.size=0.4)

legend("topright",legend=c("Boston","London","Paris","Rome", "Madrid", "Oslo", "Copenhagen",
                           "Very Often", "Often", "Sometimes", "Seldom"), 
       fill=c(terrain.colors(7), "Dark Green", "Sienna", "Orange", "Wheat"),
       cex=1, box.lty=0, bg="transparent")

# Figure 3.14 Region Variable Grid Graph
# Figure 3.15 Region Variable Fruchterman-Reingold Graph
v.colors <- rev(terrain.colors(2))[V(company)$region]

plot(company, layout=layout.grid,  # Grid layout
     vertex.color=v.colors, vertex.label=v.label,
     vertex.label.cex=0.7, vertex.label.color="black",
     vertex.size=10, edge.color=e.color, edge.arrow.size=0.4)

legend("topright",legend=c("USA","Europe",
                           "Very Often", "Often", "Sometimes", "Seldom"), 
       fill=c(terrain.colors(2), "Dark Green", "Sienna", "Orange", "Wheat"),
       cex=1, box.lty=0, bg="transparent")

# Table 3.3 Basic Statistics of the Network
# Transitivity (without considering directionality)
igraph::transitivity(company, weights=E(company)$weight)
A_w <- get.adjacency(company, attr="weight", sparse=T)
A_w <- as.matrix(A_w)  # Convert to weighted adjacency matrix

# Mean distance
mean(distance_w(A_w, directed=TRUE), na.rm=T)

# Maximum distance
diameter(company, directed=TRUE, weights=E(company)$weight)

# Average and variance of in-degree (number of advised employees) / out-degree (number of advice sought)
mean(igraph::degree(company, mode="in"))
mean(igraph::degree(company, mode="out"))
var(igraph::degree(company, mode="in"))
var(igraph::degree(company, mode="out"))

# Average and variance of in-strength (sum of advice given) / out-strength (sum of advice received)
mean(graph.strength(company, mode="in")) 
var(graph.strength(company, mode="in"))
mean(graph.strength(company, mode="out"))
var(graph.strength(company, mode="out"))

# Figure 3.16 Histogram of total advice given
hist(graph.strength(company, mode="in"), col="lightblue",
     main="Vertex Strength (Total Advice Given)")

# Figure 3.17 Histogram of total advice received
hist(graph.strength(company, mode="out"), col="pink",
     main="Vertex Strength (Total Advice Received)")

##### Chapter 4 Research Results ####

# 1. General Characteristics of Respondents

# Figure 4.1 Top 10 Individuals by Total Advice Given Average
# Figure 4.2 Average of Total Advice Given
# Figure 4.3 Top 10 Individuals by Total Advice Received Average
# Figure 4.4 Average of Total Advice Received
# Figure 4.5 Simulation Network Grid Graph
# Figure 4.6 Simulation Network Fruchterman-Reingold Graph
# Figure 4.7 Network Fit Statistics
# Figure 4.8 Trends and Distribution of MCMC Samples and Actual Values

# Table 4.1 Basic Statistics of the Network
# Table 4.2 ERGM Model Results

# Figure 4.1 Top 10 Individuals by Total Advice Given Average
avg_sort_score1 <- sort(avg_score1, decreasing=TRUE)
barplot(avg_sort_score1[1:10], main="Top 10 Individuals by Average Total Advice Given")

# Figure 4.2 Average of Total Advice Given
plot(x=1:44, y=avg_score1, cex=0.1*igraph::degree(company, mode="in"),
     xaxt="n", main="Average of Total Advice Given")
axis(1, at=1:44)

# Figure 4.3 Top 10 Individuals by Total Advice Received Average
avg_sort_score2 <- sort(avg_score2, decreasing=TRUE)
barplot(avg_sort_score2[1:10], main="Top 10 Individuals by Average Total Advice Received")

# Figure 4.4 Average of Total Advice Received
plot(x=1:44, y=avg_score2, cex=0.1*igraph::degree(company, mode="out"),
     xaxt="n", main="Average of Total Advice Received")
axis(1, at=1:44)

# Table 4.1 Basic Statistics of the Network Results 2
# Betweenness Centrality
btw <- igraph::betweenness(company, directed=TRUE, weights=E(company)$weight)
sort(btw, decreasing=TRUE)[1:10]

# PageRank
pr <- page.rank(company, directed=TRUE, weights=E(company)$weight)$vector
sort(pr, decreasing=TRUE)[1:10]

# Hub Score
hub <- hub.score(company)$vector
sort(hub, decreasing=TRUE)[1:10]

# Authority Score
aut <- authority.score(company)$vector
sort(aut, decreasing=TRUE)[1:10]

## Create a network object for ERGM application
A <- get.adjacency(company, sparse=T)
com <- network::as.network(as.matrix(A), directed=TRUE)  

# Node attributes
v.attrs <- get.data.frame(company, what="vertices")

# Edge attributes
e.attrs <- get.data.frame(company, what="edges")
ee <- as.matrix(e.attrs)

network::set.vertex.attribute(com, "name", v.attrs$name)
network::set.vertex.attribute(com, "gender", v.attrs$gender)
network::set.vertex.attribute(com, "level", v.attrs$level)
network::set.vertex.attribute(com, "location", v.attrs$location)
network::set.vertex.attribute(com, "region", v.attrs$region)

# Table 4.2 ERGM Model Results

# Null model
m_null <- ergm(com ~ edges, control=control.ergm(seed=42)); summary(m_null)

# Model 1: Model including only structural network variables
m_structure <- ergm(com ~ edges + mutual + istar(2)
                    + dgwesp(0.2, fixed=TRUE, type="OTP"), 
                    control=control.ergm(seed=42)); summary(m_structure)

# Model including covariate variables
m_1 <- ergm(com ~ edges + mutual + istar(2)
            + dgwesp(0.1, fixed=TRUE, type="OTP") 
            + nodeifactor("gender") + nodeofactor("gender") 
            + nodeifactor("region") + nodeofactor("region")
            + nodeicov("level") + nodeocov("level")
            + nodeifactor("location") + nodeofactor("location"), 
            control=control.ergm(seed=42)); summary(m_1) 
# Error with location variable, result not available -> remove

m_2 <- ergm(com ~ edges + mutual + istar(2)
            + dgwesp(0.1, fixed=TRUE, type="OTP") 
            + nodeifactor("gender") + nodeofactor("gender") 
            + nodeifactor("region") + nodeofactor("region")
            + nodeicov("level") + nodeocov("level"), 
            control=control.ergm(seed=42)); summary(m_2) 
# nodeifactor.gender.2 & nodeifactor.region.2 & nodeicov.level not significant -> remove

# Model with homophily variables
m_3 <- ergm(com ~ edges + mutual + istar(2)
            + dgwesp(0.1, fixed=TRUE, type="OTP") 
            + nodeofactor("gender") 
            + nodeofactor("region")
            + nodeocov("level")
            + nodematch('gender', diff=TRUE) + nodematch('level', diff=TRUE) + nodematch('region', diff=TRUE) + nodematch('location', diff=TRUE), 
            control=control.ergm(seed=42)); summary(m_3) 
# Error with nodematch.location variable, result not available -> remove

m_4 <- ergm(com ~ edges + mutual + istar(2)
            + dgwesp(0.1, fixed=TRUE, type="OTP") 
            + nodeofactor("gender") 
            + nodeofactor("region")
            + nodeocov("level")
            + nodematch('gender', diff=TRUE) + nodematch('level', diff=TRUE) + nodematch('region', diff=TRUE), 
            control=control.ergm(seed=42)); summary(m_4) 
# nodematch.gender & nodematch.level not significant -> remove

# Add weight variable
m_5 <- ergm(com ~ edges + mutual + istar(2)
            + dgwesp(0.1, fixed=TRUE, type="OTP") 
            + nodeofactor("gender") 
            + nodeofactor("region")
            + nodeocov("level")
            + edgecov(ee, attr="weight"), 
            control=control.ergm(seed=42)); summary(m_5) 
# Include weight with edgecov for data characteristics -> but not significant -> remove

## Since there are two variables for region as nodeofactor and nodematch, 
# check each variable one at a time to see if smaller AIC and BIC values are obtained.

# case1: Only add nodeofactor("region")
m_6 <- ergm(com ~ edges + mutual + istar(2)
            + dgwesp(0.1, fixed=TRUE, type="OTP") 
            + nodeofactor("gender") 
            + nodeofactor("region")
            + nodeocov("level"), 
            control=control.ergm(seed=42)); summary(m_6) 
# All significant, AIC
# All significant, AIC: 1677  BIC: 1716

# case2: Only add nodematch('region', diff=TRUE)
m_7 <- ergm(com ~ edges + mutual + istar(2)
            + dgwesp(0.1, fixed=TRUE, type="OTP") 
            + nodeofactor("gender") 
            + nodeocov("level")
            + nodematch('region', diff=TRUE), 
            control=control.ergm(seed=42)); summary(m_7) 
# All significant, AIC: 1422  BIC: 1466 -> Choose case2 as it is smaller than case1

## Model 2: Final Model 
# Adjust dgwesp (0.1) to dgwesp (0.2) and verify smaller AIC, BIC values
m_8 <- ergm(com ~ edges + mutual + istar(2)
            + dgwesp(0.2, fixed=TRUE, type="OTP") 
            + nodeofactor("gender") 
            + nodeocov("level")
            + nodematch('region', diff=TRUE), 
            control=control.ergm(seed=42)); summary(m_8) 
# All significant, AIC: 1403  BIC: 1448 -> Smallest values

# Simulation
sim <- simulate(m_8, nsim=1, seed=569)
summary(sim, print.adj=FALSE)

# Graph Structuring
simm <- graph.data.frame(sim)
V(simm)$gender <- sim %v% 'gender'
V(simm)$level <- sim %v% 'level'
V(simm)$location <- sim %v% 'location'
V(simm)$region <- sim %v% 'region'

v.label <- V(simm)$name
v.shapes <- c("square", "circle")[V(simm)$gender]
v.col <- rainbow(7, s=0.5)
# v.colors <- v.col[V(simm)$location] # Not included due to lack of significance in the model
v.size <- 4*(V(simm)$level)
v.f.colors <- c("blue", "red")[V(simm)$region]

# Figure 4.5 Simulation Network Grid Graph
# Figure 4.6 Simulation Network Fruchterman-Reingold Graph
plot(simm, layout=layout.grid, # layout.fruchterman.reingold
     vertex.color="white",
     vertex.shape=v.shapes, vertex.size=v.size,
     vertex.label=v.label, vertex.label.cex=1,
     vertex.label.color="black",
     vertex.frame.color=v.f.colors,
     edge.arrow.size=0.4)

# Figure 4.7 Network Fit Statistics
m_fit <- gof(m_8)
op <- par(mfrow=c(2,3), cex.lab=1.4)
plot(m_fit)

# Figure 4.8 Trends and Distribution of MCMC Samples and Actual Values
mcmc.diagnostics(m_8, vars.per.page=8)
