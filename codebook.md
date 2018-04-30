# Getting and Cleaning Data Course Project - Code Book

## Analisys process
The analysis script, run_analysis.R reads in the processed experiment data and performs a number of steps to get it into summary form.

- Both "test" and "training" group datasets are read in and merged into one data frame.
- Creates a "volunteer" column, based on subject_test.txt file. Subject numbers are replaced by pasting volunteer and the corresponding number. Ex: volunteer.1, volunteer.2, etc.
- Creates a "activity" column by reading y_test.txt. Activity identifiers are replaced with the activity labels based on the activity_labels.txt file. Labels are all set to lowercase. "_" are replaced by "."
- The data columns are then given names based on the features.txt file.
- Data columns names are set to lower case, "()" are removed and "-" are replaced by ".", in order to be better readable. 
- Columns that hold mean or standard deviation measurements are selected from the dataset, while the other measurement columns are excluded from the rest of the analysis.
- The data is then grouped by subject and activity, and the mean is calculated for every measurement column.
- Finally, the summary dataset is written to a file, tidy_data.txt.

Each line in run_analysis.R is commented. Reference the file for more information on this process.

## Columns in output file

The columns included in the output file are listed below:

volunteer - The id of the experiment participant.
activity - The name of the activity that the measurements correspond to, like laying or walking.

All of the following fields represent the mean of recorded data points for the given subject and activity. The detailed description of the different measurement types can be found in the features_info.txt file included in the data zip file.
- tbodyacc.mean.x
- tbodyacc.mean.y
- tbodyacc.mean.z
- tbodyacc.std.x
- tbodyacc.std.y
- tbodyacc.std.z
- tgravityacc.mean.x
- tgravityacc.mean.y
- tgravityacc.mean.z
- tgravityacc.std.x
- tgravityacc.std.y
- tgravityacc.std.z
- tbodyaccjerk.mean.x
- tbodyaccjerk.mean.y
- tbodyaccjerk.mean.z
- tbodyaccjerk.std.x
- tbodyaccjerk.std.y
- tbodyaccjerk.std.z
- tbodygyro.mean.x
- tbodygyro.mean.y
- tbodygyro.mean.z
- tbodygyro.std.x
- tbodygyro.std.y
- tbodygyro.std.z
- tbodygyrojerk.mean.x
- tbodygyrojerk.mean.y
- tbodygyrojerk.mean.z
- tbodygyrojerk.std.x
- tbodygyrojerk.std.y
- tbodygyrojerk.std.z
- tbodyaccmag.mean
- tbodyaccmag.std
- tgravityaccmag.mean
- tgravityaccmag.std
- tbodyaccjerkmag.mean
- tbodyaccjerkmag.std
- tbodygyromag.mean
- tbodygyromag.std
- tbodygyrojerkmag.mean
- tbodygyrojerkmag.std
- fbodyacc.mean.x
- fbodyacc.mean.y
- fbodyacc.mean.z
- fbodyacc.std.x
- fbodyacc.std.y
- fbodyacc.std.z
- fbodyacc.meanfreq.x
- fbodyacc.meanfreq.y
-fbodyacc.meanfreq.z
- fbodyaccjerk.mean.x
- fbodyaccjerk.mean.y
- fbodyaccjerk.mean.z
- fbodyaccjerk.std.x
- fbodyaccjerk.std.y
- fbodyaccjerk.std.z
- fbodyaccjerk.meanfreq.x
- fbodyaccjerk.meanfreq.y
- fbodyaccjerk.meanfreq.z
- fbodygyro.mean.x
- fbodygyro.mean.y
- fbodygyro.mean.z
- fbodygyro.std.x
- fbodygyro.std.y
- fbodygyro.std.z
- fbodygyro.meanfreq.x
- fbodygyro.meanfreq.y
- fbodygyro.meanfreq.z
- fbodyaccmag.mean
- fbodyaccmag.std
- fbodyaccmag.meanfreq
- fbodybodyaccjerkmag.mean
- fbodybodyaccjerkmag.std
- fbodybodyaccjerkmag.meanfreq
- fbodybodygyromag.mean
- fbodybodygyromag.std
- fbodybodygyromag.meanfreq
- fbodybodygyrojerkmag.mean
- fbodybodygyrojerkmag.std
- fbodybodygyrojerkmag.meanfreq
- angle.tbodyaccmean.gravity.
- angle.tbodyaccjerkmean..gravitymean.
- angle.tbodygyromean.gravitymean.
- angle.tbodygyrojerkmean.gravitymean.
- angle.x.gravitymean.
- angle.y.gravitymean.
- angle.z.gravitymean.           

