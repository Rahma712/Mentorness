create table Hotel_Reservation(
Booking_ID VARCHAR(50) NOT NULL Primary Key,
no_of_adults int NULL,
no_of_children INT NULL,
no_of_weekend_nights INT NULL,
no_of_week_nights INT NULL,
type_of_meal_plan VARCHAR(50) NULL,
room_type_reserved VARCHAR(50) NULL,
lead_time INT NULL,
arrival_date DATE NULL,
market_segment_type VARCHAR(50) NULL,
avg_price_per_room DECIMAL(18, 2) NULL,
booking_status VARCHAR(50) NULL,
)

select * from Hotel_Reservation_Dataset


-- 1 - What is the total number of reservations in the dataset? -- 700

SELECT COUNT(*) AS total_reservations FROM Hotel_Reservation_Dataset;


-- Which meal plan is the most popular among guests? -- 527 meal plan 1 is the most popular
SELECT type_of_meal_plan, COUNT(*) AS reservation_count
FROM Hotel_Reservation_Dataset
GROUP BY type_of_meal_plan
ORDER BY reservation_count DESC


-- What is the average price per room for reservations involving children?
SELECT AVG(avg_price_per_room) AS avg_price_with_children
FROM Hotel_Reservation_Dataset
WHERE no_of_children > 0;



-- How many reservations were made for the year 20XX (replace XX with the desired year)?

SELECT COUNT(*) AS reservations_in_2017
FROM Hotel_Reservation_Dataset
WHERE YEAR(arrival_date) = 2017; 


-- What is the most commonly booked room type? -- room_type 1


SELECT room_type_reserved, COUNT(*) AS booking_count
FROM Hotel_Reservation_Dataset
GROUP BY room_type_reserved
ORDER BY booking_count DESC 



-- How many reservations fall on a weekend (no_of_weekend_nights > 0)? -- 383

SELECT COUNT(*) AS Hotel_Reservation_Dataset
FROM Hotel_Reservation_Dataset
WHERE no_of_weekend_nights > 0;





-- What is the highest and lowest lead time for reservations?	-- 443 , 0
SELECT MAX(lead_time) AS max_lead_time, MIN(lead_time) AS min_lead_time
FROM Hotel_Reservation_Dataset;



--8. What is the most common market segment type for reservations? -- online
SELECT market_segment_type, COUNT(*) AS reservation_count
FROM Hotel_Reservation_Dataset
GROUP BY market_segment_type
ORDER BY reservation_count DESC



--9. How many reservations have a booking status of "Confirmed"? -- 493
SELECT COUNT(*) AS confirmed_reservations
FROM Hotel_Reservation_Dataset
WHERE booking_status = 'Not_Canceled';

--10. What is the total number of adults and children across all reservations?

SELECT SUM(no_of_adults) AS total_adults, SUM(no_of_children) AS total_children
FROM Hotel_Reservation_Dataset

--11. What is the average number of weekend nights for reservations involving children?
SELECT AVG(no_of_weekend_nights) AS avg_weekend_nights_with_children
FROM Hotel_Reservation_Dataset
WHERE no_of_children > 0;

--12. How many reservations were made in each month of the year?

SELECT MONTH(arrival_date) AS month, COUNT(*) AS reservation_count
FROM Hotel_Reservation_Dataset
GROUP BY MONTH(arrival_date)
ORDER BY month;

--13. What is the average number of nights (both weekend and weekday) spent by guests for each room
--type?

SELECT room_type_reserved, AVG(no_of_weekend_nights + no_of_week_nights) AS avg_nights
FROM Hotel_Reservation_Dataset
GROUP BY room_type_reserved;

--14. For reservations involving children, what is the most common room type, and what is the average
--price for that room type?

WITH child_reservations AS (
  SELECT room_type_reserved, avg_price_per_room
  FROM Hotel_Reservation_Dataset
  WHERE no_of_children > 0
)
SELECT room_type_reserved, AVG(avg_price_per_room) AS avg_price
FROM child_reservations
GROUP BY room_type_reserved
ORDER BY COUNT(*) DESC


--15. Find the market segment type that generates the highest average price per room.

SELECT market_segment_type, AVG(avg_price_per_room) AS avg_price
FROM Hotel_Reservation_Dataset
GROUP BY market_segment_type
ORDER BY avg_price DESC
