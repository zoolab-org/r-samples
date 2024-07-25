
# run it with: R -f scatter_cov_len.r
setwd(sprintf("%s/r-samples/asiajcis19", Sys.getenv("HOME")))

pdf_on <- function(fn, output = TRUE) {
    if(output == FALSE) { return() }
    pdf(fn, width=3.5, height=3.5, fonts=c("sans", "mono"), onefile=TRUE)
}

pdf_off <- function(output = TRUE) {
    if(output == FALSE) { return(); }
    dev.off()
}

load_csv <- function(fn) {
    d <- read.csv(fn)
    len  <- d['length'][[1]]     # time
    tb <- d['trace_bit'][[1]]    # crashes
    return(rbind(len, tb))
}

output=TRUE

#yaml
pdf_on("./plot/cov_yaml.pdf")
par(family="sans")
yaml_cov = load_csv("./dat/yaml_cov.csv")
plot(yaml_cov['len',], yaml_cov['tb',]/max(yaml_cov['tb',]), xlim=c(1,1000), xlab="Seed Length", ylab="Normalized Coverage", 
    ylim=c(0,1), type="p", col="blue", pch=20, cex=0.8)
par(family="mono")
title("yaml", outer=FALSE, cex.main=1.5)
pdf_off()

# #tcpdump
pdf_on("./plot/cov_tcpdump.pdf")
par(family="sans")
yaml_cov = load_csv("./dat/tcpdump_cov.csv")
plot(yaml_cov['len',], yaml_cov['tb',]/max(yaml_cov['tb',]), xlim=c(1,1000), xlab="Seed Length", ylab="Normalized Coverage", 
    ylim=c(0,1), type="p", col="blue", pch=20, cex=0.8)
par(family="mono")
title("tcpdump", outer=FALSE, cex.main=1.5)
pdf_off()
