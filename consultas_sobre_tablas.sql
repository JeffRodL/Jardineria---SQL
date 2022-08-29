-- Consultas sobre una Tabla --


-- ¿Devuelve un listado con el código de oficina y la ciudad donde hay 
-- oficina?
select codigo_oficina, ciudad from oficina;


-- Devuelve un listado con la ciudad y el teléfono de las oficinas de españa.
select ciudad, telefono from oficina 
where pais = 'España';


-- ¿Devuelve un listado con el nombre, apellidos y email de los empleados
-- cuyo jefe tiene un código de jefe igual a 7?
select nombre, apellido1, apellido2, email
from empleado where codigo_jefe = 7;


-- Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa
select puesto, nombre, apellido1, apellido2, email 
from empleado where puesto = 'Director General';


-- Devuelve un listado con el nombre, apellido y puesto de aquellos
-- empleados que no sean representantes de ventas
select nombre, apellido1, apellido2, puesto
from empleado where puesto != 'Representante Ventas';


-- Devuelve un listado con el nombre de todos los clientes españoles
select nombre, pais
from empleado
left join oficina
on empleado.codigo_oficina = oficina.codigo_oficina
where pais = 'España';

-- Devuelve un listado con los distintos estados por los que pueda pasar
-- un pedido.
select count(distinct estado) as 'Estados' from pedido;



-- Devuelve un listado con el código de cliente de aquellos clientes que 
-- realizaron algún pago en 2008.
-- Utilizando la función year
select codigo_cliente, fecha_pago from pago 
where year(fecha_pago) = '2008';
-- utilizando la función date_fomat
select codigo_cliente, fecha_pago from pago
where date_format(fecha_pago, '%Y') = '2008';
-- sin utilizar ninguna de las funciones anteriores
select codigo_cliente, fecha_pago from pago
where extract(year from fecha_pago) = 2008;



-- Devuelve un listado con el código de pedido, código de cliente, fecha
-- esperada, fecha de entrega de los pedidos que no han sido entregados
-- a tiempo
select codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
from pedido
where fecha_entrega != fecha_esperada;



-- Devuelve un listado con el código de pedido, código de cliente, 
-- fecha esperada y fecha de entrega de los pedidos cuya fecha de 
-- entrega ha sido al menos dos días antes de la fecha esperada.
-- Utilizando la función adddate
select codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
from pedido
where adddate(fecha_esperada, interval -2 day) >= fecha_entrega;
-- utilizado date diff
select codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
from pedido
where datediff(fecha_esperada,fecha_entrega) >= 2;
-- Utilizando suma o resta
-- este método no es tan efectivo, porque trabaja solamente con días y no
-- con la fecha total.
select codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
from pedido
where day(fecha_esperada)-day(fecha_entrega) >= 2;



-- Devuelve un listado de todos los pedidos que fueron rechazados en 2009
select count(*) as 'Pedidos rechazados' from pedido 
where estado = 'Rechazado' and
year(fecha_pedido) = '2009';



-- Devuelve un listado de todos los pedidos que han sido entregados
-- en el mes de enero de cualquier año
select count(*) as 'Pedidos entregados en Enero' from pedido 
where estado = 'Entregado' and
month(fecha_pedido) = '01';



-- Devuelve un listado con todos los pagos que se realizaron en el año 2008
-- mediante paypal. Ordena el resultado de mayor a menor
select total 
from pago
where forma_pago = 'PayPal' and
year(fecha_pago) = '2008'
order by total desc;

-- Devuelve un listado con todas las formas de pago que aparecen en la tabla.
select distinct forma_pago
from pago;



-- Devuelve un listado con todos los productos que pertenecen a la gama
-- ornamentales y que tienen más de 100 unidades en stock. El listado 
-- deberá estar ordenado por su precio de venta, mostrando en primer lugar 
-- los de mayor precio
select gama, cantidad_en_stock, precio_venta
from producto
where cantidad_en_stock >= 100 and gama = 'Ornamentales'
order by precio_venta desc;



-- Devuelve un listado con todos los clientes que sean de la ciudad de
-- Madrid y cuyo representante de ventas tenga el código de empleado 11 o 30
select nombre from empleado
where codigo_oficina like '%ES%'
and codigo_empleado in ('11','30');


