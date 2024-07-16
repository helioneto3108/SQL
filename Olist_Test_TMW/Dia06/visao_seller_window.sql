/* Objetivo:
Qual o produto mais vendido pelo seller
Considere apenas pedidos entregues */

with tb_seller_product as (
    select t2.seller_id,
            t2.product_id,
            count(*) as qtde_produtos,
            sum(t2.price) as receita_produto

    from tb_orders as t1

    left join tb_order_items as t2
        on t1.order_id = t2.order_id

    where t1.order_status = 'delivered'

    group by t2.seller_id,
            t2.product_id
),

tb_seller_sort as (
    select *,
        row_number() over (partition by seller_id
                            order by qtde_produtos desc,
                                      receita_produto desc) as order_qtde

        -- row_number é uma windown function para enumerar encima(over)
        -- de uma partição (seller_id) por algum valor (qtde_produtos)
    from tb_seller_product
)

select seller_id,
        product_id,
        qtde_produtos

from tb_seller_sort

where order_qtde = 1