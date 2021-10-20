-- Comando / Estrutra para criar um Programa simples Pl/Sql:
DECLARE
    v_id        segmercado.id%TYPE := 3;
    v_descricao segmercado.descricao%TYPE := 'Esportista';
BEGIN
    INSERT INTO segmercado (
        id,
        descricao
    ) VALUES (
        v_id,
        upper(v_descricao)
    );
    COMMIT;
END;


-- Comando / Estrutra para criar uma procedure:------------------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE incluir_segmercado                 --(nome da procedure para depois ser chamada)
    (p_ID IN NUMBER, p_descricao in varchar2)       -- variaveis iremos ter outro padr�o, a inves de usar v_ usar p_                          
IS                                                  -- IS: Todas as variaveis que ser�o utilizadas, mesmo que n�o houver variavel a ser declarada, � necessario declarar IS e BEGIN
BEGIN
    INSERT INTO segmercado (ID, descricao) VALUES (p_ID, UPPER(p_descricao));    -- Comando de inser��o ...
    COMMIT;                                                                      -- Commit da programa��o ...
END;


---- CHAMANDO A PROCEDURE ---------------------------------------------------------------------------------------------------------------------------------------------------------
-- ao chamar a procedure, � desviada para um outro c�digo salvo, e ele ir� executar algo, m�s n�o iremos saber aquilo que foi executado (chama, faz algo, e depois retorna)
-- Para executar nossa procedure, precisamo utilizar o seguinte comando EXECUTE:

EXECUTE incluir_segmercado(3,'Farmaceuticos');      -- adicionando um novo segmento a partir da procedure

-- Outra forma de Executar nossa procedure:
BEGIN
    incluir_segmercado(4, 'Industrial');
END;


-- Manuten��o da procedure (Corrigindo nossa procedure) usando or replace para mudar as configura��es... parametros, etc.----------------------------------------------------------
CREATE OR REPLACE PROCEDURE incluir_segmercado (
    p_id        IN segmercado.id%TYPE,
    p_descricao IN segmercado.descricao%TYPE
) IS
BEGIN
    INSERT INTO segmercado (
        id,
        descricao
    ) VALUES (
        p_id,
        upper(p_descricao)
    );

    COMMIT;
END;









