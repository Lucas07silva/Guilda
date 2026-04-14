-- 1. Quantidade de jogos por desenvolvedor
SELECT desenvolvedor, COUNT(id_jogo) AS total_jogo
FROM jogos
GROUP BY desenvolvedor;

-- 2. Valor total de transações de mercado por usuário
SELECT id_usuario, SUM(valor_transacao) AS total_valor_transacionado
FROM transacao_mercado
GROUP BY id_usuario;

-- 3. Média de avaliação (rating) da comunidade agrupada por jogo
SELECT id_jogo, AVG(rating) AS media_avaliacao
FROM avaliacao
GROUP BY id_jogo;

-- 4. Quantidade de conquistas (achievements) por perfil
SELECT id_perfil, COUNT(id_conquista) AS conquista_desbloqueada
FROM conquista_usuario
GROUP BY id_perfil;

-- 5. Quantidade de tópicos criados em cada discussão de fórum
SELECT id_discussao, COUNT(id_topico) AS total_topico
FROM topico_forum
GROUP BY id_discussao;

-- 6. Soma de horas jogadas (playtime) agrupada por título
SELECT titulo_jogo, SUM(horas_jogadas) AS total_playtime
FROM biblioteca_usuario
GROUP BY titulo_jogo;

-- 7. Quantidade de usuários cadastrados por região geográfica ou país
SELECT regiao, COUNT(id_usuario) AS total_usuario
FROM usuario
GROUP BY regiao;
