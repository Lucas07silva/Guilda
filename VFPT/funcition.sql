CREATE OR REPLACE FUNCTION CalcularPlaytimeTotal(
    p_usuario INT
)
RETURNS NUMERIC(10,2)
LANGUAGE plpgsql
AS
$$
DECLARE
    v_total_horas NUMERIC(10,2);
BEGIN

    SELECT COALESCE(SUM(tempo_jogado_min),0) / 60.0
    INTO v_total_horas
    FROM biblioteca
    WHERE id_usuario = p_usuario;

    RETURN ROUND(v_total_horas,2);

END;
$$;


CREATE OR REPLACE FUNCTION CalcularTaxaMercado(
    p_valor_venda NUMERIC(10,2)
)
RETURNS NUMERIC(10,2)
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN ROUND(p_valor_venda * 0.10, 2);
END;
$$;


CREATE OR REPLACE FUNCTION VerificarRaridadeItem(
    p_id_inventario INT
)
RETURNS VARCHAR(50)
LANGUAGE plpgsql
AS
$$
DECLARE
    v_raridade VARCHAR(50);
BEGIN

    SELECT ib.raridade
    INTO v_raridade
    FROM inventario_usuario iu
    JOIN item_base ib
        ON ib.id = iu.id_item_base
    WHERE iu.id = p_id_inventario;

    IF v_raridade IS NULL THEN
        RETURN 'Item não encontrado';
    END IF;

    RETURN v_raridade;

END;
$$;
