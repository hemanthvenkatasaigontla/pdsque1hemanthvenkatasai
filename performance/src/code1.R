# Load the required libraries
library(dplyr)
library(ggplot2)
library(forcats)
install.packages("readr")
library(readr)
library(tidyr)

# Set working directory
setwd("C:\\Users\\paava\\OneDrive\\Desktop\\PDS1")

# Read the dataset
student_data <- read_csv("rawdata\\StudentsPerformance.csv",show_col_types = FALSE)
# Remove any missing values
student_data <- student_data %>% 
  drop_na()

# Rename the columns to make them more readable
student_data <- student_data %>% 
  rename(gender = "gender", 
         race_ethnicity = "race/ethnicity", 
         parent_education = "parental level of education",
         lunch = "lunch", 
         test_preparation = "test preparation course", 
         math_score = "math score",
         reading_score = "reading score",
         writing_score = "writing score")

# Convert the relevant categorical columns to factor variables
student_data <- student_data %>% 
  mutate(gender = as_factor(trimws(gender)),
         race_ethnicity = as_factor(trimws(race_ethnicity)),
         parent_education = as_factor(trimws(parent_education)),
         lunch = as_factor(trimws(lunch)),
         test_preparation = as_factor(trimws(test_preparation)))

# Save the clean data to a CSV file
write_csv(student_data, "cleandata/clean_data.csv")

# Plot the data
ggplot(student_data, aes(x = math_score, y = reading_score)) +
  geom_point(aes(color = gender)) +
  labs(x = "Math Score", y = "Reading Score", color = "Gender") +
  ggtitle("Math Score vs Reading Score by Gender") +
  theme_bw()
ggsave("C:\\Users\\paava\\OneDrive\\Desktop\\PDS1\\results\\plot.png")

ggplot(student_data, aes(x = race_ethnicity, y = math_score)) +
  geom_boxplot(aes(fill = race_ethnicity)) +
  labs(x = "Race/Ethnicity", y = "Math Score", fill = "Race/Ethnicity") +
  ggtitle("Math Score by Race/Ethnicity") +
  theme_bw()
ggsave("C:\\Users\\paava\\OneDrive\\Desktop\\PDS1\\results\\plot1.png")

ggplot(student_data, aes(x = parent_education, fill = test_preparation)) +
  geom_bar(position = "dodge") +
  labs(x = "Parental Level of Education", y = "Count", fill = "Test Preparation Course") +
  ggtitle("Test Preparation Course by Parental Level of Education") +
  theme_bw()
ggsave("C:\\Users\\paava\\OneDrive\\Desktop\\PDS1\\results\\plot2.png")

ggplot(student_data, aes(x = writing_score)) +
  geom_density(aes(color = gender)) +
  labs(x = "Writing Score", y = "Density", color = "Gender") +
  ggtitle("Density of Writing Scores by Gender") +
  theme_bw()
ggsave("C:\\Users\\paava\\OneDrive\\Desktop\\PDS1\\results\\plot3.png")

ggplot(student_data, aes(x = math_score, fill = test_preparation)) +
  geom_bar(position = "dodge") +
  labs(x = "math score", y = "Count", fill = "Test Preparation Course") +
  ggtitle("Test Preparation Course by math score") +
  theme_bw()
ggsave("C:\\Users\\paava\\OneDrive\\Desktop\\PDS1\\results\\plot4.png")

                         