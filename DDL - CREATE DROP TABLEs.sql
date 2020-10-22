
USE BUDT758_DB_0504_11

DROP TABLE [CPAnalytica.Provide];
DROP TABLE [CPAnalytica.Serve];
DROP TABLE [CPAnalytica.FoodItems];
DROP TABLE [CPAnalytica.Amenities];
DROP TABLE [CPAnalytica.Cuisine];
DROP TABLE [CPAnalytica.Restaurant];

CREATE TABLE [CPAnalytica.Restaurant](
		resId VARCHAR(5) NOT NULL,
		resName CHAR(50),
		resPhone VARCHAR(20) ,
		resCostTwo VARCHAR(4),
		resAddress CHAR(70),
		resPostalCode INTEGER,
		resLatitude NUMERIC(8,6),
		resLongitude NUMERIC(8,6),
		rating5 NUMERIC(3),
		rating4 NUMERIC(3),
		rating3 NUMERIC(3),
		rating2 NUMERIC(3),
		rating1 NUMERIC(3)
		CONSTRAINT pk_Restaurant_resId PRIMARY KEY(resId))

CREATE TABLE  [CPAnalytica.Cuisine](
		cuisId VARCHAR(5) NOT NULL,
		cuisDescription CHAR(50),
		CONSTRAINT pk_Cuisine_cuisId PRIMARY KEY(cuisId))

CREATE TABLE  [CPAnalytica.Amenities](
		amnId VARCHAR(5) NOT NULL,
		amnDescription VARCHAR(50),
		CONSTRAINT pk_Amenities_amnId PRIMARY KEY(amnId))

		
CREATE TABLE  [CPAnalytica.FoodItems](
		foodId VARCHAR(5) NOT NULL,
		foodDescription CHAR(50),
		foodCalories NUMERIC(4),
		CONSTRAINT pk_FoodItems_foodId PRIMARY KEY(foodId))

		 
CREATE TABLE  [CPAnalytica.Provide](
	resId VARCHAR(5) NOT NULL,
	amnId VARCHAR(5) NOT NULL,
	CONSTRAINT pk_Provide_resId_amnId PRIMARY KEY (resId, amnId),
	CONSTRAINT fk_Provide_resId FOREIGN KEY (resId) 
		REFERENCES [CPAnalytica.Restaurant] (resId)
		ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_Provide_amnId FOREIGN KEY (amnId)
		REFERENCES [CPAnalytica.Amenities] (amnId)
		ON DELETE CASCADE ON UPDATE CASCADE );
		 
CREATE TABLE  [CPAnalytica.Serve](
	resId VARCHAR(5) NOT NULL,
	cuisId VARCHAR(5) NOT NULL,
	foodId VARCHAR(5) NOT NULL,
	price NUMERIC(4,2),
	CONSTRAINT pk_Serve_resId_cuisId_foodId PRIMARY KEY (resId, cuisId, foodId),
	CONSTRAINT fk_Serve_resId FOREIGN KEY (resId) 
		REFERENCES [CPAnalytica.Restaurant] (resId)
		ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_Serve_cuisId FOREIGN KEY (cuisId)
		REFERENCES [CPAnalytica.Cuisine] (cuisId)
		ON DELETE CASCADE ON UPDATE CASCADE, 
	CONSTRAINT fk_Serve_foodId FOREIGN KEY (foodId)
		REFERENCES [CPAnalytica.FoodItems] (foodId)
		ON DELETE CASCADE ON UPDATE CASCADE);


