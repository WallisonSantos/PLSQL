--FOR com CURSOR
-- Removido a variavel v_id que � usado para receber o valor do FETCH, Removido OPEN cur_cliente; pois no Loop j� ser� aberto.
DECLARE
    CURSOR cur_cliente IS SELECT id FROM cliente;
    v_segmercado_id cliente.segmercado_id%TYPE := 1;
BEGIN

    -- Basicamente eu vou usar um for, que � assim: FOR, eu dou o nome de uma vari�vel que eu n�o preciso declarar(ex.: v_segmercado_id), vou cham�-la, 
    -- por exemplo, de cli_rec e eu coloco IN, o nome do cursor, cur_CLIENTE, e eu termino com um LOOP e fecho com END LOOP;
    -- Quando eu fa�o isso, eu j� vou percorrer dentro desse loop todas as linhas do cursor e jogar o conte�do da linha dentro 
    -- dessa vari�vel cli_rec, que n�o � do tipo inteira, n�o � do tipo string, ela � do tipo array.
    -- Se o meu SELECT s� tem uma coluna, cli_rec s� vai ter uma posi��o, vai ser um array de uma posi��o. Se eu tivesse mais colunas, 
    -- cli_rec vai ter o n�mero de posi��es do n�mero de colunas que eu vou ter no SELECT. E eu posso me referenciar a essas posi��es.
    -- Dentro do for eu vou rodar a atualiza��o do segmento. Essa vari�vel v_SEGMERCADO_ID foi declarada. Agora, como eu passo para a rotina o c�digo do cliente atual?
    -- O c�digo do cliente atual est� em algum lugar deste array. Como ele � o campo ID, eu me referencio nele dessa maneira, cli_rec.ID, cli_rec, o nome da vari�vel 
    -- que foi declarada no for, .ID, que � o nome da coluna do select.
    
    -- E esse loop � inteligente o suficiente a terminar quando eu encontro o fim do cursor. Ent�o tudo isso foi substitu�do por esse for inteligente, 
    -- onde eu n�o precisei dar open no cursor, n�o precisei dar fetch no cursor e n�o precisei testar se o cursor terminou.
    -- quando eu saio do loop, ele automaticamente j� fecha o cursor, ent�o eu n�o preciso nem do CLOSE cur_cliente;
    
    FOR cli_rec in cur_cliente LOOP
        atualizar_cli_seg_mercado(p_segmercado_id => v_segmercado_id, p_id => cli_rec.id);
    END LOOP;
END;


--FOR com CURSOR (sem explica��o)
DECLARE
    CURSOR cur_cliente IS SELECT id FROM cliente;
    v_segmercado_id cliente.segmercado_id%TYPE := 1;
BEGIN
    FOR cli_rec in cur_cliente LOOP
        atualizar_cli_seg_mercado(p_segmercado_id => v_segmercado_id, p_id => cli_rec.id);
    END LOOP;
END;

commit
