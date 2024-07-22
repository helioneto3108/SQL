-- PARA QUE SERVE ##################################################################
-- Servem para consultar dados de outras consultas.


-- TIPOS ###########################################################################
-- Subquery no WHERE
-- Subquery com WITH
-- Subquery no FROM
-- Subquery no SELECT


-- EXEMPLOS ########################################################################

-- (Exemplo 1) Subquery no WHERE
-- Informe qual é o veículo mais barato da tabela products

select *

from sales.products

where price = (select min(price) from sales.products)


-- (Exemplo 2) Subquery com WITH
-- Calcule a idade média dos clientes por status profissional

with tb_idade as (
	select professional_status,
		(current_date - birth_date) / 365 as idade

	from sales.customers
)

select professional_status,
	avg(idade) as media_idade

from tb_idade

group by professional_status

order by media_idade desc

-- (Exemplo 3) Subquery no FROM
-- Calcule a média de idades dos clientes por status profissional

select professional_status,
	avg(idade) as media_idade

from (
	select professional_status,
		(current_date - birth_date) / 365 as idade

	from sales.customers
) as tb_idade

group by professional_status

order by media_idade desc

-- (Exemplo 4) Subquery no SELECT
-- Na tabela sales.funnel crie uma coluna que informe o nº de visitas acumuladas 
-- que a loja visitada recebeu até o momento

select t1.visit_id,
	t1.visit_page_date,
	t2.store_name,
	(
		select count(*)

		from sales.funnel as t3

		where t3.visit_page_date <= t1.visit_page_date
			and t3.store_id = t1.store_id
	) as visitas_acumulada

from sales.funnel as t1

left join sales.stores as t2
	on t1.store_id = t2.store_id

order by t2.store_name,
	t1.visit_page_date


-- RESUMO ##########################################################################
-- (1) Servem para consultar dados de outras consultas.
-- (2) Para que as subqueries no WHERE e no SELECT funcionem, elas devem retornar 
-- apenas um único valor
-- (3) Não é recomendado utilizar subqueries diretamente dentro do FROM pois isso 
-- dificulta a legibilidade da query. 