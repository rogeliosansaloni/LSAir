DROP DATABASE IF EXISTS OLAP;
CREATE DATABASE OLAP;

Use OLAP;

DROP TABLE IF EXISTS country_airline CASCADE;
DROP TABLE IF EXISTS city_airport CASCADE;
DROP TABLE IF EXISTS plane_route CASCADE;

CREATE TABLE country_airline(
	country_air_id int auto_increment,
	country varchar(255),
	code varchar(2),
	dst char,
	airline_id int,
  airline_name varchar(2),
  alias varchar(3),
  iata text,
  icao text,
  temps_actual timestamp,

	PRIMARY KEY (country_air_id)
);

CREATE TABLE city_airport(
  city_air_id int auto_increment,
  city varchar(255),
  country varchar(255),
  airport_id int,
	airport_name text,
  iata text,
  icao text,
  latitude text,
  longitude double,
  altitude double,
  timezone_id int,
  timezone_olson varchar(255),
  timezone_utc double,
  daylight_saving_time char,
  temps_actual timestamp,

  PRIMARY KEY (city_air_id)
);

CREATE TABLE plane_route(
  plane_route_id int auto_increment,
  plane_id int,
  plane_name varchar(255),
  iata_code text,
  icao_code text,
  route_id int,
  airline_id int,
  codeshare text,
  stops text,
  src_airport_id int,
  dst_airport_id int,
  temps_actual timestamp,

	PRIMARY KEY (plane_route_id)

);

