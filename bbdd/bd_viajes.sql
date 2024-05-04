-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 04-05-2024 a las 17:07:50
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bd_viajes`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `ciudades_select_all` ()   SELECT * FROM ciudades$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ciudades_select_by_id` (IN `_id` INT)   SELECT * FROM ciudades WHERE ciu_id = _id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `paises_delete` (IN `_id` INT)   DELETE FROM paises WHERE pais_id = _id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `paises_insert` (IN `_nombre` VARCHAR(50))   INSERT INTO paises VALUES
(null, _nombre)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `paises_select_all` ()   SELECT * FROM paises ORDER by pais_nombre$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `paises_select_by_id` (IN `_id` INT)   SELECT * 
FROM 
	paises 
WHERE 
	pais_id =_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `paises_update` (IN `_id` INT, IN `_nombre` VARCHAR(50))   UPDATE paises SET
	pais_nombre = _nombre
WHERE
	pais_id = _id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `usuarios_insert` (IN `_nombre` VARCHAR(50), IN `_apellido` VARCHAR(50), IN `_alias` VARCHAR(50), IN `_password` VARCHAR(50), IN `_documento` VARCHAR(50), IN `_telefono` VARCHAR(50), IN `_fecha` DATE)   INSERT INTO usuarios VALUES
(null, _nombre, _apellido, _alias, md5(_password), _documento, _telefono, _fecha )$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `usuarios_select_all` ()   SELECT * FROM usuarios ORDER BY usu_nombre$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `usuarios_select_by_id` (IN `_id` INT)  NO SQL COMMENT 'We can use this function to select a user by his/her id ' SELECT * FROM usuarios WHERE usu_id = _id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `usuarios_update` (IN `_nombre` VARCHAR(50), IN `_apellido` VARCHAR(50), IN `_alias` VARCHAR(50), IN `_password` VARCHAR(50), IN `_documento` VARCHAR(50), IN `_telefono` VARCHAR(50), IN `_fecha` DATE, IN `_id` INT)   UPDATE usuarios SET 
	usu_nombre = _nombre,
    usu_apellido = _apellido,
    usu_alias = _alias,
    usu_pass = _password,
    usu_documento_identificacion = _documento,
    usu_telefono = _telefono,
    usu_fnac = _fecha
WHERE
	usu_id = _id$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actividades`
--

CREATE TABLE `actividades` (
  `act_id` int(11) NOT NULL,
  `act_nombre` varchar(50) NOT NULL,
  `act_descripcion` text NOT NULL,
  `act_inicio` time NOT NULL,
  `act_duracion` int(11) NOT NULL,
  `act_precio` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `actividades`
--

INSERT INTO `actividades` (`act_id`, `act_nombre`, `act_descripcion`, `act_inicio`, `act_duracion`, `act_precio`) VALUES
(1, 'Montar en Barco', 'Disfruta de un emocionante paseo en barco por el mar', '09:00:00', 60, 50.00),
(2, 'Nadar con Delfines', 'Experimenta la magia de nadar junto a estos inteligentes mamíferos marinos', '10:00:00', 90, 70.00),
(3, 'Senderismo en la Montaña', 'Explora la naturaleza y disfruta de impresionantes vistas mientras caminas por la montaña', '11:00:00', 120, 90.00),
(4, 'Clases de Surf', 'Aprende a dominar las olas con nuestras clases de surf', '12:00:00', 45, 40.00),
(5, 'Paseo en Bicicleta', 'Recorre hermosos paisajes en bicicleta y disfruta del aire libre', '13:00:00', 75, 60.00),
(6, 'Sesión de Yoga al Amanecer', 'Comienza el día con una sesión relajante de yoga en la playa', '14:00:00', 30, 30.00),
(7, 'Excursión en Kayak', 'Descubre cuevas ocultas y calas remotas en una emocionante excursión en kayak', '15:00:00', 90, 70.00),
(8, 'Tour Gastronómico', 'Explora la deliciosa cocina local en un tour gastronómico por la ciudad', '16:00:00', 60, 50.00),
(9, 'Visita a Ruinas Antiguas', 'Sumérgete en la historia explorando las antiguas ruinas de la civilización', '17:00:00', 120, 90.00),
(10, 'Safari Fotográfico', 'Embárcate en un emocionante safari fotográfico y captura la vida salvaje en su hábitat natural', '18:00:00', 45, 40.00),
(11, 'Cata de Vinos', 'Degusta una variedad de exquisitos vinos locales en una experiencia de cata única', '19:00:00', 75, 60.00),
(12, 'Visita a Mercado Artesanal', 'Descubre artesanías únicas y productos locales en un pintoresco mercado', '20:00:00', 30, 30.00),
(13, 'Noche de Flamenco', 'Disfruta de una noche llena de pasión y ritmo con un espectáculo de flamenco', '21:00:00', 90, 70.00),
(14, 'Tour en Helicóptero', 'Contempla vistas panorámicas impresionantes desde las alturas en un tour en helicóptero', '22:00:00', 60, 50.00),
(15, 'Observación de Estrellas', 'Maravíllate con la belleza del cielo nocturno en una sesión de observación de estrellas', '23:00:00', 120, 80.00),
(16, 'Curso de Cocina Local', 'Aprende a preparar platos tradicionales con ingredientes locales en un divertido curso de cocina', '00:00:00', 90, 65.00),
(17, 'Visita a Parque Nacional', 'Explora la diversa flora y fauna en un impresionante parque nacional', '01:00:00', 180, 110.00),
(18, 'Paseo en Globo Aerostático', 'Disfruta de una experiencia única flotando en el cielo en un paseo en globo aerostático', '02:00:00', 120, 150.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ciudades`
--

CREATE TABLE `ciudades` (
  `ciu_id` int(11) NOT NULL,
  `ciu_nombre` varchar(50) NOT NULL,
  `ciu_codigo` varchar(3) NOT NULL,
  `ciu_foto` varchar(50) NOT NULL,
  `ciu_pais_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ciudades`
--

INSERT INTO `ciudades` (`ciu_id`, `ciu_nombre`, `ciu_codigo`, `ciu_foto`, `ciu_pais_id`) VALUES
(1, 'Madrid', 'MAD', 'madrid.jpg', 1),
(2, 'Paris', 'CDG', 'paris.jpg', 2),
(4, 'Santo Domingo', 'SDQ', 'santo_domingo.png', 3),
(5, 'Moscú', 'MOW', 'moscu.png', 4),
(6, 'Yakarta', 'JKT', 'jakarta.png', 5),
(7, 'Sofía', 'SOF', 'sofia.png', 6),
(8, 'Pekín', 'PEK', 'pekin.png', 7),
(9, 'NDjamena', 'NDJ', 'ndjamena.png', 8),
(10, 'Praga', 'PRG', 'praga.png', 9),
(11, 'Varsovia', 'WAW', 'varsovia.png', 10),
(12, 'Sídney', 'SYD', 'sydney.png', 11),
(13, 'El Cairo', 'CAI', 'el_cairo.png', 12),
(14, 'Lima', 'LIM', 'lima.png', 13),
(15, 'Berlín', 'BER', 'berlin.png', 14),
(16, 'Zagreb', 'ZAG', 'zagreb.png', 15),
(17, 'Atenas', 'ATH', 'atenas.png', 16),
(18, 'Nueva York', 'NYC', 'nueva_york.png', 17),
(19, 'Kabul', 'KBL', 'kabul.png', 18),
(20, 'Dodoma', 'DOD', 'dodoma.png', 19),
(21, 'Bogotá', 'BOG', 'bogota.png', 20),
(22, 'Buenos Aires', 'BUE', 'buenos_aires.png', 21);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ciudades_actividades`
--

CREATE TABLE `ciudades_actividades` (
  `ca_act_id` int(11) NOT NULL,
  `ca_ciu_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_user`
--

CREATE TABLE `historial_user` (
  `hu_id` int(11) NOT NULL,
  `hu_usu_id` int(11) NOT NULL,
  `hu_nombre_anterior` varchar(50) DEFAULT NULL,
  `hu_nombre_nuevo` varchar(50) NOT NULL,
  `hu_apellido_antiguo` varchar(50) DEFAULT NULL,
  `hu_apellido_nuevo` varchar(50) NOT NULL,
  `hu_alias_antiguo` varchar(50) DEFAULT NULL,
  `hu_alias_nuevo` varchar(50) NOT NULL,
  `hu_pass_antiguo` varchar(50) DEFAULT NULL,
  `hu_pass_nuevo` varchar(50) NOT NULL,
  `hu_doc_antiguo` varchar(50) DEFAULT NULL,
  `hu_doc_nuevo` varchar(50) NOT NULL,
  `hu_telefono_antiguo` varchar(50) DEFAULT NULL,
  `hu_telefono_nuevo` varchar(50) NOT NULL,
  `hu_fnac_antiguo` date DEFAULT NULL,
  `hu_fnac_nuevo` date NOT NULL,
  `hu_accion` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `hoteles`
--

CREATE TABLE `hoteles` (
  `hot_id` int(11) NOT NULL,
  `hot_nombre` varchar(50) NOT NULL,
  `hot_logo` varchar(50) NOT NULL,
  `hot_precio_noche` decimal(10,2) NOT NULL,
  `hot_ciu_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paises`
--

CREATE TABLE `paises` (
  `pais_id` int(11) NOT NULL,
  `pais_nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `paises`
--

INSERT INTO `paises` (`pais_id`, `pais_nombre`) VALUES
(1, 'España'),
(2, 'Francia'),
(3, 'República Dominicana'),
(4, 'Rusia'),
(5, 'Indonesia'),
(6, 'Bulgaria'),
(7, 'China'),
(8, 'Chad'),
(9, 'República Checa'),
(10, 'Polonia'),
(11, 'Australia'),
(12, 'Egipto'),
(13, 'Perú'),
(14, 'Alemania'),
(15, 'Croacia'),
(16, 'Grecia'),
(17, 'Estados Unidos'),
(18, 'Afganistán'),
(19, 'Tanzania'),
(20, 'Colombia'),
(21, 'Argentina'),
(23, 'Serbia'),
(24, 'Territorio Palestino'),
(25, 'Túnez'),
(26, 'Filipinas'),
(27, 'Ucrania'),
(28, 'Eslovenia'),
(29, 'Micronesia'),
(30, 'Francia'),
(31, 'Kirguistán'),
(32, 'México'),
(33, 'Irlanda'),
(34, 'Noruega'),
(35, 'Bangladés'),
(36, 'Somalia'),
(37, 'Vietnam'),
(38, 'Bielorrusia'),
(39, 'Suecia'),
(40, 'Kenia'),
(41, 'Brasil'),
(42, 'España'),
(43, 'Francia'),
(44, 'República Dominicana'),
(45, 'Rusia'),
(46, 'Indonesia'),
(47, 'Bulgaria'),
(48, 'China'),
(49, 'Chad'),
(50, 'República Checa'),
(51, 'Polonia'),
(52, 'Australia'),
(53, 'Egipto'),
(54, 'Perú'),
(55, 'Alemania'),
(56, 'Croacia'),
(57, 'Grecia'),
(58, 'Estados Unidos'),
(59, 'Afganistán'),
(60, 'Tanzania'),
(61, 'Colombia'),
(62, 'Argentina'),
(63, 'Indonesia'),
(64, 'Serbia'),
(65, 'Territorio Palestino'),
(66, 'Túnez');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservas_hotel_viajes`
--

CREATE TABLE `reservas_hotel_viajes` (
  `rhv_id` int(11) NOT NULL,
  `rhv_hot_id` int(11) NOT NULL,
  `rhv_viaje_id` int(11) NOT NULL,
  `rhv_usu_id` int(11) NOT NULL,
  `rhv_fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `rhv_fecha_inicio` date NOT NULL,
  `rhv_fecha_fin` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reserva_act`
--

CREATE TABLE `reserva_act` (
  `ra_act_id` int(11) NOT NULL,
  `ra_usu_id` int(11) NOT NULL,
  `ra_fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `usu_id` int(11) NOT NULL,
  `usu_nombre` varchar(50) NOT NULL,
  `usu_apellido` varchar(50) NOT NULL,
  `usu_alias` varchar(50) NOT NULL,
  `usu_pass` varchar(50) NOT NULL,
  `usu_documento_identificacion` varchar(50) NOT NULL,
  `usu_telefono` varchar(50) NOT NULL,
  `usu_fnac` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Disparadores `usuarios`
--
DELIMITER $$
CREATE TRIGGER `AfterInsert` AFTER INSERT ON `usuarios` FOR EACH ROW INSERT INTO historial_user VALUES
(null,
 NEW.usu_id,
 null,
 NEW.usu_nombre,
 null,
 NEW.usu_apellido,
 null,
 NEW.usu_alias,
 null,
 md5(NEW.usu_pass),
 null,
 NEW.usu_documento_identificacion,
 null,
 NEW.usu_telefono,
 null,
 NEW.usu_fnac,
 "REGISTRO NUEVO USUARIO"
)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `viajes`
--

CREATE TABLE `viajes` (
  `viaje_id` int(11) NOT NULL,
  `viaje_transporte` varchar(50) NOT NULL,
  `viaje_ciu_origen` int(11) NOT NULL,
  `viaje_ciu_destino` int(11) NOT NULL,
  `viaje_precio` decimal(10,2) NOT NULL,
  `viaje_ida` datetime NOT NULL,
  `viaje_vuelta` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `actividades`
--
ALTER TABLE `actividades`
  ADD PRIMARY KEY (`act_id`);

--
-- Indices de la tabla `ciudades`
--
ALTER TABLE `ciudades`
  ADD PRIMARY KEY (`ciu_id`),
  ADD UNIQUE KEY `ciu_codigo` (`ciu_codigo`),
  ADD KEY `r-ciudad-pais` (`ciu_pais_id`);

--
-- Indices de la tabla `ciudades_actividades`
--
ALTER TABLE `ciudades_actividades`
  ADD PRIMARY KEY (`ca_act_id`,`ca_ciu_id`),
  ADD KEY `r-ca-ciudades` (`ca_ciu_id`);

--
-- Indices de la tabla `historial_user`
--
ALTER TABLE `historial_user`
  ADD PRIMARY KEY (`hu_id`),
  ADD KEY `r-hu-users` (`hu_usu_id`);

--
-- Indices de la tabla `hoteles`
--
ALTER TABLE `hoteles`
  ADD PRIMARY KEY (`hot_id`),
  ADD KEY `r-hoteles-ciudades` (`hot_ciu_id`);

--
-- Indices de la tabla `paises`
--
ALTER TABLE `paises`
  ADD PRIMARY KEY (`pais_id`);

--
-- Indices de la tabla `reservas_hotel_viajes`
--
ALTER TABLE `reservas_hotel_viajes`
  ADD PRIMARY KEY (`rhv_id`),
  ADD KEY `r-rhv-usuarios` (`rhv_usu_id`),
  ADD KEY `r-rhv-hoteles` (`rhv_hot_id`),
  ADD KEY `r-rhv-viajes` (`rhv_viaje_id`);

--
-- Indices de la tabla `reserva_act`
--
ALTER TABLE `reserva_act`
  ADD PRIMARY KEY (`ra_act_id`,`ra_usu_id`),
  ADD KEY `r-ra-usuarios` (`ra_usu_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`usu_id`);

--
-- Indices de la tabla `viajes`
--
ALTER TABLE `viajes`
  ADD PRIMARY KEY (`viaje_id`),
  ADD KEY `r-ciudad-viaje-origen` (`viaje_ciu_origen`),
  ADD KEY `r-ciudad-viaje-destino` (`viaje_ciu_destino`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `actividades`
--
ALTER TABLE `actividades`
  MODIFY `act_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `ciudades`
--
ALTER TABLE `ciudades`
  MODIFY `ciu_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT de la tabla `historial_user`
--
ALTER TABLE `historial_user`
  MODIFY `hu_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `hoteles`
--
ALTER TABLE `hoteles`
  MODIFY `hot_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `paises`
--
ALTER TABLE `paises`
  MODIFY `pais_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT de la tabla `reservas_hotel_viajes`
--
ALTER TABLE `reservas_hotel_viajes`
  MODIFY `rhv_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `usu_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `viajes`
--
ALTER TABLE `viajes`
  MODIFY `viaje_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `ciudades`
--
ALTER TABLE `ciudades`
  ADD CONSTRAINT `r-pais-ciudad` FOREIGN KEY (`ciu_pais_id`) REFERENCES `paises` (`pais_id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `ciudades_actividades`
--
ALTER TABLE `ciudades_actividades`
  ADD CONSTRAINT `r-ca-actividades` FOREIGN KEY (`ca_act_id`) REFERENCES `actividades` (`act_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `r-ca-ciudades` FOREIGN KEY (`ca_ciu_id`) REFERENCES `ciudades` (`ciu_id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `historial_user`
--
ALTER TABLE `historial_user`
  ADD CONSTRAINT `r-hu-users` FOREIGN KEY (`hu_usu_id`) REFERENCES `usuarios` (`usu_id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `hoteles`
--
ALTER TABLE `hoteles`
  ADD CONSTRAINT `r-ciudades-hoteles` FOREIGN KEY (`hot_ciu_id`) REFERENCES `ciudades` (`ciu_id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `reservas_hotel_viajes`
--
ALTER TABLE `reservas_hotel_viajes`
  ADD CONSTRAINT `r-rhv-hoteles` FOREIGN KEY (`rhv_hot_id`) REFERENCES `hoteles` (`hot_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `r-rhv-usuarios` FOREIGN KEY (`rhv_usu_id`) REFERENCES `usuarios` (`usu_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `r-rhv-viajes` FOREIGN KEY (`rhv_viaje_id`) REFERENCES `viajes` (`viaje_id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `reserva_act`
--
ALTER TABLE `reserva_act`
  ADD CONSTRAINT `r-ra-actividades` FOREIGN KEY (`ra_act_id`) REFERENCES `actividades` (`act_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `r-ra-usuarios` FOREIGN KEY (`ra_usu_id`) REFERENCES `usuarios` (`usu_id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `viajes`
--
ALTER TABLE `viajes`
  ADD CONSTRAINT `r-ciudad-viaje-destino` FOREIGN KEY (`viaje_ciu_destino`) REFERENCES `ciudades` (`ciu_id`) ON DELETE NO ACTION ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
