
-- leccion 1
Create Database ALkeWallet;
Use alkewallet;

Show DATABASES;
-- se crea tabla usuarios con ddl, teniendo restricciones de not null, con claves foraneas y primary key
Create table Usuarios(
user_id int auto_increment primary key,
nombre varchar(50) not null,
correo varchar(50) unique not null,
contrasena varchar(255) not null,
saldo decimal(10,2) default 0.00 );

-- se crea tabla Transaccion con ddl, teniendo restricciones de not null, con claves foraneas y primary key
create table Transaccion(
transaccion_id int auto_increment primary key,
sender_user_id int not null,
reciver_user_id int not null,
importe decimal(10,2) not null,
transaction_date datetime default current_timestamp,
currency_id INT NOT NULL,
foreign key (sender_user_id) references Usuarios(user_id), 
foreign key (reciver_user_id) references Usuarios(user_id),
 FOREIGN KEY (currency_id) REFERENCES Moneda(currency_id)
 );
 
 -- se crea tabla Moneda con ddl, teniendo restricciones de not null, con claves foraneas y primary key
 create table Moneda(
 currency_id int auto_increment primary key,
 currency_name varchar(50) not null,
 currency_symbol varchar(50) not null
 );


show Tables;

Describe usuarios;
-- leccion 2

Select * from usuarios;
Select nombre from usuarios;

Select * from usuarios where saldo < '120000';


SELECT 
    t.transaccion_id,
    u1.nombre AS remitente,
    u2.nombre AS receptor,
    t.importe,
    t.transaction_date
FROM Transaccion t
INNER JOIN Usuarios u1
    ON t.sender_user_id = u1.user_id
INNER JOIN Usuarios u2
    ON t.reciver_user_id = u2.user_id;

    SELECT 
    user_id,
    nombre,
    (
        SELECT COUNT(*)
        FROM Transaccion t
        WHERE t.sender_user_id = u.user_id
    ) AS total_transacciones
FROM Usuarios u;

-- seccion 3
 INSERT INTO Usuarios (nombre, correo, contrasena, saldo)
VALUES
('Carola Martínez', 'carola@mail.cl', 'clave123', 50000.00),
('Diego Soto', 'diego@mail.cl', 'clave456', 120000.00),
('María Vega', 'maria@mail.cl', 'clave789', 75000.00);

INSERT INTO Transaccion (sender_user_id, reciver_user_id, importe)
VALUES
(1, 2, 30000.00),
(2, 3, 15000.00),
(3, 1, 8000.00);

 INSERT INTO Moneda (currency_name, currency_symbol)
VALUES
('Peso Chileno', 'CLP'),
('Dolar Estadounidense', 'USD'),
('Euro', 'EUR');


Select * from Usuarios;
Select * from transaccion;
Select * from Moneda;

UPDATE Usuarios
SET saldo = saldo - 20000.00
WHERE user_id = 1;

Select * from Usuarios;

START TRANSACTION;

-- Restar dinero al que envia dinero
UPDATE Usuarios
SET saldo = saldo - 20000
WHERE user_id = 2;

-- Sumar dinero al receptor
UPDATE Usuarios
SET saldo = saldo + 20000
WHERE user_id = 1;

-- Registrar la transacción
INSERT INTO Transaccion
(sender_user_id, reciver_user_id, importe)
VALUES
(1, 2, 20000);

COMMIT;

START TRANSACTION;

-- Restar dinero al remitente
UPDATE Usuarios
SET saldo = saldo - 20000
WHERE user_id = 1;

-- Sumar dinero al receptor
UPDATE Usuarios
SET saldo = saldo + 20000
WHERE user_id = 2;

-- ERROR: el usuario 999 no existe
INSERT INTO Transaccion (sender_user_id, reciver_user_id, importe)
VALUES (1, 999, 20000);

-- Como ocurrió un error, revertimos todo
ROLLBACK;

Select * from Usuarios;

-- leccion 4
Describe usuarios;
describe transaccion;
describe moneda;

