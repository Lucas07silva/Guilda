DROP TABLE IF EXISTS publicadora CASCADE;
DROP TABLE IF EXISTS jogo CASCADE;
DROP TABLE IF EXISTS dlc CASCADE;
DROP TABLE IF EXISTS genero CASCADE;
DROP TABLE IF EXISTS tag CASCADE;
DROP TABLE IF EXISTS jogo_genero CASCADE;
DROP TABLE IF EXISTS jogo_tag CASCADE;
DROP TABLE IF EXISTS idioma CASCADE;
DROP TABLE IF EXISTS jogo_idioma cascade;
DROP TABLE IF EXISTS requisito_sistema CASCADE;


-- Tabela de Publicadoras
create table publicadora(
    id int not null,
    nome varchar(50) not null,
    sede varchar(50) not null,
    primary key (id)
);

-- Tabela de Jogos
create table jogo (
    id int not null,
    id_publicadora int not null,
    titulo varchar(60),
    resumo varchar(800),
    preco_base decimal (10,2),
    primary key (id),
    foreign key (id_publicadora) references publicadora(id)
);

-- Tabela de DLCs (Relacionamento 1:N)
create table dlc (
    id int not null,
    titulo varchar(60),
    preco decimal (10,2),
    id_jogo int,
    primary key (id),
    foreign key (id_jogo) references jogo(id)
);

-- Tabela de generos
create table genero (
    id int not null,
    nome_genero varchar(40),
    primary key (id)
);

-- Tabela de Tags
create table tag (
    id int not null,
    nome_tag varchar(50) not null,
    primary key (id)
);

-- Tabela de Idiomas
create table idioma (
    id int not null,
    nome_idioma varchar(50) not null,
    primary key (id)
);

-- Tabela de jogo_genero (relacionamento N:N)
create table jogo_genero (
    id int not null,
    id_jogo int,
    id_genero int,
    primary key (id),
    foreign key (id_jogo) references jogo(id),
    foreign key (id_genero) references genero(id)
    );

-- Tabela de Jogos_Tags (Relacionamento N:N)
create table jogo_tag (
    id int not null,
    id_jogo int not null,
    id_tag int not null,
    numero_votos int default 0,
    primary key (id),
    foreign key (id_jogo) references jogo(id),
    foreign key (id_tag) references tag(id)
);

-- Tabela de Jogos_Idiomas
create table jogo_idioma (
    id int not null,
    id_jogo int not null,
    id_idioma int not null,
    dublado_bool boolean,
    legendado_bool boolean,
    primary key (id),
    foreign key (id_jogo) references jogo(id),
    foreign key (id_idioma) references idioma(id)
);

-- Tabela de Requisitos_Sistema
create table requisito_sistema (
    id int not null,
    id_jogo int not null,
    tipo varchar(10) not null, -- 'Min' ou 'Rec'
    cpu varchar(100),
    gpu varchar(100),
    ram varchar(20),
    os varchar(50),
    primary key (id),
    foreign key (id_jogo) references jogo(id)
);

-- Insert 
INSERT INTO publicadora (id, nome, sede) VALUES
(1, 'Sony Interactive', 'San Mateo, EUA'), (2, 'Microsoft Gaming', 'Redmond, EUA'),
(3, 'Nintendo', 'Quioto, Japão'), (4, 'Electronic Arts', 'Redwood, EUA'),
(5, 'Ubisoft', 'Montreuil, França'), (6, 'Take-Two Interactive', 'Nova York, EUA'),
(7, 'Activision Blizzard', 'Santa Monica, EUA'), (8, 'Square Enix', 'Tóquio, Japão'),
(9, 'Capcom', 'Osaka, Japão'), (10, 'Bandai Namco', 'Tóquio, Japão'),
(11, 'Sega', 'Tóquio, Japão'), (12, 'Warner Bros Games', 'Burbank, EUA'),
(13, 'Bethesda Softworks', 'Rockville, EUA'), (14, 'Paradox Interactive', 'Estocolmo, Suécia'),
(15, 'CD Projekt Red', 'Varsóvia, Polônia'), (16, 'Konami', 'Tóquio, Japão'),
(17, 'Valve', 'Bellevue, EUA'), (18, 'Epic Games', 'Cary, EUA'),
(19, 'FromSoftware', 'Tóquio, Japão'), (20, 'Focus Entertainment', 'Paris, França'),
(21, 'Devolver Digital', 'Austin, EUA'), (22, 'Team17', 'Wakefield, Reino Unido'),
(23, 'Raw Fury', 'Estocolmo, Suécia'), (24, 'Annapurna Interactive', 'Los Angeles, EUA'),
(25, 'Coffee Stain Studios', 'Skövde, Suécia'), (26, 'Deep Silver', 'Hofkirchen, Áustria'),
(27, '505 Games', 'Milão, Itália'), (28, 'Focus Home', 'Paris, França'),
(29, 'Techland', 'Wroclaw, Polônia'), (30, 'Rebellion', 'Oxford, Reino Unido');

INSERT INTO jogo (id, id_publicadora, titulo, resumo, preco_base) VALUES
(1, 1, 'God of War', 'Aventura épica nórdica', 199.90), (2, 2, 'Halo Infinite', 'Shooter futurista', 249.00),
(3, 3, 'Zelda BOTW', 'Exploração de mundo aberto', 299.00), (4, 4, 'FIFA 24', 'Simulador de futebol', 350.00),
(5, 5, 'Far Cry 6', 'Revolução em ilha tropical', 150.00), (6, 6, 'GTA V', 'Crime e ação em Los Santos', 99.00),
(7, 7, 'Diablo IV', 'RPG de ação sombrio', 349.00), (8, 8, 'Final Fantasy XVI', 'RPG de fantasia', 320.00),
(9, 9, 'Resident Evil 4', 'Terror e sobrevivência', 199.00), (10, 10, 'Elden Ring', 'Desafio soulslike', 220.00),
(11, 11, 'Sonic Frontiers', 'Aventura em alta velocidade', 180.00), (12, 12, 'Hogwarts Legacy', 'Mundo bruxo', 250.00),
(13, 13, 'Starfield', 'Exploração espacial', 299.00), (14, 14, 'Stellaris', 'Estratégia galáctica', 75.00),
(15, 15, 'Cyberpunk 2077', 'Futuro distópico', 149.00), (16, 16, 'Metal Gear Rising', 'Ação frenética', 49.00),
(17, 17, 'Portal 2', 'Puzzle em primeira pessoa', 32.00), (18, 18, 'Fortnite', 'Battle Royale', 0.00),
(19, 19, 'Dark Souls III', 'Mundo de fantasia sombria', 159.00), (20, 20, 'A Plague Tale', 'Aventura histórica', 170.00),
(21, 21, 'Cult of the Lamb', 'Gerenciamento de seita', 60.00), (22, 22, 'Overcooked 2', 'Cozinha caótica', 45.00),
(23, 23, 'Dredge', 'Pesca sinistra', 70.00), (24, 24, 'Stray', 'Jogo do gatinho', 65.00),
(25, 25, 'Satisfactory', 'Construção de fábricas', 80.00), (26, 26, 'Metro Exodus', 'FPS pós-apocalíptico', 110.00),
(27, 27, 'Control', 'Ação sobrenatural', 95.00), (28, 28, 'Vampyr', 'RPG de vampiro', 85.00),
(29, 29, 'Dying Light 2', 'Zumbis e Parkour', 210.00), (30, 30, 'Sniper Elite 5', 'Tiro tático', 130.00);

INSERT INTO genero (id, nome_genero) VALUES
(1, 'Ação'), (2, 'Aventura'), (3, 'RPG'), (4, 'Simulação'), (5, 'Estratégia'),
(6, 'Esporte'), (7, 'Corrida'), (8, 'Terror'), (9, 'Puzzle'), (10, 'FPS'),
(11, 'TPS'), (12, 'Luta'), (13, 'Plataforma'), (14, 'Indie'), (15, 'Soulslike'),
(16, 'Mundo Aberto'), (17, 'Sobrevivência'), (18, 'MMO'), (19, 'Rhythm'), (20, 'Visual Novel'),
(21, 'Stealth'), (22, 'Sandox'), (23, 'Roguelike'), (24, 'MOBA'), (25, 'Card Game'),
(26, 'Hack and Slash'), (27, 'Point and Click'), (28, 'Real-time Strategy'), (29, 'Turn-based'), (30, 'Battle Royale');

INSERT INTO tag (id, nome_tag) VALUES
(1, 'Singleplayer'), (2, 'Multiplayer'), (3, 'Cooperativo'), (4, 'PvP'), (5, 'História Rica'),
(6, 'Atmosférico'), (7, 'Dificil'), (8, 'Casual'), (9, 'Exploração'), (10, 'Sci-fi'),
(11, 'Fantasia'), (12, 'Zumbis'), (13, 'Cyberpunk'), (14, 'Minimalista'), (15, 'Competitivo'),
(16, 'Retrô'), (17, 'Pixel Art'), (18, 'Trilha Sonora'), (19, 'Violento'), (20, 'Grátis'),
(21, 'Early Access'), (22, 'VR'), (23, 'Space'), (24, 'Gore'), (25, 'Nudity'),
(26, 'Anime'), (27, 'Moddable'), (28, 'Crafting'), (29, 'Building'), (30, 'Controller Support');

INSERT INTO idioma (id, nome_idioma) VALUES
(1, 'Português'), (2, 'Inglês'), (3, 'Espanhol'), (4, 'Francês'), (5, 'Alemão'),
(6, 'Italiano'), (7, 'Japonês'), (8, 'Chinês'), (9, 'Coreano'), (10, 'Russo'),
(11, 'Árabe'), (12, 'Polonês'), (13, 'Holandês'), (14, 'Sueco'), (15, 'Turco'),
(16, 'Grego'), (17, 'Tcheco'), (18, 'Húngaro'), (19, 'Dinamarquês'), (20, 'Finlandês'),
(21, 'Norueguês'), (22, 'Romeno'), (23, 'Ucraniano'), (24, 'Tailandês'), (25, 'Vietnamita'),
(26, 'Indonésio'), (27, 'Hebraico'), (28, 'Hindi'), (29, 'Búlgaro'), (30, 'Eslovaco');

INSERT INTO dlc (id, titulo, preco, id_jogo) VALUES
(1, 'DLC Expansão 1', 29.90, 1),
(2, 'Skin Pack', 15.00, 2),
(3, 'Nível Adicional', 10.00, 3);

INSERT INTO jogo_genero (id, id_jogo, id_genero) VALUES
(1, 1, 1), (2, 1, 2), (3, 2, 10);

INSERT INTO jogo_tag (id, id_jogo, id_tag) VALUES
(1, 1, 1), (2, 1, 5), (3, 2, 2);

INSERT INTO jogo_idioma (id, id_jogo, id_idioma, dublado_bool, legendado_bool) VALUES
(1, 1, 1, true, true), (2, 2, 2, true, true), (3, 3, 1, false, true);

INSERT INTO requisito_sistema (id, id_jogo, tipo, cpu, gpu, ram, os) VALUES
(1, 1, 'Min', 'Intel i5', 'GTX 1060', '8GB', 'Win 10'),
(2, 1, 'Rec', 'Intel i7', 'RTX 2060', '16GB', 'Win 11'),
(3, 2, 'Min', 'Ryzen 5', 'RX 580', '8GB', 'Win 10');
