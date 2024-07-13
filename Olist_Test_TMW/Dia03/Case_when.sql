select 
    distinct case when product_category_name is null then 'Outros'
                  
                   when product_category_name = 'alimentos'
                        or product_category_name = 'alimentos_bebidas' then 'alimentos'
                    
                    when product_category_name in ('artes', 'artes_e_artesanato') then 'artes'
                    
                    when product_category_name like '%artigos%' then 'artigos'

                    else product_category_name
                    
                  end as categorias_fillNA

from tb_products

order by 1