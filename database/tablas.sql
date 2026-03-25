-- TABLA CLIENTE
CREATE TABLE CLIENTE (
    id_cliente NUMBER PRIMARY KEY,
    nombre VARCHAR2(100),
    correo VARCHAR2(100) UNIQUE,
    contrasena VARCHAR2(100),
    rol VARCHAR2(20)
);
-- TABLA CATEGORIA
CREATE TABLE CATEGORIA (
    id_categoria NUMBER PRIMARY KEY,
    nombre VARCHAR2(100)
);
-- TABLA PRODUCTO
CREATE TABLE PRODUCTO (
    id_producto NUMBER PRIMARY KEY,
    nombre VARCHAR2(100),
    descripcion VARCHAR2(200),
    precio NUMBER,
    stock NUMBER,
    id_categoria NUMBER,
    CONSTRAINT fk_categoria FOREIGN KEY (id_categoria) REFERENCES CATEGORIA(id_categoria)
);
-- TABLA PEDIDO
CREATE TABLE PEDIDO (
    id_pedido NUMBER PRIMARY KEY,
    fecha DATE,
    id_cliente NUMBER,
    total NUMBER,
    CONSTRAINT fk_cliente FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente)
);
-- TABLA DETALLE_PEDIDO
CREATE TABLE DETALLE_PEDIDO (
    id_detalle NUMBER PRIMARY KEY,
    id_pedido NUMBER,
    id_producto NUMBER,
    cantidad NUMBER,
    precio_unitario NUMBER,
    CONSTRAINT fk_pedido FOREIGN KEY (id_pedido) REFERENCES PEDIDO(id_pedido),
    CONSTRAINT fk_producto FOREIGN KEY (id_producto) REFERENCES PRODUCTO(id_producto)
);
-- TABLA FACTURA
CREATE TABLE FACTURA (
    id_factura NUMBER PRIMARY KEY,
    id_pedido NUMBER,
    fecha DATE,
    total NUMBER,
    CONSTRAINT fk_factura_pedido FOREIGN KEY (id_pedido) REFERENCES PEDIDO(id_pedido)
);