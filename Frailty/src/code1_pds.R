# Load the required libraries
install.packages("GGally")
library(GGally)
library(ggplot2)
library(dplyr)
library(tidyr)

# Load the input into a input frame
input <- read.csv("C:\\Users\\paava\\OneDrive\\Desktop\\PDS\\rawdata\\raw_frailty_data1.csv")

# Removing missing values of row
input <- na.omit(input)

# Converting  Frailty column to a binary indicator variable
input$Frailty <- ifelse(input$Frailty == "Y", 1, 0)

# Display the first few rows of the data frame
head(input)

# The preprocessed data should be saved to a fresh CSV file.
write.csv(input, "C:\\Users\\paava\\OneDrive\\Desktop\\PDS\\cleandata\\clean_frality_input.csv", row.names=FALSE)

# Preprocessed data should be loaded from the CSV file.
input2 <- read.csv("C:\\Users\\paava\\OneDrive\\Desktop\\PDS\\cleandata\\clean_frality_input.csv")

# Check the summary statistics of the data
summary(input2)

# Organize the numerical variables into a scatterplot matrix.
ggpairs(input2, columns=c(2,3,4), aes(color=factor(Frailty)), diag=list(continuous="density", alpha=0.5)) +
  labs(title = "Scatterplot Matrix of Numeric Variables", x = "Height (Inches)", y = "Weight (Pounds)")
ggsave("C:\\Users\\paava\\OneDrive\\Desktop\\PDS\\results\\gh_scatterplotmatrix.png")

# Make an Age variable histogram.
ggplot(input2, aes(x = Age, fill = factor(Frailty))) +
  geom_histogram(binwidth = 0.5, position = "dodge", alpha=0.5) +
  labs(title = "Histogram of Age", x = "Age", y = "Count", fill = "Frailty")
ggsave("C:\\Users\\paava\\OneDrive\\Desktop\\PDS\\results\\gh_histogram.png")

#Make a violin plot using the variable Grip.strength.
ggplot(input2, aes(x = factor(Frailty), y = Grip.strength, fill = factor(Frailty))) +
  geom_violin(trim=FALSE, alpha=0.5) +
  labs(title = "Violin Plot of Grip Strength", x = "Frailty", y = "Grip Strength", fill = "Frailty")
ggsave("C:\\Users\\paava\\OneDrive\\Desktop\\PDS\\results\\gh_violinplot.png")

# Plot the Grip.strength variable's density
ggplot(input2, aes(x = Grip.strength, fill = factor(Frailty))) +
  geom_density(alpha = 0.5) +
  labs(title = "Density Plot of Grip Strength", x = "Grip Strength", y = "Density", fill = "Frailty")
ggsave("C:\\Users\\paava\\OneDrive\\Desktop\\PDS\\results\\gh_densityplot.png")

# To compare the Grip.strength between the Frailty groups, use a t-test.
ttest_results <- t.test(input$Grip.strength ~ input$Frailty)
print(ttest_results)

# Test results should be saved as a text file.
result_text <- capture.output(print(ttest_results))
writeLines(result_text, "C:\\Users\\paava\\OneDrive\\Desktop\\PDS\\results\\results1.txt")
