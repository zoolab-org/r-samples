
# run it with: R -f length_no_ctrl.r
setwd(sprintf("%s/r-samples/asiajcis19", Sys.getenv("HOME")))

pdf("./plot/length_no_ctrl.pdf", width=5.5, height=5.5, fonts=c("sans", "mono"), onefile=TRUE)

data2<-read.csv("./dat/len_max.csv")
data<-read.csv("./dat/len_choose.csv")
with(data,plot(seed,len,xlim=c(1,1500),xlab="Iteration",ylab="Length",ylim=c(1,13000),type="h",lty=1,lwd=2,col=rgb(0.6,0.6,0.6),font=2))
lines(data2, type = "l",pch=20, col = "black",lty=1,lwd=3)
legend(0,13000, legend=c("Selected seed length","Maximum seed length in the queue"),
       col=c(rgb(0.6,0.6,0.6),"black"), lty=c(1,1), lwd=c(1,3), cex=c(0.85, 0.85),bty="n")
par(family="mono")
title("yaml", outer=FALSE, cex.main=2);
dev.off()
