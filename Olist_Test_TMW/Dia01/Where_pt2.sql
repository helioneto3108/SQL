SELECT product_id,
       product_category_name,
       product_photos_qty

FROM tb_products
WHERE (product_category_name = 'bebes'
    or product_category_name = 'perfumaria')
AND product_photos_qty > 1

-- tb_products. -> Para ver os nomes das colunas/campos