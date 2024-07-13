-- Preenchimento de null

select 
    distinct case when product_category_name is null then 'Outros'
                    else product_category_name
                  end as categorias_fillNA

from tb_products

order by 1