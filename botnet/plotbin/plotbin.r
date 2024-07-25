
# run it with: R -f plotbin.r

outputPDF = TRUE;

setwd(sprintf("%s/r-samples/botnet/plotbin", Sys.getenv("HOME")))

plotbin = function(file, maxx=43200, caption = "") {
	data = scan(file, list(integer(0), integer(0)))
	x = data[[1]]
	y = data[[2]]

	plot(x-x[1]+1, y, type='h', xlim=c(1, maxx), main = caption,
		xlab="Time Offset (second)", ylab="Number of Failures")
}

# ref: http://www.statmethods.net/advgraphs/layout.html

if(outputPDF) {
	pdf("overview.pdf", width=8, height=8, onefile=TRUE)
}

par(mfrow=c(4,4));

plotbin("1_normal.bin.dat", caption = "(a) Normal #1")
plotbin("2_normal.bin.dat", caption = "(b) Normal #2")
plotbin("3_normal.bin.dat", caption = "(c) Normal #3")
plotbin("4_normal.bin.dat", caption = "(d) Normal #4")
plotbin("1_p2p.bin.dat", caption = "(e) Peer-to-Peer #1")
plotbin("2_p2p.bin.dat", caption = "(f) Peer-to-Peer #2")
plotbin("3_p2p.bin.dat", caption = "(g) Peer-to-Peer #3")
plotbin("4_p2p.bin.dat", caption = "(h) Peer-to-Peer #4")
plotbin("1_bot.bin.dat", caption = "(i) Bot #1")
plotbin("2_bot.bin.dat", caption = "(j) Bot #2")
plotbin("3_bot.bin.dat", caption = "(k) Bot #3")
plotbin("4_bot.bin.dat", caption = "(l) Bot #4")
plotbin("5_bot.bin.dat", caption = "(m) Bot #5")
plotbin("6_bot.bin.dat", caption = "(n) Bot #6")
plotbin("7_bot.bin.dat", caption = "(o) Bot #7")

if(outputPDF) {
	dev.off()
}

