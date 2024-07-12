-- Ex4: Quantos produtos de 'beleza_saude' com menos de 1 litro?

select count(*) as qtd_linhas,
        count(DISTINCT product_id) as qtd_id_distintios

from tb_products

where product_category_name = 'beleza_saude'
    and product_height_cm * product_length_cm * product_width_cm / 1000 < 1