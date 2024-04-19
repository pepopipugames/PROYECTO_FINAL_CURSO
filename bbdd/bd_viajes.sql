-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 19-04-2024 a las 09:36:38
-- Versión del servidor: 10.4.11-MariaDB
-- Versión de PHP: 7.4.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `ciudades_select_all` ()  SELECT * FROM ciudades$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ciudades_select_by_id` (IN `_id` INT)  SELECT * FROM ciudades WHERE ciu_id = _id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `paises_delete` (IN `_id` INT)  DELETE FROM paises WHERE pais_id = _id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `paises_insert` (IN `_nombre` VARCHAR(50))  INSERT INTO paises VALUES
(null, _nombre)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `paises_select_all` ()  SELECT * FROM paises ORDER by pais_nombre$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `paises_select_by_id` (IN `_id` INT)  SELECT * 
FROM 
	paises 
WHERE 
	pais_id =_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `paises_update` (IN `_id` INT, IN `_nombre` VARCHAR(50))  UPDATE paises SET
	pais_nombre = _nombre
WHERE
	pais_id = _id$$

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `ciudades`
--

INSERT INTO `ciudades` (`ciu_id`, `ciu_nombre`, `ciu_codigo`, `ciu_foto`, `ciu_pais_id`) VALUES
(1, 'madrid', 'MAD', 'madrid.jpg', 1),
(2, 'paris', 'PAR', 'paris.jpg', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ciudades_actividades`
--

CREATE TABLE `ciudades_actividades` (
  `ca_act_id` int(11) NOT NULL,
  `ca_ciu_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `historial_user`
--

INSERT INTO `historial_user` (`hu_id`, `hu_usu_id`, `hu_nombre_anterior`, `hu_nombre_nuevo`, `hu_apellido_antiguo`, `hu_apellido_nuevo`, `hu_alias_antiguo`, `hu_alias_nuevo`, `hu_pass_antiguo`, `hu_pass_nuevo`, `hu_doc_antiguo`, `hu_doc_nuevo`, `hu_telefono_antiguo`, `hu_telefono_nuevo`, `hu_fnac_antiguo`, `hu_fnac_nuevo`, `hu_accion`) VALUES
(1, 3, NULL, 'David', NULL, 'Pires', NULL, 'batistaker47', NULL, '48ea1c9f6c3ca4c632919eeb228e55cc', NULL, '05555', NULL, '6666', NULL, '2024-04-02', 'REGISTRO NUEVO USUARIO');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paises`
--

CREATE TABLE `paises` (
  `pais_id` int(11) NOT NULL,
  `pais_nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `paises`
--

INSERT INTO `paises` (`pais_id`, `pais_nombre`) VALUES
(1, 'españa'),
(2, 'francia');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reserva_act`
--

CREATE TABLE `reserva_act` (
  `ra_act_id` int(11) NOT NULL,
  `ra_usu_id` int(11) NOT NULL,
  `ra_fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`usu_id`, `usu_nombre`, `usu_apellido`, `usu_alias`, `usu_pass`, `usu_documento_identificacion`, `usu_telefono`, `usu_fnac`) VALUES
(3, 'David', 'Pires', 'batistaker47', '78012e3c75570aa4c07b5f7410e86bb3', '05555', '6666', '2024-04-02');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
  MODIFY `act_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ciudades`
--
ALTER TABLE `ciudades`
  MODIFY `ciu_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `historial_user`
--
ALTER TABLE `historial_user`
  MODIFY `hu_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `hoteles`
--
ALTER TABLE `hoteles`
  MODIFY `hot_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `paises`
--
ALTER TABLE `paises`
  MODIFY `pais_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `reservas_hotel_viajes`
--
ALTER TABLE `reservas_hotel_viajes`
  MODIFY `rhv_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `usu_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
