tempConv <- function(temps, targUnit) {
  # Celcius to Fahrenheit
  if (targUnit == "F") {
    farTemps <- (temps * (9/5)) + 32
    return(farTemps)
    
  # Fahrenheit to Celcius
  } else if (targUnit == "C") {
    celTemps <- (temps - 32) * (5/9)
    return(celTemps)
    
  # Wrong target unit
  } else {
    stop("Invalid target unit!")
  }
}

# Celcius to Fahrenheit
temps_in_celsius <- c(0, 10, 20, 30, 40)
temps_in_fahrenheit <- tempConv(temps_in_celsius, "F")
print(temps_in_fahrenheit)

# Fahrenheit to celcius
temps_in_fahrenheit <- c(32, 50, 68, 86, 104)
temps_in_celsius <- tempConv(temps_in_fahrenheit, "C")
print(temps_in_celsius)

# Wrong target unit
temps_in_fahrenheit <- c(32, 50, 68, 86, 104)
temps_in_celsius <- tempConv(temps_in_fahrenheit, "H")
print(temps_in_celsius)