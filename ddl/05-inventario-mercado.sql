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
(1, 'Elden Ring', 'FromSoftware'),
(2, 'Cyberpunk 2077', 'CD Projekt Red');

-- ITEM BASE
INSERT INTO item_base (id, nome, raridade, id_jogo_origem) VALUES
(1, 'Rivers of Blood', 'Legendary', 1), (2, 'Moonveil Katana', 'Epic', 1), (3, 'Blasphemous Blade', 'Legendary', 1),
(4, 'Malenia Armor Set', 'Legendary', 1), (5, 'Radagon Icon', 'Rare', 1), (6, 'Golden Seed', 'Uncommon', 1),
(7, 'Mimic Tear Ashes', 'Legendary', 1), (8, 'Dark Moon Greatsword', 'Legendary', 1), (9, 'Erdtree Favor', 'Rare', 1),
(10, 'Starscourge Sword', 'Legendary', 1), (11, 'Buckler', 'Common', 1), (12, 'Fingerprint Shield', 'Epic', 1),
(13, 'Comet Azur', 'Epic', 1), (14, 'White Mask', 'Rare', 1), (15, 'Great-Jar Arsenal', 'Epic', 1),
(16, 'Mantis Blades', 'Epic', 2), (17, 'Monowire', 'Epic', 2), (18, 'Silverhand Jacket', 'Legendary', 2),
(19, 'Malorian Arms 3516', 'Legendary', 2), (20, 'Sandevistan Mk.4', 'Legendary', 2), (21, 'Kiroshi Optics', 'Common', 2),
(22, 'Arasaka Neural Link', 'Rare', 2), (23, 'Gorilla Arms', 'Epic', 2), (24, 'Projectile Launcher', 'Epic', 2),
(25, 'Satori Katana', 'Legendary', 2), (26, 'Lizzie Pistol', 'Rare', 2), (27, 'Widow Maker', 'Epic', 2),
(28, 'Skippy AI Gun', 'Legendary', 2), (29, 'Netwatch Driver', 'Rare', 2), (30, 'Trauma Team Kit', 'Uncommon', 2);

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
(1, 'Elden Lord', 1000, 1), (2, 'Shards Bearer', 500, 1),
(3, 'Night City Legend', 1000, 2), (4, 'Cyberpsycho Hunter', 450, 2);

-- INSIGNIA USUARIO
INSERT INTO insignia_usuario (id_usuario, id_insignia, nivel) VALUES
(1,1,5), (2,3,1), (3,1,2), (4,3,2), (5,1,1), (6,4,3), (7,2,5), (8,3,4), (9,2,2), (10,4,5),
(11,1,1), (12,3,1), (13,1,2), (14,4,2), (15,2,1), (16,3,3), (17,1,4), (18,4,5), (19,2,3), (20,3,1),
(21,1,1), (22,4,2), (23,2,1), (24,3,2), (25,1,3), (26,4,4), (27,2,5), (28,3,1), (29,1,2), (30,4,3);
