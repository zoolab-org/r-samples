
# run it with: R -f length_cmp.r
setwd(sprintf("%s/r-samples/asiajcis19", Sys.getenv("HOME")))

pdf("./plot/length_cmp.pdf", width=5.5, height=5.5, fonts=c("sans", "mono"), onefile=TRUE)

data2<-read.csv("./dat/len_cmp_norm.csv")
data<-read.csv("./dat/len_cmp_lambda.csv")
with(data,plot(seed,len,xlim=c(1,1500),xlab="Iteration",ylab="Length",ylim=c(-70,130),type="h",lty=1,lwd=2,col=rgb(0.6,0.6,0.6),font=2))
lines(data2, type = "h",pch=20, col = "black",lty=1,lwd=3)
legend(1,130, legend=c(expression(paste(lambda, "=0.125")), expression(paste(italic("norm"), "-selector"))),
       col=c(rgb(0.6,0.6,0.6),"black"), lty=c(1,1), lwd=c(1,3), cex=c(1.0),bty="n")
par(family="mono")
title("yaml", outer=FALSE, cex.main=2);
dev.off()
