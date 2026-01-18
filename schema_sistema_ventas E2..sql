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
('Proveedor Tech SA', 'Av. Siempre Viva 123', 'Argentina'),
('Proveedor Hogar SRL', 'Calle Falsa 456', 'Argentina');

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
('Auriculares Bluetooth', 10, 1, FALSE),
('Licuadora', 5, 2, FALSE);

-- Lista de precios
INSERT INTO lista_precio (producto_id, costo_unitario, porcentaje_id, precio_unitario) VALUES
(1, 10000.00, 1, 13000.00),
(2, 20000.00, 2, 25000.00);

-- Vendedores
INSERT INTO vendedor (nombre, apellido, ranking, comision, zona_id) VALUES
('Juan', 'Pérez', 1, 5.00, 1),
('Ana', 'Gómez', 2, 4.50, 2);

-- Clientes
INSERT INTO cliente (apellido, nombre, genero, direccion, email, fecha_nacimiento) VALUES
('Lopez', 'María', 'F', 'Calle 123', 'maria@mail.com', '1992-06-15'),
('García', 'Pedro', 'M', 'Av. 456', 'pedro@mail.com', '1988-03-22');

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

-- Vistas
-- vemtas detalladas

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

-- stock bajo

CREATE VIEW stock_bajo AS
SELECT 
    p.producto_id,
    p.nombre,
    SUM(ms.cantidad) AS stock_actual,
    p.stock_minimo
FROM producto p
JOIN movstock ms ON p.producto_id = ms.producto_id
GROUP BY p.producto_id, p.nombre, p.stock_minimo
HAVING stock_actual <= p.stock_minimo;

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
        NEW.cantidad * -1,
        NOW(),
        NEW.venta_id
    );
END $$

-- Marcar Reponer

DELIMITER $$

CREATE TRIGGER trg_control_stock
AFTER INSERT ON movstock
FOR EACH ROW
BEGIN
    UPDATE producto p
    SET reponer = TRUE
    WHERE p.producto_id = NEW.producto_id
    AND (
        SELECT SUM(cantidad)
        FROM movstock
        WHERE producto_id = NEW.producto_id
    ) <= p.stock_minimo;
END $$

