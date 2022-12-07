-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 05-12-2022 a las 23:58:45
-- Versión del servidor: 10.4.25-MariaDB
-- Versión de PHP: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bd_mgm`
--

DELIMITER $$
--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `AreaCuadrado` (`Lado` INT) RETURNS INT(11)  BEGIN
  return Lado*Lado;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `GetNroBoletaMax` () RETURNS INT(11) NO SQL BEGIN
Declare Contador int DEFAULT 0;
Select max(idboleta) into Contador from boletas;
return Contador;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `idBoletaCliente` (`id` INT) RETURNS INT(11) NO SQL BEGIN
DECLARE contador int;
Select max(b.idboleta) into contador from boletas b
WHERE b.idcliente=id;

RETURN contador;

END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `NuevoIdBoleta` () RETURNS INT(11)  BEGIN
Declare Contador int DEFAULT 0;

Select max(idboleta) into Contador from boletas;
IF (Contador IS NULL) THEN
	set Contador=0;
end if;	
return Contador+1;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `NuevoNroBoleta` () RETURNS VARCHAR(10) CHARSET latin1  BEGIN
Declare Contador int DEFAULT 0;

Select max(right(nro,8)) into Contador from boletas;
IF (Contador IS NULL) THEN
	set Contador=0;
end if;	
return concat('B-',right(concat('00000000',Contador+1),8)) ;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `NumerosALetras` (`numero` NUMERIC(19,7)) RETURNS VARCHAR(512) CHARSET latin1  BEGIN

DECLARE lcRetorno VARCHAR(512);
DECLARE lnTerna INT;
DECLARE lcMiles VARCHAR(512);
DECLARE lcCadena VARCHAR(512);
DECLARE lnUnidades INT;
DECLARE lnDecenas INT;
DECLARE lnCentenas INT;
DECLARE lnEntero INT;
DECLARE lnDecimal INT;

Set lnEntero = truncate(numero,0);
Set lnDecimal = (numero - lnEntero)*100;

IF lnEntero > 0 THEN
SET lcRetorno = '';
SET lnTerna = 1 ;

WHILE lnEntero > 0 DO

-- Recorro columna por columna
SET lcCadena = '';

SET lnUnidades = RIGHT(lnEntero,1);
SET lnEntero = LEFT(lnEntero,LENGTH(lnEntero)-1) ;

SET lnDecenas = RIGHT(lnEntero,1);
SET lnEntero = LEFT(lnEntero,LENGTH(lnEntero)-1) ;

SET lnCentenas = RIGHT(lnEntero,1);
SET lnEntero = LEFT(lnEntero,LENGTH(lnEntero)-1) ;
-- Analizo las unidades
SET lcCadena =
CASE /* UNIDADES */
WHEN lnUnidades = 1 AND lnTerna = 1 THEN CONCAT('UNO ',lcCadena)
WHEN lnUnidades = 1 AND lnTerna <> 1 THEN CONCAT('UN',lcCadena)
WHEN lnUnidades = 2 THEN CONCAT('DOS ',lcCadena)
WHEN lnUnidades = 3 THEN CONCAT('TRES ',lcCadena)
WHEN lnUnidades = 4 THEN CONCAT('CUATRO ',lcCadena)
WHEN lnUnidades = 5 THEN CONCAT('CINCO ',lcCadena)
WHEN lnUnidades = 6 THEN CONCAT('SEIS ',lcCadena)
WHEN lnUnidades = 7 THEN CONCAT('SIETE ',lcCadena)
WHEN lnUnidades = 8 THEN CONCAT('OCHO ',lcCadena)
WHEN lnUnidades = 9 THEN CONCAT('NUEVE ',lcCadena)
ELSE lcCadena
END ;/* UNIDADES */

-- Analizo las decenas
SET lcCadena =
CASE /* DECENAS */
WHEN lnDecenas = 1 THEN
CASE lnUnidades
WHEN 0 THEN 'DIEZ '
WHEN 1 THEN 'ONCE '
WHEN 2 THEN 'DOCE '
WHEN 3 THEN 'TRECE '
WHEN 4 THEN 'CATORCE '
WHEN 5 THEN 'QUINCE '
ELSE CONCAT('DIECI',lcCadena)
END
WHEN lnDecenas = 2 AND lnUnidades = 0 THEN CONCAT('VEINTE ',lcCadena)
WHEN lnDecenas = 2 AND lnUnidades <> 0 THEN CONCAT('VEINTI',lcCadena)
WHEN lnDecenas = 3 AND lnUnidades = 0 THEN CONCAT('TREINTA ',lcCadena)
WHEN lnDecenas = 3 AND lnUnidades <> 0 THEN CONCAT('TREINTA Y ',lcCadena)
WHEN lnDecenas = 4 AND lnUnidades = 0 THEN CONCAT('CUARENTA ',lcCadena)
WHEN lnDecenas = 4 AND lnUnidades <> 0 THEN CONCAT('CUARENTA Y ',lcCadena)
WHEN lnDecenas = 5 AND lnUnidades = 0 THEN CONCAT('CINCUENTA ',lcCadena)
WHEN lnDecenas = 5 AND lnUnidades <> 0 THEN CONCAT('CINCUENTA Y ',lcCadena)
WHEN lnDecenas = 6 AND lnUnidades = 0 THEN CONCAT('SESENTA ',lcCadena)
WHEN lnDecenas = 6 AND lnUnidades <> 0 THEN CONCAT('SESENTA Y ',lcCadena)
WHEN lnDecenas = 7 AND lnUnidades = 0 THEN CONCAT('SETENTA ',lcCadena)
WHEN lnDecenas = 7 AND lnUnidades <> 0 THEN CONCAT('SETENTA Y ',lcCadena)
WHEN lnDecenas = 8 AND lnUnidades = 0 THEN CONCAT('OCHENTA ',lcCadena)
WHEN lnDecenas = 8 AND lnUnidades <> 0 THEN CONCAT('OCHENTA Y ',lcCadena)
WHEN lnDecenas = 9 AND lnUnidades = 0 THEN CONCAT('NOVENTA ',lcCadena)
WHEN lnDecenas = 9 AND lnUnidades <> 0 THEN CONCAT('NOVENTA Y ',lcCadena)
ELSE lcCadena
END ;/* DECENAS */

-- Analizo las centenas
SET lcCadena =
CASE /* CENTENAS */
WHEN lnCentenas = 1 AND lnUnidades = 0 AND lnDecenas = 0 THEN CONCAT('CIEN ',lcCadena)
WHEN lnCentenas = 1 AND NOT(lnUnidades = 0 AND lnDecenas = 0) THEN CONCAT('CIENTO ',lcCadena)
WHEN lnCentenas = 2 THEN CONCAT('DOSCIENTOS ',lcCadena)
WHEN lnCentenas = 3 THEN CONCAT('TRESCIENTOS ',lcCadena)
WHEN lnCentenas = 4 THEN CONCAT('CUATROCIENTOS ',lcCadena)
WHEN lnCentenas = 5 THEN CONCAT('QUINIENTOS ',lcCadena)
WHEN lnCentenas = 6 THEN CONCAT('SEISCIENTOS ',lcCadena)
WHEN lnCentenas = 7 THEN CONCAT('SETECIENTOS ',lcCadena)
WHEN lnCentenas = 8 THEN CONCAT('OCHOCIENTOS ',lcCadena)
WHEN lnCentenas = 9 THEN CONCAT('NOVECIENTOS ',lcCadena)
ELSE lcCadena
END ;/* CENTENAS */



-- Analizo los millares
SET lcCadena =
CASE /* TERNA */
WHEN lnTerna = 1 THEN lcCadena
WHEN lnTerna = 2 AND (lnUnidades + lnDecenas + lnCentenas <> 0) THEN CONCAT(lcCadena,' MIL ')
WHEN lnTerna = 3 AND (lnUnidades + lnDecenas + lnCentenas <> 0) AND lnUnidades = 1 AND lnDecenas = 0 AND lnCentenas = 0 THEN CONCAT(lcCadena,' MILLON ')
WHEN lnTerna = 3 AND (lnUnidades + lnDecenas + lnCentenas <> 0) AND NOT (lnUnidades = 1 AND lnDecenas = 0 AND lnCentenas = 0) THEN CONCAT(lcCadena,' MILLONES ')
WHEN lnTerna = 4 AND (lnUnidades + lnDecenas + lnCentenas <> 0) THEN CONCAT(lcCadena,' MIL MILLONES ')
WHEN lnTerna = 5 AND (lnUnidades + lnDecenas + lnCentenas <> 0) AND lnUnidades = 1 AND lnDecenas = 0 AND lnCentenas = 0 THEN CONCAT(lcCadena,' BILLON ')
WHEN lnTerna = 5 AND (lnUnidades + lnDecenas + lnCentenas <> 0) AND NOT (lnUnidades = 1 AND lnDecenas = 0 AND lnCentenas = 0) THEN CONCAT(lcCadena,' BILLONES ')
WHEN lnTerna = 6 AND (lnUnidades + lnDecenas + lnCentenas <> 0) THEN CONCAT(lcCadena,' MIL BILLONES ')
WHEN lnTerna = 7 AND (lnUnidades + lnDecenas + lnCentenas <> 0) AND lnUnidades = 1 AND lnDecenas = 0 AND lnCentenas = 0 THEN CONCAT(lcCadena,' TRILLON ')
WHEN lnTerna = 7 AND (lnUnidades + lnDecenas + lnCentenas <> 0) AND NOT (lnUnidades = 1 AND lnDecenas = 0 AND lnCentenas = 0) THEN CONCAT(lcCadena,' TRILLONES ')
WHEN lnTerna = 8 AND (lnUnidades + lnDecenas + lnCentenas <> 0) THEN CONCAT(lcCadena,' MIL TRILLONES ')
ELSE ''
END ;/* MILLARES */


-- Armo el retorno columna a columna
SET lcRetorno = CONCAT(lcCadena,lcRetorno);

SET lnTerna = lnTerna + 1;

END WHILE ; /* WHILE */
ELSE
SET lcRetorno = 'CERO' ;
END IF ;

return concat(RTRIM(lcRetorno),' y ',lnDecimal,'/100') ;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `almacenamiento`
--

CREATE TABLE `almacenamiento` (
  `idalmacenamiento` int(11) NOT NULL,
  `almacenamiento` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `almacenamiento`
--

INSERT INTO `almacenamiento` (`idalmacenamiento`, `almacenamiento`) VALUES
(1, '250 TB'),
(2, '512 TB'),
(3, '1 TB');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `boletas`
--

CREATE TABLE `boletas` (
  `idboleta` int(11) NOT NULL,
  `nro` varchar(15) DEFAULT NULL,
  `fecha` timestamp NULL DEFAULT NULL,
  `total` decimal(19,7) DEFAULT NULL,
  `idcliente` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `boletas`
--

INSERT INTO `boletas` (`idboleta`, `nro`, `fecha`, `total`, `idcliente`) VALUES
(1, 'B-00000001', '2022-12-02 01:32:20', '1399.0000000', 1),
(2, 'B-00000002', '2022-12-02 01:32:20', '5798.0000000', 1),
(3, 'B-00000003', '2022-12-02 01:32:20', '5899.0000000', 2),
(4, 'B-00000004', '2022-12-02 23:40:27', '1650.8200000', 2),
(5, 'B-00000005', '2022-12-02 23:40:45', '6960.8200000', 2),
(6, 'B-00000006', '2022-12-05 17:45:32', '0.0000000', 1),
(7, 'B-00000007', '2022-12-05 17:46:12', '1650.8200000', 1),
(8, 'B-00000008', '2022-12-05 18:06:07', '6960.8200000', 1),
(9, 'B-00000009', '2022-12-05 18:09:39', '3420.8200000', 1),
(10, 'B-00000010', '2022-12-05 18:10:06', '3420.8200000', 1),
(11, 'B-00000011', '2022-12-05 18:35:54', '1650.8200000', 1),
(12, 'B-00000012', '2022-12-05 18:45:22', '128844.2000000', 2),
(13, 'B-00000013', '2022-12-05 21:51:50', '3420.8200000', 2);

--
-- Disparadores `boletas`
--
DELIMITER $$
CREATE TRIGGER `NuevaBoleta` BEFORE INSERT ON `boletas` FOR EACH ROW begin
	set new.idboleta=NuevoIdBoleta();
    set new.nro=NuevoNroBoleta();
    set new.fecha=now();
 end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `idcliente` int(11) NOT NULL,
  `nombres` varchar(18) DEFAULT NULL,
  `apellidos` varchar(45) DEFAULT NULL,
  `dni` varchar(20) DEFAULT NULL,
  `login` varchar(15) DEFAULT NULL,
  `pasword` varchar(100) DEFAULT NULL,
  `estado` varchar(1) DEFAULT NULL,
  `email` varchar(18) DEFAULT NULL,
  `direccion` varchar(18) DEFAULT NULL,
  `idperfil` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`idcliente`, `nombres`, `apellidos`, `dni`, `login`, `pasword`, `estado`, `email`, `direccion`, `idperfil`) VALUES
(1, 'Gonzalo Piero', 'Castillo Mamani xd', '15615115156', 'gonzalofalso', '987412365', NULL, '1', NULL, 2),
(2, 'Mariam', 'Castellanos', NULL, 'mariam', '1475963', NULL, '1', NULL, 2),
(3, 'Marco A.', 'Llanos Pari', '74861186', 'marcoxd', '1475963', '1', 'm4rco.4llp@gmail.c', 'a', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `color`
--

CREATE TABLE `color` (
  `idcolor` int(11) NOT NULL,
  `color` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `color`
--

INSERT INTO `color` (`idcolor`, `color`) VALUES
(1, 'Negro'),
(2, 'Gris'),
(3, 'Nigga'),
(4, 'xd');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detallesboletas`
--

CREATE TABLE `detallesboletas` (
  `iddetalle` int(11) NOT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `pu` decimal(19,7) DEFAULT NULL,
  `subtotal` decimal(19,7) DEFAULT NULL,
  `idboleta` int(11) NOT NULL,
  `idequipo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `detallesboletas`
--

INSERT INTO `detallesboletas` (`iddetalle`, `cantidad`, `pu`, `subtotal`, `idboleta`, `idequipo`) VALUES
(0, 1, '1399.0000000', '1399.0000000', 0, 1),
(1, 1, '1399.0000000', '1399.0000000', 1, 1),
(2, 2, '2899.0000000', '5798.0000000', 2, 2),
(3, 1, '5899.0000000', '5899.0000000', 3, 3),
(0, 1, '2899.0000000', '2899.0000000', 13, 2);

--
-- Disparadores `detallesboletas`
--
DELIMITER $$
CREATE TRIGGER `SetNroBoleta` BEFORE INSERT ON `detallesboletas` FOR EACH ROW begin
	set new.idboleta = GetNroBoletaMax();
 end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `equipos`
--

CREATE TABLE `equipos` (
  `idequipo` int(11) NOT NULL,
  `nombre` varchar(80) DEFAULT NULL,
  `descripcion` varchar(8000) DEFAULT NULL,
  `pu` decimal(19,7) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `idmodelo` int(11) NOT NULL,
  `idcolor` int(11) NOT NULL,
  `idpantalla` int(11) NOT NULL,
  `idalmacenamiento` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `equipos`
--

INSERT INTO `equipos` (`idequipo`, `nombre`, `descripcion`, `pu`, `stock`, `idmodelo`, `idcolor`, `idpantalla`, `idalmacenamiento`) VALUES
(1, 'Lenovo V15 (15.6\", Intel)', 'Haz que tu trabajo fluya y que tus datos estén seguros\r\n', '1399.0000000', 20, 1, 1, 1, 2),
(2, 'Laptop Gamer Asus TUF F15 FX506LHB 15.6\" Intel® Core™ i5-10300H Bonfire Black', 'Diseñada para jugar y con gran durabilidad en el mundo real, TUF Gaming F15 es una laptop gamer con Windows 10 completamente potenciada para llevarte a la victoria. Equipada con hasta la GPU GeForce® GTX 1660 Ti y con hasta el procesador Intel® Core™ i7 de 10.ª Gen. y la , los juegos con una acción trepidante se comportan con fluidez y aprovechan su pantalla de nivel IPS. A pesar de tener un chasis más pequeño que el del modelo predecesor, cuenta con una batería de 90 Wh que dura más tiempo. El sistema de refrigeración antipolvo y la durabilidad militar que caracteriza a la serie TUF se combinan en un sistema de gaming potente, portátil y con una fiabilidad contrastada en el campo de batalla.', '2899.0000000', 15, 2, 1, 1, 2),
(3, 'LAPTOP GIGABYTE G5 KD CORE i5-11400H 16GB RAM 512GB SSD RTX 3060', '¡La computadora portátil para juegos G5 combina juegos, entretenimiento, trabajo y más! Su potente procesador Intel® Core™ i5 de 11.ª generación le permite gestionar sin esfuerzo varias tareas al mismo tiempo.\r\n', '5899.0000000', 15, 3, 1, 1, 2),
(4, 'Laptop Msi Katana GF66 11UE Intel Core I7 11800H RAM 16GB Disco 512GB SSD Video ', 'Con el nuevo procesador 11a Gen. Intel® Core™ i7 y gráficos NVIDIA® GeForce RTX™ Serie 30, Katana GF66 está optimizada para liberar un verdadero desempeño durante el juego. La nueva Katana GF66 está construida con la misma dedicación exquisita que se emplea para crear un sable. Juega con un rendimiento óptimo y brilla en el campo de batalla.', '5928.0000000', 15, 4, 1, 1, 2),
(5, 'Laptop Gigabyte Aorus 5 15.6\", Intel Core I7-12700H, 512GB ssd, 16GB ram, sin we', 'El nuevo AORUS 15 redefine las computadoras portátiles para juegos de alta gama. Al combinar un rendimiento potente y movilidad con las últimas GPU NVIDIA® GeForce RTX™ Serie 30 para portátiles, sienta el poder de ejecutar cualquier juego AAA sin problemas. El panel de juegos de 360 ​​Hz con una alta relación pantalla-cuerpo, permite a los jugadores sumergirse en imágenes fluidas y de alta calidad similares a las de una sala de cine o una sala de deportes electrónicos de primer nivel.', '109190.0000000', 5, 5, 1, 1, 2),
(6, 'Laptop ROG Strix G17 (2022) G713RW-LL039W Ryzen 9 6900HX RAM 16GB Disco 1TB SSD ', 'El Strix G con paneles WQHD (2560 x 1440) de 240 Hz. Pantalla rápida es fundamental para los juegos competitivos, ya que suavizan las animaciones y facilitan el seguimiento de los enemigos. La Strix G te ayuda no perder de vista el objetivo. Tienen un tiempo de respuesta de 3 ms y es compatibles con Dolby Vision HDR para ofrecerte un contraste y una calidad de imagen excepcionales.', '10804.0000000', 5, 6, 1, 1, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `imagenes_equipo`
--

CREATE TABLE `imagenes_equipo` (
  `idimagen` int(11) NOT NULL,
  `url` varchar(50) DEFAULT NULL,
  `nombre` varchar(250) DEFAULT NULL,
  `idequipo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `imagenes_equipo`
--

INSERT INTO `imagenes_equipo` (`idimagen`, `url`, `nombre`, `idequipo`) VALUES
(1, 'lenovov15.jpg', 'Primera imagen', 1),
(2, 'Asus TUF F15.jpg', 'Segunda imagen', 2),
(3, 'Gigabyte G5.jpg', 'Tercera imagen', 3),
(4, 'Msi-Katana-GF66.jpg', 'Cuarta Imagen', 4),
(5, 'Gigabyte AORUS 15.jpg', 'Quinta Imagen', 5),
(6, 'Asus ROG Strix G17 (2022).jpg', 'Sexta Imagen', 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marcas`
--

CREATE TABLE `marcas` (
  `idmarca` int(11) NOT NULL,
  `marca` varchar(80) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `marcas`
--

INSERT INTO `marcas` (`idmarca`, `marca`) VALUES
(1, 'Lenovo'),
(2, 'Asus'),
(3, 'Gigabyte'),
(4, 'MSI');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modelos`
--

CREATE TABLE `modelos` (
  `idmodelo` int(11) NOT NULL,
  `modelo` varchar(80) DEFAULT NULL,
  `idmarca` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `modelos`
--

INSERT INTO `modelos` (`idmodelo`, `modelo`, `idmarca`) VALUES
(1, '82NB002VLM', 1),
(2, 'F15', 2),
(3, 'G5 KD', 3),
(4, 'Katana GF66', 4),
(5, 'AORUS 15 (Intel de 12.ª generación)', 3),
(6, 'ROG Strix G17 (2022)', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pantalla`
--

CREATE TABLE `pantalla` (
  `idpantalla` int(11) NOT NULL,
  `pulgadas` varchar(18) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `pantalla`
--

INSERT INTO `pantalla` (`idpantalla`, `pulgadas`) VALUES
(1, '15\"'),
(2, '14\"');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `perfiles`
--

CREATE TABLE `perfiles` (
  `idperfil` int(11) NOT NULL,
  `perfil` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `perfiles`
--

INSERT INTO `perfiles` (`idperfil`, `perfil`) VALUES
(1, 'Administrador'),
(2, 'Cliente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `idusuarios` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `login` varchar(15) DEFAULT NULL,
  `pasword` varchar(100) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `fechaalta` datetime DEFAULT NULL,
  `email` varchar(80) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_boletas`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_boletas` (
`idboleta` int(11)
,`nro` varchar(15)
,`fecha` timestamp
,`total` decimal(19,7)
,`enLetras` varchar(512)
,`idcliente` int(11)
,`cantidad` int(11)
,`pu` decimal(19,7)
,`subtotal` decimal(19,7)
,`idequipo` int(11)
,`nombreequi` varchar(80)
,`descripcion` varchar(8000)
,`idmodelo` int(11)
,`modelo` varchar(80)
,`marca` varchar(80)
,`nombrecli` varchar(18)
,`apellidocli` varchar(45)
,`direccion` varchar(18)
,`email` varchar(18)
,`dni` varchar(20)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_clientes`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_clientes` (
`idcliente` int(11)
,`nombres` varchar(18)
,`apellidos` varchar(45)
,`nombrecliente` varchar(64)
,`dni` varchar(20)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_equipo`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_equipo` (
`idequipo` int(11)
,`nombre` varchar(80)
,`descripcion` varchar(8000)
,`pu` decimal(19,7)
,`idmodelo` int(11)
,`modelo` varchar(80)
,`idmarca` int(11)
,`marca` varchar(80)
,`stock` int(11)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_equipo01`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_equipo01` (
`idequipo` int(11)
,`nombre` varchar(80)
,`descripcion` varchar(8000)
,`pu` decimal(19,7)
,`stock` int(11)
,`idcolor` int(11)
,`idalmacenamiento` int(11)
,`idpantalla` int(11)
,`idmodelo` int(11)
,`color` varchar(45)
,`almacenamiento` varchar(45)
,`pulgadas` varchar(18)
,`modelo` varchar(80)
,`idmarca` int(11)
,`marca` varchar(80)
,`url` varchar(50)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_graf_modelos_x_marca`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_graf_modelos_x_marca` (
`marca` varchar(80)
,`cant` bigint(21)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `v_boletas`
--
DROP TABLE IF EXISTS `v_boletas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_boletas`  AS SELECT `b`.`idboleta` AS `idboleta`, `b`.`nro` AS `nro`, `b`.`fecha` AS `fecha`, `b`.`total` AS `total`, `NumerosALetras`(`b`.`total`) AS `enLetras`, `b`.`idcliente` AS `idcliente`, `db`.`cantidad` AS `cantidad`, `db`.`pu` AS `pu`, `db`.`subtotal` AS `subtotal`, `db`.`idequipo` AS `idequipo`, `p`.`nombre` AS `nombreequi`, `p`.`descripcion` AS `descripcion`, `p`.`idmodelo` AS `idmodelo`, `m`.`modelo` AS `modelo`, `ma`.`marca` AS `marca`, `cl`.`nombres` AS `nombrecli`, `cl`.`apellidos` AS `apellidocli`, `cl`.`direccion` AS `direccion`, `cl`.`email` AS `email`, `cl`.`dni` AS `dni` FROM (((((`boletas` `b` join `detallesboletas` `db` on(`b`.`idboleta` = `db`.`idboleta`)) join `equipos` `p` on(`db`.`idequipo` = `p`.`idequipo`)) join `modelos` `m` on(`p`.`idmodelo` = `m`.`idmodelo`)) join `marcas` `ma` on(`m`.`idmarca` = `ma`.`idmarca`)) join `clientes` `cl` on(`b`.`idcliente` = `cl`.`idcliente`))  ;

-- --------------------------------------------------------

--
-- Estructura para la vista `v_clientes`
--
DROP TABLE IF EXISTS `v_clientes`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_clientes`  AS SELECT `clientes`.`idcliente` AS `idcliente`, `clientes`.`nombres` AS `nombres`, `clientes`.`apellidos` AS `apellidos`, concat(`clientes`.`nombres`,' ',`clientes`.`apellidos`) AS `nombrecliente`, `clientes`.`dni` AS `dni` FROM `clientes``clientes`  ;

-- --------------------------------------------------------

--
-- Estructura para la vista `v_equipo`
--
DROP TABLE IF EXISTS `v_equipo`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_equipo`  AS SELECT `e`.`idequipo` AS `idequipo`, `e`.`nombre` AS `nombre`, `e`.`descripcion` AS `descripcion`, `e`.`pu` AS `pu`, `e`.`idmodelo` AS `idmodelo`, `m`.`modelo` AS `modelo`, `m`.`idmarca` AS `idmarca`, `ma`.`marca` AS `marca`, `e`.`stock` AS `stock` FROM ((`equipos` `e` join `modelos` `m` on(`e`.`idmodelo` = `m`.`idmodelo`)) join `marcas` `ma` on(`ma`.`idmarca` = `m`.`idmarca`))  ;

-- --------------------------------------------------------

--
-- Estructura para la vista `v_equipo01`
--
DROP TABLE IF EXISTS `v_equipo01`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_equipo01`  AS SELECT `equipos`.`idequipo` AS `idequipo`, `equipos`.`nombre` AS `nombre`, `equipos`.`descripcion` AS `descripcion`, `equipos`.`pu` AS `pu`, `equipos`.`stock` AS `stock`, `equipos`.`idcolor` AS `idcolor`, `equipos`.`idalmacenamiento` AS `idalmacenamiento`, `equipos`.`idpantalla` AS `idpantalla`, `equipos`.`idmodelo` AS `idmodelo`, `color`.`color` AS `color`, `almacenamiento`.`almacenamiento` AS `almacenamiento`, `pantalla`.`pulgadas` AS `pulgadas`, `modelos`.`modelo` AS `modelo`, `modelos`.`idmarca` AS `idmarca`, `marcas`.`marca` AS `marca`, `imagenes_equipo`.`url` AS `url` FROM ((((((`equipos` join `color` on(`equipos`.`idcolor` = `color`.`idcolor`)) join `almacenamiento` on(`equipos`.`idalmacenamiento` = `almacenamiento`.`idalmacenamiento`)) join `pantalla` on(`equipos`.`idpantalla` = `pantalla`.`idpantalla`)) join `modelos` on(`equipos`.`idmodelo` = `modelos`.`idmodelo`)) join `marcas` on(`modelos`.`idmarca` = `marcas`.`idmarca`)) left join `imagenes_equipo` on(`equipos`.`idequipo` = `imagenes_equipo`.`idequipo`)) GROUP BY `equipos`.`idequipo`, `equipos`.`nombre`, `equipos`.`descripcion`, `equipos`.`stock`, `equipos`.`pu`, `equipos`.`idcolor`, `equipos`.`idalmacenamiento`, `equipos`.`idpantalla`, `equipos`.`idmodelo`, `color`.`color`, `almacenamiento`.`almacenamiento`, `pantalla`.`pulgadas`, `modelos`.`modelo`, `modelos`.`idmarca`, `marcas`.`marca``marca`  ;

-- --------------------------------------------------------

--
-- Estructura para la vista `v_graf_modelos_x_marca`
--
DROP TABLE IF EXISTS `v_graf_modelos_x_marca`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_graf_modelos_x_marca`  AS SELECT `ma`.`marca` AS `marca`, count(`mo`.`idmodelo`) AS `cant` FROM (`marcas` `ma` join `modelos` `mo` on(`ma`.`idmarca` = `mo`.`idmarca`)) GROUP BY `ma`.`marca``marca`  ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
