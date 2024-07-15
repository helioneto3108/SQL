-- A receita por estado do seller 
-- por produto da categoria mais vendida

select t2.seller_state,
         t1.product_id,
         t3.product_category_name

from tb_order_items as t1

left join tb_sellers as t2
    on t1.seller_id = t2.seller_id

left join tb_products as t3
    on t1.product_id = t3.product_id

where t3.product_category_name in (

        select product_category_name
        from tb_products
        group by product_category_name
        order by count(*) desc
        limit 1
    -- se fosse dos 3 mais pedidos eu teria que colocar 3 no limit
)

group by t2.seller_state,
         t1.product_id,
         t3.product_category_name