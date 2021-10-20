
-- Criar uma PROCEDURE que vai dar um Update no campo Segmento de Mercado, passando o ID como parametro e o valor de ID do Segmento de Mercado
-- (primeiro parametro): Vai pegar o ID do cliente, (Segundo Parametro) irá atualizar o Segmento de Mercado referente a este ID.
CREATE OR REPLACE PROCEDURE atualizar_cli_seg_mercado (
    p_id            cliente.id%TYPE,
    p_segmercado_id cliente.segmercado_id%TYPE
) IS
BEGIN
    UPDATE cliente
    SET
        segmercado_id = p_segmercado_id
    WHERE
        id = p_id;

    COMMIT;
END;

SELECT
    "A1"."ID"        "ID",
    "A1"."DESCRICAO" "DESCRICAO"
FROM
    "CURSOPLSQL"."SEGMERCADO" "A1";

SELECT
    "A1"."ID"                   "identificador",
    "A1"."RAZAO_SOCIAL"         "RAZAO_SOCIAL",
    "A1"."CNPJ"                 "CNPJ",
    "A1"."SEGMERCADO_ID"        "SEGMERCADO_ID",
    "A1"."DATA_INCLUSAO"        "DATA_INCLUSAO",
    "A1"."FATURAMENTO_PREVISTO" "FATURAMENTO_PREVISTO",
    "A1"."CATEGORIA"            "CATEGORIA"
FROM
    "CURSOPLSQL"."CLIENTE" "A1";


-- Executando a procedure (ESTA É A FORMA MAIS DIFICIL, iremos fazer abaixo uma forma melhor):
EXECUTE atualizar_cli_seg_mercado(1, 4);
EXECUTE atualizar_cli_seg_mercado(2, 4);
EXECUTE atualizar_cli_seg_mercado(3, 4);
EXECUTE atualizar_cli_seg_mercado(4, 4);
EXECUTE atualizar_cli_seg_mercado(5, 4);
EXECUTE atualizar_cli_seg_mercado(6, 4);


-- USANDO LOOP e END LOOP
DECLARE
    v_segmercado_id cliente.segmercado_id%TYPE := 1; ------------ variavel do campo segmento de mercado
    v_i             NUMBER(3) := 1; ----------------------------- variavel contador
BEGIN
    LOOP   ------------------------------------------------------ dizer que esta começando o Loop
   
        atualizar_cli_seg_mercado(v_i, v_segmercado_id);   ------ chamar a PROCEDURE, com as variaveis declaradas.
        
        v_i := v_i + 1;   --------------------------------------- INCREMENTANDO v_i.... contador
    
    EXIT WHEN   ------------------------------------------------- dizer a condição de saída de Loop
        
        v_i > 6;
        
    END LOOP;    ------------------------------------------------- dizer que o Loop terminou

END;













