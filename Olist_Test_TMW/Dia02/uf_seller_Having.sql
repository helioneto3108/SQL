select seller_state,
       count(*) as qtde_seller

from tb_sellers

/* where qtde_seller > 10
Não funciona, para conseguir filtrar desse jeito tenho que usar
o comando having para filtrar estados com mais de 10 vendedores */

-- Pré processamento
where seller_state in ('SP', 'RJ', 'PR', 'AC')

group by seller_state

-- Pós processamento, sem groupby n faz sentido usar having
having qtde_seller > 10

/* lembrando que o nome da coluna no having (qtde_seller)
so funciona, pois estamos mexendo com sqlite, outras sqls poderiam
não aceitar. logo teria que fazer a seguinte sintaxe:
'having count(*) > 10' */

/* Lembrando o having é utilizado para dados agregados, ou seja,
que já passaram por um processamento ou transformação, caso o 
contrário pode utilizar o where, ou seja, quando o dado está em
sua forma 'raw' */