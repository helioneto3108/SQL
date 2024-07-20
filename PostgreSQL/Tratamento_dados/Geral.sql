-- TIPOS ###########################################################################
-- CASE WHEN
-- COALESCE()


-- EXEMPLOS ########################################################################

-- (Exemplo 1) Agrupamento de dados com CASE WHEN
-- Calcule o nº de clientes que ganham abaixo de 5k, entre 5k e 10k, entre 10k e 
-- 15k e acima de 15k

with tb_faixas_rendas as (
	select customer_id,
		income,
		case
			when income < 5000 then 'baixa renda'
			when income between 5000 and 10000 then 'media renda'
			when income between 10000 and 15000 then 'media alta renda'
			else 'alta renda'
		end as faixa_renda
	
	from sales.customers
)

select faixa_renda,
	count(*) as qtde_clients

from tb_faixas_rendas

group by faixa_renda

-- (Exemplo 2) Tratamento de dados nulos com COALESCE
-- Crie uma coluna chamada populacao_ajustada na tabela temp_tables.regions e
-- preencha com os dados da coluna population, mas caso esse campo estiver nulo, 
-- preencha com a população média (geral) das cidades do Brasil

-- opcao 1
select *,
	case
		when population is not null then population
		else (select avg(population) from temp_tables.regions)
	end as populacao_ajustada

from temp_tables.regions

where population is null

-- opcao 2
select *,
	coalesce (population, (select avg(population) from temp_tables.regions))

from temp_tables.regions

where population is null


-- RESUMO ##########################################################################
-- (1) CASE WHEN é o comando utilizado para criar respostas específicas para 
-- diferentes condições e é muito utilizado para fazer agrupamento de dados
-- (2) COALESCE é o comando utilizado para preencher campos nulos com o primeiro
-- valor não nulo de uma sequência de valores.
