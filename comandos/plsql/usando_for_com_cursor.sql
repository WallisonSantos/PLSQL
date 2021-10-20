--FOR com CURSOR
-- Removido a variavel v_id que é usado para receber o valor do FETCH, Removido OPEN cur_cliente; pois no Loop já será aberto.
DECLARE
    CURSOR cur_cliente IS SELECT id FROM cliente;
    v_segmercado_id cliente.segmercado_id%TYPE := 1;
BEGIN

    -- Basicamente eu vou usar um for, que é assim: FOR, eu dou o nome de uma variável que eu não preciso declarar(ex.: v_segmercado_id), vou chamá-la, 
    -- por exemplo, de cli_rec e eu coloco IN, o nome do cursor, cur_CLIENTE, e eu termino com um LOOP e fecho com END LOOP;
    -- Quando eu faço isso, eu já vou percorrer dentro desse loop todas as linhas do cursor e jogar o conteúdo da linha dentro 
    -- dessa variável cli_rec, que não é do tipo inteira, não é do tipo string, ela é do tipo array.
    -- Se o meu SELECT só tem uma coluna, cli_rec só vai ter uma posição, vai ser um array de uma posição. Se eu tivesse mais colunas, 
    -- cli_rec vai ter o número de posições do número de colunas que eu vou ter no SELECT. E eu posso me referenciar a essas posições.
    -- Dentro do for eu vou rodar a atualização do segmento. Essa variável v_SEGMERCADO_ID foi declarada. Agora, como eu passo para a rotina o código do cliente atual?
    -- O código do cliente atual está em algum lugar deste array. Como ele é o campo ID, eu me referencio nele dessa maneira, cli_rec.ID, cli_rec, o nome da variável 
    -- que foi declarada no for, .ID, que é o nome da coluna do select.
    
    -- E esse loop é inteligente o suficiente a terminar quando eu encontro o fim do cursor. Então tudo isso foi substituído por esse for inteligente, 
    -- onde eu não precisei dar open no cursor, não precisei dar fetch no cursor e não precisei testar se o cursor terminou.
    -- quando eu saio do loop, ele automaticamente já fecha o cursor, então eu não preciso nem do CLOSE cur_cliente;
    
    FOR cli_rec in cur_cliente LOOP
        atualizar_cli_seg_mercado(p_segmercado_id => v_segmercado_id, p_id => cli_rec.id);
    END LOOP;
END;


--FOR com CURSOR (sem explicação)
DECLARE
    CURSOR cur_cliente IS SELECT id FROM cliente;
    v_segmercado_id cliente.segmercado_id%TYPE := 1;
BEGIN
    FOR cli_rec in cur_cliente LOOP
        atualizar_cli_seg_mercado(p_segmercado_id => v_segmercado_id, p_id => cli_rec.id);
    END LOOP;
END;

commit
