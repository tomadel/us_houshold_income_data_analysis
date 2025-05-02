# US Household Income Exploratory Data Analysis

SELECT *
FROM us_household_income;

SELECT *
FROM us_household_income_statistics;


SELECT State_Name, SUM(ALand), SUM(AWater)
FROM us_household_income
GROUP BY State_Name
ORDER BY 3 DESC;


SELECT u.State_Name, County, Type, `Primary`, Mean, Median
FROM us_household_income u
INNER JOIN us_household_income_statistics us	
	ON u.id = us.id
WHERE Mean <> 0;


#inspect the average and median income state by state
SELECT u.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income u
INNER JOIN us_household_income_statistics us	
	ON u.id = us.id
WHERE Mean <> 0    
GROUP BY State_Name
;

# check the median and average income based on type of household
SELECT Type, COUNT(Type), ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income u
INNER JOIN us_household_income_statistics us	
	ON u.id = us.id
WHERE Mean <> 0    
GROUP BY Type
ORDER BY 3 DESC
;

# remove the outliers 
SELECT Type, COUNT(Type), ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income u
INNER JOIN us_household_income_statistics us	
	ON u.id = us.id
WHERE Mean <> 0    
GROUP BY Type
HAVING COUNT(Type) > 100
ORDER BY 3 DESC
;