-- Para evitar errores si ya existen es un metodo de limpieza
DROP VIEW IF EXISTS vista_clientes_pedidos;
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS pedidos;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;

-- CREACION TABLAS ´´EXISTENTES´´
CREATE TABLE clientes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre VARCHAR(50), 
    apellido VARCHAR(50), 
    direccion VARCHAR(100), 
    correo VARCHAR(100), 
    telefono VARCHAR(20)
);
CREATE TABLE productos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre VARCHAR(50), 
    descripcion TEXT, 
    precio DECIMAL(10,2), 
    categoria VARCHAR(50), 
    stock INTEGER
);
CREATE TABLE pedidos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente INTEGER, 
    fecha DATE, 
    estado VARCHAR(20), 
    total DECIMAL(10,2),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id) ON DELETE CASCADE
);
CREATE TABLE ventas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_pedido INTEGER, 
    id_producto INTEGER, 
    cantidad INTEGER, 
    precio_venta DECIMAL(10,2),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id) ON DELETE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES productos(id) ON DELETE CASCADE
);





-- INT DATOS
INSERT INTO clientes (nombre, apellido, direccion, correo, telefono) VALUES 
('Juan', 'Pérez', 'Calle 1', 'juan@mail.com', '1234'),
('Ana', 'Gómez', 'Calle 2', 'ana@mail.com', '5678');

INSERT INTO productos (nombre, descripcion, precio, categoria, stock) VALUES 
('Polo', 'Algodón', 10.00, 'Camisetas', 50),
('Jean', 'Azul', 20.00, 'Pantalones', 30);

INSERT INTO pedidos (id_cliente, fecha, estado, total) VALUES 
(1, date('now', '-10 days'), 'Completado', 10.00),
(2, date('now'), 'Pendiente', 0.00);

INSERT INTO ventas (id_pedido, id_producto, cantidad, precio_venta) VALUES 
(1, 1, 1, 10.00);

-- SELECT Y WHERE


-- Clientes últimos 30 días
SELECT c.nombre, c.apellido, c.direccion, c.correo 
FROM clientes c JOIN pedidos p ON c.id = p.id_cliente 
WHERE p.fecha >= date('now', '-30 days');

-- Productos más vendidos el último mes
SELECT pr.nombre, SUM(v.cantidad) AS cantidad_ventas, SUM(v.cantidad * v.precio_venta) AS total_vendido 
FROM productos pr JOIN ventas v ON pr.id = v.id_producto JOIN pedidos pe ON v.id_pedido = pe.id 
WHERE pe.fecha >= date('now', '-1 month') GROUP BY pr.id;

-- Clientes con más pedidos último año
SELECT c.nombre, c.apellido, COUNT(p.id) AS cantidad_pedidos 
FROM clientes c JOIN pedidos p ON c.id = p.id_cliente 
WHERE p.fecha >= date('now', '-1 year') GROUP BY c.id;

-- UPDATE
UPDATE productos SET precio = precio * 1.10 WHERE categoria = 'Camisetas';

-- DELETE
DELETE FROM pedidos WHERE id NOT IN (SELECT id_pedido FROM ventas);

-- VISTA 
CREATE VIEW vista_clientes_pedidos AS 
SELECT (c.nombre || ' ' || c.apellido) AS nombre_completo, p.fecha, p.total 
FROM clientes c JOIN pedidos p ON c.id = p.id_cliente;
SELECT * FROM vista_clientes_pedidos;
