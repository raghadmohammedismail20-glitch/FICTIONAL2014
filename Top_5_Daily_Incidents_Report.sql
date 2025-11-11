WITH RankedIncidents AS (
SELECT 
      date,
      day_of_week,
      incidnt_num,
  ROW_NUMBER() OVER ( PARTITION BY day_of_week ORDER BY incidnt_num DESC ) AS day_rank 
FROM tutorial.sf_crime_incidents_2014_01 )
SELECT 
     date, 
     day_of_week,
     incidnt_num,
CASE 
    WHEN day_of_week='Saturday' THEN 'Critical_Weekend_Incidents'
    WHEN day_of_week='Sunday' THEN 'Critical_Weekend_Incidents'
    ELSE 'Critical_Weekday_Incidents'
END AS Incident_Type 
FROM RankedIncidents
WHERE day_rank <=5;


