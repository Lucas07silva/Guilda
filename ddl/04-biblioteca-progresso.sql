-- drop tables
   DROP TABLE IF EXISTS biblioteca CASCADE;
   DROP TABLE IF EXISTS conquista CASCADE;
   DROP TABLE IF EXISTS conquista_usuario CASCADE;
   DROP TABLE IF EXISTS save_jogo CASCADE;
   DROP TABLE IF EXISTS historico_sessao CASCADE;

-- tabela biblioteca (jogos adquiridos por usuário)
create table biblioteca (
    id int not null,
    id_usuario int not null,
    id_jogo int not null,
    tempo_jogado_min int,
    data_aquisicao timestamp,
    unique (id_usuario, id_jogo),
    primary key (id),
    foreign key (id_usuario) references usuario(id),
    foreign key (id_jogo) references jogo(id)
);

-- tabela conquista (conquistas por jogo)
create table conquista (
    id int not null,
    id_jogo int not null,
    nome varchar(200) not null,
    descricao varchar(255) not null,
    primary key (id),
    foreign key (id_jogo) references jogo(id)
);

-- tabela conquista_usuario (conquistas desbloqueadas)
create table conquista_usuario (
    id int not null,
    id_usuario int not null,
    id_conquista int not null,
    data_desbloqueio timestamp default now(),
    unique (id_usuario, id_conquista),
    primary key (id),
    foreign key (id_usuario) references usuario(id),
    foreign key (id_conquista) references conquista(id)
);

-- tabela save_jogo (arquivos de save na nuvem)
create table save_jogo (
    id int not null,
    id_usuario int not null,
    id_jogo int not null,
    link_arquivo varchar(500) not null,
    data_sync timestamp default now(),
    primary key (id),
    foreign key (id_usuario) references usuario(id),
    foreign key (id_jogo) references jogo(id)
);

-- tabela historico_sessao (registro de sessões de jogo)
create table historico_sessao (
    id int not null,
    id_usuario int not null,
    id_jogo int not null,
    data_inicio timestamp not null,
    data_fim timestamp,
    primary key (id),
    foreign key (id_usuario) references usuario(id),
    foreign key (id_jogo) references jogo(id)
);

INSERT INTO conquista (id, id_jogo, nome, descricao) VALUES
(1, 1, 'Primeiros Passos', 'Complete a introdução'), (2, 2, 'Mestre das Armas', 'Alcance o nível máximo de perícia'),
(3, 3, 'Explorador', 'Descubra todas as áreas do mapa'), (4, 4, 'Artilheiro', 'Marque 50 gols'),
(5, 5, 'Libertador', 'Libere o primeiro posto avançado'), (6, 6, 'Magnata', 'Acumule 1 milhão de dólares'),
(7, 7, 'Exorcista', 'Derrote o primeiro chefe demoníaco'), (8, 8, 'Legado', 'Conclua a missão principal'),
(9, 9, 'Sobrevivente', 'Termine o jogo no modo difícil'), (10, 10, 'Lorde Prístino', 'Derrote o chefe final'),
(11, 11, 'Velocidade da Luz', 'Complete um desafio de tempo'), (12, 12, 'Bruxo Honorário', 'Aprenda todos os feitiços'),
(13, 13, 'Astronauta', 'Pouse em 10 planetas diferentes'), (14, 14, 'Diplomata', 'Forme uma federação galáctica'),
(15, 15, 'Samurai da Rede', 'Hackeie 50 terminais'), (16, 16, 'Corte Mortal', 'Realize 100 parries'),
(17, 17, 'Cobaia de Teste', 'Complete todas as câmaras'), (18, 18, 'Vitória Real', 'Vença sua primeira partida'),
(19, 19, 'Acenda a Fogueira', 'Descanse pela primeira vez'), (20, 20, 'Protetor', 'Salve Hugo do perigo'),
(21, 21, 'Líder Supremo', 'Consiga 20 seguidores'), (22, 22, 'Chef 5 Estrelas', 'Consiga nota máxima'),
(23, 23, 'Pescador Profano', 'Pesque um peixe mutante'), (24, 24, 'Miau', 'Arranhe 50 vezes'),
(25, 25, 'Eficiência Total', 'Automatize a linha de produção'), (26, 26, 'Sombra do Túnel', 'Conclua o capítulo 1'),
(27, 27, 'Diretor', 'Domine o objeto de poder'), (28, 28, 'Sede de Sangue', 'Alimente-se de 10 cidadãos'),
(29, 29, 'Parkourista', 'Corra 10km pelos telhados'), (30, 30, 'Atirador de Elite', 'Acerte um tiro a 500 metros');

INSERT INTO biblioteca (id, id_usuario, id_jogo, tempo_jogado_min, data_aquisicao) VALUES
(1, 1, 1, 1200, '2026-01-10 10:00:00'), (2, 2, 2, 500, '2026-01-12 11:00:00'),
(3, 3, 3, 3000, '2026-01-15 14:00:00'), (4, 4, 4, 150, '2026-01-20 09:00:00'),
(5, 5, 5, 800, '2026-01-22 16:00:00'), (6, 6, 6, 4500, '2026-01-25 18:00:00'),
(7, 7, 7, 200, '2026-01-28 20:00:00'), (8, 8, 8, 120, '2026-02-01 22:00:00'),
(9, 9, 9, 900, '2026-02-03 10:00:00'), (10, 10, 10, 5000, '2026-02-05 11:30:00'),
(11, 11, 11, 300, '2026-02-07 13:00:00'), (12, 12, 12, 1500, '2026-02-09 15:45:00'),
(13, 13, 13, 200, '2026-02-11 17:00:00'), (14, 14, 14, 80, '2026-02-13 19:00:00'),
(15, 15, 15, 2500, '2026-02-15 21:00:00'), (16, 16, 16, 400, '2026-02-17 08:00:00'),
(17, 17, 17, 180, '2026-02-19 09:30:00'), (18, 18, 18, 10, '2026-02-21 10:15:00'),
(19, 19, 19, 3500, '2026-02-23 11:00:00'), (20, 20, 20, 600, '2026-02-25 12:40:00'),
(21, 21, 21, 450, '2026-02-27 14:10:00'), (22, 22, 22, 120, '2026-03-01 15:00:00'),
(23, 23, 23, 300, '2026-03-03 16:30:00'), (24, 24, 24, 90, '2026-03-05 17:50:00'),
(25, 25, 25, 2000, '2026-03-07 19:10:00'), (26, 26, 26, 750, '2026-03-09 20:00:00'),
(27, 27, 27, 400, '2026-03-11 21:20:00'), (28, 28, 28, 150, '2026-03-13 22:30:00'),
(29, 29, 29, 1100, '2026-03-15 23:40:00'), (30, 30, 30, 800, '2026-03-16 01:00:00');

INSERT INTO conquista_usuario (id, id_usuario, id_conquista, data_desbloqueio) VALUES
(1, 1, 1, '2026-03-10 10:00:00'),
(2, 2, 2, '2026-03-11 15:30:00'),
(3, 10, 10, '2026-03-12 20:00:00');

INSERT INTO save_jogo (id, id_usuario, id_jogo, link_arquivo, data_sync) VALUES
(1, 1, 1, 'https://cloud.com/save/u1_j1.bin', '2026-03-15 10:00:00'),
(2, 2, 2, 'https://cloud.com/save/u2_j2.bin', '2026-03-15 11:00:00'),
(3, 10, 10, 'https://cloud.com/save/u10_j10.bin', '2026-03-16 08:00:00');

INSERT INTO historico_sessao (id, id_usuario, id_jogo, data_inicio, data_fim) VALUES
(1, 1, 1, '2026-03-16 19:00:00', '2026-03-16 21:00:00'),
(2, 2, 2, '2026-03-16 20:00:00', '2026-03-16 20:30:00'),
(3, 10, 10, '2026-03-16 15:00:00', '2026-03-16 18:00:00');
