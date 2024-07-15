-- Qual o valor total de receita gerada por sellers de cada estado?
-- Considere a base completa, com apenas pedidos entregues

select t1.seller_state,
        sum(t2.price) as receita_estado,
        sum(t2.price) / count(distinct t1.seller_id) as avg_receita_seller,
        count(distinct t1.seller_id) as qtde_sellers_estado

from tb_sellers as t1

left join tb_order_items as t2
    on t1.seller_id = t2.seller_id

left join tb_orders as t3
    on t2.order_id = t3.order_id

where t3.order_status = 'delivered'

group by t1.seller_state