
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
