-- 1. UNION: Combina títulos de jogos base e DLCs (remove duplicatas)
SELECT titulo FROM jogos_base
UNION
SELECT titulo FROM dlcs;

-- 2. UNION ALL: Lista todos os IDs de quem enviou e recebeu convites (mantém duplicatas)
SELECT id_remetente AS id_usuario FROM convites_amizade
UNION ALL
SELECT id_destinatario AS id_usuario FROM convites_amizade;

-- 3. INTERSECT: Usuários que são moderadores E vendem itens no mercado
SELECT id_usuario FROM moderadores
INTERSECT
SELECT id_usuario FROM vendedores_mercado;

-- 4. UNION: IDs de jogos em promoção OU com nota máxima
SELECT id_jogo FROM jogos WHERE status_promocao = TRUE
UNION
SELECT id_jogo FROM jogos WHERE nota_avaliacao = 10;

-- 5. INTERSECT: Itens que estão no inventário E simultaneamente à venda
SELECT id_item FROM inventario_usuario
INTERSECT
SELECT id_item FROM itens_a_venda_mercado;
