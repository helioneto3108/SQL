-- EXERCÍCIOS ########################################################################

-- (Exercício 1) Identifique quais as marcas de veículo mais visitada na tabela sales.funnel

select t2.brand,
	count(t1.visit_id) as qtde_visitas

from sales.funnel as t1

left join sales.products as t2
	on t1.product_id = t2.product_id

group by t2.brand

order by qtde_visitas desc

-- (Exercício 2) Identifique quais as lojas de veículo mais visitadas na tabela sales.funnel

select t2.store_name,
	count(t1.visit_id) as qtde_visitas

from sales.funnel as t1

left join sales.stores as t2
	on t1.store_id = t2.store_id

group by t2.store_name

order by qtde_visitas desc


-- (Exercício 3) Identifique quantos clientes moram em cada tamanho de cidade (o porte da cidade
-- consta na coluna "size" da tabela temp_tables.regions)

select size,
	count(t2.customer_id) as qtde_clients

from sales.funnel as t1

left join sales.customers as t2
	on t1.customer_id = t2.customer_id

left join temp_tables.regions as t3
	on lower(t2.city) = lower(t3.city)
	and lower(t2.state) = lower(t3.state)

group by size

order by qtde_clients desc