# World University Rankings 2023

In this Section i'll peform Data cleaning, Transformation on SQL

## Result
The default or the data before cleaned are shown as `World University Rankings 2023.csv`. Later on the processed data are shown as `World University Rankings 2023-CLEANED.csv`

1. Using `SELECT * FROM world_university_rankings` to get brief information of the data itself
2. Changing the `''` value to null.
3. The Null values are found in 'Location' and 'Female:Male Ratio' Column. Thus i gonna focus on those both column.
4. To solve the null problem in 'Location' column, i have to check the origin of the university itself manually. 
5. Using `UPDATE` operation with `SET` operation combined with `WHEN <condition> THEN <value>` i could change the null values to Univeristy Origin Location
6. To solve Female:Male Ratio null problem. I intended to divide the column to male and female only ratio.
7. Using `SUBSTRING` operation, i can extract both Female and Male only ratio
8. Using `ALTER TABLE` with `ADD <column> datatype` i capable to add more column. These new column will keep the both of ratio values
9. First i fill the Ratio column from `SUBSTRING` Operation result to fill the not null first (using `Female:Male Ratio` as condition). Then using `AVG` of Ratio (Male / Female) Column to fill the null values
10. Hence The new columns are
    -  `FemaleRatio` and `MaleRatio` column : is a extracted ratio from originally `Female:Male Ratio` column
    -  `FemaleStudents` and `MaleStudents` column : Shows how much student based on their gender. Obtained thru `FemaleRatio*No of student` column for `FemaleStudent` and `MaleRatio*No of student` for `MaleStudents` 