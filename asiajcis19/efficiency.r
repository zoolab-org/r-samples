
# run it with: R -f efficiency.r
setwd(sprintf("%s/r-samples/asiajcis19", Sys.getenv("HOME")))

load_csv <- function(fn) {
	d <- read.csv(fn)
	time  <- d['Time'][[1]] 	# time
	crash <- d['Crash'][[1]] 	# crashes
	return(rbind(time, crash))
}

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

draw_effi <- function(tt, afl, fast, max50, max25, maxx, lt, co, lg, step=3600, sf=1, unit="hours", show_ylab=TRUE, cross=c()) {
	yy = "Number of Crashes"
	if (show_ylab == FALSE) { yy = "" }
	par(family="sans")
	my = max(afl['crash',1:maxx], fast['crash',1:maxx], max50['crash',1:maxx], max25['crash', 1:maxx]) * 1.35
	mx = max(afl['time',],  fast['time',],  max50['time',],  max25['time',])
	plot(afl['time',], afl['crash',], xlim=c(1, maxx), xlab=paste("Time (", unit, ")", sep=""), ylab=yy, ylim=c(0, max(0, my)), type="l", col=co[1], lty=lt[1], lwd=1, xaxt="n", main=tt)
	axis(1, at=seq(0, mx, step), labels=sf*seq(0, length(seq(0, mx, step))-1))
	lines(fast['time',],  fast['crash',],  type="l", col=co[2], lty=lt[2], lwd=1)
	lines(max50['time',], max50['crash',], type="l", col=co[3], lty=lt[3], lwd=1)
	lines(max25['time',], max25['crash',], type="l", col=co[4], lty=lt[4], lwd=1)
	if(length(cross) > 0) for(i in 1:length(cross)) {
		lines(c(cross[i], cross[i]), c(0, my), type="l", lwd=0.5, lty="dashed", col=rgb(0.6,0.6,0.6))
	}
	legend(0, my, legend=lg, col=co, lty=lt, cex=0.6)
}

output = TRUE
legends = c("AFL", "AFLFast", "0.50", "0.25")
colors = c("magenta", "black", "red", "blue")
ltypes = c(4, 3, 2, 1)

# yaml
pdf_on("./plot/effi_yaml_effic.pdf", output)
paper_setup()
afl   = load_csv("./dat/yaml_afl.csv")
fast  = load_csv("./dat/yaml_fast.csv")
max50 = load_csv("./dat/yaml_max_0.5.csv")
max25 = load_csv("./dat/yaml_max_0.25.csv")
draw_effi("complete", afl, fast, max50, max25, 28800, lt=ltypes, co=colors, lg=legends)
draw_effi("zoomed-in",  afl, fast, max50, max25, ceiling(8678*1.2),  lt=ltypes, co=colors, lg=legends, step=600, sf=10, unit="minutes", show_ylab=FALSE, cross=c(8678))
paper_title("yaml")
pdf_off(output)

# tcptrace
pdf_on("./plot/effi_tcptrace.pdf", output)
paper_setup()
afl   = load_csv("./dat/tcptrace_afl.csv")
fast  = load_csv("./dat/tcptrace_fast.csv")
max50 = load_csv("./dat/tcptrace_max_0.5.csv")
max25 = load_csv("./dat/tcptrace_max_0.25.csv")
draw_effi("complete", afl, fast, max50, max25, 28800, lt=ltypes, co=colors, lg=legends)
draw_effi("zoomed-in",  afl, fast, max50, max25, ceiling(7250*1.2),  lt=ltypes, co=colors, lg=legends, step=600, sf=10, unit="minutes", show_ylab=FALSE, cross=c(3700, 4043, 5400, 7250))
paper_title("tcptrace")
pdf_off(output)

# tcpdump
pdf_on("./plot/effi_tcpdump.pdf", output)
paper_setup()
afl   = load_csv("./dat/tcpdump_afl.csv")
fast  = load_csv("./dat/tcpdump_fast.csv")
max50 = load_csv("./dat/tcpdump_max_0.5.csv")
max25 = load_csv("./dat/tcpdump_max_0.25.csv")
draw_effi("complete", afl, fast, max50, max25, 28800, lt=ltypes, co=colors, lg=legends)
draw_effi("zoomed-in",  afl, fast, max50, max25, ceiling(5400*1.2),  lt=ltypes, co=colors, lg=legends, step=600, sf=10, unit="minutes", show_ylab=FALSE, cross=c(1600, 5400))
paper_title("tcpdump")
pdf_off(output)

# gif2png
pdf_on("./plot/effi_gif2png.pdf", output)
paper_setup()
afl   = load_csv("./dat/gif_afl.csv")
fast  = load_csv("./dat/gif_fast.csv")
max50 = load_csv("./dat/gif_max_0.5.csv")
max25 = load_csv("./dat/gif_max_0.25.csv")
draw_effi("complete", afl, fast, max50, max25, 28800, lt=ltypes, co=colors, lg=legends)
draw_effi("zoomed-in",  afl, fast, max50, max25, ceiling(8900*1.2),  lt=ltypes, co=colors, lg=legends, step=600, sf=10, unit="minutes", show_ylab=FALSE, cross=c(4350, 5836, 8900))
paper_title("gif2png")
pdf_off(output)
