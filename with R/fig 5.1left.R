library(scar)

data(decathlon)
df <- decathlon

  library(ggplot2)
  g <- ggplot(data = df, aes(x = X100m, y = ..density..))
  g <- g + geom_histogram(position = "identity", alpha = 0.8)
  g <- g + geom_density(fill='black', alpha=0.3)
  g