
# run it in the R console
setwd(sprintf("%s/r-samples/asiajcis19", Sys.getenv("HOME")))

data <- read.csv("./dat/length.csv")
lengths = data['length'][[1]]

avg = mean(lengths)
stdev = sd(lengths)
slots = integer(max(lengths))

for(i in lengths) {
	if(i > 0) { slots[i] = slots[i] + 1}
}

plot(slots, xlim=c(0, avg+4*stdev), type="l", lty=1, xlab="Seed length", ylab="Count")
dd = dnorm(lengths, avg, stdev)
lines(lengths, dd*max(slots)/max(dd), lty="dotted")

checks = c(0.125, 0.25, 0.50, 0.75, 1, 1.25, 1.5)
for(c in checks) {
	xpt = ceiling(avg+c*stdev)
	xpp = sum(slots[1:xpt])
	cat(c, ": ", xpt, ", ", xpp/sum(slots)*100, "%", "\n", sep="")
	lines(c(xpt, xpt), c(1, my), lty="dashed", col="grey")
}
