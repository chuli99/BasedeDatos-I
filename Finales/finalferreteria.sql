create database ferreteria;

use ferreteria;


#CREACION TABLA PRODUCTO
CREATE TABLE `ferreteria`.`producto` (
  `CodigoProducto` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(25) NOT NULL,
  `Descripción` VARCHAR(250) NOT NULL,
  `Precio` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`CodigoProducto`));
  
#CREACION TABLA DEPOSITO
CREATE TABLE `ferreteria`.`deposito` (
  `IDDeposito` INT NOT NULL AUTO_INCREMENT,
  `CodigoProducto` INT NOT NULL,
  `Cantidad` DECIMAL(10,3) NOT NULL,
  `Fecha` TIMESTAMP NOT NULL,
  PRIMARY KEY (`IDDeposito`),
  INDEX `CodigoProducto_idx` (`CodigoProducto` ASC) VISIBLE,
  CONSTRAINT `CodigoProducto`
    FOREIGN KEY (`CodigoProducto`)
    REFERENCES `ferreteria`.`producto` (`CodigoProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
#CREACION TABLA VENTA
CREATE TABLE `ferreteria`.`venta` (
  `IDVenta` INT NOT NULL AUTO_INCREMENT,
  `IDDeposito` INT NOT NULL,
  `Cantidad` DECIMAL(10,3) NOT NULL,
  `PrecioVenta` DECIMAL(10,2) NOT NULL,
  `Fecha` TIMESTAMP NOT NULL,
  PRIMARY KEY (`IDVenta`),
  INDEX `IDDepositoFK_idx` (`IDDeposito` ASC) VISIBLE,
  CONSTRAINT `IDDepositoFK`
    FOREIGN KEY (`IDDeposito`)
    REFERENCES `ferreteria`.`deposito` (`IDDeposito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

#AGREGO DATOS A PRODUCTO    
INSERT INTO `ferreteria`.`producto`(`Nombre`,`Descripción`,`Precio`)values('Destornillador Phillips','Destornillador philips de la marca alejandro','400.00');

INSERT INTO `ferreteria`.`producto`(`Nombre`,`Descripción`,`Precio`)values('Lija fina','Lija fina de la marca alejandro','100.00');

INSERT INTO `ferreteria`.`producto`(`Nombre`,`Descripción`,`Precio`)values('Martillo','Martillo de la marca alejandro','500.00');

#AGREGO DATOS A DEPOSITO
INSERT INTO `ferreteria`.`deposito`(`CodigoProducto`,`Cantidad`,`Fecha`)values('1','20',current_timestamp());

INSERT INTO `ferreteria`.`deposito`(`CodigoProducto`,`Cantidad`,`Fecha`)values('2','60',current_timestamp());

INSERT INTO `ferreteria`.`deposito`(`CodigoProducto`,`Cantidad`,`Fecha`)values('3','30',current_timestamp());

#AGREGO DATOS A VENTA
INSERT INTO `ferreteria`.`venta`(`IDDeposito`,`Cantidad`,`PrecioVenta`,`Fecha`)values('3','10','1000.0',current_timestamp());

INSERT INTO `ferreteria`.`venta`(`IDDeposito`,`Cantidad`,`PrecioVenta`,`Fecha`)values('1','2','800.0',current_timestamp());

INSERT INTO `ferreteria`.`venta`(`IDDeposito`,`Cantidad`,`PrecioVenta`,`Fecha`)values('4','1','500.0',current_timestamp());

select * from venta;

#CONSULTA STOCK DISPONIBLE POR ARTICULO A DETERMINADA FECHA
select p.Nombre,d.Cantidad as 'Stock Diario',d.Fecha from deposito d 
inner join producto p on (d.CodigoProducto = p.CodigoProducto)
where d.Fecha like '2022-06-28 %';
#CONSULTA DE PEDIDOS DIARIOS

select * from venta;

ALTER TABLE venta AUTO_INCREMENT = 1;