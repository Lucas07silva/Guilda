-- parte 1

CREATE OR REPLACE FUNCTION fn_verificar_saldo_compra()
RETURNS TRIGGER
LANGUAGE plpgsql
AS
$$
DECLARE
    v_saldo NUMERIC(10,2);
BEGIN

    SELECT saldo
    INTO v_saldo
    FROM carteira_usuario
    WHERE id_usuario = NEW.id_usuario;

    IF v_saldo < NEW.valor_total THEN
        RAISE EXCEPTION
        'Saldo insuficiente. Saldo atual: %, Valor da compra: %',
        v_saldo,
        NEW.valor_total;
    END IF;

    RETURN NEW;

END;
$$;


-- parte 2


CREATE TRIGGER VerificarSaldoCompra
BEFORE INSERT
ON transacao
FOR EACH ROW
EXECUTE FUNCTION fn_verificar_saldo_compra();




CREATE OR REPLACE FUNCTION fn_log_transacao_mercado()
RETURNS TRIGGER
LANGUAGE plpgsql
AS
$$
DECLARE
    v_novo_id INT;
    v_item_base INT;
BEGIN

    SELECT iu.id_item_base
    INTO v_item_base
    FROM inventario_usuario iu
    WHERE iu.id = OLD.id_inventario_item;

    SELECT COALESCE(MAX(id),0) + 1
    INTO v_novo_id
    FROM mercado_historico;

    INSERT INTO mercado_historico (
        id,
        id_item_base,
        valor_venda,
        data_venda
    )
    VALUES (
        v_novo_id,
        v_item_base,
        OLD.preco_venda,
        CURRENT_TIMESTAMP
    );

    RETURN OLD;

END;
$$;



CREATE TRIGGER LogTransacaoMercado
AFTER DELETE
ON mercado_anuncio
FOR EACH ROW
EXECUTE FUNCTION fn_log_transacao_mercado();


-- parte 3


CREATE OR REPLACE FUNCTION fn_atualizar_media_rating()
RETURNS TRIGGER
LANGUAGE plpgsql
AS
$$
BEGIN

    UPDATE jogo
    SET media_avaliacao = (
        SELECT ROUND(AVG(nota), 2)
        FROM avaliacao
        WHERE id_jogo = NEW.id_jogo
    )
    WHERE id = NEW.id_jogo;

    RETURN NEW;

END;
$$;



CREATE TRIGGER AtualizarMediaRating
AFTER INSERT
ON avaliacao
FOR EACH ROW
EXECUTE FUNCTION fn_atualizar_media_rating();
