CREATE OR REPLACE PROCEDURE incluir_cliente (
    p_id                   IN cliente.id%TYPE,
    p_razao_social         IN cliente.razao_social%TYPE,
    p_cnpj                 IN cliente.cnpj%TYPE,
    p_segmercado_id        IN cliente.segmercado_id%TYPE,
    p_faturamento_previsto IN cliente.faturamento_previsto%TYPE
) IS
    v_categoria cliente.categoria%TYPE;
BEGIN
    -- Atribuir a VARIAVEL v_categoria a FUNÇÃO categoria_cliente que irá receber o parametro da variavel p_faturamento_previsto, que é o faturamento do cliente;
    v_categoria := categoria_cliente(p_faturamento_previsto);

    INSERT INTO cliente (
        id,
        razao_social,
        cnpj,
        segmercado_id,
        data_inclusao,
        faturamento_previsto,
        categoria
    ) VALUES (
        p_id,
        p_razao_social,
        p_cnpj,
        p_segmercado_id,
        sysdate,
        p_faturamento_previsto,
        v_categoria
    );
    COMMIT;
END;

DELETE FROM cliente;

SELECT
    *
FROM
    cliente;

EXECUTE incluir_cliente(2, 'Supermeracado', '23314992000121', 3, 11000);

SELECT
    substr(cnpj, 1, 2)
    || '.'
    || substr(cnpj, 3, 3)
    || '.'
    || substr(cnpj, 6, 3)
    || '/'
    || substr(cnpj, 9, 4)
    || '-'
    || substr(cnpj, 13, 2)
FROM
    cliente;
-- 23 . 314 . 992 / 0001 - 21



VARIABLE g_categoria VARCHAR2(100);
EXECUTE :g_categoria := categoria_cliente(p_faturamento_previsto=>500000);
PRINT g_categoria;

