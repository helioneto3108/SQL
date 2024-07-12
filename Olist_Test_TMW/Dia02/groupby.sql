SELECT product_category_name,
       count(*) as qtde_produtos,
       max(product_weight_g) as maior_peso,
       min(product_weight_g) as menor_peso,
       avg(product_weight_g) as media_peso

FROM tb_products

-- Isso vem vem antes do groupby (no processamento tmb)
-- Tirando alguma das categorias
WHERE product_category_name is not NULL
    AND product_category_name != 'alimentos'
    AND product_category_name <> 'agro_industria_e_comercio'

GROUP BY product_category_name