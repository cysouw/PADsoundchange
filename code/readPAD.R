doculects <- read.delim("sources/doculects.csv"
					, comment.char = "#"
					, row.names = 1
					, quote = ""
					)

files <- list.files("sources/PAD merged/", full.names = TRUE)
all <- sapply(files, qlcData::read.align, flavor = "PAD", simplify = FALSE)
align <- qlcData::join.align(all)

# === remove columns with too little data

missing <- apply(align,2,function(x){sum(na.omit(x)=="-")+sum(is.na(x))})
ignore <- 120

# histogram
hist(missing
	, xlab = "Number of missing/gap characters"
	, main = "Free parameter\nwhich alignments to ignore"
	, breaks = 100
	)
abline(v = ignore, col = "red")

# adapt data
align <- align[,missing < ignore]
align <- as.matrix(align)
align <- align[doculects$SHORT_NAME,]

# == clean up

rm(files, all, ignore, missing)
