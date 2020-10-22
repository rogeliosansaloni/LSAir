USE OLAP;

DELIMITER $$
DROP PROCEDURE IF EXISTS copiarInfo$$
CREATE PROCEDURE copiarInfo()
BEGIN

  DECLARE temps_actual TIMESTAMP;
  SET temps_actual = CURRENT_TIMESTAMP();

  /*Inserim a la taula de OLAP COUNTRY_AIRLINE la info de les taules de OLTP COUNTRY i AIRLINE */
  INSERT INTO OLAP.country_airline (country, code, dst, airline_id, airline_name, alias, iata, icao, temps_actual)
SELECT DISTINCT country.country, country.code, country.dst, airline.airline_id, airline.name, airline.alias,
       airline.iata, airline.icao, temps_actual FROM OLTP.country AS country JOIN OLTP.airline AS airline ON country.country = airline.country;

/*Inserim a la taula de OLAP CITY_AIRPORT la info de les taules de OLTP CITY, TIMEZONE_CITY, TIMEZONE i AIRPORT*/
INSERT INTO OLAP.city_airport (city, country, airport_id, airport_name, iata, icao, latitude, longitude,
                               altitude, timezone_id, timezone_olson, timezone_utc, daylight_saving_time, temps_actual)
SELECT DISTINCT city.city, city.country, airport.airport_id, airport.name, airport.iata, airport.icao, airport.latitude, airport.longitude, airport.altitude,
                timezone.timezone_id, timezone.timezone_olson, timezone.timezone_utc, timezone.daylight_saving_time, temps_actual
FROM OLTP.city AS city JOIN OLTP.timezone_city AS timezone_city ON city.city = timezone_city.city
JOIN OLTP.timezone AS timezone ON timezone.timezone_id = timezone_city.timezone_id
JOIN OLTP.airport AS airport ON airport.city = city.city AND airport.country = city.country;

/*Inserim a la taula de OLAP AIRPORT_PLANE la info de les taules de OLTP AIRPORT, PLANE i ROUTE */
INSERT INTO OLAP.plane_route (plane_id, plane_name, iata_code, icao_code, route_id, airline_id, codeshare, stops, src_airport_id, dst_airport_id, temps_actual)
SELECT DISTINCT plane.plane_id, plane.name, plane.iata_code, plane.icao_code, route.route_id, route.airline_id, route.codeshare, route.stops,
                route.src_airport_id, route.dst_airport_id, temps_actual
FROM OLTP.plane as plane JOIN OLTP.route AS route ON plane.plane_id = route.plane;

END $$

DELIMITER ;

SET GLOBAL event_scheduler = ON;

DROP EVENT IF EXISTS actualitzaOLAP;
CREATE EVENT actualitzaOLAP
ON SCHEDULE EVERY 2 WEEK
DO
      CALL copiarInfo;
