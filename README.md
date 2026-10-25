# Base de Datos de Gestión de Pedidos y Ventas

Este script SQL inicializa una base de datos relacional básica para un sistema de ventas. Está escrito con sintaxis compatible con **SQLite** e incluye la creación de tablas, relaciones, una vista de consulta y datos de prueba.

## 🗄️ Estructura de la Base de Datos

El esquema consta de cuatro tablas principales interconectadas y una vista predefinida:

*   **`clientes`**: Almacena la información de contacto (nombre, apellido, dirección, correo, teléfono).
*   **`productos`**: Catálogo del inventario con descripción, precio, categoría y cantidad en stock.
*   **`pedidos`**: Cabecera de la compra realizada por un cliente. 
    *   *Relación*: Vinculada a `clientes` mediante `id_cliente`.
*   **`ventas`**: Detalle de los artículos comprados en cada pedido.
    *   *Relación*: Vinculada a `pedidos` (`id_pedido`) y `productos` (`id_producto`).

### 🔍 Vistas (Views)
*   **`vista_clientes_pedidos`**: Combina el nombre y apellido del cliente con la fecha y el total de sus pedidos para facilitar la lectura de reportes.

## ⚙️ Comportamiento de Borrado en Cascada
Las tablas dependientes (`pedidos` y `ventas`) están configuradas con `ON DELETE CASCADE`. Esto significa que si eliminas un cliente, se borrarán automáticamente todos sus pedidos, y a su vez, todos los detalles de venta asociados a esos pedidos.

## 🚀 Uso Rápido

1. Guarda el código provisto en un archivo de texto con extensión `.sql` (por ejemplo, `esquema_ventas.sql`).
2. Abre tu cliente de SQLite (como la terminal de SQLite, DB Browser for SQLite, o DBeaver).
3. Importa o ejecuta el archivo para generar la estructura y cargar los datos semilla al instante. 
