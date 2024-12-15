student_data <- data.frame(
  Name = c("Alice", "Bob", "Charlie", "Diana", "Ethan"),
  Math = c(85, 92, 88, 74, 95),
  Science = c(78, 81, 91, 87, 89),
  English = c(90, 84, 76, 85, 94)
)

gradeCalc <- function(datF) {
  # Calculate the average scores and total scores for all students
  datF$Average <- rowMeans(student_data[, 2:4])
  datF$Total <- rowSums(student_data[, 2:4])
  
  # Calculate the grade
  datF$Grade <- ifelse(datF$Average >= 90, "A",
                ifelse(datF$Average >= 80, "B",
                ifelse(datF$Average >= 70, "C", "F")))
  
  return(datF)
  
}

avgSumCalc <- gradeCalc(student_data)

print(avgSumCalc)
