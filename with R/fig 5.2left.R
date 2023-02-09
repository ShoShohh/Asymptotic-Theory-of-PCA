library(scar)

data(decathlon)
df <- decathlon

T_Anderson <- function(N, L, Lam){

  return (sqrt((N - 1) / 2) * (L - Lam) / Lam)

}

AndersonHist <- function(N, Trial){

  Lam <- eigen(cov(df))$values[1]

  L <- numeric(100 * Trial)
  Anderson <- numeric(100 * Trial)

  for(i in 1:(100 * Trial)){
    Sam <- df[sample(1:nrow(df), N), ]
    L[i] <- (prcomp(Sam)$sdev[1]) ^ 2
    Anderson[i] <- T_Anderson(N, L[i], Lam)
  }

  dfA <- data.frame(Anderson)

  library(ggplot2)
  g <- ggplot(data = dfA, aes(x = Anderson, y = ..density..)) 
  g <- g + geom_histogram(position = "identity", alpha = 0.8)
  g <- g + geom_density(fill='black', alpha=0.3)
  g
}

AndersonHist(600, 20)