fizzbuzz <- function(n) {
  output <- c()
  if (n %% 3 == 0 && n %% 5 == 0) {
    output[n] <- "FizzBuzz"
  } else if (n %% 3 == 0) {
    output[n] <- "Fizz"
  } else if (n %% 5 == 0) {
    output[n] <- "Buzz"
  } else {
    output[n] <- "None"
  }
}

lapply(c(1:15), fizzbuzz)
