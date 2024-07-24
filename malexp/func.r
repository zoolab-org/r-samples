
# run it with: R -f func.r
setwd(paste(Sys.getenv("HOME"), "r-samples/malexp/func_raw_data", sep="/"))

plot_func = function(dataset, output=FALSE, title="") {
    z = read.csv(dataset)
    groups = length(z)
    dat = list()
    datname = c()
    for(i in 1:groups) {
        rdat = z[[i]]
        if(length(which(rdat == -1)) > 0) {
            pos = which(rdat == -1)[1]
            rdat = rdat[1:pos-1]
            print(c(rdat, i, pos))
        }
        dat[[length(dat)+1]] = rdat*100
        datname = c(datname, paste("G", i-1, sep=""))
    }
    names(dat) = datname;
    dat = as.data.frame(stack(dat))
    if(output != FALSE) { pdf(output, 6, 5, onefile=TRUE) }
    boxplot(values~ind, dat, horieontal=FALSE, las=1,
        main=title, xlab="Group", ylab="Percentage (%)")
    if(output != FALSE) { dev.off() }
}

# ida benign
plot_func("func_ida_0.csv", "ben_ida_10_func.pdf", "IDA Pro / Benign")
plot_func("func_r2_0.csv",  "ben_r2_10_func.pdf", "Radare2 / Benign")
plot_func("func_ida_1.csv", "mal_ida_36_func.pdf", "IDA Pro / Malicious")
plot_func("func_r2_1.csv",  "mal_r2_36_func.pdf", "Radare2 / Malicious")
