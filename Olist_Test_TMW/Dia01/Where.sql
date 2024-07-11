-- Aplicando filtro para ter somente produtos das categorias bebes

SELECT product_id,
       product_category_name,
       product_photos_qty

FROM tb_products

WHERE product_category_name = 'bebes'
AND product_photos_qty > 1