# Original data from:


Human Activity Recognition Using Smartphones Dataset

Version 1.0

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.

Smartlab - Non Linear Complex Systems Laboratory

DITEN - Università degli Studi di Genova.

Via Opera Pia 11A, I-16145, Genoa, Italy.

activityrecognition@smartlab.ws

www.smartlab.ws


## Data collection

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

# Available variables after cleaning

## Apparatus and resulting variables

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc.XYZ and tGyro.XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc.XYZ and tGravityAcc.XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk.XYZ and tBodyGyroJerk.XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc.XYZ, fBodyAccJerk.XYZ, fBodyGyro.XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables for each pattern. '.XYZ' is used to denote 3-axial signals in the X, Y and Z directions (when applicable).

Means and standard deviations were derived for each of the resulting signals.

Each variable is normalized and bounded within \[-1, 1\].

## Naming convention

This results in 66 variables of interest. To summarize how variables are named:

* prefix: t or f (time or frequency domain)
* base: Type of signal (e.g. Acc for accelerometer, Gyro for gyroscope, see previous subchapter for details)
* statistic output: .mean or .std (respectively for mean or standard deviation)
* suffix (when applicable): .X, .Y or .Z (one variable for each spatial dimension)

Example: tBodyAcc.mean.X signifies the mean of the time domain signal for the body acceleration signal on the X axis.

To that are added 2 variables (subject number and type of activity) for a total of 68 variables in the final dataframe.

Subject number is just a number from 1 to 30.

Activity has 6 possible levels: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING and LAYING.

# Details about the cleaning process

The script first merges the training and test sets to create one big data set. All variables outside of the mean and standard deviation for each measurement are then discarded, as was requested.

At the same time, variables in the data set are named according to the previously mentionned naming convention. These names are directly extracted from the "features.txt" file, and modified when necessary.

Activities are then bound to the dataset as a factor variable, and their labels are extracted from "activity_labels.txt" before being applied to factor levels in the data set.

From this data set, another independant data set is created that contains the mean of all observations for each variable, for each activity and each subject. This results in a dataframe with 6 lines per subject (1 per activity).