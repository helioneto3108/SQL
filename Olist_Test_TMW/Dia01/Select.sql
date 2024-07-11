-- Select * from tb_sellers
-- O comando acima irá trazer todas as colunas da tabela
-- Pois o * significa todos

SELECT seller_id,
       seller_state

FROM tb_sellers

-- Pode ser ler o comando acima como
-- Selecione a coluna (seller_id e seller_state) da tabela (tb_sellers)

-- Tem como limitar o numero de linhas puxadas pelo comando limit
/* EX: select *
from tb_sellers 
limit 10 -> irá me trazer 10 linhas */
