Anderson <- function(A, N, L){
 z <- qnorm(1 - A / 100, 0, 1) 
 ci <- L / (1 + sqrt(2 / (N - 1)) * z)
 return(ci)
}

AndersonConInt <- function(A, df, Lam0, y.lower, y.upper){
  M <- ncol(df)
  P_Value <- numeric(M)
  plot(NULL, xlab="主成分", ylab="Confidence Interval", xlim=c(1, M), 
       ylim=c(y.lower, y.upper))
  for(i in 1:M){
   ci.lower <- Anderson(A, nrow(df), (prcomp(df)$sdev[i]) ^ 2)
   ac.lower <- -sqrt((nrow(df)-1)/2) * ((prcomp(df)$sdev[i]) ^ 2 - Lam0) / (Lam0)
   P_Value[i] <- pnorm(-ac.lower, mean = 0, sd = 1)

   if( ci.lower > Lam0){
    points(x=i, y=ci.lower, pch=15, cex=0.5, col=1)
    segments(x0=i, y0=ci.lower, x1=i, y1=2*y.upper, col=1)
   }
   else{
    points(x=i, y=ci.lower, pch=15, cex=0.5, col=2)
    segments(x0=i, y0=ci.lower, x1=i, y1=2*y.upper, col=2)
   }
  }
  abline(h=Lam0, lty=2)

  print(P_Value)
}

library(scar)
data(decathlon)

df <- decathlon

AndersonConInt(1, df, 5000, 0, 35000)