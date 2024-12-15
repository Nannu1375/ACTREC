numbers <- c(15, 7, 28, 13, 44, 19, 22, 31, 12, 50)

primeNumberchk <- function(vec) {
  
  evenVec <- c() # Initialize vectors for even numbers
  oddVec <- c() # Initialize vectors for odd numbers
  
  for (i in numbers) {
    if (i %% 2 == 0) {
      evenVec <- c(evenVec, i) # Add even numbers to evenVec
      }
    else {
      oddVec <- c(oddVec, i) # Add odd numbers to oddVec
    }
  }
  
  # Print the results
  result <- list(evenNumbers = evenVec, oddNumbers = oddVec)
  return(result)
}

primeNumberchk(numbers)
