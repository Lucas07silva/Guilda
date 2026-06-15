
-- BibliotecaDoUsuario: Mostra todos os jogos, horas jogadas e conquistas de um perfil específico.

DROP VIEW IF EXISTS BibliotecaDoUsuario;

CREATE OR REPLACE VIEW BibliotecaDoUsuario AS
SELECT
    b.id_usuario,
    u.username,
    j.nome AS nome_jogo,
    b.tempo_jogado_min,
    b.data_aquisicao
FROM biblioteca b
JOIN usuario u
    ON u.id = b.id_usuario
JOIN jogo j
    ON j.id = b.id_jogo;

SELECT * FROM BibliotecaDoUsuario;

-- ItensMaisValorizados: Lista os itens do mercado com os maiores preços de venda atuais.

DROP VIEW IF EXISTS ItensMaisValorizados;

CREATE VIEW ItensMaisValorizados AS
SELECT
    ma.id AS id_anuncio,
    ib.id AS id_item,
    ib.nome AS nome_item,
    ib.raridade,
    ma.preco_venda,
    u.username AS vendedor
FROM mercado_anuncio ma
JOIN inventario_usuario iu
    ON iu.id = ma.id_inventario_item
JOIN item_base ib
    ON ib.id = iu.id_item_base
JOIN usuario u
    ON u.id = ma.id_vendedor
ORDER BY ma.preco_venda DESC;

SELECT * FROM ItensMaisValorizados;

-- JogosEmDestaque: Exibe títulos com as melhores avaliações da comunidade.

DROP VIEW IF EXISTS JogosEmDestaque;

CREATE VIEW JogosEmDestaque AS
SELECT
    j.id,
    j.nome,
    j.desenvolvedora,
    j.media_avaliacao,
    COUNT(a.id) AS total_avaliacoes
FROM jogo j
LEFT JOIN avaliacao a
    ON a.id_jogo = j.id
GROUP BY
    j.id,
    j.nome,
    j.desenvolvedora,
    j.media_avaliacao
HAVING COUNT(a.id) > 0
ORDER BY
    j.media_avaliacao DESC,
    total_avaliacoes DESC;

SELECT *
FROM JogosEmDestaque
LIMIT 10;


-- JogosEmDestaque: Exibe títulos com as melhores avaliações recentes da comunidade.

DROP VIEW IF EXISTS JogosEmDestaque;

CREATE VIEW JogosEmDestaque AS
SELECT
    j.id,
    j.nome,
    j.desenvolvedora,
    ROUND(AVG(a.nota),2) AS media_recente,
    COUNT(a.id) AS total_avaliacoes_recentes
FROM jogo j
JOIN avaliacao a
    ON a.id_jogo = j.id
WHERE a.data_postagem >= CURRENT_DATE - INTERVAL '30 days'
GROUP BY
    j.id,
    j.nome,
    j.desenvolvedora
ORDER BY
    media_recente DESC,
    total_avaliacoes_recentes DESC;

SELECT * FROM JogosEmDestaque;
