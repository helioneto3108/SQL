select seller_city,
       count(*) as qtd_vendedor,
       count(distinct seller_id) as qtd_vendedor_distinto

from tb_sellers

where seller_city in ('curitiba', 'sao paulo', 'rio de janeiro')

group by seller_city