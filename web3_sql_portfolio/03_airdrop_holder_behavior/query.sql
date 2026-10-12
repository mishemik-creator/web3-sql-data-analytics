-- Кейс: Анализ поведения получателей аирдропа ARB (Hold vs Dump)
-- СУБД: Dune SQL (Trino Engine)

SELECT
  CASE 
    WHEN t.to_owner IS NOT NULL THEN 'Dumped (Слили)'
    ELSE 'Holding (Hold)'
  END AS user_behavior,
  COUNT(DISTINCT a.claimant) AS total_users,
  SUM(a.amount / 1e18) AS total_tokens_amount,
  AVG(a.amount / 1e18) AS avg_airdrop_size
FROM 
  arbitrum.airdrop_claims AS a
LEFT JOIN 
  erc20_arbitrum.evt_Transfer AS t
  ON a.claimant = t."from"
  AND t.block_time > a.block_time
  AND t.contract_address = 0x912ce59144191c1204e64559fe8253a0e49e6548 -- Контракт токена ARB
GROUP BY 
  1;
```
