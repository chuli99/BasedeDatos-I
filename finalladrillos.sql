#CREACION DE DATABASE DE FINAL DE LADRILLO

CREATE DATABASE ladrillos;

USE ladrillos;


#CREACION TABLAS DDL
CREATE TABLE `ladrillos`.`producto` (
  `id_producto` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(25) NOT NULL,
  `descripcion` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`id_producto`));

#TRABLA DEPOSITO
CREATE TABLE `ladrillos`.`deposito` (
  `id_deposito` INT NOT NULL AUTO_INCREMENT,
  `id_ladrillo` INT NOT NULL,
  `tipo` VARCHAR(25) NOT NULL,
  `precio` DECIMAL(10,2) NOT NULL,
  `stock` DECIMAL(10,2) NOT NULL,
  `fecha` TIMESTAMP NOT NULL,
  PRIMARY KEY (`id_deposito`),
  INDEX `fk_idproducto_producto_idx` (`id_ladrillo` ASC) VISIBLE,
  CONSTRAINT `fk_idproducto_producto`
    FOREIGN KEY (`id_ladrillo`)
    REFERENCES `ladrillos`.`producto` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

#TABLA CLIENTE    
CREATE TABLE `ladrillos`.`cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(25) NOT NULL,
  `apellido` VARCHAR(25) NOT NULL,
  `celular` VARCHAR(25) NOT NULL,
  `direccion` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id_cliente`));

#TABLA VENTA  
CREATE TABLE `ladrillos`.`venta` (
  `id_venta` INT NOT NULL AUTO_INCREMENT,
  `id_deposito` INT NOT NULL,
  `id_cliente` INT NOT NULL,
  `cantidad` DECIMAL(10,2) NOT NULL,
  `precio_venta` DECIMAL(10,2) NOT NULL,
  `fecha` TIMESTAMP NOT NULL,
  PRIMARY KEY (`id_venta`),
  INDEX `id_deposito_idx` (`id_deposito` ASC) VISIBLE,
  INDEX `id_cliente_idx` (`id_cliente` ASC) VISIBLE,
  CONSTRAINT `id_deposito`
    FOREIGN KEY (`id_deposito`)
    REFERENCES `ladrillos`.`deposito` (`id_deposito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_cliente`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `ladrillos`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
#AGREGO LADRILLO    
INSERT INTO `ladrillos`.`producto`(`nombre`,`descripcion`)values('Ladrillo adobon','Ladrillo de adobon de 20*40');

INSERT INTO `ladrillos`.`producto`(`nombre`,`descripcion`)values('Ladrillo estandard','Ladrillo estandard de 20*40');

INSERT INTO `ladrillos`.`producto`(`nombre`,`descripcion`)values('Ladrillo construccion','Ladrillo de construccion de 20*40');

#AGREGO PALETS DE LADRILLOS
INSERT INTO `ladrillos`.`deposito` (`id_ladrillo`, `tipo`, `precio`, `stock`, `fecha`) VALUES ('1', 'adobon', '20000', '50', current_timestamp());

INSERT INTO `ladrillos`.`deposito` (`id_ladrillo`, `tipo`, `precio`, `stock`, `fecha`) VALUES ('2', 'starndard', '15000', '100', current_timestamp());

INSERT INTO `ladrillos`.`deposito` (`id_ladrillo`, `tipo`, `precio`, `stock`, `fecha`) VALUES ('3', 'construccion', '25000', '80', current_timestamp());

#AGREGAR CLIENTES
INSERT INTO `ladrillos`.`cliente` (`nombre`, `apellido`, `celular`, `direccion`) VALUES ('Julian', 'Castillo', '2604602956', 'Balloffet 1681');

INSERT INTO `ladrillos`.`cliente` (`nombre`, `apellido`, `celular`, `direccion`) VALUES ('Nicolas ', 'Mayoral', '26043487298', 'Avenida New york 2987');

#AGREGAR VENTAS
INSERT INTO `ladrillos`.`venta` (`id_deposito`, `id_cliente`, `cantidad`, `precio_venta`, `fecha`) VALUES ('1', '1', '3', '75000', current_timestamp());

INSERT INTO `ladrillos`.`venta` (`id_deposito`, `id_cliente`, `cantidad`, `precio_venta`, `fecha`) VALUES ('2', '1', '2', '30000', current_timestamp());

INSERT INTO `ladrillos`.`venta` (`id_deposito`, `id_cliente`, `cantidad`, `precio_venta`, `fecha`) VALUES ('3', '2', '4', '10000', current_timestamp());

INSERT INTO `ladrillos`.`venta` (`id_deposito`, `id_cliente`, `cantidad`, `precio_venta`, `fecha`) VALUES ('3', '2', '4', '10000','2022-06-06 12:09:47');


#-----------CONSULTAS-------------
#CONSULTA 1
select p.nombre as 'Nombre',d.feventacha as 'Fecha de elaboracion' from deposito d 
inner join producto p on(d.id_ladrillo = p.id_producto)
where fecha like('2022-07-06 %');

#CONSULTA 2
select count(id_venta) as 'Cantidad de ventas del dia hoy' from venta where fecha like('2022-07-06 %');