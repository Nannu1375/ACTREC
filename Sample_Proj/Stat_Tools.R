## Calculate Mean
custMean <- function(vec) {
  
  ## Iterate through the numbers in the vector and add them
  j <- 0
  
  for (i in vec) {
    j <- i + j
  }
  
  ## Find the total numbers present in the vector
  totNos <- 0
  for (i in vec) {
    totNos <- totNos + 1
  }
  
  ## Calculate the mean
  meen <- j/totNos
  
  return(meen)
}

##### Calculate median
custMedian <- function(vec) {
  
  #### Arrange the numbers in ascending order
  tempVar <- 0
  
  ### First loop for multiple passes
  for (i in 1:(length(vec) - 1)) {
    
    ## Second loop for swapping
    for (j in 1:(length(vec) - i)) {
      if (vec[j] > vec[j + 1]) {
        
        # Swapping of numbers if previous nos > next nos
        tempVar <- vec[j+1]
        vec[j+1] <- vec[j]
        vec[j] <- tempVar
        
      }
    }
  }
  
  #### Find middle number
  nos <- length(vec)
  if (nos %% 2 != 0) {     ### If length of vector is odd
    
    medn <- vec[(nos + 1) / 2]
    
  } else if (nos %% 2 == 0) { ### If length of vector is even
    
    medn <- (vec[nos/2] + vec[(nos / 2) + 1]) / 2
  
  }
  return(medn)
}

###### numbers <- c(15, 7, 28, 13, 44, 19, 22, 31, 12, 50)

## Calculate mode
vec1 <- c()
custMode <- function (vec) {
  for (i in vec) {
    vec1 <- c(vec1, i)
    for (j in vec1) {
      
    }
  }
}
