-- Qual o peso médio dos produtos vendidos por sellers de cada estado? 
-- Considere apenas o ano de 2017 e pedidos entregues nesta análise.

select t1.seller_state,
        avg(t4.product_weight_g) as peso_medio

from tb_sellers as t1

left join tb_order_items as t2
    on t1.seller_id = t2.seller_id

left join tb_orders as t3
    on t2.order_id = t3.order_id

left join tb_products as t4
    on t2.product_id = t4.product_id

where order_status = 'delivered'
    and strftime('%Y', t3.order_approved_at) = '2017'

group by t1.seller_state