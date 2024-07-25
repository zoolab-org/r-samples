
# run it with: R -f crash_ratio.r
setwd(sprintf("%s/r-samples/asiajcis19", Sys.getenv("HOME")))

pdf_on <- function(fn, output = TRUE) {
    if(output == FALSE) { return(); }
    pdf(fn, width=3.5, height=3.5, fonts=c("sans", "mono"), onefile=TRUE)
}

pdf_off <- function(output = TRUE) {
    if(output == FALSE) { return(); }
    dev.off();
}

load_raw_csv <- function(fn) {
    d <- read.csv(fn);
    len <- d['length'][[1]];    # length
    succ <- d['succeed'][[1]];  # crashes
    total <- d['total'][[1]];   # total
    return(rbind(len, succ, total));
}

plot_crash_ratio_v3 <- function(fn, mytitle = "") {
	dat = load_raw_csv(fn);
	len = dat['len',]
	succ = dat['succ',]
	total = dat['total',]
	#
	maxv = 1000;
	level = 10;
	ss = rep(0, level);
	tt = rep(0, level);
	for(i in seq(1, length(len))) {
		if(i <= maxv) {
			idx = ceiling(len[i]/(maxv/level));
			ss[idx] = ss[idx] + succ[i];
			tt[idx] = tt[idx] + total[i];
		}
	}
	#
	oldmar = par("mar");
	par(mar = c(6, 4, 4, 2)+0.1);
	barplot(tt/tt, ylim=c(0, 1), col="darkgray", ylab="Crash Ratio");
	title(xlab="Seed Length Group", line=4);
	backup = par("new");
	par(new=TRUE)
	tick = barplot(ss/tt, ylim=c(0, 1), col="blue");
	par(new=backup);
	axis(1, at=tick[, 1], labels=seq(1, 999, (maxv/level)), line=1, cex.axis=0.75);
	backup = par("family");
	par(family = "mono");
	title(main=mytitle, outer=FALSE, cex.main=1.5);
	par(family = backup);
	par(mar = oldmar);
}

output=TRUE

plot_crash_ratio <- plot_crash_ratio_v3;

#yaml
pdf_on("./plot/crash_ratio_yaml.pdf");
plot_crash_ratio("./dat/yaml_crash_ratio.csv", "yaml");
pdf_off();

pdf_on("./plot/crash_ratio_abcm2ps.pdf");
plot_crash_ratio("./dat/abcm2ps_crash_ratio.csv", "abcm2ps");
pdf_off();

pdf_on("./plot/crash_ratio_mp3gain.pdf");
plot_crash_ratio("./dat/mp3gain_crash_ratio.csv", "mp3gain");
pdf_off();

pdf_on("./plot/crash_ratio_cxxfilt.pdf");
plot_crash_ratio("./dat/cxxfilt_crash_ratio.csv", "cxxfilt");
pdf_off();

pdf_on("./plot/crash_ratio_tcptrace.pdf");
plot_crash_ratio("./dat/tcptrace_crash_ratio.csv", "tcptrace");
pdf_off();

