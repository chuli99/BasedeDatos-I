create database holamundo2;
USE holamundo2;

CREATE TABLE user(
	id int auto_increment not null,
    name varchar(50) not null,
    edad int not null,
    email varchar(50) not null,
    primary key (id)
)


INSERT INTO user(name, edad, email) values ('Josepo', 21,'josepo@gmail.com');
INSERT INTO user(name, edad, email) values ('Eduardo', 30,'eduardo@gmail.com');
INSERT INTO user(name, edad, email) values ('Joaco', 30,'joaco@gmail.com');
INSERT INTO user(name, edad, email) values ('Pedro', 54,'pedro99@gmail.com');
INSERT INTO user(name, edad, email) values ('Julian', 30,'julian@gmail.com');

INSERT INTO user(name, edad, email) values ('German', 17,'german@gmail.com');

SELECT * FROM user;

#Limit limita a la cantidad de recursos que queremos ver
SELECT * FROM user limit 1;

SELECT * FROM user WHERE edad <25;

#Trae todos los que cumplan las 2 condiciones por separado, con un and deberia cumplir las dos
SELECT * FROM user WHERE edad > 25 or email = 'josepo@gmail.com';

#Busca entre 20 y 30
SELECT * FROM user WHERE edad between 20 and 30;

SELECT * FROM user WHERE email like '%gmail%';

UPDATE user SET email = 'german@hotmail.com' WHERE id = 7;

#BUSCAR POR ORDEN ASCENDENTE
SELECT * FROM user order by edad asc;

#BUSCAR POR ORDEN DESCENDENTE
SELECT * FROM user order by edad desc;

#BUSCAR EL MAYOR Y EL MENOR
#user es la tabla, mayor es el nombre que le vamos a asignar
SELECT max(edad) as mayor from user;
SELECT min(edad) as menor from user;

#VER LAS COLUMNAS QUE SELECCIONEMOS
SELECT id, name FROM user;

#TAGEAR COLUMNAS
SELECT id, name as nombre from user;

