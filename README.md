# Coursera_data_cleaning_week4_assignment
Assignment for week 4 of Coursera Getting and Cleaning Data course
# Summary
This is assignment for week 4 of Getting and Cleaning Data course from coursera.
Script for this assignment creates clean data set from 'UCI HAR Dataset' available at:

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones]

Goal of this project is merge various files from this dataset, subset desired data and assign names to activities and to variables in columns. Last goal is to create tidy dataset with average of every variable.

# RUN
The script is called ```run_analysis.R```. Script will :
1. Loads library data.table
2. Downloads and unzips fille into folder /data
3. Reads files for train, test, features and labels
4. Names columns and merges data together
5. Subsets required columns from merged data
6. Adds names of activities
7. Creates tidy dataset and saves is as a textfile: tidyset.txt
  
  
