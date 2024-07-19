-- EXERCÍCIOS ########################################################################

-- (Exemplo 1) Identifique qual é o status profissional mais frequente nos clientes 
-- que compraram automóveis no site

select t2.professional_status,
	count(t1.paid_date) as qtde_compras

from sales.funnel as t1

left join sales.customers as t2
	on t1.customer_id = t2.customer_id

group by t2.professional_status

order by qtde_compras desc
	
-- (Exemplo 2) Identifique qual é o gênero mais frequente nos clientes que compraram
-- automóveis no site. Obs: Utilizar a tabela temp_tables.ibge_genders
select * from temp_tables.ibge_genders limit 10

select t3.gender,
	count(t1.paid_date) as qdte_compras

from sales.funnel as t1

left join sales.customers as t2
	on t1.customer_id = t2.customer_id

left join temp_tables.ibge_genders as t3
	on lower(t2.first_name) = t3.first_name

group by t3.gender

order by qdte_compras desc
	
-- (Exemplo 3) Identifique de quais regiões são os clientes que mais visitam o site
-- Obs: Utilizar a tabela temp_tables.regions
select * from sales.customers limit 10
select * from temp_tables.regions limit 10

select t3.region,
	count(t1.paid_date) as qdte_compras

from sales.funnel as t1

left join sales.customers as t2
	on t1.customer_id = t2.customer_id

left join temp_tables.regions as t3
	on lower(t2.city) = lower(t3.city)
	and lower(t2.state) = lower(t3.state)

group by t3.region

order by qdte_compras desc