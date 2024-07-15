/* - Qual a receita de cada categoria por produto?
- e o total de vendas? em unidades e pedidos */

/* deixar somente as 10 categorias que mais rende */

select
        t2.product_category_name,
        sum(t1.price) as receita

from tb_order_items as t1

left join tb_products as t2
    on t1.product_id = t2.product_id

group by t2.product_category_name

order by sum(t1.price) desc

limit 10

/* limit funciona como o head do pandas */