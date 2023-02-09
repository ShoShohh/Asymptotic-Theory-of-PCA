Anderson <- function(A, N, L){
  ci <- c(0, 0)
  z <- qnorm(1 - (A / 2) / 100, 0, 1)

  ci[1] <- L / (1 + sqrt(2 / (N - 1)) * z)
  ci[2] <- L / (1 - sqrt(2 / (N - 1)) * z)
 
  return(ci)
}

AndersonConInt <- function(A, df, Lam0, y.lower, y.upper){
  M <- ncol(df)
  P_Value <- numeric(M)
  plot(NULL, xlab="主成分", ylab="Confidence Interval", xlim=c(1, M), 
       ylim=c(y.lower, y.upper))
                 
  for(i in 1:M){
   ci <- Anderson(A, nrow(df), (prcomp(df)$sdev[i]) ^ 2)
   ci.lower <- ci[1]                                   
   ci.upper <- ci[2]                                     

   ac.lower <- sqrt((nrow(df)-1)/2) * ((prcomp(df)$sdev[i]) ^ 2 - Lam0) / (Lam0)

   P_Value[i] <- pnorm(-ac.lower, mean = 0, sd = 1, lower.tail = FALSE) / 2 + pnorm(ac.lower, mean = 0, sd = 1, lower.tail = TRUE) / 2

   if( ci.lower > Lam0 | ci.upper < Lam0){               
    points(x=c(i,i), y=ci, pch=15, cex=0.5, col=1)      
    segments(x0=i, y0=ci.lower, x1=i, y1=ci.upper, col=1)
   }                                  
   else{                              
    points(x=c(i,i), y=ci, pch=15, cex=0.5, col=2)       
    segments(x0=i, y0=ci.lower, x1=i, y1=ci.upper, col=2)
   }                                  
  }                                 
  abline(h=Lam0, lty=2)
  abline(v=20, lty=3)

  print(P_Value)
}

library(scar)
data(decathlon)

df <- decathlon

AndersonConInt(1.0, df, 5000, 0, 35000)