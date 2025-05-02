# US Household Income Data Cleaning

SELECT *
FROM us_household_income;

SELECT *
FROM us_household_income_statistics;

ALTER TABLE us_household_income_statistics RENAME COLUMN `ï»¿id` TO `id`;


#Check duplicates
SELECT id, COUNT(id)
FROM us_household_income
GROUP BY id
HAVING COUNT(id) > 1;

# filter the duplicates
SELECT *
FROM
	(
	SELECT row_id,
	id,
	ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) AS row_num
	FROM us_household_income) AS duplicates
WHERE row_num > 1 ;

# delete the duplicates
DELETE FROM us_household_income
WHERE row_id IN (
	SELECT row_id
	FROM
		(
		SELECT row_id,
		id,
		ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) AS row_num
		FROM us_household_income) AS duplicates
	WHERE row_num > 1 )
;

#now delete the duplicates for the us_household_income_statistics table
#Check duplicates

SELECT id, COUNT(id)
FROM us_household_income_statistics
GROUP BY id
HAVING COUNT(id) > 1;


SELECT DISTINCT(State_Name)
FROM us_household_income
GROUP BY State_Name
ORDER BY 1;

# correcting false state name data
UPDATE us_household_income
SET State_Name = 'Georgia'
WHERE State_Name = 'georia';

UPDATE us_household_income
SET State_Name = 'Alabama'
WHERE State_Name = 'alabama';


# correct missing  data in place
SELECT *
FROM us_household_income
WHERE Place = ''
ORDER BY 1;


UPDATE us_household_income
SET Place = 'Autaugaville'
WHERE County = 'Autauga County'
AND City = 'Vinemont';

SELECT * 
FROM us_household_income;

SELECT Type, COUNT(Type)
FROM us_household_income
GROUP BY Type
ORDER BY 1;

# correct the false data
UPDATE us_household_income
SET  Type = 'Borough'
WHERE Type = 'Boroughs';

SELECT ALand, AWater
FROM us_household_income
WHERE (AWater = 0 OR AWater = '' OR AWater IS NULL)
AND (ALand = 0 OR ALand = '' OR ALand IS NULL)
;