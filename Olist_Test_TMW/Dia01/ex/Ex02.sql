-- Ex2: Quantos produtos tem mais de 5 litros?

SELECT count(*),
        count(DISTINCT product_id)

FROM tb_products

where product_height_cm * product_length_cm * product_width_cm / 1000  > 5

/* Nem todo banco de dados aceita usar o nome da coluna criada
, ou seja, o as (nesse caso 'product_volume') para fazer a filtragem.
Quando ocorrer isso vc deve colocar a operação. Ex:
where product_height_cm * product_length_cm * product_width_cm / 1000 > 5 */