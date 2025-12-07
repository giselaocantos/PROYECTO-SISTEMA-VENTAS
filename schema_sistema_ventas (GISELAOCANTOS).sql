
-- Proyecto: Sistema de Ventas y Stock 
-- Autor: Gisela Ocantos
-- Fecha: 2025-12-07

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

-- Fin del script
