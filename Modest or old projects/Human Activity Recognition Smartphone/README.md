# A small data cleaning project (with Dataverse packages)

## General structure

The data cleaning is comprised of 3 scripts :

* run_analysis.R
This runs the main cleaning procedure. It takes no argument, and returns a dataset with the average of each variable for each activity and each subject (see the Code Book for more details : CodeBook.md in this repo).

* read_X_file.R
This script is called by run_analysis(), and extracts data from X\*.txt files to create usable dataframes.

* get_names.R
This script is also called by run_analysis(), and extracts names from .txt files that contain key/names tuples (namely features.txt and activity_labels.txt) to create usable character vectors.

## Usage

All scripts should be at the root folder of the UCI HAR Dataset (folder including the features.txt file)

Just source run_analysis.R in R and run the run_analysis() procedure to get the returned dataframe.