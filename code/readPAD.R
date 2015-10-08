doculects <- read.delim("sources/doculects.csv"
					, comment.char = "#"
					, row.names = 1
					, quote = ""
					)

read.PAD <- function(file) {
	
	a <- read.table(file
			, header = FALSE
			, quote = ""
			, comment.char = "#"
			, sep = "\t"
			)

	a[,2] <- gsub(".", "", a[,2], fixed = T)

	getAnno <- a[,1] == ":ANN"
	annotation <- a[getAnno,]
	standard <- as.matrix(a[a[,2]=="STANDARD",-c(1,2)])[1,]
	standard <- tolower(standard)

	a <- a[!getAnno,]
	a <- as.matrix(a[!duplicated(a[,2]),])
	rownames(a) <- a[,2]
	a <- a[,-c(1,2)]

	a <- t(sapply(as.character(doculects$SHORT_NAME), function(x){
		if (sum(rownames(a) == x) == 0) {
			rep(NA, times = dim(a)[2])
		} else {
			a[x,]
		}
	}))

	colnames(a) <- standard
	return(a)

}

# 

files <- list.files("sources/PAD merged/", full.names = TRUE)
all <- sapply(files, read.PAD)

nr_words <- rep(1:length(all),sapply(all,function(x){dim(x)[2]}))
cols <- unlist(sapply(all,colnames))
all <- do.call(cbind,all)
rows <- rownames(all)
words <- gsub("_.+\\.msa\\.V\\d+","",names(cols))
words <- gsub("sources/PAD merged//", "", words)
nr_cols <- gsub(".+\\.V(\\d+)$","\\1",names(cols),perl=T)
nr_cols <- as.numeric(nr_cols)-2

# === remove columns with too little data

ignore <- 120

missing <- apply(all,2,function(x){sum(na.omit(x)=="-")+sum(is.na(x))})
all <- all[,missing < ignore]
cols <- cols[missing < ignore]
words <- words[missing < ignore]
nr_words <- nr_words[missing < ignore]
nr_cols <- nr_cols[missing < ignore]

colnames(all) <- paste(1:ncol(all), words, nr_cols, cols)

# == clean up

rm(files)
rm(read.PAD)