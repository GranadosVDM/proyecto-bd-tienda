# Diccionario de Datos

## Proyecto Tienda Funko Pop

---

## 1. Descripción general

Este proyecto corresponde a una base de datos para la gestión de una tienda de Funko Pop.  
El sistema permite administrar clientes, categorías, productos, pedidos, detalles de pedido, facturas e histórico de precios.

Además, incluye:

- procedimientos almacenados,
- funciones,
- cursores,
- vistas,
- secuencias,
- triggers,
- y conexión Java/JDBC con Oracle.

---

## 2. Tablas del sistema

### 2.1 Tabla: CATEGORIA

**Descripción:** Almacena las categorías de los productos.

**Columnas:**

- `ID_CATEGORIA` → NUMBER → Identificador único de la categoría.
- `NOMBRE` → VARCHAR2(100) → Nombre de la categoría.
- `DESCRIPCION` → VARCHAR2(200) → Descripción de la categoría.
- `ESTADO` → VARCHAR2(10) → Estado de la categoría (`ACTIVA` o `INACTIVA`).

**Restricciones:**

- `PK_CATEGORIA` → Clave primaria sobre `ID_CATEGORIA`.
- `UQ_CATEGORIA_NOMBRE` → Restricción única sobre `NOMBRE`.
- `CK_CATEGORIA_ESTADO` → Restricción check para permitir solo `ACTIVA` o `INACTIVA`.

---

### 2.2 Tabla: CLIENTE

**Descripción:** Almacena la información de los clientes de la tienda.

**Columnas:**

- `ID_CLIENTE` → NUMBER → Identificador único del cliente.
- `NOMBRE` → VARCHAR2(100) → Nombre del cliente.
- `CORREO` → VARCHAR2(100) → Correo electrónico del cliente.
- `TELEFONO` → VARCHAR2(20) → Número telefónico del cliente.

**Restricciones:**

- `PK_CLIENTE` → Clave primaria sobre `ID_CLIENTE`.
- `UQ_CLIENTE_CORREO` → Restricción única sobre `CORREO`.

---

### 2.3 Tabla: PRODUCTO

**Descripción:** Almacena los productos Funko Pop disponibles en inventario.

**Columnas:**

- `ID_PRODUCTO` → NUMBER → Identificador único del producto.
- `NOMBRE` → VARCHAR2(100) → Nombre del producto.
- `PRECIO` → NUMBER(10,2) → Precio del producto.
- `STOCK` → NUMBER → Cantidad disponible en inventario.
- `ID_CATEGORIA` → NUMBER → Categoría a la que pertenece el producto.

**Restricciones:**

- `PK_PRODUCTO` → Clave primaria sobre `ID_PRODUCTO`.
- `FK_PRODUCTO_CATEGORIA` → Clave foránea que referencia `CATEGORIA(ID_CATEGORIA)`.
- `CK_PRODUCTO_PRECIO` → Verifica que el precio sea mayor o igual a 0.
- `CK_PRODUCTO_STOCK` → Verifica que el stock sea mayor o igual a 0.

---

### 2.4 Tabla: PEDIDO

**Descripción:** Registra los pedidos realizados por los clientes.

**Columnas:**

- `ID_PEDIDO` → NUMBER → Identificador único del pedido.
- `FECHA` → DATE → Fecha del pedido.
- `ID_CLIENTE` → NUMBER → Cliente que realizó el pedido.
- `TOTAL` → NUMBER(10,2) → Total monetario del pedido.

**Restricciones:**

- `PK_PEDIDO` → Clave primaria sobre `ID_PEDIDO`.
- `FK_PEDIDO_CLIENTE` → Clave foránea que referencia `CLIENTE(ID_CLIENTE)`.

---

### 2.5 Tabla: DETALLE_PEDIDO

**Descripción:** Almacena el detalle de productos incluidos en cada pedido.

**Columnas:**

- `ID_DETALLE` → NUMBER → Identificador único del detalle.
- `ID_PEDIDO` → NUMBER → Pedido al que pertenece el detalle.
- `ID_PRODUCTO` → NUMBER → Producto incluido en el pedido.
- `CANTIDAD` → NUMBER → Cantidad solicitada del producto.
- `PRECIO_UNITARIO` → NUMBER(10,2) → Precio unitario del producto al momento de la venta.
- `SUBTOTAL` → NUMBER(10,2) → Subtotal calculado (`CANTIDAD * PRECIO_UNITARIO`).

**Restricciones:**

- `PK_DETALLE_PEDIDO` → Clave primaria sobre `ID_DETALLE`.
- `FK_DETALLE_PEDIDO_PEDIDO` → Clave foránea que referencia `PEDIDO(ID_PEDIDO)`.
- `FK_DETALLE_PEDIDO_PRODUCTO` → Clave foránea que referencia `PRODUCTO(ID_PRODUCTO)`.
- `CK_DETALLE_CANTIDAD` → Verifica que la cantidad sea mayor que 0.
- `CK_DETALLE_PRECIO` → Verifica que el precio unitario sea mayor o igual a 0.
- `CK_DETALLE_SUBTOTAL` → Verifica que el subtotal sea mayor o igual a 0.

---

### 2.6 Tabla: FACTURA

**Descripción:** Almacena la factura generada a partir de un pedido.

**Columnas:**

- `ID_FACTURA` → NUMBER → Identificador único de la factura.
- `ID_PEDIDO` → NUMBER → Pedido asociado a la factura.
- `FECHA` → DATE → Fecha de la factura.
- `TOTAL` → NUMBER(10,2) → Total de la factura.

**Restricciones:**

- `PK_FACTURA` → Clave primaria sobre `ID_FACTURA`.
- `FK_FACTURA_PEDIDO` → Clave foránea que referencia `PEDIDO(ID_PEDIDO)`.
- `UQ_FACTURA_ID_PEDIDO` → Restricción única para impedir más de una factura por pedido.

---

### 2.7 Tabla: HISTORICO_PRECIOS

**Descripción:** Guarda los cambios de precios realizados sobre los productos.

**Columnas:**

- `ID_HISTORICO` → NUMBER → Identificador único del histórico.
- `ID_PRODUCTO` → NUMBER → Producto afectado.
- `PRECIO_ANTERIOR` → NUMBER(10,2) → Precio anterior del producto.
- `PRECIO_NUEVO` → NUMBER(10,2) → Nuevo precio del producto.
- `FECHA_CAMBIO` → DATE → Fecha en que se realizó el cambio.

**Restricciones:**

- `PK_HISTORICO_PRECIOS` → Clave primaria sobre `ID_HISTORICO`.
- `FK_HISTORICO_PRODUCTO` → Clave foránea que referencia `PRODUCTO(ID_PRODUCTO)`.

---

## 3. Relaciones entre tablas

Las relaciones principales del sistema son las siguientes:

- `PRODUCTO.ID_CATEGORIA` → `CATEGORIA.ID_CATEGORIA`
- `PEDIDO.ID_CLIENTE` → `CLIENTE.ID_CLIENTE`
- `DETALLE_PEDIDO.ID_PEDIDO` → `PEDIDO.ID_PEDIDO`
- `DETALLE_PEDIDO.ID_PRODUCTO` → `PRODUCTO.ID_PRODUCTO`
- `FACTURA.ID_PEDIDO` → `PEDIDO.ID_PEDIDO`
- `HISTORICO_PRECIOS.ID_PRODUCTO` → `PRODUCTO.ID_PRODUCTO`

---

## 4. Objetos PL/SQL del sistema

### 4.1 Procedimientos almacenados

#### `INSERTAR_PEDIDO`

Inserta un nuevo pedido para un cliente.

#### `INSERTAR_DETALLE`

Inserta un detalle de pedido con producto, cantidad, precio unitario y subtotal.

#### `ACTUALIZAR_TOTAL_PEDIDO`

Calcula y actualiza el total de un pedido sumando sus subtotales.

#### `DESCONTAR_STOCK`

Descuenta stock del producto cuando se registra una venta.

#### `AUMENTAR_STOCK`

Aumenta stock del producto.

#### `REGISTRAR_DETALLE_VENTA`

Registra el detalle de venta y actualiza stock y total del pedido.

#### `ELIMINAR_PEDIDO_VACIO`

Elimina un pedido si no posee detalles asociados.

#### `INSERTAR_FACTURA`

Genera una factura a partir de un pedido válido con total calculado.

#### `MOSTRAR_FACTURAS_CLIENTE`

Usa cursor para mostrar las facturas de un cliente con `DBMS_OUTPUT`.

#### `MOSTRAR_INVENTARIO_CURSOR`

Usa cursor para mostrar el inventario de productos con `DBMS_OUTPUT`.

---

### 4.2 Funciones

#### `FN_TOTAL_PEDIDO`

Devuelve el total de un pedido.

**Validaciones:**

- Si el pedido no existe, genera error.
- Si el pedido no tiene total calculado, genera error.

#### `FN_CANTIDAD_FACTURAS_CLIENTE`

Devuelve la cantidad de facturas registradas para un cliente.

---

### 4.3 Triggers

#### `TRG_CATEGORIA_BI`

Trigger `BEFORE INSERT` sobre `CATEGORIA`.  
Asigna automáticamente el valor de `ID_CATEGORIA` usando la secuencia `SEQ_CATEGORIA`.

#### `TRG_FACTURA_BI`

Trigger `BEFORE INSERT` sobre `FACTURA`.  
Asigna automáticamente el valor de `ID_FACTURA` usando la secuencia `SEQ_FACTURA`.

---

### 4.4 Secuencias

#### `SEQ_CATEGORIA`

Secuencia utilizada para generar automáticamente el identificador de la tabla `CATEGORIA`.

#### `SEQ_FACTURA`

Secuencia utilizada para generar automáticamente el identificador de la tabla `FACTURA`.

---

## 5. Vistas

### `VISTA_PEDIDOS`

Muestra información resumida de los pedidos junto con el nombre del cliente.

**Campos mostrados:**

- ID del pedido
- fecha
- ID del cliente
- nombre del cliente
- total del pedido

### `VISTA_INVENTARIO`

Muestra información resumida del inventario junto con la categoría del producto.

**Campos mostrados:**

- ID del producto
- nombre del producto
- precio
- stock
- categoría

---

## 6. Reglas de negocio implementadas

- No se puede registrar un detalle si el stock es insuficiente.
- No se puede generar una factura si el pedido no existe.
- No se puede generar una factura si el pedido no tiene total calculado.
- No se puede generar más de una factura por pedido.
- No se puede eliminar un pedido si tiene detalles asociados.
- El stock se actualiza automáticamente al registrar una venta.
- El total del pedido se actualiza según los subtotales de sus detalles.
- Las categorías solo pueden estar en estado `ACTIVA` o `INACTIVA`.

---

## 7. Validaciones probadas en el proyecto

Durante las pruebas del sistema se verificó correctamente lo siguiente:

- inserción de pedidos,
- inserción de detalles,
- actualización de total del pedido,
- descuento de stock,
- aumento de stock,
- validación de stock insuficiente,
- eliminación de pedidos vacíos,
- funcionamiento de vistas,
- inserción de categorías,
- generación de facturas,
- validación de factura duplicada,
- validación de pedido inexistente,
- validación de pedido sin total calculado,
- ejecución de funciones,
- ejecución de cursores,
- conexión Java/JDBC a Oracle,
- consulta de datos desde Java,
- ejecución de procedimientos desde Java,
- ejecución de funciones desde Java.

---

## 8. Conexión Java/JDBC

La aplicación Java se conectó exitosamente a Oracle utilizando:

- driver JDBC de Oracle,
- wallet de conexión,
- configuración de librerías en Visual Studio Code.

Se validó:

- conexión exitosa,
- consultas `SELECT`,
- ejecución de procedimientos almacenados,
- ejecución de funciones Oracle desde Java.

---

## 9. Archivos principales del proyecto

### Base de datos

- `script_final.sql`
- `diccionario_datos.md`

### Java

- `ConexionBD.java`
- `Main.java`

### Configuración

- carpeta `lib` con los archivos `.jar`
- carpeta `.vscode` con `settings.json`
- wallet de Oracle para la conexión segura

---

## 10. Conclusión

La base de datos de la tienda Funko Pop quedó estructurada y funcional, incorporando objetos SQL y PL/SQL para manejo de datos, validaciones de negocio, automatización de procesos y conexión desde una aplicación Java mediante JDBC.
