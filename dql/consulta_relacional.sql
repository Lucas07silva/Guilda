-- 1. Relaciona categorias e jogos, garantindo que todas as categorias apareçam (mesmo sem jogos)
SELECT c.nome AS categoria, j.nome AS jogo
FROM jogo j
RIGHT JOIN categoria c ON j.id_categoria = c.id;

-- 2. Lista os jogos que pertencem à biblioteca de cada usuário
SELECT u.profile_name, j.nome AS jogo_na_biblioteca
FROM biblioteca b
INNER JOIN usuario u ON b.id_usuario = u.id
INNER JOIN jogo j ON b.id_jogo = j.id;

-- 3. Histórico de transações de mercado por usuário (inclui usuários que nunca transacionaram)
SELECT u.profile_name, m.id AS id_transacao_mercado, m.valor
FROM usuario u
LEFT JOIN mercado m ON u.id = m.id_usuario;

-- 4. Identifica a qual jogo cada item do inventário pertence
SELECT i.nome AS item_inventario, j.nome AS jogo_origem
FROM inventario i
INNER JOIN jogo j ON i.id_jogo = j.id;

-- 5. Lista os tópicos do fórum e seus respectivos autores
SELECT t.titulo AS topico_forum, u.profile_name AS autor_discussao
FROM forum t
INNER JOIN usuario u ON t.id_usuario = u.id;

-- 6. Lista todos os jogos e suas DLCs vinculadas (se houver)
SELECT j.nome AS jogo, d.nome AS dlc_vinculada
FROM jogo j
LEFT JOIN dlc d ON j.id = d.id_jogo;

-- 7. Consulta de amizades: retorna o nome do perfil do amigo
SELECT a.id_usuario, u.profile_name AS nome_amigo
FROM amigo a
INNER JOIN usuario u ON a.id_amigo = u.id;

-- 8. Associa itens do mercado à sua descrição de raridade
SELECT m.nome AS item_mercado, r.descricao AS raridade_tipo
FROM mercado m
INNER JOIN raridade r ON m.id_raridade = r.id;

-- 9. Lista desenvolvedores e seus jogos (garante que o desenvolvedor apareça mesmo sem jogos publicados)
SELECT d.nome AS desenvolvedor, j.nome AS jogo_publicado
FROM jogo j
RIGHT JOIN desenvolvedor d ON j.id_desenvolvedor = d.id;

-- 10. Detalhamento de vendas: une a transação ao item e ao nome do jogo comprado
SELECT t.id AS id_transacao, j.nome AS produto_adquirido, t.valor_total
FROM transacao t
INNER JOIN item_transacao it ON t.id = it.id_transacao
INNER JOIN jogo j ON it.id_jogo = j.id;

-- 11. Mostra todas as conquistas e quais usuários as desbloquearam
SELECT c.nome AS conquista, u.profile_name AS usuario_desbloqueou
FROM conquista c
LEFT JOIN conquista_usuario cu ON c.id = cu.id_conquista
LEFT JOIN usuario u ON cu.id_usuario = u.id;

-- 12. Vincula o texto da avaliação ao título do jogo correspondente
SELECT j.nome AS titulo_jogo, a.texto AS avaliacao_usuario
FROM jogo j
INNER JOIN avaliacao a ON j.id = a.id_jogo;
