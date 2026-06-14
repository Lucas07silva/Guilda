
-- 5.inventario_mercado

CREATE OR REPLACE VIEW ItensMaisValorizados AS
SELECT 
    ib.id AS id_item,
    ib.nome AS nome_item,
    ib.raridade,
    j.titulo AS nome_jogo, -- Corrigido de j.nome para j.titulo (02)
    COUNT(mh.id) AS total_vendas,
    ROUND(COALESCE(AVG(mh.valor_venda), 0.00), 2) AS preco_medio_venda,
    ROUND(COALESCE(AVG(b.tempo_jogado_min) / 60.0, 0.00), 1) AS media_horas_jogadas_dos_donos
FROM item_base ib
JOIN jogo j ON ib.id_jogo_origem = j.id
LEFT JOIN mercado_historico mh ON ib.id = mh.id_item_base
LEFT JOIN biblioteca b ON j.id = b.id_jogo
GROUP BY ib.id, ib.nome, ib.raridade, j.titulo
ORDER BY preco_medio_venda DESC, total_vendas DESC;
