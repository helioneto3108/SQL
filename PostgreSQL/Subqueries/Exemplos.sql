-- EXEMPLOS ########################################################################

-- (Exemplo 1) Análise de recorrência dos leads
-- Calcule o volume de visitas por dia ao site separado por 1ª visita e demais visitas

with tb_first_view as (
	select customer_id,
		min(visit_page_date) as Primeira_visita
	
	from sales.funnel
	
	group by customer_id
)

select t1.visit_page_date,
	(t1.visit_page_date <> t2.Primeira_visita) as lead_recorrente,
	count(*) as qtde_clients

from sales.funnel as t1

left join tb_first_view as t2
	on t1.customer_id = t2.customer_id 

group by t1.visit_page_date,
	lead_recorrente

order by visit_page_date desc

-- (Exemplo 2) Análise do preço versus o preço médio
-- Calcule, para cada visita ao site, quanto o preço do um veículo visitado pelo cliente
-- estava acima ou abaixo do preço médio dos veículos daquela marca 
-- (levar em consideração o desconto dado no veículo)

with tb_avg_price as (
	select brand,
		cast (avg(price) as money) as avg_price
	
	from sales.products
	
	group by brand
),

tb_final_price as (	
	select t1.visit_id,
		t1.visit_page_date,
		t3.brand,
		cast ((t2.price * (1 + t1.discount)) as money) as final_price,
		t3.avg_price
	
	from sales.funnel as t1
	
	left join sales.products as t2
		on t1.product_id = t2.product_id
	
	left join tb_avg_price as t3
		on t2.brand = t3.brand
)

select *,
	cast ((final_price - avg_price) as money)

from tb_final_price