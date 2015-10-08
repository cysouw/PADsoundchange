
#' # === read PAD data ===

# results in two objects:
# - the alignments in a character matrix called "align"
# - information on the villages in a dataframe called "doculects"
source("code/readPAD.R")

# alignments with too little data are removed

#' # === Simplify orthography ===

# more than 4000 different segments in the data
length(unique(na.omit(as.character(align))))

# simplify orthography
# results in an object called "simple" with same structure as "align"
source("code/simplifyOrthography.R")

# still almost 1000 different segments
length(unique(na.omit(as.character(simple))))


#' # === Global similarity between villages ===

# this step is not important for the sound change
# just a quick look at the global structure
# two different visualisations of a clustering on the raw data
source("code/clusterVillages.R")

#' # === Similarity between alignments ===

library(qlcMatrix)

# do not count shared gaps as similarity
# because then completely different alignments with many gaps get similar
tmp <- t(simple)
tmp[tmp == "-"] <- NA
sim <- sim.obs(tmp)
rm(tmp)

#' # === Clustering of alignments ===

# maximum at 30 clusters
source("code/clusterAlignments.R")

# the clustering-vector is in the objects "clusters"
# difficult to classify columns have been removed as NA
# how many?
sum(is.na(clusters))


#' # === Visual inspection of clusters

# two help function for easier visualisation
# - draw.cluster based on "limage"
# - draw.line to add separation lines into the plots
source("code/visualizeClusters.R")

# possibly make new groups
original <- clusters

renew <- function(cluster, range, new_number, order = ordering) {
	clusters[which(clusters==cluster)[order$cols[range]]] <<- new_number
}

# ======

#+ fig.width = 11, fig.height = 6
dev.new(width = 11, height = 6)

# a short/long
ordering <- draw.cluster(1, 10) 

# v (orthographic w)
ordering <- draw.cluster(2)
	# b/_en 
	draw.line(25)
	renew(2, 26:29, 31)
ordering <- draw.cluster(2)
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



