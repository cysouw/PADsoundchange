# visualisation of clusters
# using function "limage" with different defaults

library(qlcVisualize)

draw.cluster <- function(cluster
						, ncol = 6
						, order = "R2E"
						, cl = clusters
						, method = "poi"
						, ...
						) {

	limage(simple[,which(cl ==  cluster)]
		, col = rainbow(ncol)
		, order =  order
		, method = method
		, cex.axis = 0.3
		, cex.legend = 0.7
		, cex.remaining = 0.2
		, show.remaining =  TRUE
		, ...
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

