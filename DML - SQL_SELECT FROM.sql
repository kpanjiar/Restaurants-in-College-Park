
USE [BUDT758_DB_0504_11]

--What are the average calories of each restaurant? 

SELECT resName,AVG(foodCalories) as 'Avg Calorie Amount'
FROM dbo.Calories
GROUP BY resName
ORDER BY AVG(foodCalories)


--Which are the top 10 restaurants that are cheap with healthy options and are highly rated ?

SELECT TOP 10 m.resName,m.AverageCalories, m.AverageRating
FROM (
     SELECT AVG (foodCalories) AS 'AverageCalories' , c.resName , l.AverageRating
     FROM Calories c, (
       SELECT k.resName ,  w.AverageRating , k.resId
       FROM [dbo].[CPAnalytica.Restaurant] k, (
              SELECT (d.Weighted/(s.rating5+s.rating4+s.rating3+s.rating2+s.rating1)) AS 'AverageRating', s.resId
              FROM [dbo].[CPAnalytica.Restaurant] s, (
                    SELECT SUM((r.rating5*5)+(4*r.rating4)+(3*r.rating3)+(2*r.rating2)+(1*r.rating1)) AS 'Weighted' , resId
                    FROM [dbo].[CPAnalytica.Restaurant] r
                    GROUP BY r.resId) d
              WHERE s.resId=d.resId AND (s.rating5+s.rating4+s.rating3+s.rating2+s.rating1) > 10) w
  WHERE k.resId=w.resId AND w.AverageRating>3.5 AND k.resCostTwo LIKE '$') l      
WHERE c.resId = l.resId
GROUP BY c.resName,l.AverageRating) m
ORDER BY  m.AverageCalories


--Which restaurants serve salads ordered by the least number of calories? 

SELECT r.[resName], bf.[foodCalories] ,bf.[foodDescription]
FROM [dbo].[CPAnalytica.Restaurant] r, (
SELECT b.[resId],fp.[foodId],fp.[foodDescription], fp.[foodCalories]
FROM [dbo].[CPAnalytica.Serve] b, (
SELECT [foodId],[foodDescription],[foodCalories]
FROM [dbo].[CPAnalytica.FoodItems] 
WHERE [foodDescription] LIKE '%salad%') fp
WHERE b.[foodId]=fp.[foodId]) bf
WHERE r.[resId]=bf.[resId]
ORDER BY bf.[foodCalories]



--Which restaurants provide Parking as an amenity?

select r.resName,a.amnDescription from 
(select amnId, amnDescription
from [dbo].[CPAnalytica.Amenities]
where [amnDescription]='Parking') a, 
[dbo].[CPAnalytica.Provide] p,
[dbo].[CPAnalytica.Restaurant] r
where p.amnId=a.amnId and p.resId=r.resId










