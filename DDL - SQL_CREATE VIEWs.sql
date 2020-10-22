
USE BUDT758_DB_0504_11

CREATE VIEW Menu AS
SELECT r.resName AS 'Restaurant Name', f.foodDescription as 'Food Item' , b.price AS 'Price'
FROM [CPAnalytica.Belong] b, [CPAnalytica.FoodItems] f, [CPAnalytica.Restaurant] r
WHERE b.foodId=f.foodId AND b.resId=r.resId

CREATE VIEW dbo.Calories AS 
SELECT r.resId , f.foodDescription , f.foodCalories, r.resName
FROM [CPAnalytica.FoodItems] f, [CPAnalytica.Serve] b , [CPAnalytica.Restaurant] r
WHERE r.resId = b.resId AND b.foodId = f.foodId 
GROUP BY r.resId ,r.resName , f.foodDescription , f.foodCalories

DROP VIEW Calories
DROP VIEW Menu