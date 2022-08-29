# Jardinería DB

La base de datos fue tomada de [https://josejuansanchez.org/bd/ejercicios-consultas-sql/index.html#jardinería](https://josejuansanchez.org/bd/ejercicios-consultas-sql/index.html#jardiner%C3%ADa)  

# Conociendo la base de datos

Se tienen 8 tablas, las cuales corresponden a una venta de flores de una jardinería. Estas contienen 

- **Cliente**
    - Código cliente
        - Código identificador único para cada cliente.
    - Nombre cliente
        - Nombre del comprador (Distribuidora o personal)
    - Nombre contacto
        - Nombre de la persona que realiza la compra.
    - Apellido contacto
        - Apellido de la persona que realiza la compra.
    - Teléfono
        - Télefono de la empresa distribuidora.
    - Fax
        - Número de fax de la empresa.
    - Línea de dirección 1
        - Número de casa, edificio, calle.
    - Línea de dirección 2
        - Número de bloque, nombre del área.
    - Ciudad
    - Región
    - País
    - Código postal
    - Código de empleado
        - Foreign Key para el número de empleado que lo atendió
    - Límite de crédito
- **Pedido**
    - Código de pedido
        - Código único para cada pedido realizado
    - Fecha de pedido
    - Fecha esperada de entrega
    - Fecha real de entrega
    - Estado de entrega
        - Puede ser entregado, rechazado o pendiente.
    - Comentario
        - Comentario que indica cómo se entregó el paquete.
    - Código de cliente
        - Foreign Key que conecta la tabla pedido con cliente.
- **Detalle del pedido**
    - Código de pedido
        - Código único del detalle del pedido el cual se comparte con el de la tabla **pedido**.
    - Código del producto
        - Código de cada uno de los productos.
    - Cantidad
        - Cantidad de productos
    - Precio por unidad
    - Número de línea
- **Producto**
    - Código del producto
        - Primary Key que comparte con el código del producto de la tabla **detalle del producto.**
    - Nombre
        - Nombre del producto
    - Gamma
        - Categoría a la que pertenece el producto
    - Dimensiones
    - Proveedor
    - Descripción del producto
    - Cantidad en Stock
    - Precio de venta
    - Precio de venta a proveedores
- **Gamma del producto**
    - Gamma
        - Categoría
    - Descripción
    - Descripción html
    - Imagen
- **Empleados**
    - Código de empleado
        - Primary Key utilizada en la tabla de clientes.
    - Nombre empleado
    - Apelido 1, apellido 2
    - Extensior
    - Email
    - Codígo de oficina
    - Código de jefe
        - Cada empleado tiene un jefe
    - Puesto
- **Oficina**
    - Codigo de la oficina, referenciando a la tabla de empleados
    - Ciudad, país, código postal, télefono, líneas de dirección
    - 

Las tablas pueden ser importadas mediante las siguientes líneas de código:

```sql
DROP DATABASE IF EXISTS jardineria;
CREATE DATABASE jardineria CHARACTER SET utf8mb4;
USE jardineria;

CREATE TABLE oficina (
  codigo_oficina VARCHAR(10) NOT NULL,
  ciudad VARCHAR(30) NOT NULL,
  pais VARCHAR(50) NOT NULL,
  region VARCHAR(50) DEFAULT NULL,
  codigo_postal VARCHAR(10) NOT NULL,
  telefono VARCHAR(20) NOT NULL,
  linea_direccion1 VARCHAR(50) NOT NULL,
  linea_direccion2 VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (codigo_oficina)
);

CREATE TABLE empleado (
  codigo_empleado INTEGER NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  apellido1 VARCHAR(50) NOT NULL,
  apellido2 VARCHAR(50) DEFAULT NULL,
  extension VARCHAR(10) NOT NULL,
  email VARCHAR(100) NOT NULL,
  codigo_oficina VARCHAR(10) NOT NULL,
  codigo_jefe INTEGER DEFAULT NULL,
  puesto VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (codigo_empleado),
  FOREIGN KEY (codigo_oficina) REFERENCES oficina (codigo_oficina),
  FOREIGN KEY (codigo_jefe) REFERENCES empleado (codigo_empleado)
);

CREATE TABLE gama_producto (
  gama VARCHAR(50) NOT NULL,
  descripcion_texto TEXT,
  descripcion_html TEXT,
  imagen VARCHAR(256),
  PRIMARY KEY (gama)
);

CREATE TABLE cliente (
  codigo_cliente INTEGER NOT NULL,
  nombre_cliente VARCHAR(50) NOT NULL,
  nombre_contacto VARCHAR(30) DEFAULT NULL,
  apellido_contacto VARCHAR(30) DEFAULT NULL,
  telefono VARCHAR(15) NOT NULL,
  fax VARCHAR(15) NOT NULL,
  linea_direccion1 VARCHAR(50) NOT NULL,
  linea_direccion2 VARCHAR(50) DEFAULT NULL,
  ciudad VARCHAR(50) NOT NULL,
  region VARCHAR(50) DEFAULT NULL,
  pais VARCHAR(50) DEFAULT NULL,
  codigo_postal VARCHAR(10) DEFAULT NULL,
  codigo_empleado_rep_ventas INTEGER DEFAULT NULL,
  limite_credito NUMERIC(15,2) DEFAULT NULL,
  PRIMARY KEY (codigo_cliente),
  FOREIGN KEY (codigo_empleado_rep_ventas) REFERENCES empleado (codigo_empleado)
);

CREATE TABLE pedido (
  codigo_pedido INTEGER NOT NULL,
  fecha_pedido date NOT NULL,
  fecha_esperada date NOT NULL,
  fecha_entrega date DEFAULT NULL,
  estado VARCHAR(15) NOT NULL,
  comentarios TEXT,
  codigo_cliente INTEGER NOT NULL,
  PRIMARY KEY (codigo_pedido),
  FOREIGN KEY (codigo_cliente) REFERENCES cliente (codigo_cliente)
);

CREATE TABLE producto (
  codigo_producto VARCHAR(15) NOT NULL,
  nombre VARCHAR(70) NOT NULL,
  gama VARCHAR(50) NOT NULL,
  dimensiones VARCHAR(25) NULL,
  proveedor VARCHAR(50) DEFAULT NULL,
  descripcion text NULL,
  cantidad_en_stock SMALLINT NOT NULL,
  precio_venta NUMERIC(15,2) NOT NULL,
  precio_proveedor NUMERIC(15,2) DEFAULT NULL,
  PRIMARY KEY (codigo_producto),
  FOREIGN KEY (gama) REFERENCES gama_producto (gama)
);

CREATE TABLE detalle_pedido (
  codigo_pedido INTEGER NOT NULL,
  codigo_producto VARCHAR(15) NOT NULL,
  cantidad INTEGER NOT NULL,
  precio_unidad NUMERIC(15,2) NOT NULL,
  numero_linea SMALLINT NOT NULL,
  PRIMARY KEY (codigo_pedido, codigo_producto),
  FOREIGN KEY (codigo_pedido) REFERENCES pedido (codigo_pedido),
  FOREIGN KEY (codigo_producto) REFERENCES producto (codigo_producto)
);

CREATE TABLE pago (
  codigo_cliente INTEGER NOT NULL,
  forma_pago VARCHAR(40) NOT NULL,
  id_transaccion VARCHAR(50) NOT NULL,
  fecha_pago date NOT NULL,
  total NUMERIC(15,2) NOT NULL,
  PRIMARY KEY (codigo_cliente, id_transaccion),
  FOREIGN KEY (codigo_cliente) REFERENCES cliente (codigo_cliente)
);
```

Los datos para cada tabla pueden ser encontrados en la carpeta. 

![jardineria.png](Jardineri%CC%81a%20DB%20b4d47b70e8bc4f67a97fe445dc74f7d9/jardineria.png)