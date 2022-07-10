#CREACION DE BASE DE DATOS

CREATE DATABASE granja;

USE granja;

#CREACION TABLA PRODUCTO
CREATE TABLE `granja`.`producto` (
  `id_producto` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(15) NOT NULL,
  `descripcion` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id_producto`));

#CREACION TABLA PRODUCCION
CREATE TABLE `granja`.`produccion` (
  `id_produccion` INT NOT NULL AUTO_INCREMENT,
  `id_producto` INT NOT NULL,
  `tipo` VARCHAR(30) NOT NULL,
  `precio` DECIMAL(10,2) NOT NULL,
  `cantidad` INT NOT NULL,
  `fecha` TIMESTAMP NOT NULL,
  PRIMARY KEY (`id_produccion`),
  INDEX `id_producto_idx` (`id_producto` ASC) VISIBLE,
  CONSTRAINT `id_producto`
    FOREIGN KEY (`id_producto`)
    REFERENCES `granja`.`producto` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
#CREACION TABLA VENTA
CREATE TABLE `granja`.`venta` (
  `id_venta` INT NOT NULL AUTO_INCREMENT,
  `id_produccion` INT NOT NULL,
  `id_cliente` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `precio_venta` DECIMAL(10,2) NOT NULL,
  `fecha` TIMESTAMP NOT NULL,
  PRIMARY KEY (`id_venta`),
  INDEX `id_produccion_idx` (`id_produccion` ASC) VISIBLE,
  INDEX `id_cliente_idx` (`id_cliente` ASC) VISIBLE,
  CONSTRAINT `id_produccion`
    FOREIGN KEY (`id_produccion`)
    REFERENCES `granja`.`produccion` (`id_produccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_cliente`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `granja`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


#CREACION TABLA CLIENTES
CREATE TABLE `granja`.`cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(15) NOT NULL,
  `apellido` VARCHAR(15) NOT NULL,
  `celular` VARCHAR(15) NOT NULL,
  `direccion` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_cliente`));
  


#AGREGO PRODUCTOS
INSERT INTO `granja`.`producto` (`nombre`, `descripcion`) VALUES ('Huevo blanco', 'Huevo blanco de gallina  A');
INSERT INTO `granja`.`producto` (`nombre`, `descripcion`) VALUES ('Huevo amarillo', 'Huevo amarillo de gallina B');

#AGREGO PRODUCCION
INSERT INTO `granja`.`produccion` (`id_producto`, `tipo`, `precio`, `cantidad`, `fecha`) VALUES ('1', 'Maple huevo blanco', '400', '150', current_timestamp());
INSERT INTO `granja`.`produccion` (`id_producto`, `tipo`, `precio`, `cantidad`, `fecha`) VALUES ('2', 'Maple huevo amarillo', '450', '120', current_timestamp());
INSERT INTO `granja`.`produccion` (`id_producto`, `tipo`, `precio`, `cantidad`, `fecha`) VALUES ('1', 'Medio maple huevo blanco', '200', '80', current_timestamp());
INSERT INTO `granja`.`produccion` (`id_producto`, `tipo`, `precio`, `cantidad`, `fecha`) VALUES ('2', 'Medio maple huevo amarillo', '225', '50', current_timestamp());

#AGREGO CLIENTES
INSERT INTO `granja`.`cliente` (`nombre`, `apellido`, `celular`, `direccion`) VALUES ('Julian', 'Castillo', '2604602956', 'Tirasso 1607');
INSERT INTO `granja`.`cliente` (`nombre`, `apellido`, `celular`, `direccion`) VALUES ('Nicolas', 'Mayoral', '2604604939', 'Avenida 9 de Julio');
INSERT INTO `granja`.`cliente` (`nombre`, `apellido`, `celular`, `direccion`) VALUES ('Alexis', 'Lino', '2604586793', 'San Lorenzo 2398');

#AGREGO VENTAS
INSERT INTO `granja`.`venta` (`id_produccion`, `id_cliente`, `cantidad`, `precio_venta`, `fecha`) VALUES ('1', '1', '3', (select precio*3 from produccion where id_produccion = 1), current_timestamp());

INSERT INTO `granja`.`venta` (`id_produccion`, `id_cliente`, `cantidad`, `precio_venta`, `fecha`) VALUES ('2', '3', '2', (select precio*2 from produccion where id_produccion = 2), current_timestamp());

INSERT INTO `granja`.`venta` (`id_produccion`, `id_cliente`, `cantidad`, `precio_venta`, `fecha`) VALUES ('3', '2', '1', (select precio*1 from produccion where id_produccion = 3), current_timestamp());

#VENTA DE UN DIA DISTINTO PARA VERIFICAR LA CONSULTA
INSERT INTO `granja`.`venta` (`id_produccion`, `id_cliente`, `cantidad`, `precio_venta`, `fecha`) VALUES ('4', '1', '2', (select precio*2 from produccion where id_produccion = 4), "2022-06-08 14:31:32");


#-------CONSULTAS-------
#PRODUCCION DIARIA

SELECT p.tipo as 'Produccion', pr.nombre as 'Producto', p.fecha as 'Fecha de elaboracion' FROM produccion p
INNER JOIN producto pr ON(p.id_producto = pr.id_producto)
WHERE fecha LIKE("2022-07-08%");


#PEDIDOS DIARIOS
SELECT v.id_produccion as "Producto Numero:",v.cantidad as "Cantidad vendida",v.precio_venta as "Importe", concat(c.nombre," ",c.apellido) as "Vendido a cliente:" FROM venta v
INNER JOIN cliente c on(v.id_cliente = c.id_cliente)
WHERE fecha LIKE("2022-07-08%");

