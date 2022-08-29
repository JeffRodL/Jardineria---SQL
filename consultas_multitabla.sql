-- Consultas multitabla (composición interna)
-- Resolver todas las consultas utilizando inner join y natural join

-- obtener un listado con el nombre de cada cliente y el nombre y apellido
-- de su representante de ventas
select nombre_cliente, nombre, apellido1 
from cliente
left join empleado
on cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado;



-- Muestra el nombre de los clientes que hayan realizado pagos junto
-- con el nombre de sus representante de ventas
select nombre_cliente, nombre
from cliente 
join empleado
on empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
join pago
on pago.codigo_cliente=cliente.codigo_cliente;



-- Muestra el nombre de los clientes que no hayan realizado pagos junto 
-- con el nombre de sus representante de ventas
select distinct nombre_cliente, nombre
from cliente 
left join empleado
on empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas 
left join pago
on pago.codigo_cliente = cliente.codigo_cliente
-- donde no hay pagos en la tabla pagos.
where pago.codigo_cliente is null;



-- Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus
-- representantes junto con la ciudad de la oficina a la que pertenece el representante
select cliente.nombre_cliente, empleado.nombre, oficina.ciudad
from cliente 
join empleado
on empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
join pago
on pago.codigo_cliente=cliente.codigo_cliente
join oficina
on oficina.codigo_oficina = empleado.codigo_oficina;



-- Devuelve el nombre de los clientes que no hayan hecho pagos
-- y el nombre de sus representantes junto con la ciudad de la oficina
-- a la que pertenece el representante
select distinct cliente.nombre_cliente, empleado.nombre, oficina.ciudad
from cliente 
left join empleado
on empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas 
left join pago
on pago.codigo_cliente = cliente.codigo_cliente
left join oficina
on oficina.codigo_oficina = empleado.codigo_oficina
-- donde no hay pagos en la tabla pagos.
where pago.codigo_cliente is null;



-- Lista la dirección de las oficinas que tengan clientes en Fuenlabrada
select cliente.nombre_cliente, cliente.ciudad, oficina.linea_direccion1
from empleado
	join cliente 
	on cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
    join oficina
    on oficina.codigo_oficina = empleado.codigo_oficina
where cliente.ciudad like 'Fuenlabrada';



-- Devuelve el nombre de los clientes y el nombre de sus representantes
-- junto con la ciudad de la oficina a la que pertenece el representante
 select cliente.nombre_cliente, empleado.nombre, oficina.ciudad
 from empleado
	join cliente
	on cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado 
    join oficina
    on oficina.codigo_oficina = empleado.codigo_oficina;
    


-- Devuelve un listado con el nombre de los empleados junto con el nombre
-- de sus jefes.
select e.nombre, e.apellido1, o.nombre as nombre_jefe,
o.apellido1 as apellido_jefe 
from empleado as e
join empleado as o
on e.codigo_jefe = o.codigo_empleado;



-- Devolver un listado de las diferentes gamas de productos que ha comprado
-- cada cliente
select cliente.nombre_cliente, g.gama
from cliente
-- 
	join pedido 
	on pedido.codigo_cliente = cliente.codigo_cliente
--   
    join detalle_pedido as dp
    on dp.codigo_pedido = pedido.codigo_pedido
--
	join producto as p
    on p.codigo_producto = dp.codigo_producto
--
	join gama_producto as g
    on g.gama = p.gama
group by (cliente.nombre_cliente,g.gama);
