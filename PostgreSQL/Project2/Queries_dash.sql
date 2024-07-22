-- (Query 1) Gênero dos leads
-- Colunas: gênero, leads(#)

select 
	case
		when gender = 'female' then 'Mulher'
		when gender = 'male' then 'Homem'
	end as genero,
	count(distinct t1.customer_id) qtde_genero

from sales.funnel as t1

left join sales.customers as t2
	on t1.customer_id = t2.customer_id

left join temp_tables.ibge_genders as t3
	on lower(t2.first_name) = t3.first_name

group by genero

-- (Query 2) Status profissional dos leads
-- Colunas: status profissional, leads (%)

select professional_status,
	(count(*)::float)/(select count(*) from sales.customers) as profissao_leads

from sales.customers

group by professional_status

order by profissao_leads desc


-- (Query 3) Faixa etária dos leads
-- Colunas: faixa etária, leads (%)

select
	case
		when (current_date - birth_date) / 365 < 21 then '0-21'
		when (current_date - birth_date) / 365 < 40 then '21-40'
		when (current_date - birth_date) / 365 < 60 then '40-60'
		when (current_date - birth_date) / 365 < 80 then '60-80'
		else '80+'
	end as faixa_etaria,
	(count(*)::float) / (select count(*) from sales.customers) as faixa_etaria_percent

from sales.customers

group by faixa_etaria

order by faixa_etaria desc


-- (Query 4) Faixa salarial dos leads
-- Colunas: faixa salarial, leads (%), ordem

select
	case
		when income < 5000 then '0-5000'
		when income < 10000 then '5000-10000'
		when income < 15000 then '10000-15000'
		when income < 20000 then '15000-20000'
		else '20000+'
	end as faixa_salarial,
	(count(*)::float) / (select count(*) from sales.customers) as faixa_salaria_percent,
	case
		when income < 5000 then 1
		when income < 10000 then 2
		when income < 15000 then 3
		when income < 20000 then 4
		else 5 
	end as ordem

from sales.customers

group by faixa_salarial,
	ordem

order by ordem


-- (Query 5) Classificação dos veículos visitados
-- Colunas: classificação do veículo, veículos visitados (#)
-- Regra de negócio: Veículos novos tem até 4 anos e seminovos acima de 4 anos

select 
	case
		when (extract(year from visit_page_date) - model_year::int) <= 2 then 'Novo'
		else 'Seminovo'
	end as class_carro,
	count(*) as qtde_carros
	
from sales.funnel as t1

left join sales.products as t2
	on t1.product_id = t2.product_id

group by class_carro


-- (Query 6) Idade dos veículos visitados
-- Colunas: Idade do veículo, veículos visitados (%), ordem

select
	case
		when (extract(year from t1.visit_page_date) - model_year::int) <= 2 then 'Até 2 anos'
		when (extract(year from t1.visit_page_date) - model_year::int) <= 4 then 'de 2 à 4 anos'
		when (extract(year from t1.visit_page_date) - model_year::int) <= 6 then 'de 4 à 6 anos'
		when (extract(year from t1.visit_page_date) - model_year::int) <= 8 then 'de 6 à 8 anos'
		when (extract(year from t1.visit_page_date) - model_year::int) <= 10 then 'de 8 à 10 anos'
		else 'acima de 10 anos'
	end as idade_carro,
	(count(*)::float) / (select count(*) from sales.funnel) as qtde_carros,
	case
		when (extract(year from t1.visit_page_date) - model_year::int) <= 2 then 1
		when (extract(year from t1.visit_page_date) - model_year::int) <= 4 then 2
		when (extract(year from t1.visit_page_date) - model_year::int) <= 6 then 3
		when (extract(year from t1.visit_page_date) - model_year::int) <= 8 then 4
		when (extract(year from t1.visit_page_date) - model_year::int) <= 10 then 5
		else 6
	end as ordem

from sales.funnel as t1

left join sales.products as t2
	on t1.product_id = t2.product_id

group by idade_carro, 
	ordem

order by ordem

-- (Query 7) Veículos mais visitados por marca
-- Colunas: brand, model, visitas (#)

select t2.brand,
	t2.model,
	count(*) as qtde_carros

from sales.funnel as t1

left join sales.products as t2
	on t1.product_id = t2.product_id

group by t2.brand,
	t2.model

order by t2.brand,
	t2.model