##-----------------------------------------------------------------------------##
#  Today's lecture will cover three very important topics:
#  (1) Lists
#  (2) Functions that return multiple values
#  (3) The lm() function which returns a best-fit regression line given two
#      columns of data
#
#  ** If we have time, we'll introduce one more function: aggregate();
#     This function will speed up a lot of the coding you did in your
#     Mini-project when you had to find the means and sds by year.
#
#  - Like the last few sessions, you all will follow along and code as we go.
#  - Along the way, you will also get some plotting practice
##-----------------------------------------------------------------------------##

## Setup: Load the MLB payroll data into your working directory
# You can download it as well as this R script template at
# www.raidenhasegawa.com.

managers.df <- read.csv("mlb_team_payroll.csv",
                        header = TRUE,
                        stringsAsFactors = FALSE)

## Recap: Vectors are great for storing data of the same type

# for example, numeric data
x <- c(1,2,3)

# or character data
x <- c("Raiden","Sameer","Justin","Mo")

## Lists: what if you want to store data of different types?

# What happens here?
c(100,"Billy Beane")

# The solution: Lists

# Create an empty list

## There are a couple ways to add new elements to a list

# Without names

# With names

## How about creating a non-empty list

## There are also a couple of ways of accessing elements of a list

# With names (The `$` operator)

# Without names (lists are lists of lists)

## Does anyone know where we've seen lists before?

## Why do we care about lists?

# An example: hist()

####################

## Regression: MLB Payroll Data

# Motivating questions: 
# - What's the relationship between win percentage
# and payroll (corrected for inflation)?
# - Can we use regression to summarize the relationship
# and make predictions?
# - Can we also use regression to compare GM performance
# even between "poor" and "rich" GMs?

# Let's start by correcting for inflation: any ideas?

# Now we can go ahead a plot our dependent variable vs.
# our explanatory variable


# What's this `~` thing? Formulas in R

## Fitting the regression line with the lm() function!!!
# - What do we get from lm()?
# - Like hist(), lm() returns a whole list of outputs

# Let's save our fitted values and residuals as new columns

## The empirical rule for residuals - Does it hold for our example?

# It's often useful to turn the residuals into z-scores
# (Question: Do we need to subtract out the mean?)

## Predicting with regression, using the predict() function

####################

## The aggregate() function: something that will make your
# life a whole lot easier

# A simple example
example.df <- data.frame(x = c(1, 2, 3, 4), 
                         y = c(5, 6, 7, 8), 
                         z = c("group1", "group1", "group2", "group2"))

