SELECT * FROM tb_produtos WHERE SABOR LIKE '%Ma�a%';

SELECT * FROM TB_PRODUTOS WHERE SABOR LIKE '%Ma�a%' AND EMBALAGEM LIKE '%PET%' AND preco_lista >= 18;

SELECT * from tb_clientes where NOME LIKE '%Mattos';

SELECT DISTINCT EMBALAGEM FROM tb_produtos;

SELECT DISTINCT SABOR FROM tb_produtos;

SELECT DISTINCT SABOR FROM tb_produtos WHERE SABOR = 'Cereja';

SELECT DISTINCT EMBALAGEM, SABOR FROM tb_produtos;

SELECT ROWNUM, PRODUTO, NOME FROM TB_PRODUTOS
WHERE ROWNUM <= 10;

SELECT * FROM TB_PRODUTOS ORDER BY PRECO_LISTA DESC;

SELECT * FROM tb_produtos ORDER BY NOME;

SELECT * FROM tb_produtos ORDER BY EMBALAGEM DESC, NOME ASC;

SELECT NOME FROM tb_produtos;


SELECT * FROM tb_produtos WHERE NOME = 'Linha Refrescante - 1 Litro - Morango/Lim�o';

SELECT * FROM tb_produtos;

SELECT ESTADO, LIMITE_CREDITO, NOME FROM tb_clientes;

SELECT ESTADO, SUM(LIMITE_CREDITO) AS TOTAL_CREDITO FROM tb_clientes GROUP BY ESTADO;

SELECT ESTADO, SUM(LIMITE_CREDITO) AS MAX_CREDIT FROM tb_clientes GROUP BY estado;

SELECT EMBALAGEM, MAX(PRECO_LISTA) AS MAX_PRECO FROM tb_produtos GROUP BY embalagem;

SELECT EMBALAGEM, SUM(PRECO_LISTA) AS SOMA_EMB FROM tb_produtos GROUP BY embalagem;

SELECT EMBALAGEM, MIN(PRECO_LISTA) AS MIN_PREC FROM tb_produtos GROUP BY EMBALAGEM;

SELECT EMBALAGEM, COUNT(*) AS NUMERO FROM tb_produtos GROUP BY EMBALAGEM;

SELECT BAIRRO, SUM(LIMITE_CREDITO) AS TOTAL_CREDITO FROM TB_CLIENTES GROUP BY BAIRRO;

SELECT SABOR, SUM(PRECO_LISTA) AS TOTAL_SABOR FROM tb_produtos WHERE EMBALAGEM = 'PET' GROUP BY SABOR;

SELECT BAIRRO, SUM(LIMITE_CREDITO) AS TOTAL_CREDITO FROM tb_clientes
WHERE CIDADE = 'Rio de Janeiro' GROUP BY BAIRRO;

SELECT ESTADO, BAIRRO, SUM(LIMITE_CREDITO) AS TOTAL_CREDITO FROM tb_clientes GROUP BY ESTADO, BAIRRO ORDER BY ESTADO, BAIRRO;