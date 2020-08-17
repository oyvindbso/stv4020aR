##### Problemløsning

# Fakultet:
# Vi vet at fakultet av et tall n er produktet av rekken heltall fra n ned til 1
# Fakultet av 6 er derfor:
6 * 5 * 4 * 3 * 2 * 1

# Vi kan sjekke med den innebygde funksjonen for fakultet:
n <- 6
factorial(n)


# Vi kan også lage vår egen måte å regne ut fakultet
n <- 6
k <- n:1


prod(k)

# Eller hakket mer egendefinert:
p <- max(k)
for(i in 2:length(k)){
  p <- p * (k[i])
}

# Men hvorfor er fakultet av 0 lik 1?
factorial(0)


# Det kan løses med litt leking:
factorial(6) # dette vet vi, men det er også det samme med:

factorial(7) / 7 # fordi:

n <- 6
n <- (n+1):1
prod(n) / n[1]


# Det samme gjelder 0:
n <- 0
n <- (n+1):1

# 1 / 1 = 1
prod(n) / n[1]


new_factorial <- function(n){
  n <- (n + 1):1
  
  product <- prod(n) / n[1]
  
  return(product)
}

rekke <- sapply(0:6, new_factorial)

library(ggplot2)
ggplot(NULL, aes(y = rekke, x = 0:(length(rekke)-1))) +
  geom_line() +
  geom_point()
