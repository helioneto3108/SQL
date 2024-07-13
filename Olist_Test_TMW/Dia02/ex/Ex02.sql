/* Ex2. Faça uma query que apresente o tamanho 
médio, máximo e mínimo do nome do objeto por categoria */

select product_category_name,
       avg(product_name_lenght) as media_nome,
       max(product_name_lenght) as maximo_nome,
       min(product_name_lenght) as minimo_nome

from tb_products

where product_category_name not null

group by product_category_name