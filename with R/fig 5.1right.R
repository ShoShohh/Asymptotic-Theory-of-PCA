library(scar)
data(decathlon)

df <- decathlon

qqnorm(df$X100m)
qqline(df$X100m)