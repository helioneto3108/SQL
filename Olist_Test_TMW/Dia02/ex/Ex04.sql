/* Ex4. Faça uma query que apresente o tamanho médio, máximo e mínimo do 
nome do objeto por categoria.
Considere apenas os objetos que tenham a descrição maior que 100.
Exiba apenas as categorias com tamanho médio de descrição do objeto maior que 500 caracteres. */

select product_category_name,
       avg(product_name_lenght) as media_nome,
       max(product_name_lenght) as maximo_nome,
       min(product_name_lenght) as minimo_nome,
       product_description_lenght,
       avg(product_description_lenght) as media_descrição

from tb_products

where product_category_name not null
    and product_description_lenght > 100 

group by product_category_name

having media_descrição > 500 

order by avg(product_name_lenght) desc, 
         min(product_name_lenght) asc