USE holamundo2;

CREATE TABLE products(
	id int not null auto_increment,
    name varchar(50) not null,
    created_by int not null,
    marca varchar (50) not null,
    primary key(id),
    #AQUI ABAJO ACLARAMOS LA FOREING KEY Y A QUE TABLA SE RELACIONA
	foreign key(created_by) references user(id)
);

#Renombrar una tabla
rename table products to product;

SHOW databases;

#Insertar solo con un Insert
insert into product(name,created_by,marca)
values
	('ipad', 1,'apple'),
    ('iphone', 1,'apple'),
    ('watch',2,'apple'),
    ('mcbook',2,'apple'),
    ('imac',3,'apple'),
    ('ipad mini',3,'apple');
    
SELECT * FROM product;


#LEFT JOIN
#SI HAY USUARIOS QUE APARECEN COMO RESULTADOS EN PRODUCT TRAELOS, SI NO TRAELOS COMO NULOS
#U es un alias para poner delante de los atributos de user. Luego de left Join va la tabla que queremos unir con la tabla de usuario.
#AL FINAL DE la linea, las dos columnas que vamos a relacionar
SELECT u.id, u.email, p.name from user u LEFT JOIN product p on u.id = p.created_by; 

#RIGT JOIN
#lo mismo que el left join, pero por la derecha. El que va a traer los datos es product
SELECT u.id, u.email, p.name from user u RIGHT JOIN product p on u.id = p.created_by; 

#INNER JOIN
#TRAE solo las columnas asosiadas.
SELECT u.id, u.email, p.name from user u INNER JOIN product p on u.id = p.created_by; 
