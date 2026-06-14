
-- 5.inventario_mercado
CREATE OR REPLACE FUNCTION VerificarRaridadeItem(p_id_item_base INT)
RETURNS VARCHAR(50) AS $$
DECLARE
    v_raridade VARCHAR(50);
BEGIN
    SELECT COALESCE(raridade, 'Comum') INTO v_raridade
    FROM item_base
    WHERE id = p_id_item_base;
    
    RETURN v_raridade;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION CalcularTaxaMercado(p_preco_venda DECIMAL(10, 2), p_id_vendedor INT, p_id_item_base INT)
RETURNS DECIMAL(10, 2) AS $$
DECLARE
    v_taxa_percentual DECIMAL(4, 3) := 0.050;
    v_tempo_jogado INT;
    v_id_jogo INT;
BEGIN
    SELECT id_jogo_origem INTO v_id_jogo FROM item_base WHERE id = p_id_item_base;
    SELECT COALESCE(tempo_jogado_min, 0) INTO v_tempo_jogado 
    FROM biblioteca 
    WHERE id_usuario = p_id_vendedor AND id_jogo = v_id_jogo;
    IF v_tempo_jogado >= 1200 THEN
        v_taxa_percentual := 0.025;
    END IF;

    RETURN ROUND(p_preco_venda * v_taxa_percentual, 2);
END;
$$ LANGUAGE plpgsql;
