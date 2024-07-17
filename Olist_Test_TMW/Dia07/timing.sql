/* Fazendo uma tabela para ver vendedores
que estão mais tempo sem vender do que 
a media de revenda deles considerando que 
o dia de hj é 01/07/2018 */

with tb_marcacao_seller as (
    select t2.seller_id,
            max(t1.order_approved_at) as dt_ultima_venda,
            '2018-07-01' as dt_atual,
            julianday('2018-07-01') - julianday(max(t1.order_approved_at)) as qtde_dias_sem_vendas,

            case when julianday('2018-07-01') - julianday(max(t1.order_approved_at)) > 90
                then 1 else 0
                end as flag_vendas_90dias,
            
            t3.media_vendas,

            case when  julianday('2018-07-01') - julianday(max(t1.order_approved_at)) > t3.media_vendas
                then 1 else 0
                end as flag_avg_tempo


    from tb_orders as t1

    left join tb_order_items as t2
        on t1.order_id = t2.order_id

    left join tb_avg_venda_seller as t3
        on t2.seller_id = t3.seller_id

    where date(t1.order_approved_at) < '2018-07-01'
        and t1.order_status = 'delivered'

    group by t2.seller_id
)

select flag_vendas_90dias,
        flag_avg_tempo,
        count(*)

from tb_marcacao_seller

group by flag_vendas_90dias,
         flag_avg_tempo