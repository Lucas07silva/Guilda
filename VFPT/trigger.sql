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





CREATE TRIGGER VerificarSaldoCompra
BEFORE INSERT
ON transacao
FOR EACH ROW
EXECUTE FUNCTION fn_verificar_saldo_compra();
