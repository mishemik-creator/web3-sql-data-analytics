-- Кейс: Анализ UAW и выявление аномальной активности пользователей за 30 дней
-- СУБД: Dune SQL (Trino Engine)

SELECT
  DATE_TRUNC('day', block_time) AS trade_date,
  COUNT(DISTINCT from_owner) AS unique_addresses, -- Расчет метрики UAW
  COUNT(*) AS total_transactions,
  CAST(COUNT(*) AS DOUBLE) / COUNT(DISTINCT from_owner) AS tx_per_user -- Средняя активность
FROM
  ethereum.token_transfers
WHERE
  block_time >= NOW() - INTERVAL '30' day
GROUP BY
  1
HAVING 
  CAST(COUNT(*) AS DOUBLE) / COUNT(DISTINCT from_owner) > 5 -- Фильтр аномальных дней
ORDER BY
  1 DESC;
