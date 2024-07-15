/* Qual o valor total de receita gerada por clientes de cada estado?
 Considere a base completa, com apenas pedidos entregues */

select t1.customer_state,
       sum(t3.price) as receita_estado,
       sum(t3.price) / count(distinct t2.customer_id) as avg_receita_estado

from tb_customers as t1

left join tb_orders as t2
    on t2.customer_id = t1.customer_id

left join tb_order_items as t3
    on t2.order_id = t3.order_id

where t2.order_status = 'delivered'

group by t1.customer_state

order by receita_estado desc