-- PROCEDIMIENTO: INSERTAR CLIENTE
CREATE OR REPLACE PROCEDURE insertar_cliente (
        p_nombre IN VARCHAR2,
        p_correo IN VARCHAR2,
        p_contrasena IN VARCHAR2,
        p_rol IN VARCHAR2
    ) AS BEGIN
INSERT INTO CLIENTE (id_cliente, nombre, correo, contrasena, rol)
VALUES (
        seq_cliente.NEXTVAL,
        p_nombre,
        p_correo,
        p_contrasena,
        p_rol
    );
END;
-- PROCEDIMIENTO: ACTUALIZAR CLIENTE
CREATE OR REPLACE PROCEDURE actualizar_cliente (
        p_id IN NUMBER,
        p_nombre IN VARCHAR2,
        p_correo IN VARCHAR2,
        p_contrasena IN VARCHAR2,
        p_rol IN VARCHAR2
    ) AS BEGIN
UPDATE CLIENTE
SET nombre = p_nombre,
    correo = p_correo,
    contrasena = p_contrasena,
    rol = p_rol
WHERE id_cliente = p_id;
END;
/ -- PROCEDIMIENTO: ELIMINAR CLIENTE
CREATE OR REPLACE PROCEDURE eliminar_cliente (p_id IN NUMBER) AS BEGIN
DELETE FROM CLIENTE
WHERE id_cliente = p_id;
END;
/ -- PROCEDIMIENTO: CONSULTAR CLIENTES
CREATE OR REPLACE PROCEDURE consultar_clientes (p_cursor OUT SYS_REFCURSOR) AS BEGIN OPEN p_cursor FOR
SELECT *
FROM CLIENTE;
END;
/ -- PROCEDIMIENTO: INSERTAR PRODUCTO
CREATE OR REPLACE PROCEDURE insertar_producto (
        p_nombre IN VARCHAR2,
        p_precio IN NUMBER,
        p_stock IN NUMBER,
        p_id_categoria IN NUMBER
    ) AS BEGIN
INSERT INTO PRODUCTO (id_producto, nombre, precio, stock, id_categoria)
VALUES (
        seq_producto.NEXTVAL,
        p_nombre,
        p_precio,
        p_stock,
        p_id_categoria
    );
END;
/