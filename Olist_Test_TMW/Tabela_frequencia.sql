with tb_freq_abs as (
    select seller_state,
        count(*) as freq_abs

    from tb_sellers

    group by seller_state
)

select *,
    cast(freq_abs as float) / (select sum(freq_abs) from tb_freq_abs) as freq_relativa,
    sum(cast(freq_abs as float) / (select sum(freq_abs) from tb_freq_abs)) 
        over (order by freq_abs desc) as freq_relativa_acumulada

from tb_freq_abs

group by seller_state

order by freq_abs desc