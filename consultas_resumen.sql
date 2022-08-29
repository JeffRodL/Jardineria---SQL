-- CONSULTAS RESUMEN

-- ¿Cuántos empleados hay en la compañía?
select count(*) as 'Cantidad de empleados' from empleado;

-- ¿Cuántos clientes tiene cada país?
select cliente.pais, count(*) from cliente
group by cliente.pais;



-- ¿Cuánto fue el pago medio en 2009?
select avg(total) as 'Pago medio' from pago
where year(fecha_pago) = '2009';



-- ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma
-- descendente por el número de pedidos
select pedido.estado, count(estado) as 'Cantidad' from pedido
group by pedido.estado 
order by pedido.estado desc;



-- Calcula el precio de venta del producto más caro y más barato en una
-- misma consulta
select max(precio_venta) as 'Mas caro', min(precio_venta) as 'Mas barato'
from producto;



-- Calcula el número de clientes que tiene la empresa
select count(*) as 'Cantidad de clientes' from cliente;



-- ¿Cuántos clientes tiene la ciudad de Madrid?
select count(region) as 'Clientes Madrid' from cliente
where cliente.region like 'Madrid';



-- ¿Calcula cuántos clientes tiene cada una de las ciudades que empieza por M?
select cliente.ciudad, count(*) as cantidad from cliente where cliente.ciudad like 'M%'
group by cliente.ciudad
order by cantidad desc;



-- Devuelve el nombre de los representantes de ventas y el número de clientes
-- al que atiende cada uno
select empleado.nombre, count(cliente.codigo_cliente) from empleado
join cliente on cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
where puesto = 'Representante de ventas'
group by empleado.nombre;



-- Calcula el número de clientes que no tienen asignado un representante de ventas
select count(*) as clientes_sin_representante from cliente 
where cliente.codigo_empleado_rep_ventas is null;



-- Calcula la fecha del primer y último pago realizado por cada uno de los
-- clientes. El listado deberá mostrar el nombre y los apellidos de cada cliente.
select codigo_pedido, count(codigo_producto) from detalle_pedido group by
codigo_pedido;