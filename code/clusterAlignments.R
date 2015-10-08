# looking for optimal number of cluster

library(fpc)
range <- 20:40
p <- pamk(as.dist(1-sim), krange = range, critout = TRUE)

# show clustering fit
#+ fig.width = 5, fig.height = 5
dev.new()
plot(range
	, p$crit[range]
	, type = "l"
	, xlab = "Number of clusters"
	, ylab = "Fit"
	)

# remove alignments that do not fit in a cluster
# this workaround is necessary because of reordering
library(cluster)
clusters <- p$pamobject$clustering
sil <- silhouette(clusters,as.dist(1-sim))
clusters[sil[,"sil_width"] < 0.01] <- NA

# cleaning up
rm(range, p, sil)
