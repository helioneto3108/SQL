/* Achar os vendedores que não venderam nada em dezembro de 2017 */

select t1.seller_id,
       t1.seller_state
        

from tb_sellers as t1

left join tb_order_items as t2
    on t1.seller_id = t2.seller_id

left join tb_orders as t3
    on t2.order_id = t3.order_id

where t3.order_approved_at < '2018-01-01'
    and t3.order_status = 'delivered'

group by t1.seller_id

having max(case when strftime('%Y-%m',t3.order_approved_at) = '2017-12' then 1
             else 0 
        end) = 0