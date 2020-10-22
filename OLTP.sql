DROP DATABASE IF EXISTS OLTP;
CREATE DATABASE OLTP;

Use OLTP;

DROP TABLE IF EXISTS country
  CASCADE;
DROP TABLE IF EXISTS city CASCADE;
DROP TABLE IF EXISTS airline CASCADE;
DROP TABLE IF EXISTS airport CASCADE;
DROP TABLE IF EXISTS timezone CASCADE;
DROP TABLE IF EXISTS timezone_city CASCADE;
DROP TABLE IF EXISTS plane CASCADE;
DROP TABLE IF EXISTS route CASCADE;

CREATE TABLE country(
	country varchar(255),
	code varchar(2),
	dst char,
	PRIMARY KEY (country)
);

CREATE TABLE city(
	country varchar(255),
	city varchar(255),
	foreign key (country) references country(country),
	PRIMARY KEY (country, city)
);

CREATE TABLE airline(
  airline_id int,
  name varchar(2),
  alias varchar(3),
  iata text,
  icao text,
  country varchar(255),
	foreign key (country) references country(country),
	PRIMARY KEY (airline_id)
);

CREATE TABLE airport(
	airport_id int,
	name text,
  city varchar(255),
  country varchar(255),
  iata text,
  icao text,
  latitude text,
  longitude double,
  altitude double,
	foreign key (country, city) references city(country, city),
	PRIMARY KEY (airport_id)
);

CREATE TABLE timezone(
  timezone_id int,
  timezone_olson varchar(255),
  timezone_utc double,
  daylight_saving_time char,
  PRIMARY KEY (timezone_id)
);

CREATE TABLE timezone_city(
  country varchar(255),
	city varchar(255),
  timezone_id int,
	foreign key (country, city) references city(country, city),
	foreign key (timezone_id) references timezone(timezone_id),
	PRIMARY KEY (country, city, timezone_id)
);

CREATE TABLE plane(
  plane_id int,
  name varchar(255),
  iata_code text,
  icao_code text,
	PRIMARY KEY (plane_id)
);

CREATE TABLE route(
  route_id int,
  airline_id int,
  src_airport_id int,
	dst_airport_id int,
  codeshare text,
  stops text,
  plane int,
	foreign key (src_airport_id) references airport(airport_id),
	foreign key (dst_airport_id) references airport(airport_id),
  foreign key (plane) references plane(plane_id),
	PRIMARY KEY (route_id)
);