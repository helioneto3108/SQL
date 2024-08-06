-- Ex1. Faça uma query que apresente o tamanho médio, 
-- máximo e mínimo da descrição do objeto por categoria

select product_category_name,
       avg(product_description_lenght) as media_descrição,
       max(product_description_lenght) as maxima_descrição,
       min(product_description_lenght) as minima_descrição

from tb_products

where product_category_name not null

group by product_category_name