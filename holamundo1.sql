#Creacion de database
create database holamundo;

#Mostrar base de datos
show databases;
#Usar base de datos en especifico, para agregrar tabla
use holamundo;
#Creacion de tabla
CREATE TABLE animales(
	id int,
    tipo varchar(255),
    estado varchar(255),
    PRIMARY KEY (id)
);
#Agregar datos a la tabla
INSERT INTO animales(tipo,estado) VALUES ('perro','tiste');
INSERT INTO animales(tipo,estado) VALUES ('burro','feliz');
INSERT INTO animales(tipo,estado) VALUES ('gato','feliz');
#Modificar una tabla ya creada
ALTER TABLE animales MODIFY COLUMN id int auto_increment;

#Muestra el comando de creacion
SHOW CREATE TABLE animales;

#Permite seleccionar elementos que se encuentran dentro de una tabla
SELECT * FROM animales;

#Selecciona de la lista de animales el id = 1
SELECT * FROM animales WHERE id = 1;

 SELECT * FROM animales WHERE estado = 'feliz' AND tipo = 'gato';
 
 #Cambio el estado del animal id 3 a Tiste
 UPDATE animales SET estado = 'tiste' WHERE id = 3;


#Existe un modo seguro para eliminar registros unicamente por el id 
DELETE from animales where estado = 'feliz';
DELETE from animales where id = 3;
