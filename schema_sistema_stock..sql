-- OCANTOS GISELA AYELEN - SISTEMA DE STOCK
CREATE DATABASE sistema_ventas;
USE sistema_ventas;

-- 1) Tablas independientes primero
CREATE TABLE cliente (
    cliente_id INT AUTO_INCREMENT PRIMARY KEY,
    apellido VARCHAR(100) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    genero ENUM ("F", "M", "O") NOT NULL,
    direccion VARCHAR(200),
    email VARCHAR(150),
    fecha_nacimiento DATE,
    fecha_alta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(30) DEFAULT 'ACTIVO'
);

CREATE TABLE metodo_pago (
    metodo_pago_id INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL
);

CREATE TABLE zona_venta (
    zona_id INT AUTO_INCREMENT PRIMARY KEY,
    sector VARCHAR(100) NOT NULL
);

CREATE TABLE proveedor (
    proveedor_id INT AUTO_INCREMENT PRIMARY KEY,
    razon_social VARCHAR(200) NOT NULL,
    direccion VARCHAR(200),
    pais VARCHAR(100)
);

CREATE TABLE deposito (
    deposito_id INT AUTO_INCREMENT PRIMARY KEY,
    direccion VARCHAR(200),
    tipo VARCHAR(50)
);

CREATE TABLE categoria (
    categoria_id INT AUTO_INCREMENT PRIMARY KEY,
    tipo_producto VARCHAR(150) NOT NULL
);

-- 2) Tablas que dependen de las anteriores
CREATE TABLE porcentaje_gcia (
    porcentaje_id INT AUTO_INCREMENT PRIMARY KEY,
    porcentaje DECIMAL(5,2) NOT NULL,
    categoria_id INT,
    FOREIGN KEY (categoria_id) REFERENCES categoria(categoria_id)
);

CREATE TABLE producto (
    producto_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(200) NOT NULL,
    stock_minimo INT DEFAULT 0,
    categoria_id INT,
    reponer BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (categoria_id) REFERENCES categoria(categoria_id)
);

CREATE TABLE lista_precio (
    lista_id INT AUTO_INCREMENT PRIMARY KEY,
    producto_id INT NOT NULL,
    costo_unitario DECIMAL(10,2) NOT NULL,
    porcentaje_id INT,
    precio_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (producto_id) REFERENCES producto(producto_id),
    FOREIGN KEY (porcentaje_id) REFERENCES porcentaje_gcia(porcentaje_id)
);

CREATE TABLE vendedor (
    vendedor_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    ranking INT,
    comision DECIMAL(5,2),
    zona_id INT,
    FOREIGN KEY (zona_id) REFERENCES zona_venta(zona_id)
);

CREATE TABLE envio (
    envio_id INT AUTO_INCREMENT PRIMARY KEY,
    costo_envio DECIMAL(10,2),
    fecha_envio DATE,
    estado_envio VARCHAR(50)
);

-- 3) Tablas transaccionales que referencian las anteriores
CREATE TABLE venta (
    venta_id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    fecha_venta DATETIME DEFAULT CURRENT_TIMESTAMP,
    metodo_pago_id INT,
    total DECIMAL(12,2),
    estado_pago VARCHAR(50),
    vendedor_id INT,
    envio_id INT,
    FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id),
    FOREIGN KEY (metodo_pago_id) REFERENCES metodo_pago(metodo_pago_id),
    FOREIGN KEY (vendedor_id) REFERENCES vendedor(vendedor_id),
    FOREIGN KEY (envio_id) REFERENCES envio(envio_id)
);

CREATE TABLE detalle_venta (
    detallev_id INT AUTO_INCREMENT PRIMARY KEY,
    venta_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (venta_id) REFERENCES venta(venta_id),
    FOREIGN KEY (producto_id) REFERENCES producto(producto_id)
);

CREATE TABLE compra (
    compra_id INT AUTO_INCREMENT PRIMARY KEY,
    proveedor_id INT,
    fecha_compra DATETIME DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(12,2),
    estado_pago VARCHAR(50),
    FOREIGN KEY (proveedor_id) REFERENCES proveedor(proveedor_id)
);

CREATE TABLE detalle_compra (
    detallec_id INT AUTO_INCREMENT PRIMARY KEY,
    compra_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL,
    costo_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (compra_id) REFERENCES compra(compra_id),
    FOREIGN KEY (producto_id) REFERENCES producto(producto_id)
);

CREATE TABLE movstock (
    movimiento_id INT AUTO_INCREMENT PRIMARY KEY,
    producto_id INT NOT NULL,
    deposito_id INT NOT NULL,
    tipo_mov ENUM('ENTRADA','SALIDA','AJUSTE') NOT NULL,
    cantidad INT NOT NULL,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    compra_id INT,
    venta_id INT,
    FOREIGN KEY (producto_id) REFERENCES producto(producto_id),
    FOREIGN KEY (deposito_id) REFERENCES deposito(deposito_id),
    FOREIGN KEY (compra_id) REFERENCES compra(compra_id),
    FOREIGN KEY (venta_id) REFERENCES venta(venta_id)
);
-- Categorías
INSERT INTO categoria (tipo_producto) VALUES
('Electrónica'),
('Hogar');

-- Zonas de venta
INSERT INTO zona_venta (sector) VALUES
('Centro'),
('Norte');

-- Métodos de pago
INSERT INTO metodo_pago (tipo) VALUES
('Efectivo'),
('Tarjeta de Crédito');

-- Proveedores
INSERT INTO proveedor (razon_social, direccion, pais) VALUES
('Distribuidora Uno','Av 100','Argentina'),
('Tech Global','Av 200','Argentina'),
('Electro SA','Av 300','Argentina'),
('Hogar Total','Av 400','Argentina'),
('Importadora Sur','Av 500','Argentina'),
('Mayorista Norte','Av 600','Argentina'),
('Comercial Delta','Av 700','Argentina'),
('Logística Express','Av 800','Argentina'),
('Suministros SRL','Av 900','Argentina'),
('Distribuciones AR','Av 1000','Argentina'),
('Proveedor X','Av 1100','Argentina'),
('Proveedor Y','Av 1200','Argentina'),
('Proveedor Z','Av 1300','Argentina'),
('Electro Hogar','Av 1400','Argentina'),
('Tech Store','Av 1500','Argentina'),
('Full Import','Av 1600','Argentina'),
('Comercial Andina','Av 1700','Argentina'),
('Mercantil SA','Av 1800','Argentina'),
('Distribuciones Centro','Av 1900','Argentina'),
('Supply Chain SA','Av 2000','Argentina');

-- Depósitos
INSERT INTO deposito (direccion, tipo) VALUES
('Depósito Central', 'Principal'),
('Depósito Secundario', 'Auxiliar');

-- Porcentajes de ganancia
INSERT INTO porcentaje_gcia (porcentaje, categoria_id) VALUES
(30.00, 1),
(25.00, 2);

-- Productos
INSERT INTO producto (nombre, stock_minimo, categoria_id, reponer) VALUES
('Mouse Gamer',10,1,FALSE),
('Monitor 24"',8,1,FALSE),
('Teclado Mecánico',12,1,FALSE),
('Smart TV 50"',5,1,FALSE),
('Plancha',6,2,FALSE),
('Microondas',4,2,FALSE),
('Heladera',3,2,FALSE),
('Notebook',7,1,FALSE),
('Tablet',9,1,FALSE),
('Impresora',5,1,FALSE),
('Cafetera',6,2,FALSE),
('Ventilador',10,2,FALSE),
('Parlante Bluetooth',15,1,FALSE),
('Aspiradora',4,2,FALSE),
('Router WiFi',8,1,FALSE),
('Cargador Portátil',20,1,FALSE),
('Freidora',6,2,FALSE),
('Secador de Pelo',10,2,FALSE),
('Smartwatch',12,1,FALSE),
('Horno Eléctrico',5,2,FALSE);

-- Lista de precios
INSERT INTO lista_precio (producto_id, costo_unitario, porcentaje_id, precio_unitario) VALUES
(1, 10000.00, 1, 13000.00),
(2, 20000.00, 2, 25000.00);

-- Vendedores
INSERT INTO vendedor (nombre, apellido, ranking, comision, zona_id) VALUES
('Sergio','Lopez',3,4.00,1),
('Marina','Ruiz',4,3.50,2),
('Gustavo','Perez',2,5.00,1),
('Laura','Diaz',1,6.00,2),
('Nicolas','Torres',5,3.00,1),
('Carolina','Vega',2,4.50,2),
('Martin','Castro',3,4.00,1),
('Natalia','Rojas',4,3.75,2),
('Facundo','Silva',2,5.25,1),
('Daniela','Morales',3,4.10,2),
('Esteban','Herrera',1,6.50,1),
('Romina','Suarez',5,3.20,2),
('Ivan','Mendez',4,3.90,1),
('Melina','Gimenez',2,4.80,2),
('Bruno','Navarro',3,4.30,1),
('Flor','Ortiz',1,6.00,2),
('Alan','Peralta',4,3.60,1),
('Micaela','Acosta',2,5.10,2),
('Tomas','Benitez',3,4.40,1),
('Agustina','Santos',5,3.30,2);

-- Clientes
INSERT INTO cliente (apellido, nombre, genero, direccion, email, fecha_nacimiento) VALUES
('Martinez','Lucía','F','Calle 10','lucia1@mail.com','1995-04-10'),
('Sosa','Carlos','M','Calle 11','carlos2@mail.com','1990-07-22'),
('Fernandez','Ana','F','Calle 12','ana3@mail.com','1987-09-15'),
('Ramirez','Jorge','M','Calle 13','jorge4@mail.com','1993-01-30'),
('Diaz','Camila','F','Calle 14','camila5@mail.com','1998-12-11'),
('Torres','Miguel','M','Calle 15','miguel6@mail.com','1985-06-05'),
('Vega','Sofía','F','Calle 16','sofia7@mail.com','1991-03-19'),
('Castro','Pablo','M','Calle 17','pablo8@mail.com','1989-08-27'),
('Rojas','Valentina','F','Calle 18','vale9@mail.com','1996-02-14'),
('Silva','Diego','M','Calle 19','diego10@mail.com','1994-05-21'),
('Morales','Julieta','F','Calle 20','julieta11@mail.com','1997-11-03'),
('Herrera','Lucas','M','Calle 21','lucas12@mail.com','1992-10-08'),
('Suarez','Paula','F','Calle 22','paula13@mail.com','1990-04-01'),
('Mendez','Andrés','M','Calle 23','andres14@mail.com','1986-12-17'),
('Gimenez','Carla','F','Calle 24','carla15@mail.com','1999-07-07'),
('Navarro','Marcos','M','Calle 25','marcos16@mail.com','1988-01-13'),
('Ortiz','Florencia','F','Calle 26','flor17@mail.com','1993-09-29'),
('Peralta','Ezequiel','M','Calle 27','eze18@mail.com','1991-06-16'),
('Acosta','Brenda','F','Calle 28','brenda19@mail.com','1995-08-12'),
('Benitez','Franco','M','Calle 29','franco20@mail.com','1994-03-02');

-- Envíos
INSERT INTO envio (costo_envio, fecha_envio, estado_envio) VALUES
(1500.00, CURRENT_DATE, 'EN PREPARACIÓN'),
(2000.00, CURRENT_DATE, 'DESPACHADO');

-- Compra
INSERT INTO compra (proveedor_id, total, estado_pago) VALUES
(1, 200000.00, 'PAGADO');

-- Detalle de compra
INSERT INTO detalle_compra (compra_id, producto_id, cantidad, costo_unitario, subtotal) VALUES
(1, 1, 20, 10000.00, 200000.00);

-- Movimiento de stock (entrada)
INSERT INTO movstock (producto_id, deposito_id, tipo_mov, cantidad, compra_id) VALUES
(1, 1, 'ENTRADA', 20, 1);

-- Venta
INSERT INTO venta (cliente_id, metodo_pago_id, total, estado_pago, vendedor_id, envio_id) VALUES
(1, 2, 26000.00, 'PAGADO', 1, 1);

-- Detalle de venta
INSERT INTO detalle_venta (venta_id, producto_id, cantidad, precio_unitario, subtotal) VALUES
(1, 1, 2, 13000.00, 26000.00);

-- Movimiento de stock (salida)
INSERT INTO movstock (producto_id, deposito_id, tipo_mov, cantidad, venta_id) VALUES
(1, 1, 'SALIDA', 2, 1);

-- Vista ventas detalladas

CREATE VIEW ventas_detalladas AS
SELECT 
    v.venta_id,
    c.apellido,
    c.nombre,
    v.fecha_venta,
    p.nombre AS producto,
    dv.cantidad,
    dv.precio_unitario,
    dv.subtotal
FROM venta v
JOIN cliente c ON v.cliente_id = c.cliente_id
JOIN detalle_venta dv ON v.venta_id = dv.venta_id
JOIN producto p ON dv.producto_id = p.producto_id;

-- Vista stock bajo

CREATE VIEW stock_bajo AS
SELECT 
    p.producto_id,
    p.nombre,
    SUM(ms.cantidad) AS stock_actual,
    p.stock_minimo
FROM producto p
JOIN movstock ms ON p.producto_id = ms.producto_id
GROUP BY p.producto_id, p.nombre, p.stock_minimo
HAVING SUM(ms.cantidad) <= p.stock_minimo;

-- Vista vendedor

CREATE VIEW ventas_por_vendedor AS
SELECT 
    vendedor_id,
    COUNT(*) AS cantidad_ventas,
    SUM(total) AS total_vendido
FROM venta
GROUP BY vendedor_id;

-- Funciones

DELIMITER $$

CREATE FUNCTION calcular_precio_final(
    costo DECIMAL(10,2),
    porcentaje DECIMAL(5,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN costo + (costo * porcentaje / 100);
END $$

DELIMITER $$


-- Total vendido
DELIMITER $$

CREATE FUNCTION fn_total_vendido_producto(
    p_producto_id INT
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_total INT;

    SELECT COALESCE(SUM(cantidad),0)
    INTO v_total
    FROM detalle_venta
    WHERE producto_id = p_producto_id;

    RETURN v_total;
END $$

DELIMITER ;

-- Stored procedures 
-- registrar_venta

DELIMITER $$

CREATE PROCEDURE registrar_venta (
    IN p_cliente_id INT,
    IN p_metodo_pago INT,
    IN p_vendedor INT,
    IN p_envio INT,
    IN p_total DECIMAL(12,2)
)
BEGIN
    INSERT INTO venta (
        cliente_id, fecha_venta, metodo_pago_id, total, estado_pago, vendedor_id, envio_id
    )
    VALUES (
        p_cliente_id, NOW(), p_metodo_pago, p_total, 'PENDIENTE', p_vendedor, p_envio
    );
END $$

DELIMITER ;

-- Actualizar stock

DELIMITER $$

CREATE PROCEDURE actualizar_stock (
    IN p_producto INT,
    IN p_deposito INT,
    IN p_tipo ENUM('ENTRADA','SALIDA','AJUSTE'),
    IN p_cantidad INT
)
BEGIN
    INSERT INTO movstock (
        producto_id, deposito_id, tipo_mov, cantidad, fecha
    )
    VALUES (
        p_producto, p_deposito, p_tipo, p_cantidad, NOW()
    );
END $$

DELIMITER ;

-- Triggers
-- Descontar stock

DELIMITER $$

CREATE TRIGGER trg_descuento_stock
AFTER INSERT ON detalle_venta
FOR EACH ROW
BEGIN
    INSERT INTO movstock (
        producto_id,
        deposito_id,
        tipo_mov,
        cantidad,
        fecha,
        venta_id
    )
    VALUES (
        NEW.producto_id,
        1,
        'SALIDA',
        -NEW.cantidad,
        NOW(),
        NEW.venta_id
    );
END $$

DELIMITER ;

-- Control stock
DELIMITER $$

CREATE TRIGGER trg_control_stock
AFTER INSERT ON movstock
FOR EACH ROW
BEGIN
    UPDATE producto
    SET reponer = TRUE
    WHERE producto_id = NEW.producto_id
    AND (
        SELECT SUM(cantidad)
        FROM movstock
        WHERE producto_id = NEW.producto_id
    ) <= stock_minimo;
END $$

DELIMITER ;

-- COMPRA 2
INSERT INTO compra (proveedor_id, total, estado_pago)
VALUES (2, 150000.00, 'PAGADO');

INSERT INTO detalle_compra (compra_id, producto_id, cantidad, costo_unitario, subtotal) VALUES
(2, 2, 10, 20000.00, 200000.00),
(2, 3, 15, 8000.00, 120000.00);

INSERT INTO movstock (producto_id, deposito_id, tipo_mov, cantidad, compra_id) VALUES
(2,1,'ENTRADA',10,2),
(3,1,'ENTRADA',15,2);


-- COMPRA 3
INSERT INTO compra (proveedor_id, total, estado_pago)
VALUES (3, 90000.00, 'PAGADO');

INSERT INTO detalle_compra (compra_id, producto_id, cantidad, costo_unitario, subtotal) VALUES
(3, 4, 5, 60000.00, 300000.00),
(3, 5, 12, 7000.00, 84000.00);

INSERT INTO movstock (producto_id, deposito_id, tipo_mov, cantidad, compra_id) VALUES
(4,1,'ENTRADA',5,3),
(5,1,'ENTRADA',12,3);


-- COMPRA 4
INSERT INTO compra (proveedor_id, total, estado_pago)
VALUES (4, 120000.00, 'PAGADO');

INSERT INTO detalle_compra (compra_id, producto_id, cantidad, costo_unitario, subtotal) VALUES
(4, 6, 8, 15000.00, 120000.00),
(4, 7, 4, 90000.00, 360000.00);

INSERT INTO movstock (producto_id, deposito_id, tipo_mov, cantidad, compra_id) VALUES
(6,1,'ENTRADA',8,4),
(7,1,'ENTRADA',4,4);


-- COMPRA 5
INSERT INTO compra (proveedor_id, total, estado_pago)
VALUES (5, 80000.00, 'PAGADO');

INSERT INTO detalle_compra (compra_id, producto_id, cantidad, costo_unitario, subtotal) VALUES
(5, 8, 6, 250000.00, 1500000.00),
(5, 9, 10, 120000.00, 1200000.00);

INSERT INTO movstock (producto_id, deposito_id, tipo_mov, cantidad, compra_id) VALUES
(8,1,'ENTRADA',6,5),
(9,1,'ENTRADA',10,5);

-- VENTA 2
INSERT INTO venta (cliente_id, metodo_pago_id, total, estado_pago, vendedor_id, envio_id)
VALUES (2,1,26000.00,'PAGADO',2,2);

INSERT INTO detalle_venta (venta_id, producto_id, cantidad, precio_unitario, subtotal)
VALUES (2,2,2,25000.00,50000.00);


-- VENTA 3
INSERT INTO venta (cliente_id, metodo_pago_id, total, estado_pago, vendedor_id, envio_id)
VALUES (3,2,13000.00,'PAGADO',3,1);

INSERT INTO detalle_venta (venta_id, producto_id, cantidad, precio_unitario, subtotal)
VALUES (3,1,5,13000.00,65000.00);


-- VENTA 4
INSERT INTO venta (cliente_id, metodo_pago_id, total, estado_pago, vendedor_id, envio_id)
VALUES (4,1,50000.00,'PAGADO',4,2);

INSERT INTO detalle_venta (venta_id, producto_id, cantidad, precio_unitario, subtotal)
VALUES (4,3,10,12000.00,120000.00);


-- VENTA 5
INSERT INTO venta (cliente_id, metodo_pago_id, total, estado_pago, vendedor_id, envio_id)
VALUES (5,2,60000.00,'PAGADO',5,1);

INSERT INTO detalle_venta (venta_id, producto_id, cantidad, precio_unitario, subtotal)
VALUES (5,4,3,80000.00,240000.00);

-- VENTA 6
INSERT INTO venta (cliente_id, metodo_pago_id, total, estado_pago, vendedor_id, envio_id)
VALUES (1,2,39000,'PAGADO',1,1);

INSERT INTO detalle_venta (venta_id, producto_id, cantidad, precio_unitario, subtotal)
VALUES (6,1,3,13000,39000);


-- VENTA 7
INSERT INTO venta (cliente_id, metodo_pago_id, total, estado_pago, vendedor_id, envio_id)
VALUES (2,1,50000,'PAGADO',1,2);

INSERT INTO detalle_venta (venta_id, producto_id, cantidad, precio_unitario, subtotal)
VALUES (7,2,2,25000,50000);


-- VENTA 8
INSERT INTO venta (cliente_id, metodo_pago_id, total, estado_pago, vendedor_id, envio_id)
VALUES (1,2,26000,'PAGADO',2,1);

INSERT INTO detalle_venta (venta_id, producto_id, cantidad, precio_unitario, subtotal)
VALUES (8,1,2,13000,26000);


-- VENTA 9
INSERT INTO venta (cliente_id, metodo_pago_id, total, estado_pago, vendedor_id, envio_id)
VALUES (3,1,25000,'PAGADO',3,2);

INSERT INTO detalle_venta (venta_id, producto_id, cantidad, precio_unitario, subtotal)
VALUES (9,2,1,25000,25000);


-- VENTA 10
INSERT INTO venta (cliente_id, metodo_pago_id, total, estado_pago, vendedor_id, envio_id)
VALUES (4,2,78000,'PAGADO',1,1);

INSERT INTO detalle_venta (venta_id, producto_id, cantidad, precio_unitario, subtotal)
VALUES (10,1,6,13000,78000);


-- VENTA 11
INSERT INTO venta (cliente_id, metodo_pago_id, total, estado_pago, vendedor_id, envio_id)
VALUES (5,1,25000,'PAGADO',4,2);

INSERT INTO detalle_venta (venta_id, producto_id, cantidad, precio_unitario, subtotal)
VALUES (11,2,1,25000,25000);


-- VENTA 12
INSERT INTO venta (cliente_id, metodo_pago_id, total, estado_pago, vendedor_id, envio_id)
VALUES (2,2,39000,'PAGADO',1,1);

INSERT INTO detalle_venta (venta_id, producto_id, cantidad, precio_unitario, subtotal)
VALUES (12,1,3,13000,39000);


-- VENTA 13
INSERT INTO venta (cliente_id, metodo_pago_id, total, estado_pago, vendedor_id, envio_id)
VALUES (6,1,25000,'PAGADO',2,2);

INSERT INTO detalle_venta (venta_id, producto_id, cantidad, precio_unitario, subtotal)
VALUES (13,2,1,25000,25000);


-- VENTA 14
INSERT INTO venta (cliente_id, metodo_pago_id, total, estado_pago, vendedor_id, envio_id)
VALUES (1,2,52000,'PAGADO',1,1);

INSERT INTO detalle_venta (venta_id, producto_id, cantidad, precio_unitario, subtotal)
VALUES (14,1,4,13000,52000);


-- VENTA 15
INSERT INTO venta (cliente_id, metodo_pago_id, total, estado_pago, vendedor_id, envio_id)
VALUES (7,1,25000,'PAGADO',3,2);

INSERT INTO detalle_venta (venta_id, producto_id, cantidad, precio_unitario, subtotal)
VALUES (15,2,1,25000,25000);


-- VENTA 16
INSERT INTO venta (cliente_id, metodo_pago_id, total, estado_pago, vendedor_id, envio_id)
VALUES (2,2,13000,'PAGADO',1,1);

INSERT INTO detalle_venta (venta_id, producto_id, cantidad, precio_unitario, subtotal)
VALUES (16,1,1,13000,13000);


-- VENTA 17
INSERT INTO venta (cliente_id, metodo_pago_id, total, estado_pago, vendedor_id, envio_id)
VALUES (8,1,25000,'PAGADO',4,2);

INSERT INTO detalle_venta (venta_id, producto_id, cantidad, precio_unitario, subtotal)
VALUES (17,2,1,25000,25000);


-- VENTA 18
INSERT INTO venta (cliente_id, metodo_pago_id, total, estado_pago, vendedor_id, envio_id)
VALUES (1,2,13000,'PAGADO',1,1);

INSERT INTO detalle_venta (venta_id, producto_id, cantidad, precio_unitario, subtotal)
VALUES (18,1,1,13000,13000);


-- VENTA 19
INSERT INTO venta (cliente_id, metodo_pago_id, total, estado_pago, vendedor_id, envio_id)
VALUES (9,1,25000,'PAGADO',2,2);

INSERT INTO detalle_venta (venta_id, producto_id, cantidad, precio_unitario, subtotal)
VALUES (19,2,1,25000,25000);


-- VENTA 20
INSERT INTO venta (cliente_id, metodo_pago_id, total, estado_pago, vendedor_id, envio_id)
VALUES (10,2,39000,'PAGADO',3,1);

INSERT INTO detalle_venta (venta_id, producto_id, cantidad, precio_unitario, subtotal)
VALUES (20,1,3,13000,39000);
