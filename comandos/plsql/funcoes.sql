-- As rotinas que recebem parâmetros de entrada, mas têm que devolver um só valor, devem ser implementadas através de funções.
-- Sobre as funções, quais das alternativas abaixo são verdadeiras ?
-- A função só deve ter parâmetros de entrada. Uma das principais características das funções é receber valores através de parâmetros
-- e devolver um só valor, assim os parâmetros só podem ser de entrada.
-- A cláusula RETURN do cabeçalho determina qual é o tipo de dado retornado da função.
-- A cláusula RETURN do cabeçalho irá indicar qual é o tipo de dado de retorno da função, ou seja, a variável do ambiente externo
-- que receberá o valor da função também terá que ser do mesmo tipo de dado
-- Criando um programa PL SQL que vai pegar o ID do segmento e escrever na saida o descritor (ainda não é uma função):---------------------------------------------------------------
SET SERVEROUTPUT ON;

DECLARE
    v_id        segmercado.id%TYPE := 3;
    v_descricao segmercado.descricao%TYPE; -- Não precisa ser inicializada pois ele quem receberá o valor do Descritor,
BEGIN
    -- Para atribuir deve ser usado depois do campo DESCRITOR, INTO e a variavel - jogando o conteúdo do campo para a variavel
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

-- Criando uma função (que tem a estrutura quase igual ao da Procedure):
-- Para a função precisamos obrigatóriamente informar o RETURN, iremos informar o TIPO do retorno ... 
CREATE OR REPLACE FUNCTION obter_descricao_segmercado   ---------------------------------------------------- .. Criar ou alterar, o nome da função,
(p_id IN segmercado.id%TYPE)   ----------------------------------------------------------------------------- .. passar como parametro a variavel p_id
RETURN segmercado.descricao%TYPE   ------------------------------------------------------------------------- .. declara como que é o retorno dessa função
IS
    v_descricao segmercado.descricao%TYPE;   --------------------------------------------------------------- .. declaro variavel de trabalho, que será manipulado dentro dó código
BEGIN
-- SELECT usando INTO jogando o resultado do SELECT para a variavel v_descição e passando como parametro de filtro o p_id que foi declarado na entrada da FUNCTION
-- e depois usado o RETURN onde vou voltar para quem chamou a FUNÇÃO o valor de v_descricao...
    SELECT
        descricao
    INTO v_descricao
    FROM
        segmercado
    WHERE
        id = p_id;
    RETURN v_descricao;
END;


-- Comandos de Oracle SQL Developer para chamar a FUNÇÃO. Ao executar esse comando essa variavel vai ficar na memória do SQL Developer:
VARIABLE g_descricao VARCHAR2(100);

EXECUTE :g_descricao := obter_descricao_segmercado(2);

PRINT g_descricao;



-- Comandos de Oracle PL SQL para chamar a função. No Declare será declarado uma variavel que vai receber o retorno da FUNÇÃO:
SET SERVEROUT ON

DECLARE
    v_descricao segmercado.descricao%TYPE;
BEGIN
    v_descricao := obter_descricao_segmercado(2);   --  v_descricao Recebe o retorno da FUNÇÃO qual passamos o parametro ( );
    dbms_output.put_line('A descrição do Segmento de Mercado é ' || v_descricao);
END;








