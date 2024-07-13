/* Ex3. Faça uma query que apresente o tamanho médio, máximo e mínimo 
do nome do objeto por categoria. 
Considere apenas os objetos que tenham a descrição maior que 100. */

select product_category_name,
       count(DISTINCT product_id) as qtde_produtos,
       avg(product_name_lenght) as media_nome,
       max(product_name_lenght) as maximo_nome,
       min(product_name_lenght) as minimo_nome,
       product_description_lenght

from tb_products

where product_category_name not null
    and product_description_lenght >= 100

group by product_category_name
