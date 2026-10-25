BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS clientes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre VARCHAR(50), 
    apellido VARCHAR(50), 
    direccion VARCHAR(100), 
    correo VARCHAR(100), 
    telefono VARCHAR(20)
);
CREATE TABLE IF NOT EXISTS pedidos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente INTEGER, 
    fecha DATE, 
    estado VARCHAR(20), 
    total DECIMAL(10,2),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS productos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre VARCHAR(50), 
    descripcion TEXT, 
    precio DECIMAL(10,2), 
    categoria VARCHAR(50), 
    stock INTEGER
);
CREATE TABLE IF NOT EXISTS ventas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_pedido INTEGER, 
    id_producto INTEGER, 
    cantidad INTEGER, 
    precio_venta DECIMAL(10,2),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id) ON DELETE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES productos(id) ON DELETE CASCADE
);
INSERT INTO "clientes" ("id","nombre","apellido","direccion","correo","telefono") VALUES (1,'Juan','Pérez','Calle 1','juan@mail.com','1234'),
 (2,'Ana','Gómez','Calle 2','ana@mail.com','5678');
INSERT INTO "pedidos" ("id","id_cliente","fecha","estado","total") VALUES (1,1,'2026-10-15','Completado',10);
INSERT INTO "productos" ("id","nombre","descripcion","precio","categoria","stock") VALUES (1,'Polo','Algodón',11,'Camisetas',50),
 (2,'Jean','Azul',20,'Pantalones',30);
INSERT INTO "ventas" ("id","id_pedido","id_producto","cantidad","precio_venta") VALUES (1,1,1,1,10);
CREATE VIEW vista_clientes_pedidos AS 
SELECT (c.nombre || ' ' || c.apellido) AS nombre_completo, p.fecha, p.total 
FROM clientes c JOIN pedidos p ON c.id = p.id_cliente;
COMMIT;
