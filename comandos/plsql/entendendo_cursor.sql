-- Incluindo mais um ID ...
EXECUTE incluir_cliente(9, 'Mercado', '32412998002112', 1, 900000);
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
    
-- For�ando o problema, que teremos ao tentar fazer um Loop onde o numero de IDs da tabela � maior que a variavel contador que usamos para fazer o LOOP,
-- Para ajustar esta situa��o, precisamos usar ao inv�s do contador, o c�digo real do cliente (Usaremos o CURSOR)
DECLARE
    v_segmercado_id cliente.id%TYPE := 4;
BEGIN
    FOR v_id IN 1..6 LOOP
        atualizar_cli_seg_mercado(p_id=> v_id, p_segmercado_id=> v_segmercado_id);
    END LOOP;
END;

-- CURSOR, � uma estrutura implementada no Oracle e que permite uma interatividade linha a linha atrav�s de uma determinada ordem predefinida 
-- quando o cursor � definido, onde eu posso percorrer elementos da tabela que est�o armazenados em mem�ria.
-- Para usarmos o cursor, temos quatro fases espec�ficas. Primeira fase eu declaro o cursor. Ao declarar o cursor
-- eu dou um nome para ele e defino a forma com que o cursor vai ser populado em mem�ria. Essa defini��o � atrav�s de um comando SQL
-- um comando select, igual �queles que n�s aprendemos no curso de consultas avan�adas.
-- Depois eu abro o cursor, ou seja, disponibilizo o cursor para uso, percorro linha a linha do cursor e obtenho os valores dele
-- e eu fa�o qualquer coisa que eu queira com esses valores. Depois eu fecho o cursor, ou seja, eu o libero da mem�ria.
-- Os cursores em PL/SQL podem ser expl�citos e impl�citos. O PL/SQL declara um cursor implicitamente para toda instru��o 
-- DML (UPDATE, INSERT, DELETE, SELECT...INTO), incluindo consultas que retornam apenas uma linha. As consultas que retornam mais de 
-- uma linha dever�o ser declaradas explicitamente. Cursores expl�citos s�o indicados quando � necess�rio um controle no processamento do mesmo.



SET SERVEROUTPUT ON;

-- Colocando em pratica (OS 4 PASSOS - Declara��o, Abertura, Percorrer linha a linha e Fechar Cursor) na cria��o do CURSOR
DECLARE
    -- Incluir qualquer comando de consulta suportado pelo SQL Oracle
    -- Ao declarar este cursos o resultado deste SELECT ir� para a mem�ria associada a esta variavel cur_cliente
    -- declarar tbm duas variaveis de trabalho, pois teremos que percorrer o CURSOR linha a linha, e a cada linha que percorrer,
    -- precisa jogar para variaveis o valor do ID da linha e o valor da RAZAO SOCIAL daquela linha que estou interagindo,
    CURSOR cur_cliente IS SELECT ID, RAZAO_SOCIAL FROM CLIENTE;
    v_id cliente.id%TYPE;
    v_razao_social cliente.razao_social%TYPE;

BEGIN
    -- Com esse comando o Cursor � aberto, pego o resultado do SELECT acima e jogo em mem�ria,
    -- No DECLARE ele n�o estava em mem�ria, ele s� esta preparado para ser usado, s� ap�s o comando OPEN que � executado a QUERY, qual tras o resultado.
    
    OPEN cur_cliente;    
    -- eu preciso fazer um loop, onde a cada execu��o do loop eu vou testar se o cursor acabou ou n�o. Se o cursor n�o acabou, eu passo para a pr�xima linha.
    -- Se o cursor acabou, eu saio do loop. Lembrando, loop eu tenho LOOP, EXIT WHEN e END LOOP;. N�o necessariamente � isso � um detalhe que talvez eu n�o tenha falado 
    -- o exit when precisa estar colado ao end loop, eu posso ter comandos entre o loop e o exit when e comandos entre o exit when e o end loop.

    LOOP            
        FETCH cur_cliente INTO v_id, v_razao_social;
    -- Vou jogar o conteudo do cursor em duas varias v_id, v_razao_social, pois o SELECT tras duas colunas,
    -- a variavel que vai receber o conteudo da primeira coluna daquela linha e a que vai receber o conteudo da segunda coluna daquela linha (Se no SELECT tivesse 20 colunas deveria haver no INTO 20 variaveis)
    -- O comando Fetch, do cursor, realiza a sua leitura.nA quantidade de vari�veis ap�s a cl�usula INTO, do comando FETCH,
    -- dever� ser igual � quantidade de colunas do cursor. O processo de leitura s� anda para frente
    
    EXIT WHEN
        -- Sair do Loop quando, ao dar o FETCH n�o foi encontrado uma linha, porem se ao fazer o FETCH foi encontrado uma linha, o NOTFOUND n�o ser� verdade, e continuara
        -- executando os comandos ap�s ele, onde iremos escrever na saida o conteudo da variavel v_id e razao social
        cur_cliente%NOTFOUND;
        dbms_output.put_line('ID = ' || v_id);
        dbms_output.put_line('Razao Social = ' || v_razao_social);
        
    END LOOP;
    
        -- Fechar o CURSOR para descarrer ele da mem�ria ... CLOSE cur_cliente
        CLOSE cur_cliente;
END;

-- saida: ID = 2
-- Razao Social = Supermercado
-- ID = 1
-- Razao Social = Supermercado
-- ID = 3
-- Razao Social = Hipermercado
-- ID = 4
-- Razao Social = Farmacia Farm
-- ID = 5
-- Razao Social = Mercearia Merc
-- ID = 6
-- Razao Social = Lojas Americana
-- ID = 9
-- Razao Social = Mercado

-- Atualziar o segmento de mercado (UPDATE) mesmo quando n�o sabemos o tamanho do ID ou quando esta fora de ordem.
-- O comando SELECT, do cursor, � definido entre DECLARE/IS e o BEGIN do bloco. A query do cursor pode referenciar uma ou mais tabelas.
-- A query do cursor � o comando SELECT do SQL. Podemos utilizar qualquer recurso que esteja dispon�vel para esse comando. 
-- Por exemplo: pode conter v�rias tabelas, cl�usulas WHERE, ORDER BY, GROUP BY, HAVING, ou qualquer outra cl�usula que seja aceita no SELECT do SQL do Oracle:
DECLARE
    CURSOR cur_cliente IS
    SELECT
        id
    FROM
        cliente;

    v_segmercado_id cliente.segmercado_id%TYPE := 3;
    v_id            cliente.id%TYPE;
BEGIN
    OPEN cur_cliente;
    LOOP
        FETCH cur_cliente INTO v_id;
        EXIT WHEN cur_cliente%notfound;
        atualizar_cli_seg_mercado(p_segmercado_id => v_segmercado_id, p_id => v_id);
    END LOOP;

    CLOSE cur_cliente;
END;

SELECT
    *
FROM
    cliente;






