
# run it with: R -f coverage_ratio.r
setwd(sprintf("%s/r-samples/asiajcis19", Sys.getenv("HOME")))

pdf_on <- function(fn, output = TRUE) {
    if(output == FALSE) { return(); }
    pdf(fn, width=3.5, height=3.5, fonts=c("sans", "mono"), onefile=TRUE)
}

pdf_off <- function(output = TRUE) {
    if(output == FALSE) { return(); }
    dev.off()
}

load_raw_csv <- function(fn) {
    d <- read.csv(fn)
    tb <- d['tb'][[1]];    # time
    crash <- d['crash'][[1]];   # crashes
    return(rbind(tb,crash))
}

plot_coverage_ratio <- function(fn, mytitle = "") {
	dat = load_raw_csv(fn)
	tb = dat['tb',];		# marked trace bits
	crash = dat['crash',]		# # of crashes
	ntb = tb / max(tb)		# normalized trace bits
	idx = ceiling(ntb*10)
	#
	count = rep(0, 10)
	total = rep(0, 10)
	for(i in seq(1, length(tb))) {
		count[idx[i]] = count[idx[i]] + crash[i]
		total[idx[i]] = total[idx[i]] + 1
	}
	#
	oldmar = par("mar")
	par(mar = c(6, 4, 4, 2)+0.1)
	tick = barplot(count/total, ylim=c(0, 1), col="darkgray", ylab="Crash Ratio")
	lab = seq(10, 100, 10)
	axis(1, at=tick[, 1], labels=paste(lab-10, "-", lab, sep=""), line=1, cex.axis=0.75)
	title(xlab="Normalized Coverage (%)", line=4)
	backup = par("family")
	par(family = "mono")
	title(main=mytitle, outer=FALSE, cex.main=1.5)
	par(family = backup)
	par(mar = oldmar)
}

output=TRUE

#cxxfilt
pdf_on("./plot/coverage_ratio_cxxfilt.pdf")
plot_coverage_ratio("./dat/cxxfilt_tracebit_ratio.csv", "cxxfilt")
pdf_off()

#yaml
pdf_on("./plot/coverage_ratio_yaml.pdf")
plot_coverage_ratio("./dat/yaml_tracebit_ratio.csv", "yaml")
pdf_off()

#tcpdump
pdf_on("./plot/coverage_ratio_tcpdump.pdf")
plot_coverage_ratio("./dat/tcpdump_tracebit_ratio.csv", "tcpdump")
pdf_off()

#mp3gain
pdf_on("./plot/coverage_ratio_mp3gain.pdf")
plot_coverage_ratio("./dat/mp3gain_tracebit_ratio.csv", "mp3gain")
pdf_off()
