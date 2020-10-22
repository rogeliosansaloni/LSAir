/*SET profiling = 1; */

/*1.SELECT d'una taula*/
/*OLTP*/
SELECT DISTINCT plane.name FROM OLTP.plane AS plane WHERE plane.plane_id = 50;
SHOW PROFILES;

/*OLAP*/
SELECT DISTINCT plane_route.plane_name FROM OLAP.plane_route AS plane_route WHERE plane_route.plane_id = 50;
SHOW PROFILES;

/*2.SELECT amb 5 taules*/
/*OLTP*/
SELECT DISTINCT airline.name FROM OLTP.airline AS airline JOIN OLTP.country AS country ON airline.country = country.country
 JOIN OLTP.city AS city ON country.country = city.country JOIN OLTP.timezone_city AS timezone_city ON timezone_city.city = city.city
JOIN OLTP.timezone AS timezone ON timezone_city.timezone_id = timezone.timezone_id
WHERE timezone.timezone_utc = -10 AND timezone.daylight_saving_time = "N";
SHOW PROFILES;

/*OLAP*/
SELECT DISTINCT country_airline.airline_name FROM OLAP.country_airline AS country_airline
  JOIN OLAP.city_airport AS city_airport ON country_airline.country = city_airport.country
WHERE city_airport.timezone_utc = -10 AND city_airport.daylight_saving_time = "N";
SHOW PROFILES;

/*3.INSERT a una taula*/

/*DELETE FROM OLTP.timezone WHERE timezone_id  = 0;*/

/*OLTP*/
INSERT INTO OLTP.timezone (timezone_id, timezone_olson, timezone_utc, daylight_saving_time)
VALUES (0, "Europe/Barcelona", 1, "N");
SHOW PROFILES;

/*DELETE FROM OLAP.city_airport WHERE timezone_id  = 0;*/

/*OLAP*/
INSERT INTO OLAP.city_airport (city, country, airport_id, airport_name, iata, icao, latitude, longitude, altitude, timezone_id, timezone_olson, timezone_utc, daylight_saving_time)
VALUES (null, null, null, null, null, null, null, null, null, 0, "Europe/Barcelona", 1, "N");
SHOW PROFILES;

/*4.UPDATE a una taula*/
/*OLTP*/
UPDATE OLTP.airline SET name = "00" WHERE OLTP.airline.airline_id = 2;
SHOW PROFILES;

/*OLAP*/
UPDATE OLAP.country_airline SET airline_name = "00" WHERE OLAP.country_airline.airline_id = 2;
SHOW PROFILES;

/*5.DELETE a una taula*/
/*OLTP*/
/*INSERT INTO OLTP.airline (airline_id, name, alias, iata, icao, country) VALUES (3, "1T", null, "1T", "RNX", "South Africa");*/
DELETE FROM OLTP.airline WHERE name  = "1T";
SHOW PROFILES;

/*OLAP*/
/*INSERT INTO OLAP.country_airline (country, airline_id, airline_name, alias, iata, icao) VALUES ( "South Africa", 3, "1T", null, "1T", "RNX");*/
DELETE FROM OLAP.country_airline WHERE airline_name  = "2";

/*SHOW PROFILES;*/