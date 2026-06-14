
-- 5.inventario_mercado

CREATE OR REPLACE FUNCTION fn_log_transacao_mercado()
RETURNS TRIGGER AS $$
DECLARE
    v_id_item_base INT;
BEGIN
    SELECT id_item_base INTO v_id_item_base
    FROM inventario_usuario
    WHERE id = OLD.id_inventario_item;

    INSERT INTO mercado_historico (id, id_item_base, valor_venda, data_venda)
    VALUES (
        COALESCE((SELECT MAX(id) FROM mercado_historico), 0) + 1,
        v_id_item_base,
        OLD.preco_venda,
        CURRENT_TIMESTAMP
    );
    
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS LogTransacaoMercado ON mercado_anuncio;
CREATE TRIGGER LogTransacaoMercado
AFTER DELETE ON mercado_anuncio
FOR EACH ROW
EXECUTE FUNCTION fn_log_transacao_mercado();
