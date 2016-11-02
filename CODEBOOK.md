CODE BOOK  (run_analysis.txt)
==========
Experiment: The experiments have been carried out with a group of 30 volunteers. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity were captured at a constant rate of 50Hz. 561 feature-vectors for each record have been recorded.

Raw Data: 
    (features.txt)
        1  feature_vector_code
        2/562  561 feature vector names
    (activity_labels.txt)
        1  activity_code
        2  activity_label
    (X_train.txt)
        1-561  561 feature vector values calculated by the gyroscope and accelerometer in the phone for train group
    (y_train.txt)
        1  activity_code (Activity codes for each record in X_train.txt for each window sample)
    (subject_train.txt)
        1  subject_code (Subject who performed the activity for each window sample in X_train.txt)
    (X_test.txt)
        1-561  561 feature vector values calculated by the gyroscope and accelerometer in the phone for test group
    (y_test.txt)
        1  activity_code (Activity codes for each record in X_test.txt for each window sample)
    (subject_test.txt)
        1  subject_code (Subject who performed the activity for each window sample in X_test.txt)
    
Processed Data:
    1  subject_code
    2  activity_label
    3-81  average values for 79 feature vector values (only mean and standard deviation vectors) calculated for the subject and activity 
    82  activity_code