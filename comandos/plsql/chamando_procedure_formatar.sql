create or replace NONEDITIONABLE PROCEDURE incluir_cliente (
    p_id                   IN cliente.id%TYPE,
    p_razao_social         IN cliente.razao_social%TYPE,
    p_cnpj                 IN cliente.cnpj%TYPE,
    p_segmercado_id        IN cliente.segmercado_id%TYPE,
    p_faturamento_previsto IN cliente.faturamento_previsto%TYPE
) IS
    v_categoria cliente.categoria%TYPE;
    v_cnpj cliente.cnpj%type := p_cnpj;
BEGIN
    
    -- FUN��O:
    -- Atribuir a VARIAVEL v_categoria a FUN��O categoria_cliente que ir� receber o parametro da variavel p_faturamento_previsto, que � o faturamento do cliente;
    v_categoria := categoria_cliente(p_faturamento_previsto);

    -- PROCEDURE:
    -- formatar_cnpj(p_cnpj); a express�o 'P_CNPJ' n�o pode ser usada como um destino de designa��o: N�o poder� mudar o seu valor, pois j� esta entrando na procedure formatar_cnpj como IN    
    -- desta forma ser� utilizado a variavel de trabalho, qual n�o � uma variavel IN, e que ir� receber o valor inicial que vem de p_cnpj.
    formatar_cnpj(v_cnpj);

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
        v_cnpj,
        p_segmercado_id,
        sysdate,
        p_faturamento_previsto,
        v_categoria
    );
    COMMIT;
END;

SELECT * FROM cliente;

EXECUTE incluir_cliente(1, 'Supermercado', '23453331000123', 1, 900000);
EXECUTE incluir_cliente(3, 'Hipermercado', '23453331000223', 1, 800000);
EXECUTE incluir_cliente(4, 'Farmacia Farm', '11159931000223', 1, 10000);
EXECUTE incluir_cliente(5, 'Mercearia Merc', '34321231000112', 1, 8000);
EXECUTE incluir_cliente(6, 'Lojas Americana', '02158921000222', 1, 90000);





