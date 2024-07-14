/* - Qual a receita de cada categoria por produto?
- e o total de vendas? em unidades e pedidos */

select
        t2.product_category_name,
        sum(t1.price) as receita,
        count(*) as qtde_total_itens_vendidos,
        count(distinct t1.order_id) as qtde_pedidos,
        round(count(*) / cast(count(distinct t1.order_id) as float), 2) as avg_itens_pedidos

from tb_order_items as t1

left join tb_products as t2
    on t1.product_id = t2.product_id

group by t2.product_category_name

order by avg_itens_pedidos desc