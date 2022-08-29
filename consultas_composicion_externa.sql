-- Consultas multitabla (composición externa)
-- Resolver todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT 
-- JOIN, NATURAL LEFT JOIN Y NATURAL RIGHT JOIN.



-- Devolver un listado que muestre solamente los clientes que no han
-- realizado ningún pago
select cliente.nombre_cliente
from cliente
left join pago
on pago.codigo_cliente = cliente.codigo_cliente
where pago.codigo_cliente is null;

-- Devolver un listado que muestre solamente los clientes que no han
-- realizado ningún pedido
select cliente.nombre_cliente
from cliente
left join pedido
on pedido.codigo_cliente = cliente.codigo_cliente
where pedido.codigo_cliente is null;



-- Devuelve un listado que muestre solamente los clientes que no han 
-- realizado ningún pedido y ningún pago
select cliente.nombre_cliente
from cliente
left join pedido
on pedido.codigo_cliente = cliente.codigo_cliente
left join pago
on pago.codigo_cliente = cliente.codigo_cliente
where pedido.codigo_cliente is null and 
pago.codigo_cliente is null;



-- Devuelve un listado que muestre los clientes que no han realizado ningún
-- pago y los que no han realizado ningún pedido
select cliente.nombre_cliente
from cliente
	left join pago on pago.codigo_cliente = cliente.codigo_cliente
    left join pedido on pedido.codigo_cliente = cliente.codigo_cliente
where pedido.codigo_cliente is null and pago.codigo_cliente is null;



-- Devuelve un listado que muestre solamente los empleados que no tienen una 
-- oficina asociada
select empleado.nombre
from empleado
	left join oficina on oficina.codigo_oficina = empleado.codigo_oficina
where oficina.codigo_oficina is null;



-- Devuelve las oficinas donde no trabajan ninguno de los empleados que 
-- hayan sido los representantes de ventas de algún cliente que haya
-- realizado la compra de algún producto de gama frutales

select o.* from oficina as o
	join empleado as em on o.codigo_oficina = em.codigo_oficina
    join cliente as cl on cl.codigo_empleado_rep_ventas = em.codigo_empleado
    join pedido as pd on cl.codigo_cliente = pd.codigo_cliente
    join detalle_pedido as dt_pd on dt_pd.codigo_pedido = pd.codigo_pedido
    join producto as pr on dt_pd.codigo_producto = pr.codigo_producto
    join gama_producto as g_pr on pr.gama =g_pr.gama
where g_pr.gama like 'Frutales' and (cl.codigo_empleado_rep_ventas <>
all (select codigo_empleado from empleado as e join oficina as o on
(o.codigo_oficina=e.codigo_oficina))); 



-- Devuelve un listado que muestre los empleados que no tienen una oficina
-- asociada y los que no tienen un cliente asociado.
select empleado.nombre
from empleado
	left join cliente on cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
	left join oficina on oficina.codigo_oficina = empleado.codigo_oficina
where oficina.codigo_oficina is null and
cliente.codigo_empleado_rep_ventas is null;



-- Devuelve un listado de los productos que nunca han aparecido en un pedido



-- Devuelve las oficinas donde no trabajan ninguno de los empleados que
-- hayan sido los representantes de ventas de algún cliente que haya realizado
-- la compra de algún producto de la gama 'Frutales'



-- Devuelve un listado con los clientes que han realizado algún pedido pero
-- no han realizado ningún pago
select nombre_cliente from cliente as c
	join pedido as p on p.codigo_cliente = c.codigo_cliente
	join pago as a on a.codigo_cliente = c.codigo_cliente
where a.codigo_cliente <> c.codigo_cliente;



-- Devuelve un listado con los datos de los empleados que no tienen clientes
-- asociados y el nombre de su jefe asociado
select em.nombre, em.codigo_jefe 
from empleado as em
	join cliente as cl on em.codigo_empleado = cl.codigo_empleado_rep_ventas
group by(em.nombre,em.codigo_jefe);