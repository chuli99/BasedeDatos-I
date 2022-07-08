CREATE DATABASE taller_textil;

use taller_textil;


#CREACION TABLA PIEZA
CREATE TABLE `taller_textil`.`pieza` (
  `id_pieza` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(20) NULL,
  PRIMARY KEY (`id_pieza`));

#CREACION TABLA DEPOSITO
CREATE TABLE `taller_textil`.`deposito` (
  `id_deposito` INT NOT NULL AUTO_INCREMENT,
  `id_pieza` INT NOT NULL,
  `estado` VARCHAR(15) NOT NULL,
  `cantidad` INT NOT NULL,
  `fecha` TIMESTAMP NOT NULL,
  PRIMARY KEY (`id_deposito`),
  INDEX `id_pieza_idx` (`id_pieza` ASC) VISIBLE,
  CONSTRAINT `id_pieza`
    FOREIGN KEY (`id_pieza`)
    REFERENCES `taller_textil`.`pieza` (`id_pieza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

#CREACION TABLA PRODUCCION
CREATE TABLE `taller_textil`.`produccion` (
  `id_produccion` INT NOT NULL AUTO_INCREMENT,
  `id_deposito` INT NOT NULL,
  `cantidad_productos` INT NOT NULL,
  `fecha` TIMESTAMP NOT NULL,
  PRIMARY KEY (`id_produccion`),
  INDEX `id_deposito_idx` (`id_deposito` ASC) VISIBLE,
  CONSTRAINT `id_deposito`
    FOREIGN KEY (`id_deposito`)
    REFERENCES `taller_textil`.`deposito` (`id_deposito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

#CREACION TABLA PRODUCTO
CREATE TABLE `taller_textil`.`producto` (
  `id_producto` INT NOT NULL AUTO_INCREMENT,
  `id_produccion` INT NOT NULL,
  `color` VARCHAR(10) NOT NULL,
  `talle` VARCHAR(5) NOT NULL,
  `material` VARCHAR(7) NOT NULL,
  `numero_de_lote` INT NOT NULL,
  `precio` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id_producto`),
  INDEX `id_produccion_idx` (`id_produccion` ASC) VISIBLE,
  CONSTRAINT `id_produccion`
    FOREIGN KEY (`id_produccion`)
    REFERENCES `taller_textil`.`produccion` (`id_produccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
#DATOS
#AGREGO PIEZAS
INSERT INTO `taller_textil`.`pieza` (`tipo`) VALUES ('espalda');
INSERT INTO `taller_textil`.`pieza` (`tipo`) VALUES ('frente');
INSERT INTO `taller_textil`.`pieza` (`tipo`) VALUES ('manga');
INSERT INTO `taller_textil`.`pieza` (`tipo`) VALUES ('cuello');
INSERT INTO `taller_textil`.`pieza` (`tipo`) VALUES ('puno');

#AGREGO PIEZAS A DEPOSITO
INSERT INTO `taller_textil`.`deposito` (`id_pieza`, `estado`, `cantidad`, `fecha`) VALUES ('1', 'aprobado', '1500', current_timestamp());

INSERT INTO `taller_textil`.`deposito` (`id_pieza`, `estado`, `cantidad`, `fecha`) VALUES ('2', 'fallas', '300', current_timestamp());

#AGREGO PRODUCCION
INSERT INTO `taller_textil`.`produccion` (`id_deposito`, `cantidad_productos`, `fecha`) VALUES ('2', '100', current_timestamp());

INSERT INTO `taller_textil`.`produccion` (`id_deposito`, `cantidad_productos`, `fecha`) VALUES ('2', '100', current_timestamp());

INSERT INTO `taller_textil`.`produccion` (`id_deposito`, `cantidad_productos`, `fecha`) VALUES ('2', '100', current_timestamp());

