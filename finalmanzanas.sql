create database manzanas;

use manzanas;

#CREACION TABLA PRODUCTO
CREATE TABLE `manzanas`.`producto` (
  `id_producto` INT NOT NULL AUTO_INCREMENT,
  `peso` DECIMAL(10,3) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_producto`));

#CREACION TABLA PRODUCCION
CREATE TABLE `manzanas`.`produccion` (
  `id_produccion` INT NOT NULL AUTO_INCREMENT,
  `id_producto` INT NOT NULL,
  `tipo` VARCHAR(25) NOT NULL,
  `precio` DOUBLE NOT NULL,
  `stock` INT NOT NULL,
  `fecha` DATETIME NOT NULL,
  PRIMARY KEY (`id_produccion`),
  INDEX `id_producto_idx` (`id_producto` ASC) VISIBLE,
  CONSTRAINT `id_producto`
    FOREIGN KEY (`id_producto`)
    REFERENCES `manzanas`.`producto` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

#CREACION TABLA CLIENTE
CREATE TABLE `manzanas`.`cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(20) NOT NULL,
  `apellido` VARCHAR(25) NOT NULL,
  `celular` VARCHAR(25) NOT NULL,
  `direccion` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id_cliente`));

#CREACION TABLA VENTA
CREATE TABLE `manzanas`.`venta` (
  `id_venta` INT NOT NULL AUTO_INCREMENT,
  `id_cliente` INT NOT NULL,
  `id_produccion` INT NOT NULL,
  `cantidad` DECIMAL(10,2) NOT NULL,
  `precio_venta` DOUBLE NOT NULL,
  `fecha` TIMESTAMP NOT NULL,
  PRIMARY KEY (`id_venta`),
  INDEX `id_cliente_idx` (`id_cliente` ASC) VISIBLE,
  INDEX `id_produccion_idx` (`id_produccion` ASC) VISIBLE,
  CONSTRAINT `id_cliente`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `manzanas`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_produccion`
    FOREIGN KEY (`id_produccion`)
    REFERENCES `manzanas`.`produccion` (`id_produccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
    
#AGREGO MANZANAS
INSERT INTO `manzanas`.`producto` (`peso`, `descripcion`) VALUES ('0.21', 'Manzana roja pequena');

INSERT INTO `manzanas`.`producto` (`peso`, `descripcion`) VALUES ('0.34', 'Manzana roja grande');

#AGREGO PRODUCCION
INSERT INTO `manzanas`.`produccion` (`id_producto`, `tipo`, `precio`, `stock`, `fecha`) VALUES ('1', 'Botella de 750mm ', '300', '200', current_timestamp());

INSERT INTO `manzanas`.`produccion` (`id_producto`, `tipo`, `precio`, `stock`, `fecha`) VALUES ('2', 'Bolsa de 15 manzanas', '200', '400', current_timestamp());

INSERT INTO `manzanas`.`produccion` (`id_producto`, `tipo`, `precio`, `stock`, `fecha`) VALUES ('1', 'Botella de 1l de jugo', '400', '200', current_timestamp());

#AGREGO CLIENTES
INSERT INTO `manzanas`.`cliente` (`nombre`, `apellido`, `celular`, `direccion`) VALUES ('Julian', 'Castillo', '2604602956', 'Tirasso 1607');
INSERT INTO `manzanas`.`cliente` (`nombre`, `apellido`, `celular`, `direccion`) VALUES ('Nicolas', 'Mayoral', '26042890402', 'Avenida New York 2929');

#AGREGO VENTAS
INSERT INTO `manzanas`.`venta` (`id_cliente`, `id_produccion`, `cantidad`, `precio_venta`, `fecha`) VALUES ('1', '1', '4',(select precio*4 from produccion where id_produccion = 1) , current_timestamp());

INSERT INTO `manzanas`.`venta` (`id_cliente`, `id_produccion`, `cantidad`, `precio_venta`, `fecha`) VALUES ('2', '1', '3', (select precio*3 from produccion where id_produccion = 1), current_timestamp());

INSERT INTO `manzanas`.`venta` (`id_cliente`, `id_produccion`, `cantidad`, `precio_venta`, `fecha`) VALUES ('1', '2', '1', (select precio*1 from produccion where id_produccion = 2), current_timestamp());

INSERT INTO `manzanas`.`venta` (`id_cliente`, `id_produccion`, `cantidad`, `precio_venta`, `fecha`) VALUES ('2', '3', '2', (select precio*2 from produccion where id_produccion = 2), '2022-06-07 12:00:06');


select * from produccion;
#--------CONSULTAS------------
#PRODUCCION DIARIA
SELECT p.tipo as "Producto producido",p.fecha as "Fecha y hora",pr.descripcion as "Elaborado con" FROM produccion p  
INNER JOIN producto pr on(p.id_producto = pr.id_producto)
WHERE fecha LIKE("2022-07-07%");

#PEDIDOS DIARIOS
SELECT p.tipo as 'Producto',CONCAT(c.nombre,' ',c.apellido) as "Pedido por:",v.precio_venta as'Precio Final',v.fecha as 'Fecha' FROM venta v
INNER JOIN cliente c on(v.id_cliente = c.id_cliente)
INNER JOIN produccion p on(v.id_produccion = p.id_produccion)