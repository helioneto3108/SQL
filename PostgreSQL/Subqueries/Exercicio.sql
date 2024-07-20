-- EXERCÍCIOS ########################################################################

-- (Exercício 1) Crie uma coluna calculada com o número de visitas realizadas por cada
-- cliente da tabela sales.customers

with tb_visitas as (
	select customer_id,
		count(*) as qtde_visita
	
	from sales.funnel
	
	group by customer_id
	
	order by qtde_visita desc
)

select t1.first_name || ' ' || t1.last_name as comp_name,
	t2.qtde_visita

from sales.customers as t1

left join tb_visitas as t2
	on t1.customer_id = t2.customer_id