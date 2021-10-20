-- As poss�veis vantagens abaixo, sobre o armazenamento de procedures no banco de dados:
-- Manuten��o: modificando uma regra de neg�cio, automaticamente, todos os programas PL/SQL que usam estas procedures tamb�m ir�o herdar esta modifica��o.
-- Seguran�a: C�digo interno da procedure � protegido. O analista que a desenvolveu vai colocar as regras de neg�cio l� dentro e o usu�rio que execut�-la n�o poder� modific�-la.

CREATE OR REPLACE PROCEDURE incluir_cliente (
    p_id                   IN cliente.id%TYPE,
    p_razao_social         IN cliente.razao_social%TYPE,
    p_cnpj                 IN cliente.cnpj%TYPE,
    p_segmercado_id        IN cliente.segmercado_id%TYPE,
    p_faturamento_previsto IN cliente.faturamento_previsto%TYPE
) IS
BEGIN
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
        '00000'
    );
    COMMIT;
END;

EXECUTE incluir_cliente (2, 'Supermercado 1', '23415331000290', 1, 9000);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SET SERVEROUTPUT ON;

-- Criado um c�digo PL SQL para saber como achar a categoria do cliente, qual depois ser� transformado em FUNCTION
DECLARE
    v_faturamento_previsto cliente.faturamento_previsto%TYPE:= 100000+1;           ---------------------------------- entrando com a vari�vel ...
    v_categoria cliente.categoria%TYPE;             ----------------------------------------------------------------- outra vari�vel que ira receber o valores de seguinte condi��o
BEGIN
    if v_faturamento_previsto < 10000 then
        v_categoria := 'Pequeno Porte';
    elsif v_faturamento_previsto < 50000 then
        v_categoria := 'M�dio Porte';
    elsif v_faturamento_previsto < 100000 then
        v_categoria :='M�dio Grande Porte';
    else
        v_categoria := 'Grande Porte';
    end if;
    dbms_output.put_line('A categoria � ' || v_categoria);
END;


CREATE OR REPLACE FUNCTION categoria_cliente (
    p_faturamento_previsto IN cliente.faturamento_previsto%TYPE
) RETURN cliente.categoria%TYPE IS
    v_categoria cliente.categoria%TYPE; --------------------------------- variavel v_categoria que ir� receber o retorno
BEGIN
    IF p_faturamento_previsto < 10000 THEN
        v_categoria := 'Pequeno Porte';
    ELSIF p_faturamento_previsto < 50000 THEN
        v_categoria := 'M�dio Porte';
    ELSIF p_faturamento_previsto < 100000 THEN
        v_categoria := 'M�dio Grande Porte';
    ELSE
        v_categoria := 'Grande Porte';
    END IF;

    RETURN v_categoria;  ------------------------------------------------ retorno da fun��o de pegar a categoria_cliente 
END;








