# Introduction

A Human Activity Recognition database was orgionaly compiled by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto, and Xavier Parra.  According to the researchers "the recordings of 30 subjects performing [one of six] activities of daily living while carrying a waist-mounted smartphone with embedded inertial sensors." This data set was then downloaded from <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>. 

The following information was obtained from the file, "features_info.txt," provided with the data:

> The measures used in this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
> 
>Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
> 
> Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 
> 
> These signals were used to estimate variables of the feature vector for each pattern: 
> '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
> 
> tBodyAcc-XYZ 
> tGravityAcc-XYZ 
> tBodyAccJerk-XYZ
> tBodyGyro-XYZ 
> tBodyGyroJerk-XYZ 
> tBodyAccMag 
> tGravityAccMag 
> tBodyAccJerkMag 
> tBodyGyroMag 
> tBodyGyroJerkMag 
> fBodyAcc-XYZ 
> fBodyAccJerk-XYZ
> fBodyGyro-XYZ
> fBodyAccMag
> fBodyAccJerkMag
> fBodyGyroMag
> fBodyGyroJerkMag

Originally  Additional measures were collected in the original data set, but were not considered for the purposes of this project.

# Project Variables
All variable names were transformed using the principles outlined in the Week 4 video, “Editing Text Variables.”  These principles include: 1) use of all lower case characters, 2) use of descriptive terms (e.g. “time” not “t”,  “acceleration” not “Acc”, etc.), 3) no use duplicated strings, and 4) no use of underscores, dots, or white spaces.  
* subject
Values for this variable was derived from the files "subject_test.txt" and "subject_train.txt" provided with the initial data and indicate from which of the 30 subjects the other variables described below are derived. 

* activity
This variable identifies which of the ADLs was performed by the subject at the time measures above were collected.  Character values from “activity_labels.txt” were substituted for the numeric values included in the files “y_test.txt” and “y_train.txt.” The levels for this variable resulting from that substitution are as follows: laying, sitting, standing, walking, walkingdownstairs, and walkingupstairs.

Mean and standard deviations were calculated for each instance of the observed measures, for each activity, and for each subject who participated in the original study.  The remaining project variables were derived from these by computing their own average values across subjects and activities.  This results in 66 new project variables.  66  = (3 for each mean of the 8 “X,Y,Z” measures) +  (3 for each standard deviation of the 8 “X,Y,Z” measures) + (1 mean of each of the 9 other variables) + (1 standard deviation for each of the 9 other variables).   All variable names end in “mean;” “std;” or a variation of these with x, y, or z appended as appropriate.  As such, these project are named as follows:
* timebodyaccelerometermeanx
* timebodyaccelerometermeany                 
* timebodyaccelerometermeanz 
* timegravityaccelerometermeanx              
* timegravityaccelerometermeany
* timegravityaccelerometermeanz              
* timebodyaccelerometerjerkmeanx 
* timebodyaccelerometerjerkmeany             
* timebodyaccelerometerjerkmeanz 
* timebodygyroscopemeanx
* timebodygyroscopemeany 
* timebodygyroscopemeanz                    
* timebodygyroscopejerkmeanx
* timebodygyroscopejerkmeany
* timebodygyroscopejerkmeanz
* timebodyaccelerometermagnitudemean    
* timegravityaccelerometermagnitudemean 
* timebodyaccelerometerjerkmagnitudemean    
* timebodygyroscopemagnitudemean 
* timebodygyroscopejerkmagnitudemean         
* frequencybodyaccelerometermeanx 
* frequencybodyaccelerometermeany           
* frequencybodyaccelerometermeanz
* frequencybodyaccelerometerjerkmeanx    
* frequencybodyaccelerometerjerkmeany
* frequencybodyaccelerometerjerkmeanz        
* frequencybodygyroscopemeanx
* frequencybodygyroscopemeany               
* frequencybodygyroscopemeanz 
* frequencybodyaccelerometermagnitudemean  
* frequencybodyaccelerometerjerkmagnitudemean 
* frequencybodygyroscopemagnitudemean       
* frequencybodygyroscopejerkmagnitudemean
* timebodyaccelerometerstdx         
* timebodyaccelerometerstdy
* timebodyaccelerometerstdz             
* timegravityaccelerometerstdx
* timegravityaccelerometerstdy             
* timegravityaccelerometerstdz
* timebodyaccelerometerjerkstdx              
* timebodyaccelerometerjerkstdy 
* timebodyaccelerometerjerkstdz            
* timebodygyroscopestdx
* timebodygyroscopestdy                   
* timebodygyroscopestdz
* timebodygyroscopejerkstdx
* timebodygyroscopejerkstdy
* timebodygyroscopejerkstdz                
* timebodyaccelerometermagnitudestd
* timegravityaccelerometermagnitudestd
* timebodyaccelerometerjerkmagnitudestd
* timebodygyroscopemagnitudestd           
* timebodygyroscopejerkmagnitudestd
* frequencybodyaccelerometerstdx            
* frequencybodyaccelerometerstdy
* frequencybodyaccelerometerstdz           
* frequencybodyaccelerometerjerkstdx
* frequencybodyaccelerometerjerkstdy"         
* frequencybodyaccelerometerjerkstdz
* frequencybodygyroscopestdx"                 
* frequencybodygyroscopestdy
* frequencybodygyroscopestdz             
* frequencybodyaccelerometermagnitudestd
* frequencybodyaccelerometerjerkmagnitudestd 
* frequencybodygyroscopemagnitudestd
* frequencybodygyroscopejerkmagnitudestd  
