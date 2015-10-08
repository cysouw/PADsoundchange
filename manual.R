
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
# ==> source("code/clusterVillages.R")


#' # === Similarity between alignments ===

# do not count shared gaps as similarity
# because then completely different alignments with many gaps get similar
tmp <- t(simple)
tmp[tmp == "-"] <- NA
sim <- qlcMatrix::sim.obs(tmp)
rm(tmp)


#' # === Clustering of alignments ===

# looking for clusters of alignments
# this approach result in very many small clusters
library(apcluster)
p <- apcluster(sim)
clusters <- labels(p, type = "enum")

# the following approach is more involved, based on PAM
# maximum at 30 clusters
# ==> source("code/clusterAlignments.R")
# the clustering-vector is  also in the objects "clusters" (will be overwritten!)
# difficult to classify columns have been removed as NA


#' # === Visual inspection of clusters

# two help function for easier visualisation
# - draw.cluster based on "limage"
# - draw.line to add separation lines into the plots
source("code/visualizeClusters.R")

# manual inspection of the PAM-based clustering is in:
# ==> source("code/PAMclusterManual.R")

stats(clusters, simple)
