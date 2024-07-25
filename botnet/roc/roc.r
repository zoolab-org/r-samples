
# run it with: R -f roc.r

pdf = TRUE

setwd(sprintf("%s/r-samples/botnet/roc", Sys.getenv("HOME")))

plotroc = function(second, ymin = 0.994, caption = "", outputPDF = FALSE, of = "") {
####################################################################
	if(outputPDF) {
		pdf(of, width=6, height=6, onefile=TRUE)
	}
	tt = sprintf("Measurement Time Window = %ds%s", second, caption)
	# bot
	fname = sprintf("roc.%d.bot.txt", second)
	data = scan(fname, comment.char = "#", list(double(0), double(0)))
	fpr = data[[1]]
	tpr = data[[2]]
	plot(fpr, tpr, type='l', lty=1, lwd=2, xlim=c(0,1), ylim=c(ymin,1),
		main = tt, cex.main = 1.5,
		xlab="False Positive Rate",
		ylab="True Positive Rate")
	# p2p
	fname = sprintf("roc.%d.p2p.txt", second)
	data = scan(fname, comment.char = "#", list(double(0), double(0)))
	fpr = data[[1]]
	tpr = data[[2]]
	lines(fpr, tpr, lty=2, lwd=2)
	# norm
	fname = sprintf("roc.%d.norm.txt", second)
	data = scan(fname, comment.char = "#", list(double(0), double(0)))
	fpr = data[[1]]
	tpr = data[[2]]
	lines(fpr, tpr, lty=4, lwd=2)

	lines(c(0,1), c(0,1), lty=3)

	legend(0.4, ymin+0.2*(1-ymin),
		legend = c("Normal vs Others", "Peer-to-Peer vs Others", "Bot vs Others"),
		lty = c(4, 2, 1),
		lwd = 2)

	if(outputPDF) {
		dev.off()
	}
####################################################################
}

# ref: http://www.statmethods.net/advgraphs/layout.html

plotroc(180, ymin=0, caption="", outputPDF=pdf, of="roc-180.L.pdf")
plotroc(120, ymin=0, caption="", outputPDF=pdf, of="roc-120.L.pdf")
plotroc(60, ymin=0, caption="", outputPDF=pdf, of="roc-060.L.pdf")

plotroc(180, caption=" (Zoom-In)", outputPDF=pdf, of="roc-180.S.pdf")
plotroc(120, caption=" (Zoom-In)", outputPDF=pdf, of="roc-120.S.pdf")
plotroc(60, caption=" (Zoom-In)", outputPDF=pdf, of="roc-060.S.pdf")
