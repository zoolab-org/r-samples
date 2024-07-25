

# run it with: R -f stat.r

pdf = TRUE

setwd(sprintf("%s/r-samples/botnet/stat", Sys.getenv("HOME")))

plotstat = function(file, caption = "",
		outputPDF = FALSE, of = "",
		range = 0.001) {
####################################################################
	if(outputPDF) {
		pdf(of, width=6, height=6, onefile=TRUE)
	}
	data = scan(file, comment.char = "#",
			list("", double(0), double(0), double(0),
			double(0), double(0), ""))
	x = seq(1:length(data[[1]]))
	tp     = data[[2]]
	fp     = data[[3]]
	prec   = data[[4]]
	recall = data[[5]]
	fm     = data[[6]]

#	par(mar=c(5, 4, 4, 2)+0.1);	# default
	par(mar=c(5, 4, 4, 4)+0.1)
	plot(x, prec, type='p', pch=15, ylim=c(1-range, 1), main = caption,
		cex.main = 2,
		xlab="Measurement Time Window (seconds)",
		ylab="Precision / Recall / F-Measure",
		axes = FALSE)
	lines(x, prec, lty=1, lwd=2)
	axis(2)
	axis(1, at=seq(1:length(data[[1]])),
		labels=data[[1]], cex=0.75)

#	points(x, tp, type='p', pch=17)
#	lines(x, tp, lty=3, lwd=2)

	points(x, recall, type='p', pch=17)
	lines(x, recall, lty=3, lwd=2)

	points(x, fm, type='p', pch=18)
	lines(x, fm, lty=4, lwd=2)

	par(new = TRUE)
	plot(x, fp, type='p', pch=19, ylim=c(0, range), axes=FALSE, ann=FALSE)
	lines(x, fp, lty=5, lwd=2)
	axis(4)
#	axis(4,
#		at=c(0, 0.0002, 0.0004, 0.0006, 0.0008, 0.001),
#		labels=c("0", "0.0002", "0.0004", "0.0006", "0.0008", "0.001"))
	mtext("FP Rate", side=4, line=3)

	legend(7, range*0.8,
		legend = c("Precision", "Recall (TP Rate)", "F-Measure", "FP Rate"),
		lty = c(1, 3, 4, 5),
		lwd = 2,
		pch = c(15, 17, 18, 19))

	if(outputPDF) {
		dev.off()
	}
####################################################################
}

# ref: http://www.statmethods.net/advgraphs/layout.html

plotstat("bot.txt", caption="Bot vs Others", outputPDF=pdf, of="stat-bot.pdf")
plotstat("p2p.txt", caption="Peer-to-Peer vs Others", outputPDF=pdf, of="stat-p2p.pdf")
plotstat("norm.txt", caption="Normal vs Others", outputPDF=pdf, of="stat-norm.pdf", 0.01)
