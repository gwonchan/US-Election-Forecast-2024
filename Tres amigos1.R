# Load the necessary package
library(rvest)

# Specify the URL of the webpage
url  <- "https://www.archives.gov/electoral-college/2020"
# Read the webpage
web_page <- read_html(url)

# Extract tables
tables <- web_page %>% html_nodes("table") %>% html_table()


# Load necessary packages
library(rvest)
library(dplyr)  # For data manipulation
library(ggplot2)  # For advanced plotting


# Access the second table
second_table <- tables[[2]]  # Change index to 2 for the second table


# Print the second table
print(second_table)

# Remove the first row
second_table_clean <- second_table[-1, ]


# Remove the last row
my_tibble_clean <- second_table_clean[-nrow(second_table_clean), ]

# Remove the last row
my_tibble_clean1 <- my_tibble_clean[-nrow(my_tibble_clean), ]

# Change specific column names directly
colnames(my_tibble_clean1) <- c("State", "Electoral_Votes", "For_President1", "For_President2", "For_Vice_President1", "For_Vice_President2")



plot(my_tibble_clean1$Electoral_Votes,my_tibble_clean1$State)

print(my_tibble_clean1$State)


# Check the structure of the tibble
str(my_tibble_clean1)

# View the unique values in the Electoral_Votes column
unique(my_tibble_clean1$Electoral_Votes)
# Convert Electoral_Votes to numeric
my_tibble_clean1$Electoral_Votes <- as.numeric(my_tibble_clean1$Electoral_Votes)

# Check for NAs after conversion
sum(is.na(my_tibble_clean1$Electoral_Votes))  # This will give you the number of NAs
# Remove rows with NA in Electoral_Votes
my_tibble_clean1 <- my_tibble_clean1[!is.na(my_tibble_clean1$Electoral_Votes), ]






# Create a bar plot of Electoral Votes by State
barplot(my_tibble_clean1$Electoral_Votes, 
        names.arg = my_tibble_clean1$State,  # Add state names to x-axis
        xlab = "State", 
        ylab = "Electoral Votes", 
        main = "Electoral Votes by State at 2020",
        las = 2,  # Rotate x-axis labels
        col = "steelblue")
