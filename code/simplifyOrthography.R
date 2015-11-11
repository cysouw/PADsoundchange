# prepare a draft profile to be edited by hand:
# qlcData::write.profile(align, file = "draftprofile.tsv", normalize = "NFD", sep = "", editing = TRUE)

# simplify data using edited profile
simple <- qlcData::tokenize(align
				, profile = "data/profile.tsv"
				, transliterate = "Replacement"
				, sep = ""
				, normalize = "NFD"
				)$strings$transliterated

# remove all values that only occur once
# not used in the end
# once <- !duplicated(simple) & rev(!duplicated(rev(simple)))
# simple[once] <- NA
				
dim(simple) <- dim(align)
dimnames(simple) <- dimnames(align)

