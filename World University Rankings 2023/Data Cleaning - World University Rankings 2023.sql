select * from world_university_rankings;
 
select * from world_university_rankings
Where location = '';

-- Change the '' value to null on location col
UPDATE world_university_rankings
SET location = null Where location ='';

select `Name of University`,location from world_university_rankings
where `Name of University` LIKE '%Hong Kong%';

UPDATE world_university_rankings
SET location = 'China' WHERE `Name of University` LIKE '%Hong Kong%';

SELECT * from world_university_rankings
WHERE Location IS NULL;

UPDATE world_university_rankings
SET Location = CASE
	WHEN `Name of University` LIKE '%Singapore%' then 'Singapore'
    WHEN `Name of University` LIKE '%China%' OR `Name of University` LIKE '%Taiwan%' OR `Name of University` LIKE '%SUSTech%' OR `Name of University` LIKE '%Zhejiang%' OR `Name of University` LIKE '%Tsinghua%' OR `Name of University` LIKE '%Peking%' then 'China'
    WHEN `Name of University` LIKE '%Munich%' OR `Name of University` LIKE '%Heidelberg%' then 'Germany'
    WHEN `Name of University` LIKE '%State%' then 'United States'
    WHEN `Name of University` LIKE '%Leuven%' then 'Belgia'
    WHEN `Name of University` LIKE '%McGill%' OR `Name of University` LIKE '%McMaster%' OR `Name of University` LIKE '%Montreal%' OR `Name of University` LIKE '%Ottawa%' then 'Canada'
    WHEN `Name of University` LIKE '%Queensland%' OR `Name of University` LIKE '%Sydney%' OR `Name of University` LIKE '%Adelaide%' then 'Australia'
    WHEN `Name of University` LIKE '%Manchester%' OR `Name of University` LIKE '%Cardiff%' OR `Name of University` LIKE '%Liverpool%' OR `Name of University` LIKE '%Newcastle%' OR `Name of University` LIKE '%Warwick%'  OR `Name of University` LIKE '%Bristol%' OR `Name of University` LIKE '%Sheffield%' then 'United Kingdom'
    WHEN `Name of University` LIKE '%Groningen%' OR `Name of University` LIKE '%Radboud%' OR `Name of University` LIKE '%Erasmus%' OR `Name of University` LIKE '%Leiden%'  then 'Netherland'
    WHEN `Name of University` LIKE '%Seoul%' OR `Name of University` LIKE '%Ulsan%' OR `Name of University` LIKE '%Sungkyunkwan%' OR `Name of University` LIKE '%Pohang%' then 'South Korea'
    WHEN `Name of University` LIKE '%Glasgow%' then 'Scotland'
    WHEN `Name of University` LIKE '%Abdulaziz%' then 'Saudi Arabia'
    WHEN `Name of University` LIKE '%Cape%' then 'South Africa'
    WHEN `Name of University` LIKE '%Paris%' then 'France'
    WHEN `Name of University` LIKE '%Bologna%' then 'Italy'
    WHEN `Name of University` LIKE '%Dublin%' OR `Name of University` LIKE '%Belfast%' then 'Ireland'
    
    ELse Location
    END;
    
-- Female Ratio    
select `Name of University`, cast(SUBSTRING_INDEX(`Female:Male Ratio`,':',1) as decimal) as Female
From world_university_rankings;
-- Adding Female Only Ratio 
Alter Table world_university_rankings
ADD FemaleRatio DECIMAL;
-- Updating The value Where the female:male ratio exist
Update world_university_rankings Set FemaleRatio = cast(SUBSTRING_INDEX(`Female:Male Ratio`,':',1) as decimal) 
WHERE `Female:Male Ratio` != '';
-- Updating the value with average of Ratio on Nulls
WITH meanValue AS (
SELECT AVG(FemaleRatio) as FemaleRatioMean
    from world_university_rankings
    Where FemaleRatio is not null
    )
    UPDATE world_university_rankings
    SET FemaleRatio = (
    select FemaleRatioMean from meanValue
    )
    Where FemaleRatio is Null;


-- Male Ratio
select `Name of University`, cast(SUBSTRING_INDEX(`Female:Male Ratio`,':',-1) as decimal) as Male
From world_university_rankings;

Alter Table world_university_rankings
ADD MaleRatio DECIMAL;
Update world_university_rankings Set MaleRatio = cast(SUBSTRING_INDEX(`Female:Male Ratio`,':',-1) as decimal) 
WHERE `Female:Male Ratio` != '';
WITH meanValue AS (
SELECT AVG(MaleRatio) as MaleRatioMean
    from world_university_rankings
    Where MaleRatio is not null
    )
    UPDATE world_university_rankings
    SET MaleRatio = (
    select MaleRatioMean from meanValue
    )
    Where MaleRatio is Null;


-- If we do Ratio*Student Number we can get the exact number of stundent based on gender
ALTER TABLE world_university_rankings
ADD FemaleStudents float,
ADD MaleStudents float
;

UPDATE world_university_rankings
SET FemaleStudents = FemaleRatio*`No of student`,
	MaleStudents = MaleRatio*`No of student`
Where `No of student` is not null;

-- Since Female Male Ratio has been extracted. The Original Column can be deleted for good
ALTER TABLE world_university_rankings
DROP COLUMN `Female:Male Ratio`;