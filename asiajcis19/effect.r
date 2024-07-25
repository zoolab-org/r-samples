
# run it with: R -f effect.r
setwd(sprintf("%s/r-samples/asiajcis19", Sys.getenv("HOME")))

pdf_on <- function(fn, output = FALSE) {
	if(output == FALSE) { return() }
	pdf(fn, width=7.2, height=3.6, fonts=c("sans", "mono"), onefile=TRUE)
}

pdf_off <- function(output = FALSE) {
	if(output == FALSE) { return() }
	dev.off()
}

paper_setup <- function() {
	par(oma=c(0, 0, 2, 0), mfrow=c(1, 2))
	par(mar=c(5, 4, 2, 2)+0.1)
}

paper_title <- function(tt) {
	par(family="mono")
	title(tt, outer=TRUE, cex.main=2)
}

draw_eff <- function(tt, vals, labs, show_ylab = TRUE, afl = 0, aflfast = 0) {
	yy = "Number of Crashes"
	if (show_ylab == FALSE) { yy = "" }
	par(family="sans")
	pt = barplot(vals, xlab=expression("Parameter  "*lambda), ylab=yy, ylim=c(0, 1.05*max(vals, afl, aflfast)), col="grey", main=tt)
	npt = length(pt)
	unit = (pt[npt,] - pt[1,]) / (npt-1)
	if(afl > 0) {
		lines(c(pt[1,]-unit, pt[npt,]+unit), c(afl, afl), lwd=2, lty=3, col="blue")
	}
	if(aflfast > 0) {
		lines(c(pt[1,]-unit, pt[npt,]+unit), c(aflfast, aflfast), lwd=2, lty=4, col="red")
	}
	text(pt, -max(vals)/20, labels=labs, srt=-45, adj=0, xpd=TRUE, cex=0.9)
}

output = TRUE

# yaml
pdf_on("./plot/effect_yaml.pdf", output)
paper_setup()
draw_eff("avg", c(203, 180, 158, 129.6, 130.2, 140, 147), c("0.125","0.25","0.5","0.75","1.0","1.25","1.5"), afl=129.5, aflfast=125.2)
draw_eff("max", c(170.5, 152.5, 137, 117, 109, 89, 100),  c("0.125","0.25","0.5","0.75","1.0","1.25","1.5"), show_ylab=FALSE, afl=129.5, aflfast=125.2)
paper_title("yaml")
pdf_off(output)

# c++filt
pdf_on("./plot/effect_cxxfilt.pdf", output)
paper_setup()
draw_eff("avg", c(22/6, 26/6, 28/6, 14/6, 21/6, 23/3, 3), c("0.125","0.25","0.5","0.75","1.0","1.25","1.5"), afl=12/6, aflfast=10/6)
draw_eff("max", c(27/6, 21/6, 14/6, 20/6, 30/6, 17/6, 2), c("0.125","0.25","0.5","0.75","1.0","1.25","1.5"), show_ylab=FALSE, afl=12/6, aflfast=10/6)
paper_title("c++filt")
pdf_off(output)

# tcptrace
pdf_on("./plot/effect_tcptrace.pdf", output)
paper_setup()
draw_eff("avg", c(216.6, 256.5, 284, 308, 336, 356, 357), c("0.125","0.25","0.5","0.75","1.0","1.25","1.5"), afl=297, aflfast=408)
draw_eff("max", c(429, 409.5, 409, 384.5, 485, 541, 523), c("0.125","0.25","0.5","0.75","1.0","1.25","1.5"), show_ylab=FALSE, afl=297, aflfast=408)
paper_title("tcptrace")
pdf_off(output)

# tcpdump
pdf_on("./plot/effect_tcpdump.pdf", output)
paper_setup()
draw_eff("avg", c(97, 170, 58.5, 112, 217.5, 42, 108), c("0.125","0.25","0.5","0.75","1.0","1.25","1.5"), afl=95.6,aflfast=114)
draw_eff("max", c(223, 146, 167, 73, 127, 58, 84),     c("0.125","0.25","0.5","0.75","1.0","1.25","1.5"), show_ylab=FALSE, afl=95.6,aflfast=114)
paper_title("tcpdump")
pdf_off(output)

# gif2png
pdf_on("./plot/effect_gif2png.pdf", output)
paper_setup()
draw_eff("avg", c(113, 73, 65, 86.5, 77, 89, 79.5),   c("0.125","0.25","0.5","0.75","1.0","1.25","1.5"), afl=92.5, aflfast=93)
draw_eff("max", c(71, 103, 87.5, 105, 85, 102, 82.5), c("0.125","0.25","0.5","0.75","1.0","1.25","1.5"), show_ylab=FALSE, afl=92.5, aflfast=93)
paper_title("gif2png")
pdf_off(output)
