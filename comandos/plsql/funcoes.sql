-- As rotinas que recebem par�metros de entrada, mas t�m que devolver um s� valor, devem ser implementadas atrav�s de fun��es.
-- Sobre as fun��es, quais das alternativas abaixo s�o verdadeiras ?
-- A fun��o s� deve ter par�metros de entrada. Uma das principais caracter�sticas das fun��es � receber valores atrav�s de par�metros
-- e devolver um s� valor, assim os par�metros s� podem ser de entrada.
-- A cl�usula RETURN do cabe�alho determina qual � o tipo de dado retornado da fun��o.
-- A cl�usula RETURN do cabe�alho ir� indicar qual � o tipo de dado de retorno da fun��o, ou seja, a vari�vel do ambiente externo
-- que receber� o valor da fun��o tamb�m ter� que ser do mesmo tipo de dado
-- Criando um programa PL SQL que vai pegar o ID do segmento e escrever na saida o descritor (ainda n�o � uma fun��o):---------------------------------------------------------------
SET SERVEROUTPUT ON;

DECLARE
    v_id        segmercado.id%TYPE := 3;
    v_descricao segmercado.descricao%TYPE; -- N�o precisa ser inicializada pois ele quem receber� o valor do Descritor,
BEGIN
    -- Para atribuir deve ser usado depois do campo DESCRITOR, INTO e a variavel - jogando o conte�do do campo para a variavel
    SELECT
        descricao
    INTO v_descricao
    FROM
        segmercado
    WHERE
        id = v_id;
    
    -- Comando para escrever na saida do script o valor da variavel v_descricao que recebeu o Select acima:
    dbms_output.put_line(v_descricao);
END;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Criando uma fun��o (que tem a estrutura quase igual ao da Procedure):
-- Para a fun��o precisamos obrigat�riamente informar o RETURN, iremos informar o TIPO do retorno ... 
CREATE OR REPLACE FUNCTION obter_descricao_segmercado   ---------------------------------------------------- .. Criar ou alterar, o nome da fun��o,
(p_id IN segmercado.id%TYPE)   ----------------------------------------------------------------------------- .. passar como parametro a variavel p_id
RETURN segmercado.descricao%TYPE   ------------------------------------------------------------------------- .. declara como que � o retorno dessa fun��o
IS
    v_descricao segmercado.descricao%TYPE;   --------------------------------------------------------------- .. declaro variavel de trabalho, que ser� manipulado dentro d� c�digo
BEGIN
-- SELECT usando INTO jogando o resultado do SELECT para a variavel v_desci��o e passando como parametro de filtro o p_id que foi declarado na entrada da FUNCTION
-- e depois usado o RETURN onde vou voltar para quem chamou a FUN��O o valor de v_descricao...
    SELECT
        descricao
    INTO v_descricao
    FROM
        segmercado
    WHERE
        id = p_id;
    RETURN v_descricao;
END;


-- Comandos de Oracle SQL Developer para chamar a FUN��O. Ao executar esse comando essa variavel vai ficar na mem�ria do SQL Developer:
VARIABLE g_descricao VARCHAR2(100);

EXECUTE :g_descricao := obter_descricao_segmercado(2);

PRINT g_descricao;



-- Comandos de Oracle PL SQL para chamar a fun��o. No Declare ser� declarado uma variavel que vai receber o retorno da FUN��O:
SET SERVEROUT ON

DECLARE
    v_descricao segmercado.descricao%TYPE;
BEGIN
    v_descricao := obter_descricao_segmercado(2);   --  v_descricao Recebe o retorno da FUN��O qual passamos o parametro ( );
    dbms_output.put_line('A descri��o do Segmento de Mercado � ' || v_descricao);
END;








