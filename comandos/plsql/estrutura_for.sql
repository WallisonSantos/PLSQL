
-- ACESSANDO a PROCEDURE atualizar_cli_seg_mercado
-- (primeiro parametro): Vai pegar o ID do cliente, (Segundo Parametro) ir� atualizar o Segmento de Mercado referente a este ID.
DECLARE
    v_segmercado_id cliente.segmercado_id%TYPE := 4;   ----------  Variavel  v_segmercado_id   tabela cliente no segmercado_id
BEGIN
    FOR v_id IN 1..6 LOOP     -----------------------------------  Especificar at� onde ir� ser feito a contagem ...
        atualizar_cli_seg_mercado(p_segmercado_id => v_segmercado_id, p_id => v_id);    ----  PROCEDURE atualizar_cli_seg_mercado(p_id, p_segmercado_id)
    END LOOP;
END;

-- Essa rotina de For s� funciona pk supomos que a rotina v� s� de 1 at� 6 
-- Sobre o indexador do FOR, qual das alternativas abaixo � verdadeira? O indexador tem sempre incremento unit�rio
-- O passo do indexador do FOR � sempre unit�rio, tampouco � permitido modific�-lo, s� podemos ler o valor do indexador.



SELECT
    "A1"."ID"                   "ID",
    "A1"."RAZAO_SOCIAL"         "RAZAO_SOCIAL",
    "A1"."CNPJ"                 "CNPJ",
    "A1"."SEGMERCADO_ID"        "SEGMERCADO_ID",
    "A1"."DATA_INCLUSAO"        "DATA_INCLUSAO",
    "A1"."FATURAMENTO_PREVISTO" "FATURAMENTO_PREVISTO",
    "A1"."CATEGORIA"            "CATEGORIA"
FROM
    "CURSOPLSQL"."CLIENTE" "A1";
    
    
CREATE OR REPLACE PROCEDURE update_cli_seg_mercado(
-- id
p_id cliente.id%TYPE,
p_segmercado_id cliente.
) IS
BEGIN
UPDATE CLIENTE SET ID = p_segmercado_id where id = p_id;



    
    
    
    
