randNumStats <- function(n = 10) {
  
  numVec <- runif(n, min = 1, max = 100)
  
  statList <- list(
    Mean = mean(numVec),
    Median = median(numVec),
    SD = sd(numVec),
    Range = diff(range(numVec))
  )
  return(statList)
}

calc <- randNumStats(12)
print(calc)
