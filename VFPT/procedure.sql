CREATE OR REPLACE PROCEDURE ComprarJogo(
    p_usuario INT,
    p_jogo INT
)
LANGUAGE plpgsql
AS
$$
DECLARE
    v_preco NUMERIC(10,2);
    v_nova_biblioteca_id INT;
BEGIN

    IF NOT EXISTS (
        SELECT 1
        FROM usuario
        WHERE id = p_usuario
    ) THEN
        RAISE EXCEPTION 'Usuário % não encontrado', p_usuario;
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM jogo
        WHERE id = p_jogo
    ) THEN
        RAISE EXCEPTION 'Jogo % não encontrado', p_jogo;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM biblioteca
        WHERE id_usuario = p_usuario
        AND id_jogo = p_jogo
    ) THEN
        RAISE EXCEPTION 'Usuário já possui este jogo na biblioteca';
    END IF;

    SELECT COALESCE(MAX(id),0)+1
    INTO v_nova_biblioteca_id
    FROM biblioteca;

    SELECT valor_localizado
    INTO v_preco
    FROM preco_regional
    WHERE id_jogo = p_jogo
    LIMIT 1;

    INSERT INTO biblioteca (
        id,
        id_usuario,
        id_jogo,
        tempo_jogado_min,
        data_aquisicao
    )
    VALUES (
        v_nova_biblioteca_id,
        p_usuario,
        p_jogo,
        0,
        CURRENT_TIMESTAMP
    );

    RAISE NOTICE 'Jogo comprado com sucesso. Preço: %', v_preco;

END;
$$;


CREATE OR REPLACE PROCEDURE ListarItemMercado(
    p_id_inventario_item INT,
    p_preco NUMERIC(10,2)
)
LANGUAGE plpgsql
AS
$$
DECLARE
    v_vendedor INT;
    v_novo_id INT;
BEGIN

    SELECT id_usuario_dono
    INTO v_vendedor
    FROM inventario_usuario
    WHERE id = p_id_inventario_item;

    IF v_vendedor IS NULL THEN
        RAISE EXCEPTION 'Item de inventário não encontrado.';
    END IF;

    SELECT COALESCE(MAX(id),0) + 1
    INTO v_novo_id
    FROM mercado_anuncio;

    INSERT INTO mercado_anuncio(
        id,
        id_inventario_item,
        preco_venda,
        id_vendedor
    )
    VALUES(
        v_novo_id,
        p_id_inventario_item,
        p_preco,
        v_vendedor
    );

    RAISE NOTICE 'Item listado no mercado com sucesso.';
END;
$$;


CREATE OR REPLACE PROCEDURE RegistrarAvaliacao(
    p_usuario INT,
    p_jogo INT,
    p_nota INT,
    p_comentario VARCHAR(2000),
    p_recomendado BOOLEAN
)
LANGUAGE plpgsql
AS
$$
DECLARE
    v_novo_id INT;
BEGIN

    IF p_nota < 1 OR p_nota > 5 THEN
        RAISE EXCEPTION 'A nota deve estar entre 1 e 5.';
    END IF;

    SELECT COALESCE(MAX(id),0) + 1
    INTO v_novo_id
    FROM avaliacao;

    INSERT INTO avaliacao(
        id,
        id_usuario,
        id_jogo,
        texto,
        recomendado_bool,
        data_postagem,
        nota
    )
    VALUES(
        v_novo_id,
        p_usuario,
        p_jogo,
        p_comentario,
        p_recomendado,
        CURRENT_DATE,
        p_nota
    );

    UPDATE jogo
    SET media_avaliacao = (
        SELECT ROUND(AVG(nota),2)
        FROM avaliacao
        WHERE id_jogo = p_jogo
    )
    WHERE id = p_jogo;

END;
$$;
