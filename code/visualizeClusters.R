# visualisation of clusters
# using function "limage" with different defaults

draw.cluster <- function(cluster) {

	columns <- simple[ , clusters == cluster]				
	qlcVisualize::limage(columns
						, col = rainbow(8)
						, order = "R2E"
						, method = "poi"
						, show.remaining = TRUE
						, cex.axis = 1
						, cex.remaining = .5
						, cex.legend = 2
						, font = "Charis SIL"
						)
}

# simple function to draw lines in limage-plot

draw.line <- function(h, lwd = 1) {
	segments(rep(0,length(h))
			, rep(h, length(h))
			, rep(183, length(h))
			, rep(h, length(h))
			, lwd = lwd
			)
}

# drawing to PDF

plot.cluster <- function(cluster) {
	
	# PDF device
	
	filename <- paste0("images/", cluster, ".pdf")
	dev.new(file = filename 
			, width = nrow(align)/6+1
			, height = max(table(clusters))/6+1
			, type = "pdf"
			)

	# plotting the image
		
	sysfonts::font.add(family = "Charis SIL", regular = "CharisSIL-R.ttf")
	showtext::showtext.begin()

	draw.cluster(cluster)
	
	showtext::showtext.end()
	dev.off()
}


# function to list most frequent sounds per cluster

stats <- function(clusters, alignments) {
	sapply(unique(clusters), function(clus) {
		c(sort(table(alignments[,clusters == clus]), decreasing = TRUE)[1:5]
		, cols = sum(clusters == clus)
		)
	}, simplify = FALSE)
}

