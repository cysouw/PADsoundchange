# manual improvements of PAM clustering

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
ordering <- draw.cluster(3)
	# Dativ
	draw.line(2)
	renew(3, 1:2, 34)

# t
ordering <- draw.cluster(4)

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

# t/d
ordering <- draw.cluster(7, 8)
	TODO!

# e/ä
ordering <- draw.cluster(8, 12, order = "MDS_angle")

# p/b
ordering <- draw.cluster(9, 8, order = "MDS_angle")
	# pf
	draw.line(20)
	renew(9, 21:22, 37)

# schwa	
ordering <- draw.cluster(10, 8)	
	# schwa/_r
	draw.line(24)
	renew(10, 1:24, 38)
ordering <- draw.cluster(10, 8)	
	# prefix "ge-"
	draw.line(c(41,53))
	renew(10, 42:53, 39)	
ordering <- draw.cluster(10, 8)	
	# suffix "-en"
	draw.line(c(1,22))
	renew(10, 2:22, 40)

# l
ordering <- draw.cluster(11)

# f
ordering <- draw.cluster(12, 8)
	# pf
	draw.line(2)
	renew(12, 1:2, 37)
ordering <- draw.cluster(12, 10)
	# p/f
	draw.line(10)
	renew(12, 1:10, 41)

# s
ordering <- draw.cluster(13, 10)
	# s/t
	draw.line(c(21,34))
	renew(13, 22:34, 42)
ordering <- draw.cluster(13, 10)
	# chs
	draw.line(c(17,19))
	renew(13, 18:19, 43)
ordering <- draw.cluster(13, 10)
	# s/_t
	draw.line(c(10,15))
	renew(13, 11:15, 44)
ordering <- draw.cluster(42)
	# s/zero
	draw.line(4)
	renew(42, 1:4, 45)
ordering <- draw.cluster(42)
	# s/t final
	draw.line(4)
	renew(42, 1:4, 46)
	# remaining 42 is s/t medial

# eng
ordering <- draw.cluster(14)
	
# e/ei	
ordering <- draw.cluster(15, 12)

# o/au
ordering <- draw.cluster(16, 10)

# ch/k
ordering <- draw.cluster(17, 10)

# o/u
ordering <- draw.cluster(18, 10)

# ie
ordering <- draw.cluster(19, 12)

# k
ordering <- draw.cluster(20, 10)

# au
ordering <- draw.cluster(21, 10)

# r
ordering <- draw.cluster(22, 10)
	# r/C_
	draw.line(14)
	renew(22, 1:14, 47)

# n
ordering <- draw.cluster(23)

# ei
ordering <- draw.cluster(24, 12)
	# eu
	draw.line(5)
	renew(24, 1:5, 48)

# k/g
ordering <- draw.cluster(25)
	# g-initial
	draw.line(11)
	renew(25, 1:11, 49)
ordering <- draw.cluster(25)
	# ge-prefix/_[bk]
	draw.line(3)
	renew(25, 1:3, 50)
ordering <- draw.cluster(25)
	# other ge-prefix
	draw.line(3)
	renew(25, 4:9, 51)

# sch
ordering <- draw.cluster(26)
	# sch/_t
	draw.line(15)
	renew(26, 16:18, 52)

# ich
ordering <- draw.cluster(27)

# o
ordering <- draw.cluster(28, 12)

# t/tz
ordering <- draw.cluster(29)

# h
ordering <- draw.cluster(30)


