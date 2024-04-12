CREATE SCHEMA bd_tuimak;
USE bd_tuimak;

CREATE TABLE pais (
	pais_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    pais_nombre VARCHAR(50),
    PRIMARY KEY(pais_id)
);

CREATE TABLE  viaje (
	viaje_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    viaje_medio_transporte VARCHAR (50),
    PRIMARY KEY(viaje_id)
);