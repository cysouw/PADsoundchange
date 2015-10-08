#' # === read PAD data ===
source("code/readPAD.R")


#' # === Simplify orthography ===

# more than 4000 different segments in the data
length(unique(na.omit(as.character(all))))

# simplify orthography
library(qlcTokenize)
# prepare a draft profile to be edited by hand
# write.profile(all, file = "draftprofile.tsv", normalize = "NFD", sep = "", editing = TRUE)

#simplify data using edited profile
simple <- tokenize(all, profile = "data/profile.tsv", transliterate = "Replacement", sep = "", normalize = "NFD")$strings$transliterated
dim(simple) <- dim(all)
dimnames(simple) <- dimnames(all)

# still almost 1000 different segments
length(unique(na.omit(as.character(simple))))

#' # === Global similarity between villages ===

library(qlcMatrix)
sim.locations <- sim.obs(simple)

# make "dialect" groups
library(apcluster)
clusters <- apcluster(sim.locations, q = 0.2)
hier <- aggExCluster(sim.locations,clusters)

# reformat output of apcluster
cl.vec <- c()
for (i in 1:length(clusters@clusters)){cl.vec[clusters[[i]]] <- i}
n <- max(cl.vec)

# plot dialects
library(qlcVisualize)
library(mapdata)

coordinates <- doculects[,c(1,2)]

#+ fig.width = 7, fig.height = 9
map("worldHires", "Germany", fill = TRUE, col = "grey90")
lmap(coordinates, cl.vec, draw = 1:n, levels = 0.25, cex.legend = 0.5, col = sample(rainbow(n)), position = "topleft", add = TRUE)


#' # === Similarity between alignments ===

library(qlcMatrix)

all2 <- t(simple)
all2[all2=="-"] <- NA
sim <- sim.obs(all2)


#' # === Clustering of alignments ===

# maximum at 30 clusters
library(fpc)
range <- 20:40
p <- pamk(as.dist(1-sim), krange = range, critout = TRUE)

# show clustering fit
#+ fig.width = 5, fig.height = 5
plot(range, p$crit[range], type = "b", xlab = "Number of clusters", ylab = "Fit")

# remove alignments that do not fit in a cluster
# this workaround is necessary because of reordering
library(cluster)
cl <- p$pamobject$clustering
sil <- silhouette(cl,as.dist(1-sim))
cl[sil[,"sil_width"] < 0] <- NA

#' # === Visual inspection of clusters

library(qlcVisualize)

draw.cluster <- function(cluster
						, ncol = 6
						, order = "R2E"
						, member = cl
						, method = "poi"
						, ...
						) {

	limage(simple[,which(member ==  cluster)]
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

draw.line <- function(h, lwd = 1) {
	segments(rep(0,length(h))
			, rep(h, length(h))
			, rep(183, length(h))
			, rep(h, length(h))
			, lwd = lwd
			)
}

# possibly make new groups
m <- cl

renew <- function(cluster, range, new_number, order = ordering) {
	m[which(cl==cluster)[order$cols[range]]] <<- new_number
}

# ======
#+ fig.width = 10, fig.height = 7

# a short/long
ordering <- draw.cluster(1, 10) 

# v (orthographic w)
ordering <- draw.cluster(2)
	# b/_en 
	draw.line(25)
	renew(2, 26:29, 31)
ordering <- draw.cluster(2, member = m)
	# b/_e
	draw.line(22) 	
	renew(2, 23:25, 32)

# m
ordering <- draw.cluster(3)
	# n/[fb]e_
	draw.line(7)
	renew(3, 1:7, 33)
	# Dativ
	draw.line(22)
	renew(3, 23:24, 34)

# t/d
ordering <- draw.cluster(4)
	# TODO!


# short a
ordering <- draw.cluster(5, 10)
	# "Tag"
	draw.line(5)
	renew(5, 1:5, 35)

# ach
ordering <- draw.cluster(6, 10)
	# "Tag"
	draw.line(6)
	renew(6, 7:11, 36)

# e/ä
ordering <- draw.cluster(7, 12)

# p/b
ordering <- draw.cluster(8, 6, "MDS_angle")
	# pf
	draw.line(20)
	renew(8, 21:22, 37)

# schwa	
ordering <- draw.cluster(9, 8)	
	# schwa/_r
	draw.line(24)
	renew(9, c(1:24), 38)
ordering <- draw.cluster(9, 8, member = m)	
	#TODO

# l
ordering <- draw.cluster(10)

# f
ordering <- draw.cluster(11, 8)
	# pf
	draw.line(2)
	renew(11, 1:2, 39)
	# p/f
	draw.line(12)
	renew(11, 3:12, 40)

# s
ordering <- draw.cluster(12, 10, method = "hamming")
	# chs
	draw.line(c(3,5))
	renew(12, 4:5, 41)
	# s/zero
	draw.line(c(21,25))
	renew(12, 22:25, 42)
	# s/t
	draw.line(34)
	renew(12, 26:34, 43)
ordering <- draw.cluster(12, 10, member = m, order = "MDS_angle")
	# s/_t
	draw.line(c(1,6))
	renew(12, 2:6, 44) # DOESNT WORK!!!



