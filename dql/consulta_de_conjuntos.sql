-- 1. UNION: Combina títulos de jogos base e DLCs (remove duplicatas)
SELECT titulo FROM jogo_base
UNION
SELECT titulo FROM dlc;

-- 2. UNION ALL: Lista todos os IDs de quem enviou e recebeu convites (mantém duplicatas)
SELECT id_remetente AS id_usuario FROM convite_amizade
UNION ALL
SELECT id_destinatario AS id_usuario FROM convite_amizade;

-- 3. INTERSECT: Usuários que são moderadores E vendem itens no mercado
SELECT id_usuario FROM moderador
INTERSECT
SELECT id_usuario FROM vendedor_mercado;

-- 4. UNION: IDs de jogos em promoção OU com nota máxima
SELECT id_jogo FROM jogo WHERE status_promocao = TRUE
UNION
SELECT id_jogo FROM jogo WHERE nota_avaliacao = 10;

-- 5. INTERSECT: Itens que estão no inventário E simultaneamente à venda
SELECT id_item FROM inventario_usuario
INTERSECT
SELECT id_item FROM item_a_venda_mercado;
