-- (Query 1) Receita, leads, conversão e ticket médio mês a mês
-- Colunas: mês, leads (#), vendas (#), receita (k, R$), conversão (%), ticket médio (k, R$)

with tb_leads_mes as (
	select
		date_trunc('month', visit_page_date)::date as visit_month,
		count(*) as qtde_leads
	
	from sales.funnel
	
	group by visit_month
	
	order by visit_month
),

tb_selles_month as (
	select 
		date_trunc('month', t1.paid_date)::date as selles_month,
		count(*) as qtde_selles,
		sum(t2.price * (1 + t1.discount))::money as receita,
		avg(t2.price * (1 + t1.discount))::money as ticket_medio
	
	from sales.funnel as t1
	
	left join sales.products as t2
		on t1.product_id = t2.product_id

	where t1.paid_date is not null
	
	group by selles_month
	
	order by selles_month
)

select t1.selles_month as month,
	t2.qtde_leads,
	t1.qtde_selles,
	t1.receita / 1000, -- para dar resultado em k
	(t1.qtde_selles::float / t2.qtde_leads::float) as conversao,
	t1.ticket_medio / 1000 -- para dar resultado em k

from tb_selles_month as t1

left join tb_leads_mes as t2
	on t1.selles_month = t2.visit_month

-- (Query 2) Estados que mais venderam no mes de agosto
-- Colunas: país, estado, vendas (#)

select 'Brazil' as pais,
	t2.state,
	count(*) as qtde_selles

from sales.funnel as t1

left join sales.customers as t2
	on t1.customer_id = t2.customer_id

where paid_date between '2021-08-01' and '2021-08-31'

group by t2.state

order by qtde_selles desc

limit 5

-- (Query 3) Marcas que mais venderam no mês de agosto
-- Colunas: marca, vendas (#)

select t2.brand,
	count(*) as vendas_marcas

from sales.funnel as t1

left join sales.products as t2
	on t1.product_id = t2.product_id

where paid_date between '2021-08-01' and '2021-08-31'

group by t2.brand

order by vendas_marcas desc

limit 5


-- (Query 4) Lojas que mais venderam no mes de agosto
-- Colunas: loja, vendas (#)

select t2.store_name,
	count(*) as qtde_vendas

from sales.funnel as t1

left join sales.stores as t2
	on t1.store_id = t2.store_id

where paid_date between '2021-08-01' and '2021-08-31'

group by t2.store_name

order by qtde_vendas desc

limit 5

-- (Query 5) Dias da semana com maior número de visitas ao site em agotso (ultimo mes)
-- Colunas: dia_semana, dia da semana, visitas (#)

select extract('dow' from visit_page_date) as dia_semana,
	case
		when extract('dow' from visit_page_date) = 0 then 'domingo'
		when extract('dow' from visit_page_date) = 1 then 'segunda'
		when extract('dow' from visit_page_date) = 2 then 'terça'
		when extract('dow' from visit_page_date) = 3 then 'quarta'
		when extract('dow' from visit_page_date) = 4 then 'quinta'
		when extract('dow' from visit_page_date) = 5 then 'sexta'
		when extract('dow' from visit_page_date) = 6 then 'sábado'
		else null
	end as nome_semana,
	count(*) qtde_visita

from sales.funnel

where visit_page_date between '2021-08-01' and '2021-08-31'
	
group by dia_semana

order by dia_semana
