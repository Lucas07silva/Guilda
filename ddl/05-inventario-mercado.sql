-- 1) DROP TABLES

DROP TABLE IF EXISTS insignia_usuario;
DROP TABLE IF EXISTS item_oferta_troca;
DROP TABLE IF EXISTS oferta_troca;
DROP TABLE IF EXISTS mercado_historico;
DROP TABLE IF EXISTS mercado_anuncio;
DROP TABLE IF EXISTS inventario_usuario;
DROP TABLE IF EXISTS insignia;
DROP TABLE IF EXISTS item_base;
DROP TABLE IF EXISTS jogo;
DROP TABLE IF EXISTS usuario;


-- 2) DDL - CREATE TABLES
CREATE TABLE usuario (
    id INT NOT NULL PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE jogo (
    id INT NOT NULL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    desenvolvedora VARCHAR(255)
);

CREATE TABLE item_base (
    id INT NOT NULL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    raridade VARCHAR(50),
    id_jogo_origem INT NOT NULL,
    FOREIGN KEY (id_jogo_origem) REFERENCES jogo(id)
);

CREATE TABLE inventario_usuario (
    id INT NOT NULL PRIMARY KEY,
    id_item_base INT NOT NULL,
    id_usuario_dono INT NOT NULL,
    FOREIGN KEY (id_item_base) REFERENCES item_base(id),
    FOREIGN KEY (id_usuario_dono) REFERENCES usuario(id)
);

CREATE TABLE mercado_anuncio (
    id INT NOT NULL PRIMARY KEY,
    id_inventario_item INT NOT NULL,
    preco_venda DECIMAL(10, 2) NOT NULL,
    id_vendedor INT NOT NULL,
    FOREIGN KEY (id_inventario_item) REFERENCES inventario_usuario(id),
    FOREIGN KEY (id_vendedor) REFERENCES usuario(id)
);

CREATE TABLE mercado_historico (
    id INT NOT NULL PRIMARY KEY,
    id_item_base INT NOT NULL,
    valor_venda DECIMAL(10, 2) NOT NULL,
    data_venda TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_item_base) REFERENCES item_base(id)
);

CREATE TABLE oferta_troca (
    id INT NOT NULL PRIMARY KEY,
    id_remetente INT NOT NULL,
    id_destinatario INT NOT NULL,
    status VARCHAR(50) DEFAULT 'PENDENTE',
    FOREIGN KEY (id_remetente) REFERENCES usuario(id),
    FOREIGN KEY (id_destinatario) REFERENCES usuario(id)
);

CREATE TABLE item_oferta_troca (
    id_oferta INT NOT NULL,
    id_inventario_item INT NOT NULL,
    PRIMARY KEY (id_oferta, id_inventario_item),
    FOREIGN KEY (id_oferta) REFERENCES oferta_troca(id),
    FOREIGN KEY (id_inventario_item) REFERENCES inventario_usuario(id)
);

CREATE TABLE insignia (
    id INT NOT NULL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    xp_recompensa INT NOT NULL,
    id_jogo INT NOT NULL,
    FOREIGN KEY (id_jogo) REFERENCES jogo(id)
);

CREATE TABLE insignia_usuario (
    id_usuario INT NOT NULL,
    id_insignia INT NOT NULL,
    nivel INT NOT NULL DEFAULT 1,
    PRIMARY KEY (id_usuario, id_insignia),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id),
    FOREIGN KEY (id_insignia) REFERENCES insignia(id)
);


-- 3) DML - INSERTS


-- USUARIOS
INSERT INTO usuario (id, username, email) VALUES
(1, 'ana.silva', 'ana.silva@email.com'), (2, 'bruno.melo', 'bruno.melo@email.com'),
(3, 'carla.dias', 'carla.dias@email.com'), (4, 'diego.souza', 'diego.souza@email.com'),
(5, 'elena.martins', 'elena.martins@email.com'), (6, 'fabio.lima', 'fabio.lima@email.com'),
(7, 'gabriel.vaz', 'gabriel.vaz@email.com'), (8, 'helena.rocha', 'helena.rocha@email.com'),
(9, 'igor.nunes', 'igor.nunes@email.com'), (10, 'julia.ferreira', 'julia.ferreira@email.com'),
(11, 'kevin.santos', 'kevin.santos@email.com'), (12, 'lara.gomes', 'lara.gomes@email.com'),
(13, 'marcos.oliveira', 'marcos.oliveira@email.com'), (14, 'nina.castro', 'nina.castro@email.com'),
(15, 'otavio.pinto', 'otavio.pinto@email.com'), (16, 'paula.leite', 'paula.leite@email.com'),
(17, 'quel.ribeiro', 'quel.ribeiro@email.com'), (18, 'rafael.costa', 'rafael.costa@email.com'),
(19, 'sofia.alves', 'sofia.alves@email.com'), (20, 'tiago.mendes', 'tiago.mendes@email.com'),
(21, 'ursula.bezerra', 'ursula.bezerra@email.com'), (22, 'vitor.pereira', 'vitor.pereira@email.com'),
(23, 'wagner.silva', 'wagner.silva@email.com'), (24, 'xenia.luz', 'xenia.luz@email.com'),
(25, 'yago.frota', 'yago.frota@email.com'), (26, 'zilda.reis', 'zilda.reis@email.com'),
(27, 'arthur.moraes', 'arthur.moraes@email.com'), (28, 'beatriz.paz', 'beatriz.paz@email.com'),
(29, 'caio.teixeira', 'caio.teixeira@email.com'), (30, 'dora.viana', 'dora.viana@email.com');

-- JOGOS
INSERT INTO jogo (id, nome, desenvolvedora) VALUES
(1, 'God of War', 'Santa Monica Studio'),
(2, 'Halo Infinite', '343 Industries'),
(3, 'Zelda BOTW', 'Nintendo'),
(4, 'FIFA 24', 'EA Sports'),
(5, 'Far Cry 6', 'Ubisoft'),
(6, 'GTA V', 'Rockstar Games'),
(7, 'Diablo IV', 'Blizzard Entertainment'),
(8, 'Final Fantasy XVI', 'Square Enix'),
(9, 'Resident Evil 4', 'Capcom'),
(10, 'Elden Ring', 'FromSoftware'),
(11, 'Sonic Frontiers', 'Sega'),
(12, 'Hogwarts Legacy', 'Avalanche Software'),
(13, 'Starfield', 'Bethesda Game Studios'),
(14, 'Stellaris', 'Paradox Interactive'),
(15, 'Cyberpunk 2077', 'CD Projekt Red'),
(16, 'Metal Gear Rising', 'PlatinumGames'),
(17, 'Portal 2', 'Valve'),
(18, 'Fortnite', 'Epic Games'),
(19, 'Dark Souls III', 'FromSoftware'),
(20, 'A Plague Tale', 'Asobo Studio'),
(21, 'Cult of the Lamb', 'Massive Monster'),
(22, 'Overcooked 2', 'Team17'),
(23, 'Dredge', 'Black Salt Games'),
(24, 'Stray', 'BlueTwelve Studio'),
(25, 'Satisfactory', 'Coffee Stain Studios'),
(26, 'Metro Exodus', '4A Games'),
(27, 'Control', 'Remedy Entertainment'),
(28, 'Vampyr', 'Dontnod Entertainment'),
(29, 'Dying Light 2', 'Techland'),
(30, 'Sniper Elite 5', 'Rebellion Developments');

-- ITEM BASE
INSERT INTO item_base (id, nome, raridade, id_jogo_origem) VALUES
(1, 'Lâminas do Caos', 'Lendário', 1),          -- God of War
(2, 'Rifle de Assalto MA40', 'Comum', 2),      -- Halo Infinite
(3, 'Master Sword', 'Épico', 3),               -- Zelda BOTW
(4, 'Cartão de Jogador Ouro', 'Raro', 4),       -- FIFA 24
(5, 'Machete de Guerrilha', 'Comum', 5),       -- Far Cry 6
(6, 'Bastão de Beisebol', 'Comum', 6),          -- GTA V
(7, 'Elmo de Shako', 'Lendário', 7),           -- Diablo IV
(8, 'Invencível (Espada)', 'Épico', 8),        -- Final Fantasy XVI
(9, 'Erva Verde', 'Comum', 9),                 -- Resident Evil 4
(10, 'Lágrima Larvar', 'Raro', 10),            -- Elden Ring
(11, 'Esmeralda do Caos', 'Lendário', 11),     -- Sonic Frontiers
(12, 'Varinha de Videira', 'Raro', 12),        -- Hogwarts Legacy
(13, 'Fragmento de Artefato', 'Épico', 13),    -- Starfield
(14, 'Matéria Escura', 'Raro', 14),            -- Stellaris
(15, 'Lâminas Mantis', 'Épico', 15),           -- Cyberpunk 2077
(16, 'Espada de Alta Frequência', 'Épico', 16),-- Metal Gear Rising
(17, 'Gerador de Portais', 'Lendário', 17),    -- Portal 2
(18, 'Poção de Escudo', 'Comum', 18),          -- Fortnite
(19, 'Alma de Cinzas', 'Lendário', 19),        -- Dark Souls III
(20, 'Estilingue de Amicia', 'Comum', 20),     -- A Plague Tale
(21, 'Velo de Ouro', 'Épico', 21),             -- Cult of the Lamb
(22, 'Extintor de Incêndio', 'Comum', 22),     -- Overcooked 2
(23, 'Relíquia Abissal', 'Raro', 23),          -- Dredge
(24, 'Mochila de Drone', 'Comum', 24),         -- Stray
(25, 'Célula de Energia', 'Raro', 25),         -- Satisfactory
(26, 'Máscara de Gás', 'Comum', 26),           -- Metro Exodus
(27, 'Objeto de Poder', 'Épico', 27),          -- Control
(28, 'Soro Vampírico', 'Raro', 28),            -- Vampyr
(29, 'Gancho de Escalada', 'Raro', 29),        -- Dying Light 2
(30, 'Munição Perfurante', 'Comum', 30);       -- Sniper Elite 5

-- INVENTARIO USUARIO
INSERT INTO inventario_usuario (id, id_item_base, id_usuario_dono) VALUES
(1,1,1), (2,16,2), (3,2,3), (4,17,4), (5,3,5), (6,18,6), (7,4,7), (8,19,8), (9,5,9), (10,20,10),
(11,6,11), (12,21,12), (13,7,13), (14,22,14), (15,8,15), (16,23,16), (17,9,17), (18,24,18), (19,10,19), (20,25,20),
(21,11,21), (22,26,22), (23,12,23), (24,27,24), (25,13,25), (26,28,26), (27,14,27), (28,29,28), (29,15,29), (30,30,30);

-- MERCADO ANUNCIO
INSERT INTO mercado_anuncio (id, id_inventario_item, preco_venda, id_vendedor) VALUES
(1,1,250.00,1), (2,2,180.00,2), (3,3,150.00,3), (4,4,500.00,4), (5,5,120.00,5), (6,6,300.00,6),
(7,7,450.00,7), (8,8,600.00,8), (9,9,50.00,9), (10,10,400.00,10), (11,11,15.00,11), (12,12,25.00,12),
(13,13,80.00,13), (14,14,90.00,14), (15,15,320.00,15), (16,16,140.00,16), (17,17,110.00,17), (18,18,210.00,18),
(19,19,450.00,19), (20,20,550.00,20), (21,21,12.00,21), (22,22,18.00,22), (23,23,200.00,23), (24,24,220.00,24),
(25,25,600.00,25), (26,26,45.00,26), (27,27,85.00,27), (28,28,999.00,28), (29,29,35.00,29), (30,30,10.00,30);

-- INSIGNIA
INSERT INTO insignia (id, nome, xp_recompensa, id_jogo) VALUES
(1, 'Matador de Deuses', 500, 1),           -- God of War
(2, 'Spartan Lendário', 450, 2),           -- Halo Infinite
(3, 'Herói de Hyrule', 600, 3),            -- Zelda BOTW
(4, 'Artilheiro de Ouro', 300, 4),         -- FIFA 24
(5, 'Libertador de Yara', 350, 5),         -- Far Cry 6
(6, 'Magnata do Crime', 400, 6),           -- GTA V
(7, 'Andarilho do Inferno', 550, 7),       -- Diablo IV
(8, 'Portador do Cristal', 500, 8),        -- Final Fantasy XVI
(9, 'Mestre do Survival', 450, 9),         -- Resident Evil 4
(10, 'Lorde Prístino', 700, 10),           -- Elden Ring
(11, 'Velocidade Supersônica', 300, 11),   -- Sonic Frontiers
(12, 'Bruxo de Hogwarts', 400, 12),        -- Hogwarts Legacy
(13, 'Explorador das Estrelas', 500, 13),  -- Starfield
(14, 'Imperador Galáctico', 350, 14),      -- Stellaris
(15, 'Lenda de Night City', 450, 15),      -- Cyberpunk 2077
(16, 'Ciborgue de Elite', 300, 16),        -- Metal Gear Rising
(17, 'Mestre dos Portais', 250, 17),       -- Portal 2
(18, 'Mestre do Drop', 200, 18),           -- Fortnite
(19, 'Alma das Cinzas', 600, 19),          -- Dark Souls III
(20, 'Sobrevivente da Peste', 350, 20),    -- A Plague Tale
(21, 'Líder do Culto', 300, 21),           -- Cult of the Lamb
(22, 'Chef de Estrela Michelin', 200, 22), -- Overcooked 2
(23, 'Pescador do Abismo', 250, 23),       -- Dredge
(24, 'Miau-ventureiro', 250, 24),          -- Stray
(25, 'Eficiência Industrial', 300, 25),    -- Satisfactory
(26, 'Rastreador do Metro', 350, 26),      -- Metro Exodus
(27, 'Diretor do FBC', 350, 27),           -- Control
(28, 'Doutor das Sombras', 300, 28),       -- Vampyr
(29, 'Mestre do Parkour', 400, 29),        -- Dying Light 2
(30, 'Atirador de Elite', 350, 30);        -- Sniper Elite 5

-- INSIGNIA USUARIO
INSERT INTO insignia_usuario (id_usuario, id_insignia, nivel) VALUES
(1,1,5), (2,3,1), (3,1,2), (4,3,2), (5,1,1), (6,4,3), (7,2,5), (8,3,4), (9,2,2), (10,4,5),
(11,1,1), (12,3,1), (13,1,2), (14,4,2), (15,2,1), (16,3,3), (17,1,4), (18,4,5), (19,2,3), (20,3,1),
(21,1,1), (22,4,2), (23,2,1), (24,3,2), (25,1,3), (26,4,4), (27,2,5), (28,3,1), (29,1,2), (30,4,3);
