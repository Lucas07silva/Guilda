CREATE TABLE item_base (
    id INT NOT NULL PRIMARY KEY,
    nome VARCHAR(255),
    raridade VARCHAR(50),
    id_jogo_origem INT NOT NULL
);

CREATE TABLE inventario_usuario (
    id INT NOT NULL PRIMARY KEY,
    id_item_base INT NOT NULL,
    id_usuario_dono INT NOT NULL
);

CREATE TABLE mercado_anuncio (
    id INT NOT NULL PRIMARY KEY,
    id_serial_item INT NOT NULL,
    preco_venda DECIMAL(10, 2),
    id_vendedor INT NOT NULL
);

CREATE TABLE mercado_historico (
    id INT NOT NULL PRIMARY KEY,
    id_item_base INT NOT NULL,
    valor_venda DECIMAL(10, 2),
    data_venda TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE oferta_troca (
    id INT NOT NULL PRIMARY KEY,
    id_remetente INT NOT NULL,
    id_destinatario INT NOT NULL,
    status VARCHAR(50)
);

CREATE TABLE item_oferta_troca (
    id_oferta INT NOT NULL,
    id_serial_item INT NOT NULL,
    PRIMARY KEY (id_oferta, id_serial_item)
);

CREATE TABLE insignia (
    id INT NOT NULL PRIMARY KEY,
    nome VARCHAR(255),
    xp_recompensa INT NOT NULL,
    id_jogo INT NOT NULL
);

CREATE TABLE insignia_usuario (
    id_usuario INT NOT NULL,
    id_insignia INT NOT NULL,
    nivel INT NOT NULL,
    PRIMARY KEY (id_usuario, id_insignia)
);
