# Global similarity between villages
# using sparse matrix algebra

library(qlcMatrix)
sim.locations <- sim.obs(simple)

# make "dialect" groups
# apcluster has a free variable "q"
# lower q leads to less clusters
library(apcluster)
clusters <- apcluster(sim.locations, q = 0.3)

index <- labels(clusters, type = "enum")
n <- length(clusters)

# plot dialects
library(qlcVisualize)
library(mapdata)

coordinates <- doculects[,c(1,2)]
colors <- sample(rainbow(n))

#+ fig.width = 10, fig.height = 7

dev.new(width = 10, height = 7)
par(mfrow = c(1,2))

map("worldHires", "Germany", fill = TRUE, col = "grey90")
lmap(coordinates
	, index
	, draw = 1:n
	, levels = 0.25
	, cex.legend = 0.5
	, col = colors
	, position = "topleft"
	, add = TRUE
	)

tiles <- voronoi(coordinates, mapsToOwin("Germany"))
vmap(tiles, col = colors[index][-attr(tiles,"rejects")], border = NA)
legend("topleft", legend = 1:n, fill = colors, cex = 0.5)

par(mfrow = c(1,1))

# clean up

rm(sim.locations, clusters, index, n, coordinates, tiles, colors)
