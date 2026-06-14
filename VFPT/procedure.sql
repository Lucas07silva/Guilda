-- 4. biblioteca-progresso
CREATE OR REPLACE PROCEDURE atualizar_save_nuvem(
    p_id_usuario INT, 
    p_id_jogo INT, 
    p_link_arquivo VARCHAR
)
AS $$
BEGIN
    INSERT INTO save_jogo (id, id_usuario, id_jogo, link_arquivo, data_sync)
    VALUES (
        (SELECT COALESCE(MAX(id), 0) + 1 FROM save_jogo), 
        p_id_usuario, 
        p_id_jogo, 
        p_link_arquivo, 
        NOW()
    )
    ON CONFLICT (id_usuario, id_jogo)
    DO UPDATE SET link_arquivo = EXCLUDED.link_arquivo, data_sync = NOW();
END;
$$ LANGUAGE plpgsql;


-- 5.inventario_mercado
CREATE OR REPLACE PROCEDURE ListarItemMercado()
LANGUAGE plpgsql AS $$
DECLARE
    r RECORD;
BEGIN
    FOR r IN 
        SELECT 
            ma.id AS anuncio_id,
            p.nick_name AS vendedor, -- Corrigido para buscar da tabela perfil (01)
            ib.nome AS item_nome,
            ib.raridade,
            j.titulo AS jogo_origem, -- Corrigido de j.nome para j.titulo (02)
            ma.preco_venda,
            CalcularTaxaMercado(ma.preco_venda, ma.id_vendedor, ib.id) AS taxa_mercado
        FROM mercado_anuncio ma
        JOIN perfil p ON ma.id_vendedor = p.id_usuario -- Ajuste de integração
        JOIN inventario_usuario iu ON ma.id_inventario_item = iu.id
        JOIN item_base ib ON iu.id_item_base = ib.id
        JOIN jogo j ON ib.id_jogo_origem = j.id
    LOOP
        RAISE NOTICE 'Anúncio: % | Vendedor: % | Item: % (%) | Jogo: % | Preço: R$ % | Taxa Estimada: R$ %',
            r.anuncio_id, r.vendedor, r.item_nome, r.raridade, r.jogo_origem, r.preco_venda, r.taxa_mercado;
    END LOOP;
END;
$$;
