-- Кейс: Ежемесячный объем торгов и долей рынка топ-бирж (DEX) за 6 месяцев
-- СУБД: Dune SQL (Trino Engine)

SELECT
  DATE_TRUNC('month', block_time) AS trade_month,
  project, -- Название проекта (uniswap, pancakeswap, etc.)
  SUM(CAST(amount_usd AS DOUBLE)) AS usd_volume
FROM
  dex.trades AS t
WHERE
  block_time >= DATE_TRUNC('month', NOW()) - INTERVAL '6' month
GROUP BY
  1, 2
ORDER BY
  trade_month DESC, usd_volume DESC;
