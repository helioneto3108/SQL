select 
    distinct coalesce(product_category_name, 'Outros') as categoria_fillNA
    -- coalesce ele pega o primeiro valor não nulo

from tb_products

order by product_category_name